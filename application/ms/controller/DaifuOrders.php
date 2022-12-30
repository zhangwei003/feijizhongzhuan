<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/7
 * Time: 21:27
 */

namespace app\ms\controller;


use app\common\library\enum\CodeEnum;
use app\common\logic\MsMoneyType;
use think\Cache;
use think\Db;
use think\Exception;
use think\Request;
use think\Log;

class DaifuOrders extends Base
{

    /**
     * @return mixed
     * 代付订单列表
     */
    public function index(Request $request)
    {
        $where = [];


        //当前时间段统计

        $startTime = $request->param('start_time');
        //dd($startTime);
        $endTime = $request->param('end_time');
        if ($startTime && empty($endTime)) {
            $where['a.create_time'] = ['egt', strtotime($startTime)];
        }
        if (empty($startTime) && $endTime) {
            $where['a.create_time'] = ['elt', strtotime($endTime)];
        }
        if ($startTime && $endTime) {
            $where['a.create_time'] = ['between', [strtotime($startTime), strtotime($endTime)]];
        }


        //指定时间段的统计start
        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');

        $adminSonUser = Db::name('user')->where('admin_id',$admin_id)->column('uid');

        $successWhere['uid'] = ['in',$adminSonUser];
        $where1['uid'] = ['in',$adminSonUser];
        $successWhere['status'] = 2;
        $successWhere['ms_id'] = $this->agent_id;
        $successWhere['create_time'] = $this->parseRequestDate4();
        $successCount = $this->modelDaifuOrders->where($successWhere)->count();
        $successMoney = $this->modelDaifuOrders->where($successWhere)->sum('amount');
        $orderSum = $this->modelDaifuOrders->where($where1)->count();
//        $orderSum = $this->modelDaifuOrders->count();
        $this->assign('successCount', $successCount);
        $this->assign('orderSum', $orderSum);
        $this->assign('successMoney', $successMoney);
        //指定时间段的统计end
        //  $DaifuOrdersLogic = new \app\common\logic\DaifuOrders();
        //  $orders = $this->modelDaifuOrders->lock(true)->where(['id' => $id])->find();
        $daifu_logic = new \app\common\logic\Config();
	$daifu_err_reason = $daifu_logic->getConfigInfo(['name'=> 'daifu_err_reason']);
//	var_dump($daifu_err_reason['value']);die();
        $res = explode(",",$daifu_err_reason['value']);
        $this->assign('res',$res);
        //  $this->logicConfig->getConfigList(['name'=> 'daifu_err_reason'])->toarray();

        $status = $this->request->param('status', -1);
        $status != -1 && $where['a.status'] = ['eq', $status];
        $where['a.ms_id'] = $this->agent_id;



        if (!empty($this->request->param('trade_no'))){
            unset($where['a.create_time']);
            unset($where['a.status']);
            $where['a.trade_no'] = ['eq', $this->request->param('trade_no')];
        }

        !empty($this->request->param('bank_owner')) && $where['a.bank_owner']
            = ['eq', $this->request->param('bank_owner')];

        if(!empty($this->request->param('out_trade_no'))){
            unset($where['a.create_time']);
            unset($where['a.trade_no']);
            unset($where['a.status']);
            $where['a.out_trade_no'] = ['eq', $this->request->param('out_trade_no')];
        }
        !empty($this->request->param('out_trade_no')) && $where['a.out_trade_no']
            = ['eq', $this->request->param('out_trade_no')];
        //组合搜索
        !empty($this->request->param('uid')) && $where['a.uid']
            = ['eq', $this->request->param('uid')];

        $exp = new \think\Db\Expression('field(a.status,3,1,2,0)');

        $fields = ['a.*'];
//        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
//
//        $adminSonUser = Db::name('user')->where('admin_id',$admin_id)->column('uid');
//
//        $where['a.uid'] = ['in',$adminSonUser];
//        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
//        $where['b.admin_id'] = $admin_id;


        $query = $this->modelDaifuOrders->alias('a')
//            ->where('a.create_time','<',time()-20)
            ->where($where)
            ->field($fields)
            ->order($exp)
            ->order('id asc');
//        $query->whereOr(function ($query) {
//            $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
//            $adminSonUser = Db::name('user')->where('admin_id',$admin_id)->column('uid');
//            $query->whereOr('a.uid', 'in', $adminSonUser);
//        });
        if (($status == '-1' or $status == '1')&&empty($this->request->param('out_trade_no'))&&empty($this->request->param('trade_no'))){
            $query->whereOr(function ($query) {
                $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
                $adminSonUser = Db::name('user')->where('admin_id',$admin_id)->column('uid');
                $query->whereOr('a.uid', 'in', $adminSonUser)->where('a.status',1);
            });
        }

        $listData = $query->paginate(15, false, ['query' => request()->param()]);
//        print_r($this->modelDaifuOrders->getLastSql());die;
        $list = $listData->items();
        $count = $listData->count();
        $page = $listData->render();
        $this->assign('list', $list);
        $this->assign('status', $status);
        $this->assign('count', $count);
        $this->assign('page', $page);
        $this->assign('request', $request);

        $daifu_success_uplode = Db::name('config')->where(['name'=>'daifu_success_uplode','admin_id'=>$this->agent['admin_id']])->value('value');
        if (!empty($daifu_success_uplode)){
            $this->assign('daifu_success_uplode', $daifu_success_uplode);
        }else{
            $this->assign('daifu_success_uplode', 1);
        }
        //所有的支付渠道
       // $device = isMobile() ? 'index_mobile' : 'index';
        $device = 'index';
        return $this->fetch($device);
    }


    /**
     * 弃单
     */

    public function discard_df(){
       $id = $this->request->param('id');
        if (!$id) {
            $this->error('非法操作');
        }

//        $pass = $this->request->param('pass');
//        if(!captcha_check($pass)){
//            //验证失败
//            $this->error('验证码错误');
//        };
        $uid = Db::name('daifu_orders')->where('id',$id)->value('uid');
        $u_admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
        if ($admin_id != $u_admin_id){
            $this->error('非法操作1');
        }
        
        try {
            $transfer = $this->modelDaifuOrders->lock(true)->where(['id' => $id, 'status'=>3,'ms_id'=>$this->agent_id])->find();
            if (!$transfer) {
//                $transfer->rollback();
                throw new Exception('订单不存在或者订单已处理，请刷新！');
            }
            $transfer->status = 1;
            $transfer->ms_id = 0;
            $transfer->save();
            $transfer->commit();
            $this->success('成功弃单');
        } catch (Exception $e) {
            $transfer->rollback();
            $this->error($e->getMessage());
        }
    }

    /**
     * 匹配订单
     */
    public function matching()
    {
        $id = $this->request->param('id');
        if (!$id) {
            $this->error('非法操作');
        }

        $cache = Cache::get('matching'.$this->agent_id);
        if (!empty($cache) && (time()-$cache) < 15){
//            $this->error('频率过高，请稍后再来');
        }
        Cache::set('matching'.$this->agent_id,time());

        $uid = Db::name('daifu_orders')->where('id',$id)->find();
        $u_admin_id = Db::name('user')->where('uid',$uid['uid'])->value('admin_id');
        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
        if ($admin_id != $u_admin_id){
            $this->error('非法操作1');
        }
        Db::startTrans();
        try {
//            sleep(10);
            $ms = Db::name('ms')->where('userid',$this->agent_id)->find();

            if ($ms['status'] == 0){
                Db::rollback();
                throw new Exception('你的状态已被禁用，请联系管理员处理');
            }
            if ($ms['work_status'] == 0){
                Db::rollback();
                throw new Exception('你正处于未开工状态，如需抢单请打开开工按钮');
            }

            $transfer = $this->modelDaifuOrders->lock(true)->where(['id' => $id])->find();
            if (!$transfer|| $transfer['status']!=1) {
                Db::rollback();
                throw new Exception('订单不存在或者订单已处理，请刷新！');
            }
             $cache = Cache::get('matching'.$this->agent_id);
        if (!empty($cache) && (time()-$cache) < 2){
         //   $this->error('▒~Q▒~N~G▒~G▒~X▒~L请▒~M▒~P~N▒~F~M▒~]▒');
        }
        Cache::set('matching'.$this->agent_id,time());

            $status3 = $this->modelDaifuOrders->where(['status'=>3,'ms_id'=>$this->agent_id])->count('id');
            $admin_daifu_number = Db::name('config')->where(['name'=>'admin_daifu_number','admin_id'=>$admin_id])->value('value');
            if (empty($admin_daifu_number)){
                if ($status3 > 2){
                    Db::rollback();
                    throw new Exception('正在处理订单已到最大值，请处理后再抢单！');
                }
            }else{
                if ($status3 >= $admin_daifu_number){
                    Db::rollback();
                    throw new Exception('正在处理订单已到最大值，请处理后再抢单！');
                }
            }


            $transfer->status = 3;
            $transfer->ms_id = $this->agent_id;
            $res = $transfer->save();
            if ($res){
                Db::commit();
                Log::notice('码商'.$this->agent_id.'抢到代付订单：'.$uid['out_trade_no']);
                $this->success('请求成功');
            }
        } catch (Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        /*$id = $this->request->param('id');
        if (!$id) {
            $this->error('非法操作');
        }
        try {
            $transfer = $this->modelDaifuOrders->lock(true)->where(['id' => $id])->find();
            if (!$transfer) {
                throw new \Exception('订单不存在');
            }
            if ($transfer->ms_id > 0 || $transfer->status != '1') {
                throw new Exception('订单已匹配');
            }
            $transfer->ms_id = $this->agent->userid;
            $transfer->matching_time = time();
            $transfer->save();
            $transfer->commit();
            $this->success('请求成功');
        } catch (Exception $e) {
            $this->error($e->getMessage());
        }*/
    }



    /**
     * 上传图片
     */
    public function upload(){

        $orderinfo = Db::name('daifu_orders')->where('id',$this->request->param('orderid'))->field('transfer_chart,ms_id')->find();
        if ($orderinfo['ms_id'] != $this->agent_id){
            $this->error('非法操作');
        }
        if (!empty($orderinfo['transfer_chart'])){
            $this->error('此订单已经上传过了');
        }


        // 获取表单上传文件 例如上传了001.jpg
        $file = request()->file('file');
//        print_r($file);die;
        // 移动到框架应用根目录/public/uploads/ 目录下
        if($file){
            $info = $file->validate(['size'=>1048576,'ext'=>'jpg,png','image' => 'require|image'])->move(ROOT_PATH . 'public' . DS . 'uploads'. DS .'transfer');
            if($info){
                $path=str_replace('\\','/',$info->getSaveName());
//                E:\wwwroot\git\sanfang\public\uploads\transfer\20221215\340c1ec6a83cfc681539174994e5e3f8.jpg
                $res = Db::name('daifu_orders')->where('id',$this->request->param('orderid'))->update(['transfer_chart'=>'/public/uploads/transfer/'.$path]);
//                public\uploads\transfer\20221215\fca52f78e51ac9e3aeeb3579b8ddca5d.jpg
                if ($res === false){
                    return json(['code'=>1,'msg'=>'上传失败']);
                }
                return json(['code'=>0,'msg'=>'上传成功']);
            }else{
                // 上传失败获取错误信息
//                echo $file->getError();

                return json(['code'=>1,'msg'=>$file->getError()]);
            }
        }
    }


    /**
     * 码商修改代付结果
     * @return mixed
     */
    public function sendDfResult()
    {
        $id = $this->request->param('id');
        $uid = Db::name('daifu_orders')->where('id',$id)->value('uid');
        $u_admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
        if ($admin_id != $u_admin_id){
            $this->error('非法操作1');
        }
        //代付银行卡
        $df_bank_id = $this->request->param('df_bank_id');
        $status = $this->request->param('status');
        $remark = $this->request->param('remark');
        $error_reason = $this->request->param('error_reason', '');
        if (!$id || !in_array($status, [0, 2])) {
            $this->error('非法操作');
        }
        Db::startTrans();
        $DaifuOrdersLogic = new \app\common\logic\DaifuOrders();
        try {
            $orders = $this->modelDaifuOrders->lock(true)->where(['id' => $id])->find();
            if (!$orders) {
                throw new Exception('订单不存在');
            }
         /*   $bank = $this->modelDepositeCard->where(['id' => $df_bank_id, 'status' => 1])->find();
            if ($status == 2) {
                if (empty($bank)) {
                    throw new Exception('当前不存在或卡号被卡被禁用');
                }
                if ($orders['uid'] != $bank['uid']) {
                    throw new Exception('当前代付银行卡只能被商户ID:' . $bank['uid'] . '充值或代付');
                }
                if ($bank['ms_id'] != $this->agent_id) {
                    throw new Exception('当前代付卡是由码商ID:' . $bank['ms_id'] . '添加您的操作非法');
                }
            }*/

            if ($status == 2) {
                $daifu_success_uplode = Db::name('config')->where(['name'=>'daifu_success_uplode','admin_id'=>$this->agent['admin_id']])->value('value');
                if (!empty($daifu_success_uplode) && $daifu_success_uplode == 2){
                    $daifuInfo = $this->modelDaifuOrders->where('id',$id)->value('transfer_chart');
                    if (empty($daifuInfo)){
                        throw new Exception('请先上传转账截图');
                    }
                }
                Db::name('daifu_orders')->where('id',$id)->update(['remark'=>$remark]);
                Log::notice('码商：'.$this->agent_id.' 成功完成代付订单：'.$orders['out_trade_no']);
                $result = $DaifuOrdersLogic->successOrder($orders['id']);
            } else {
                Log::notice('码商：'.$this->agent_id.' 进行代付失败操作，订单：'.$orders['out_trade_no']);
                $result = $DaifuOrdersLogic->errorOrder($orders['id']);
            }
            //更新订单的代付银行卡
            $up['finish_time'] = time();
//            $up['df_bank_id'] = $df_bank_id;
            $up['error_reason'] = $error_reason;

            $res = $this->modelDaifuOrders->where(['id' => $id])->update($up);

            if ($res === false) {
                throw new Exception('代付失败');
            }


            //添加银行卡流水日志
            /*if ($status == 2) {
                $remark = "码商【ID:{$this->agent_id}】为代付订单【ID:{$id}】代付";
                $this->logicDepositeCard->addLogs($df_bank_id, $orders['amount'], 2, 2, $remark);
            }*/

            Db::commit();

            if ($result['code'] == 1) {
                $this->success('操作成功', url('index'));
            }
            $this->error('操作成功', url('index'));
        } catch (Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
    }


    /**
     * 获取当前码商对应的商户的最新订单
     */
    public function lastOrder(\app\common\logic\User $user)
    {
        $uids = $user->getUsersByMsId($this->agent_id);
        $uids = collection($uids)->column('uid');
        $lastOrderId = \app\common\model\DaifuOrders::where(['uid' => ['in', $uids]])->order(['id' => 'desc'])->value('id');
        echo $lastOrderId;
    }


    /**
     * 导出代付订单
     * @param Request $request
     * @return mixed
     * @throws Exception
     * @throws \think\exception\DbException
     */
    public function exportDfOrder(Request $request)
    {
        $where = [];
        //当前时间段统计

        $startTime = $request->param('start_time');
        //dd($startTime);
        $endTime = $request->param('end_time');
        if ($startTime && empty($endTime)) {
            $where['a.create_time'] = ['egt', strtotime($startTime)];
        }
        if (empty($startTime) && $endTime) {
            $where['a.create_time'] = ['elt', strtotime($endTime)];
        }
        if ($startTime && $endTime) {
            $where['a.create_time'] = ['between', [strtotime($startTime), strtotime($endTime)]];
        }

        $status = $this->request->param('status', 1);
        $status != -1 && $where['a.status'] = ['eq', $status];

        !empty($this->request->param('trade_no')) && $where['a.trade_no']
            = ['eq', $this->request->param('trade_no')];
        !empty($this->request->param('out_trade_no')) && $where['a.out_trade_no']
            = ['eq', $this->request->param('out_trade_no')];
        //组合搜索
        !empty($this->request->param('uid')) && $where['a.uid']
            = ['eq', $this->request->param('uid')];
        $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');

        $adminSonUser = Db::name('user')->where('admin_id',$admin_id)->column('uid');
        $where['a.uid'] = ['in',$adminSonUser];

        $fields = ['a.*', 'b.pao_ms_ids', 'c.username', 'bank_account_username', 'bank_account_number', 'e.enable'];
        $query = $this->modelDaifuOrders->alias('a')
            ->join('user b', 'a.uid=b.uid', 'left')
            ->join('ms c', 'a.ms_id=c.userid', 'left')
            ->join('deposite_card d', 'a.df_bank_id=d.id', 'left')
            ->join('cm_balance e', 'a.uid=e.uid', 'left')
            ->field($fields)
            ->order('id desc')
            ->where($where)
            ->where(function ($query) {
                $query->whereOr("IF (a.ms_id!=0,a.ms_id = {$this->agent->userid},(find_in_set( {$this->agent->userid}, pao_ms_ids )  or pao_ms_ids=''))");
            });

        $listData = $query->select();

        //组装header 响应html为execl 感觉比PHPExcel类更快
        $orderStatus = ['处理失败', '待处理', '已完成'];


        $strTable = '<table width="500" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">ID标识</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="100">订单编号(商户)</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">商户UID</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">商户余额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收款信息</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">付款信息</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">状态</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">失败原因</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">创建时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">完成时间</td>';
        $strTable .= '</tr>';

        if ($listData) {
            foreach ($listData as $k => $val) {
                $skAccountInfo = '姓名:' . $val['bank_owner'] . ' 银行:' . $val['bank_name'] . ' 卡号:' . $val['bank_number'];
                $payAccountInfo = '---';
                if ($val['bank_id']) {
                    $payAccountInfo = '转账银行卡ID:' . $val['bank_id'] . ' 姓名:' . $val['bank_account_username'] . ' 卡号:' . $val['bank_account_number'];
                }
                $val['finish_time'] = $val['finish_time']?date("Y-m-d H:i:s",$val['finish_time']):'---';
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;' . $val['id'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['out_trade_no'] . ' </td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['uid'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['enable'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['amount'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $skAccountInfo . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $payAccountInfo . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $orderStatus[$val['status']] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['error_reason'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['create_time'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['finish_time'] . '</td>';
                $strTable .= '</tr>';
                unset($listData[$k]);
            }
        }
        $strTable .= '</table>';
        downloadExcel($strTable, 'daifu_orders_execl');
    }


}
