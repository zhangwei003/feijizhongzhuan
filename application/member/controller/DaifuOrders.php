<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/7
 * Time: 21:27
 */

namespace app\member\controller;


use app\common\library\enum\CodeEnum;
use app\common\library\RsaUtils;
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
    public function index(){
        $this->assign('status',$this->request->param('Orderstatus'));
        $rsa_public_key = $this->modelConfig->where('name', 'rsa_public_key')->value('value');
        $this->assign('publicKeyString', $rsa_public_key);
        return $this->fetch();
    }


    public function getDaifuOrderList(Request $request){
        $rsa_private_key = $this->modelConfig->where('name', 'rsa_private_key')->value('value');
        $rsa = new RsaUtils('', $rsa_private_key);

        $searchParams = [];
        if ($request->param('search')){
            $rsaRet = $rsa->decrypt($request->param('search'));
            if (empty($rsaRet)){
                return json([
                    'code'=>1,
                    'msg'=>'请求错误！'
                ]);
            }
            $searchParams = array_filter(json_decode($rsaRet,true));
        }

        $where = [];
        $startTime = '';
        $endTime = '';
        $where['create_time'] = ['elt',time()];
        if (isset($searchParams['startDate']) && $searchParams['startDate']){
            $startTime = $searchParams['startDate'];
            $where['create_time'] = ['egt', strtotime($startTime)];
        }

        if (isset($searchParams['endDate']) && $searchParams['endDate']){
            $endTime = $searchParams['endDate'];
            $where['create_time'] = ['elt',strtotime($endTime)];
        }

       if ($startTime && $endTime) {
            $where['create_time'] = ['between', [strtotime($startTime), strtotime($endTime)]];
        }


        $admin_sonUser = Db::name('user')->where('admin_id',$this->agent['admin_id'])->column('uid');
        if (!empty($request->param('limit'))){
            $limit = $request->param('limit');
        }

        if (!empty($request->param('page'))){
            $page = $request->param('page');
        }
        $where['uid'] = ['in',$admin_sonUser];
        $where['ms_id'] = $this->agent_id;

        if (isset($searchParams['trade_no']) && $searchParams['trade_no']){
            unset($where['create_time']);
            $where['trade_no'] = $searchParams['trade_no'];
        }

        if (isset($searchParams['out_trade_no']) && $searchParams['out_trade_no']){
            unset($where['create_time']);
            $where['out_trade_no'] = $searchParams['out_trade_no'];
        }

        $status = $searchParams['status'] ??  -1;
        if ($status != -1){
            $where['status'] = $status;
        }

        $exp = new \think\Db\Expression('field(status,3,2,0,1)');
        $start=$limit*($page-1);
        $query = $this->modelDaifuOrders
                        ->where($where)
                        ->limit($start,$limit)
                        ->order($exp)
                        ->order('id asc');


        if (($status == '-1' or $status == '1')&&empty($searchParams['out_trade_no'] ?? '')&&empty($searchParams['trade_no'] ?? '')){
            $query->whereOr(function ($query) {
                $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
                $adminSonUser = Db::name('user')->where('admin_id',$admin_id)->column('uid');
                $query->whereOr('uid', 'in', $adminSonUser)->where('status',1);
            });
        }

        $query = $query->select();

        $count = $this->modelDaifuOrders->where($where)->count();
        if ($count > 0){
            return json([
                'code'=>0,
                'msg'=>'请求成功',
                'data'=>$query,
                'count'=>$count
            ]);
        }else{
            return json([
                'code'=>1,
                'msg'=>'暂无数据'
            ]);
        }


    }

    /**
     * 获取错误注释
     */

    public function getErrorReson(){
        $daifu_logic = new \app\common\logic\Config();
        $daifu_err_reason = $daifu_logic->getConfigInfo(['name'=> 'daifu_err_reason']);
        $res = explode(",",$daifu_err_reason['value']);
        return json(['code'=>0,'data'=>$res]);
    }



    /**
     * 弃单
     */

    public function discard_df(){
        if ($this->request->isPost()){
            $id = $this->request->param('id');
            if (!$id) {
                return json(['code'=>0,'msg'=>'非法操作']);
            }

            $uid = Db::name('daifu_orders')->where('id',$id)->value('uid');
            $u_admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($this->agent['admin_id'] != $u_admin_id){
                return json(['code'=>0,'msg'=>'非法操作1']);
            }
            $this->modelDaifuOrders->startTrans();
            try {
                $transfer = $this->modelDaifuOrders->lock(true)->where(['id' => $id, 'status'=>3,'ms_id'=>$this->agent_id])->find();
                if (!$transfer) {
                    throw new Exception('订单不存在或者订单已处理，请刷新！');
                }
                $transfer->status = 1;
                $transfer->ms_id = 0;
                $transfer->save();
                $transfer->commit();
                return json(['code'=>1,'msg'=>'成功弃单']);
            } catch (Exception $e) {
                $transfer->rollback();
                return json(['code'=>0,'msg'=>$e->getMessage()]);
            }
        }

        return json(['code'=>0,'msg'=>'非法操作']);
    }

    /**
     * 匹配订单
     */
    public function matching()
    {
        if ($this->request->isPost()){
            $id = $this->request->post('id');
            if (!$id) {
                return json(['code'=>0,'msg'=>'非法操作']);
            }

            $cache = Cache::get('matching'.$this->agent_id);
            if (!empty($cache) && (time()-$cache) < 15){
//            $this->error('频率过高，请稍后再来');
            }
            Cache::set('matching'.$this->agent_id,time());

            $uid = Db::name('daifu_orders')->where('id',$id)->find();
            $u_admin_id = Db::name('user')->where('uid',$uid['uid'])->value('admin_id');
            if ($this->agent['admin_id'] != $u_admin_id){
                return json(['code'=>0,'msg'=>'非法操作1']);
            }
            Db::startTrans();
            try {
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
                if ($status3 > 2){
                    Db::rollback();
                    throw new Exception('正在处理订单已到最大值，请处理后再抢单！');
                }
                $transfer->status = 3;
                $transfer->ms_id = $this->agent_id;
                $res = $transfer->save();
                if ($res){
                    Db::commit();
                    Log::notice('码商'.$this->agent_id.'抢到代付订单：'.$uid['out_trade_no']);
                    return json(['code'=>1,'msg'=>'请求成功']);
                }
            } catch (Exception $e) {
                Db::rollback();
                return json(['code'=>0,'msg'=>$e->getMessage()]);
            }
        }
        return json(['code'=>0,'msg'=>'非法操作']);
    }

    /**
     * 码商修改代付结果
     * @return mixed
     */
    public function sendDfResult(Request $request)
    {
        if ($request->isPost()){
            $id = $this->request->param('id');
            $uid = Db::name('daifu_orders')->where('id',$id)->value('uid');
            $u_admin_id = Db::name('user')->where('uid',$uid)->value('admin_id');
            $admin_id = Db::name('ms')->where('userid',$this->agent_id)->value('admin_id');
            if ($admin_id != $u_admin_id){
                return json(['code'=>0,'msg'=>'非法操作']);
            }
            //代付银行卡
//            $df_bank_id = $this->request->param('df_bank_id');
            $status = $this->request->param('status');
            $remark = $this->request->param('remark');
            $error_reason = $this->request->param('error_reason', '');
//            print_r($error_reason);die;
            if (!$id || !in_array($status, [0, 2])) {
                return json(['code'=>0,'msg'=>'非法操作']);
            }
            Db::startTrans();
            $DaifuOrdersLogic = new \app\common\logic\DaifuOrders();
            try {
                $orders = $this->modelDaifuOrders->lock(true)->where(['id' => $id])->find();
                if (!$orders) {
                    throw new Exception('订单不存在');
                }

                if ($status == 2) {
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

                Db::commit();

                return $result;
            } catch (Exception $e) {
                Db::rollback();
                return json(['code'=>0,'msg'=>$e->getMessage()]);
            }
        }
        return json(['code'=>0,'msg'=>'非法操作']);

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
