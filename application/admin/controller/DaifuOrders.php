<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/7
 * Time: 21:27
 */

namespace app\admin\controller;


use app\common\library\enum\CodeEnum;
use app\common\logic\TgLogic;
use think\Cache;
use think\Db;
use think\Exception;
use think\Log;
use app\api\service\DaifuPayment;
class DaifuOrders extends BaseAdmin
{

    /**
     * @return mixed
     * 代付订单列表
     */
    public function index(){
        $where['create_time'] = $this->parseRequestDate3();
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
            $where['uid'] = ['in',$adminSonMs];
        }

    	$orderCal  = $this->logicDaifuOrders->calOrdersData($where);


    	 $daifu_logic = new \app\common\logic\Config();
        $daifu_err_reason = $daifu_logic->getConfigInfo(['name'=> 'daifu_err_reason']);
        // $this->assign('list', $this->logicConfig->getConfigList(['name'=> 'daifu_err_reason'],true,'sort ace'));
        $data = $this->logicConfig->getConfigList(['name'=> 'daifu_err_reason'])->toarray();
   
        $res = explode(",",$daifu_err_reason['value']);
     
        // print($this->logicConfig->getConfigList(['name'=> 'daifu_err_reason'])->toarray());
        $daifu_success_uplode = Db::name('config')->where(['name'=>'daifu_success_uplode','admin_id'=>is_admin_login()])->value('value');
        if (!empty($daifu_success_uplode) && $daifu_success_uplode == 2){
            $this->assign('daifu_chars',$daifu_success_uplode);
        }else{
            $this->assign('daifu_chars',1);
        }
        $this->assign('res',$res);
        $this->assign('fees',$orderCal);
        //所有的支付渠道
        return $this->fetch();
    }

    /**
     * 获取代付转发通道
     */
    public function getTransferDfChannel(){
        $dfChannel = require_once('./data/conf/daifu.php');
        if (is_admin_login() != 1){
            foreach ($dfChannel as $k=>$v){
                if ($v['admin_id'] != is_admin_login()){
                        unset($dfChannel[$k]);
                }
            }
        }

        return json(['code'=>0,'data'=>$dfChannel]);
    }


    /**
     * 转发通道start
     */
    public function dfTransfer(){
        if ($this->request->isPost()){
            $dfInfo = Db::name('daifu_orders')->where('id',$this->request->param('id'))->find();
            $channel = [];
            $dfChannel = require_once('./data/conf/daifu.php');
            foreach ($dfChannel as $k=>$v){
                if ($v['id'] == $this->request->param('channel')){
                    $channel = $v;
                }
            }

            $appChannel = [
                'channel' => $channel['contrroler'],
                'action' => 'pay',
                'config' => $channel
            ];
            list($payment,$action,$config) = array_values($appChannel);

            $result = DaifuPayment::$payment($config)->$action($dfInfo);

            if ($result['code'] == 1){
                Db::startTrans();
                try {
                    $transfer = $this->modelDaifuOrders->lock(true)->where(['id' => $this->request->param('id')])->find();
                    if (!$transfer|| $transfer['status']!=1) {
                        Db::rollback();
                        throw new Exception('订单不存在或者订单已处理，请刷新！');
                    }
                    $transfer->is_to_channel = 2;
                    $transfer->status = 3;
                    $transfer->daifu_transfer_name = $channel['channel_name'];
                    $res = $transfer->save();
                    if ($res){
                        Db::commit();
                        Log::notice('管理员'.is_admin_login().'中转代付订单：'.$dfInfo['out_trade_no'].'到'.$channel['channel_name']);
                        return json($result);
                    }
                } catch (Exception $e) {
                    Db::rollback();
                    return json(['code'=>0,'msg'=>$e->getMessage()]);
                }
            }
            return json($result);
        }
    }




    /**
     * 代付参数设置
     */
    public function setting(){
        // $postData = input('post.');
        // print_r($postData);die;
        $this->common();

        $this->assign('list', $this->logicConfig->getConfigList(['group'=> '3'],true,'sort ace'));
        return $this->fetch();
    }

    /**
     * Common
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    private function common(){
        // print_r($this->request->post());die;
        $this->request->isPost() && $this->result(
            $this->logicConfig->settingSave(
                $this->request->post()
            )
        );
    }
    /**
     * 代付订单列表
     */
    public function getorderslist(){

        $where = [];
        //code
        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }
        !empty($this->request->param('orderNum')) && $where['a.trade_no']
            = ['eq', trim($this->request->param('orderNum'))];


        if (!empty($this->request->param('username'))){
            $ms_aid = Db::name('ms')->where('username',$this->request->param('username'))->value('admin_id');
            if (is_admin_login() != 1){
                if (is_admin_login() != $ms_aid){
                    $this->error('非法请求');
                }
            }
            $where['m.username'] = ['eq', trim($this->request->param('username'))];
        }



        !empty($this->request->param('bank_owner')) && $where['a.bank_owner']
            = ['eq', trim($this->request->param('bank_owner'))];

        !empty($this->request->param('trade_no')) && $where['a.out_trade_no']
            = ['eq', trim($this->request->param('trade_no'))];


        //组合搜索
        // !empty($this->request->param('trade_no')) && $where['trade_no']
        //   = ['eq', $this->request->param('trade_no')];


    if (is_admin_login() != 1){
        $sonuser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
        $where['a.uid'] = ['in',$sonuser];
    }

        if (!empty($this->request->param('uid'))){
            if (is_admin_login() != 1){
                $u_aid = Db::name('user')->where('uid',$this->request->param('uid'))->value('admin_id');
                if ($u_aid != is_admin_login()){
                    $this->error('非法请求');
                }
            }
            $where['a.uid'] = ['eq', $this->request->param('uid')];

        }

        //时间搜索  时间戳搜素
        $where['create_time'] = $this->parseRequestDate3();

        if (!empty($this->request->param('trade_no'))){
            unset($where['create_time']);
        }



       $data =  $this->modelDaifuOrders
           ->alias('a')
            ->where($where)
            ->join('cm_ms m', 'a.ms_id = m.userid', 'left')
            ->field('a.*, m.username')
            ->order('create_time desc')
            ->paginate($this->request->param('limit', 15));


        $this->result($data->items() ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg'=> '',
                'count'=>$data->total(),
                'data'=>$data->items()
            ] : [
                'code' => CodeEnum::ERROR,
                'msg'=> '暂无数据',
                'count'=>$data->total(),
                'data'=>$data->items()
            ]);
    }


    /**
     * 审核成功
     */
    public function auditSuccess(){
        if (is_admin_login() != 1){
            $uid = Db::name('daifu_orders')->where('id',$this->request->post('id'))->value('uid');
            $admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($admin_id != is_admin_login()){
                $this->error('非法操作');
            }
        }
        $order = Db::name('daifu_orders')->where('id',$this->request->post('id'))->value('out_trade_no');
        Log::notice('管理员：'.is_admin_login().'强制完成代付订单：'.$order);
        $this->result($this->logicDaifuOrders->successOrder($this->request->post('id')));
    }

    /**
     * 驳回
     */
    public function auditError(){
        // $res = $this->modelDaifuOrders->where(['id' => $id])->update($up);
        if (is_admin_login() != 1){
            $uid = Db::name('daifu_orders')->where('id',$this->request->post('id'))->value('uid');
            $admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($admin_id != is_admin_login()){
                $this->error('非法操作');
            }
        }


        Db::name('daifu_orders')->where('id',$this->request->post('id'))->update(['error_reason'=>$this->request->post('reason')]);
        $order = Db::name('daifu_orders')->where('id',$this->request->post('id'))->value('out_trade_no');
        Log::notice('管理员：'.is_admin_login().'强制关闭代付订单：'.$order);
        $this->result($this->logicDaifuOrders->errorOrder($this->request->post('id'),0));
    }

    /**
     * 驳回
     */
    public function add_notify(){
        if (is_admin_login() != 1){
            $uid = Db::name('daifu_orders')->where('id',$this->request->post('id'))->value('uid');
            $admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($admin_id != is_admin_login()){
                $this->error('非法操作');
            }
        }
        $this->result($this->logicDaifuOrders->retryNotify($this->request->post('id')));
    }



    /**
     * @return mixed
     * 订单详情
     */
    public function details()
    {
        $where['id'] = $this->request->param('id', '0');

        //订单
        $order = $this->logicDaifuOrders->getOrderInfo($where);

        $notify = [];
        //当支付成功的时候才会看有没有回调成功
//        if ($order['status'] == '2') {
//            //回调
//            $notify = $this->logicDaifuOrders->getOrderNotify(['order_id' => $where['id']]);
//        }

        $this->assign('order', $order);
//        $this->assign('notify', $notify);

        return $this->fetch();
    }


    /**
     * 查询订单金额
     * 按照简单的来
     */
    public function  searchOrderMoney(){

        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }

        !empty($this->request->param('orderNum')) && $where['a.trade_no']
            = ['eq', $this->request->param('orderNum')];
        !empty($this->request->param('trade_no')) && $where['a.out_trade_no']
            = ['eq', $this->request->param('trade_no')];
        //组合搜索
        // !empty($this->request->param('trade_no')) && $where['trade_no']
        //   = ['eq', $this->request->param('trade_no')];



        if (!empty($this->request->param('username'))){
            $ms_id = Db::name('ms')->where('username',$this->request->param('username'))->field('userid,admin_id')->find();
            if (is_admin_login() != 1){
                if (is_admin_login() != $ms_id['admin_id']){
                    $this->error('非法请求');
                }
            }
            $where['a.ms_id'] = ['eq',$ms_id['userid']];
         }

        //时间搜索  时间戳搜素
        $where['a.create_time'] = $this->parseRequestDate3();


        if (!empty($this->request->param('uid'))){
            if (is_admin_login() != 1){
                $u_aid = Db::name('user')->where('uid',$this->request->param('uid'))->value('admin_id');
                if ($u_aid != is_admin_login()){
                    $this->error('非法请求');
                }
            }
            $where['a.uid'] = ['eq', $this->request->param('uid')];

        }

        if (is_admin_login() != 1){
            $sonuser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
            $where['a.uid'] = ['in',$sonuser];
        }
        $orderCal  = $this->logicDaifuOrders->getOrdersAllStat($where)['fees'];
//        echo json_encode($where);

        $orderCal['percent'] =  $orderCal['paid_count']==0?0: sprintf("%.2f",$orderCal['paid_count']/$orderCal['total_count'])*100;

        exit(json_encode($orderCal));
        // echo  sprintf('%.2f',$searchTotalOrderAmount['searchTotalOrderAmount']);
    }


    /**
     * 导出订单
     */
    public function  exportOrder(){
        //组合搜索
        $where = [];
        //code
        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }
        !empty($this->request->param('orderNum')) && $where['a.trade_no']
            = ['eq', $this->request->param('orderNum')];

        !empty($this->request->param('trade_no')) && $where['a.out_trade_no']
            = ['eq', $this->request->param('trade_no')];
        //组合搜索
        // !empty($this->request->param('trade_no')) && $where['trade_no']
        //   = ['eq', $this->request->param('trade_no')];

        !empty($this->request->param('uid')) && $where['a.uid']
            = ['eq', $this->request->param('uid')];



        //时间搜索  时间戳搜素
        $where['a.create_time'] = $this->parseRequestDate3();
        //导出默认为选择项所有
        //$orderList = $this->logicDaifuOrders->getOrderList($where,true, 'create_time desc', false);
        $orderList = $this->modelDaifuOrders->alias('a')->where($where)->field('a.*,m.username')->join('ms m', 'a.ms_id = m.userid', 'left')->select();

        //组装header 响应html为execl 感觉比PHPExcel类更快
        $orderStatus =['订单关闭','等待支付','支付完成','处理中','异常订单'];
        $strTable ='<table width="500" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">ID标识</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">交易商户</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="100">打款单号</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">交易金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">交易手续费</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">交易方式</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收款姓名</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收款账号</td>';

        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">状态</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">创建时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">更新时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">卡商名称</td>';

//        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">码商号</td>';
//        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">支付渠道</td>';


        $strTable .= '</tr>';
        if(is_array($orderList)){
            foreach($orderList as $k=>$val){
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['id'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['uid'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['out_trade_no'].' </td>';
//                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;'.$val['id'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['amount'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'. bcadd($val['service_charge'],$val['single_service_charge'], 2).'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">代付</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'. $val['bank_owner'] .'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'. $val['bank_number'] .'</td>';

                $strTable .= '<td style="text-align:left;font-size:12px;">'.$orderStatus[$val['status']].'</td>';

//                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['channel'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['create_time'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['update_time'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['username'].'</td>';
                $strTable .= '</tr>';
                unset($orderList[$k]);
            }
        }
        $strTable .='</table>';
        downloadExcel($strTable,'daifu_orders');
    }

    //充值申请列表
    public function applyList()
    {
        $where = [];
        //code
        //状态
        if ($this->request->param('status') != "") {
            $where['status'] = ['eq', $this->request->param('status')];
        }
        !empty($this->request->param('orderNum')) && $where['trade_no']
            = ['eq', $this->request->param('orderNum')];

        //按照商户号搜索
        if ($this->request->param('uid') != "") {
            $where['uid'] = ['eq', $this->request->param('uid')];
        }

        //时间搜索  时间戳搜素
        $where['create_time'] = $this->parseRequestDate3();

        $data = $this->logicDepositOrders->getOrderList($where, true, 'create_time desc',false);

        $count = $this->logicDepositOrders->getOrderCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg'=> '',
                'count'=>$count,
                'data'=>$data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg'=> '暂无数据',
                'count'=>$count,
                'data'=>$data
            ]);
    }

    //驳回申请
    public function rejectApply($id)
    {
        $this->result($this->logicDepositeOrder->delDepositeCard(['id' => $id]));
        //1.设置申请充值订单状态为失败状态
    }

    //完成申请
    public function acceptApply($id)
    {

        $this->result($this->logicDepositeOrder->acceptApply(['id' => $id]));

    }

    /**
     * @return mixed
     *  充值银行卡首页
     */
    public function depositeCard()
    {
        return $this->fetch();
    }

    /**
     * 获取充值银行卡列表
     */
    public function getDepositeCardList(){
        $where = [];
        if ($this->request->param('status') != "") {
            $where['status'] = ['eq', $this->request->param('status')];
        }
        !empty($this->request->param('bank_account_username')) && $where['bank_account_username']
            = ['like', '%'.$this->request->param('bank_account_username').'%'];

        !empty($this->request->param('bank_account_number')) && $where['bank_account_number']
            = ['like', '%'.$this->request->param('bank_account_number').'%'];
        $fields = 'a.*,b.name';
        $data = $this->logicDepositeCard->getCardList($where, $fields, 'create_time desc',false);
        $count = $this->logicDepositeCard->getCardCount($where);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg'=> '',
                'count'=>$count,
                'data'=>$data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg'=> '暂无数据',
                'count'=>$count,
                'data'=>$data
            ]);
    }



    //添加充值银行卡
    public function addDepositeCard()
    {
        $this->request->isPost() && $this->result($this->logicDepositeCard->saveCard($this->request->post(),'add'));
        $this->assign('bank',$this->logicBanker->getBankerList());
        return $this->fetch();
    }

    //编辑充值银行卡
    public function editDepositeCard()
    {

        $this->request->isPost() && $this->result($this->logicDepositeCard->saveCard($this->request->post(),'edit'));
        $this->assign('bank',$this->logicBanker->getBankerList());
        $this->assign('info',$this->logicDepositeCard->getCard($this->request->param('id')));
        return $this->fetch();
    }

    //删除充值银行卡
    public function delDepositeCard()
    {
        $this->result($this->logicDepositeCard->delCard(['id' => $this->request->param('id')]));
    }

    /**
     * 指定码商
     */
    public function appoint_ms()
    {
	    //todo 这里需要判断是通道还是码商 如果是通道的话就选择哪个通道，然后转发过去
	    $id = $this->request->param('id', '');
	    $ms_name = $this->request->param('ms_name', '');
        if ($this->request->isAjax()){
            $this->modelDaifuOrders->startTrans();
            $ms_id = $this->request->param('ms_id');
            $order = $this->modelDaifuOrders->lock(true)->where(['id' => $id])->find();
            if ($order['ms_id'])
            {
           //     $this->error('该订单已分配码商！');
            }
            if (!$order){
               $this->error('订单不存在！');
	    }
            $ms = $this->modelMs->where('username', $ms_name)->find();
            if (!$ms) {
                $this->error('码商不存在！');
	    }

	    $ms_id =  $ms['userid'];
            $order->ms_id = $ms_id;
            $order->status = 3;
            $order->save();
            $this->modelDaifuOrders->commit();

            $Ms =  $this->modelMs->where('userid', $ms_id)->find();
            if ($Ms && $Ms['tg_group_id']){
                //发送信息给渠道飞机群
                $TgLogic = new TgLogic(['tg_bot_type' => 'df']);
                //文本信息
		$sendText1 = '金额：' . intval($order['amount']).PHP_EOL.PHP_EOL.
			     '姓名：' . $order['bank_owner'] . PHP_EOL .
                             '卡号：' . $order['bank_number'] . PHP_EOL .
                             '银行：' . $order['bank_name'] . PHP_EOL ;
                $sendText2 = '请按照金额打款，不要多打和重复打款，否则无法追回，打款完麻烦发转账成功截图在群里，谢谢—';
                $TgLogic->sendMessageTogroup($sendText1, $Ms['tg_group_id']);
                $TgLogic->sendMessageTogroup($sendText2, $Ms['tg_group_id']);
            }
            Log::notice('管理员'.is_admin_login().'将代付订单：'.$order['out_trade_no'].'指派给码商'.$ms['username']);
            $this->success('操作成功');
        }
        $yhhMs =  $this->modelDaifuOrders->getYhkMs();
        $this->assign('yhkMs', $yhhMs);
        $this->assign('id', $id);
        return $this->fetch();
    }



    /**
     * 代付商户统计
     */
    public function UserStats(){
        return $this->fetch();
    }

    /**
     * 获取代付商户统计
     */

    public function getUserStats(){
        $where = [];
        $where['status'] = 1;
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }
        $userList = Db::name('user')->where($where)->field('uid,username')->select();

        if (!empty($this->request->param('username'))){
            $where1['username'] = $this->request->param('username');
            $userList = Db::name('user')->where('status',1)->where($where1)->field('uid,username,admin_id')->select();
            if (is_admin_login() != 1){
                if ($userList['admin_id']!= is_admin_login()) {
                    $this->error('非法操作');
                };
            }
        }

        if (empty($userList)){
            $this->error('没有数据啦');
        }
        $start = date('Y-m-d 00:00:00',time());
        $end = date('Y-m-d 23:59:59',time());
        if (!empty($this->request->param('start'))){
            $start = $this->request->param('start');
        }

        if (!empty($this->request->param('end'))){
            $end = $this->request->param('end');
        }

        $where2['create_time'] = ['between time',[$start,$end]];

        foreach ($userList as $k=>$v){
            $userList[$k]['daifu_total'] = Db::name('daifu_orders')->where('uid',$v['uid'])->where($where2)->sum('amount');
            $userList[$k]['daifu_success_total'] = Db::name('daifu_orders')->where(['uid'=>$v['uid'],'status'=>2])->where($where2)->sum('amount');

            $userList[$k]['daifu_total_number'] = Db::name('daifu_orders')->where('uid',$v['uid'])->where($where2)->count();
            $userList[$k]['daifu_success_number'] = Db::name('daifu_orders')->where(['uid'=>$v['uid'],'status'=>2])->where($where2)->count();

            if ($userList[$k]['daifu_success_number'] == 0 ){
                $userList[$k]['success_rate'] = 0;
            }else{
                $userList[$k]['success_rate'] = sprintf("%.2f",$userList[$k]['daifu_success_number'] / $userList[$k]['daifu_total_number'] * 100);
            }
            if ($userList[$k]['daifu_total'] == 0 && $userList[$k]['daifu_success_total'] == 0 &&  $userList[$k]['daifu_total_number'] == 0 && $userList[$k]['daifu_success_number'] == 0){
                unset($userList[$k]);
            }

        }

        return json(['code'=>0,'data'=>$userList,'count'=>count($userList)]);


    }


    /**
     * 团队跑量统计
     */
    public function teamStats(){
        return $this->fetch();

    }

    /**
     * 获取团队跑量统计
     */
    public function getTeamStats(){

        //查询今日完成订单
        $orderWhere = [];
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $orderWhere['ms_id'] = ['in',$adminSonMs];
            $where['admin_id'] = ['in',$adminSonMs];
        }
        $orderWhere['status'] = 2;
        $start = date('Y-m-d 00:00:00',time());
        $end = date('Y-m-d 23:59:59',time());
        if (!empty($this->request->param('start'))){
            $start = $this->request->param('start');

        }
        if (!empty($this->request->param('end'))){
            $end = $this->request->param('end');
        }

        if (!empty($this->request->param('username'))){
            $username = trim($this->request->param('username'));
            $ms = Db::name('ms')->where(['username'=>$username,'status'=>1])->field('userid,pid,admin_id')->find();
            if (is_admin_login() != 1){
                if (is_admin_login() != $ms['admin_id']){
                    $this->result([
                        'code' => 1,
                        'msg' => '非法请求',
                        'count' => 0,
                        'data' => ''
                    ]);
                }
            }
            if ($ms['pid'] != 0){
                $this->result([
                    'code' => 1,
                    'msg' => '不是团长',
                    'count' => 0,
                    'data' => ''
                ]);
            }
            $mss = $this->getIds($ms['userid']);

            array_unshift($mss, $ms['userid']);
//                        print_r($mss);die;
            $orderWhere['o.ms_id'] = ['in',$mss];
            $where['username'] = $this->request->param('username');
        }


        $orderWhere['create_time'] = ['between time',[$start,$end]];
        $order = Db::name('daifu_orders')->alias('o')->field('amount,ms_id')->where($orderWhere)->select();
        $order = $this->GetRepeatValGroup($order,'ms_id');
        $ms = [];
        foreach ($order as $k=>$v){
            $ms[$k]['total_amount'] = array_sum(array_column($v,'amount'));
        }

        $mslist = [];
        foreach ($ms as $k=>$v){
//            $mslist[$k]['username'] = Db::name('ms')->where('userid',$k)->value('username');
            $mslist[$k]['pid'] = Db::name('ms')->where('userid',$k)->value('pid');
            $mslist[$k]['total_amount'] = $v['total_amount'];
            $mslist[$k]['userid'] = $k;
        }
//                print_r($mslist);die;
//

        foreach ($mslist as $k=>$v){
            if ($v['pid'] != 0){
                $ffmsid = getNavPid($k);
                if(array_key_exists($ffmsid,$mslist)){
                    $mslist[$ffmsid]['total_amount'] = $mslist[$ffmsid]['total_amount'] + $v['total_amount'];
                }else{
                    $mslist[$ffmsid]['total_amount'] = 0 + $v['total_amount'];
//                    $mslist[$ffmsid]['username'] = Db::name('ms')->where('userid',$ffmsid)->value('username');
                    $mslist[$ffmsid]['pid'] = 0;
//                    $mslist[$ffmsid]['userid'] = $ffmsid;
//                    unset($mslist[$k]);
                }

            }
        }

        $where['status'] = 1;
        $where['level'] = 1;
        $where['pid'] = 0;
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }

        $topMs = Db::name('ms')->where($where)->select();
        $data = $this->logicMs->sortTrees($topMs,0,1);

        foreach ($data as $k=>$v){
            foreach ($mslist as $key=>$val){
                if ($key == $v['userid']){
                    $data[$k]['total_amount'] = $val['total_amount'];
                }
            }
        }


        $count = count($data);
      $this->result($data || !empty($data) ?
            [
                'code' => 0,
                'msg' => '请求成功',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::SUCCESS,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );

    }

    public $son_id=array();

    public function getIds($parentid){
        $list=Db::name("ms")->where(["pid"=>$parentid])->field('pid,userid,username,level')->select();
        foreach ($list as $key => $value) {
            $this->son_id[]=$value['userid'];
            $this->getIds($value['userid']);
        }
        return $this->son_id;
    }

    public function GetRepeatValGroup($arr,$keys)
    {
        if(!is_array($arr) || !$keys) {
            return false;
        }
        $temp = array();
        foreach($arr as $key=>$val) {
            $temp[$val[$keys]][] = $val;
        }
        return $temp;
    }

}
