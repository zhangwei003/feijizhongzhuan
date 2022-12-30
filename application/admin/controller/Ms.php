<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/7
 * Time: 21:27
 */

namespace app\admin\controller;


use app\common\library\CryptAes;
use app\common\library\enum\CodeEnum;
use app\common\logic\CodeLogic;
use app\common\logic\Config;
use app\common\logic\MsMoneyType;
use app\common\logic\MsSomeBill;
use app\common\logic\Queuev1Logic;
use app\common\model\EwmPayCode;
use app\common\model\MsWhiteIp;
use think\Db;
use think\Error;
use think\Request;


/**
 * 码商管理
 * Class Mch
 * @package app\admin\controller
 */
class Ms extends BaseAdmin
{

    /**
     * 一键停工
     */
    public function closemswork(){
        if (is_admin_login() != 1){
            $res = Db::name('ms')->where('admin_id',is_admin_login())->update(['work_status'=>0]);
        }else{
            $res = Db::name('ms')->where('work_status',1)->update(['work_status'=>0]);
        }
        if ($res === false){
            return json(['code'=>0]);
        }else{
            return json(['code'=>1]);
        }
    }

    /**
     * 码商统计
     */
    public function stats(){
        $code = Db::name('pay_code')->where('status',1)->select();

        $this->assign('code',$code);

        return $this->fetch();
    }

    /**
     * 获取码商统计
     */
    public function getMsStats(){
        $where = [];
        $msWhere = [];
        if (is_admin_login() != 1){
            $msWhere['admin_id'] = is_admin_login();

        }
        if (!empty($this->request->param('username'))){
            $where['gema_username'] = $this->request->param('username');
        }

        if (!empty($this->request->param('code_type'))){
            $where['code_type'] = $this->request->param('code_type');
        }

        $start_time = date('Y-m-d 00:00:00',time());
        $end_time = date('Y-m-d 23:59:59',time());

        if (!empty($this->request->param('start')) && !empty($this->request->param('end'))){
            $start_time = $this->request->param('start');
            $end_time = $this->request->param('end');
        }

        $where['add_time'] = ['between time',[$start_time,$end_time]];

        $msList = Db::name('ms')->where($msWhere)->where('status',1)->select();

        foreach ($msList as $k=>$v){
                $msList[$k]['total_number'] = Db::name('ewm_order')
                                                        ->where($where)
                                                        ->where('gema_userid',$v['userid'])
                                                        ->count();

                $msList[$k]['success_number'] = Db::name('ewm_order')
                                                        ->where($where)
                                                        ->where('gema_userid',$v['userid'])
                                                        ->where('status',1)
                                                        ->count();

                $msList[$k]['total_amount'] = Db::name('ewm_order')
                                                        ->where('gema_userid',$v['userid'])
                                                        ->where($where)
                                                        ->sum('order_price');

                $msList[$k]['success_amount'] = Db::name('ewm_order')
                                                        ->where('gema_userid',$v['userid'])
                                                        ->where($where)
                                                        ->where('status',1)
                                                         ->sum('order_price');



                 if ($msList[$k]['success_number'] == 0){
                     $msList[$k]['success_rate'] = 0;
                 }else{
                     $mssuccessrate = sprintf("%.2f",$msList[$k]['success_number'] / $msList[$k]['total_number'] * 100);
                     $msList[$k]['success_rate'] = $mssuccessrate;
                 }


        }

        return json(['code'=>0,'data'=>$msList,'count'=>count($msList)]);

    }


    /**
     * @return mixed
     */
    public function index()
    {
        $where['status'] = 1;
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }
        $msMoney = Db::name('ms')->where($where)->sum('money');

        $where['work_status'] = 1;
        $where['money'] = ['GT',0];
        $nolineMs = Db::name('ms')->where($where)->select();
        $where1['status'] = 1;
        foreach ($nolineMs as $k=>$v){
            $nolineCode = Db::name('ewm_pay_code')->where('ms_id',$v['userid'])->where($where1)->count();
            if ($nolineCode == 0){
                unset($nolineMs[$k]);
            }
        }
        $nolineCode = count($nolineMs);

        $this->assign('online',$nolineCode);
        $this->assign('msMoney',$msMoney);
        return $this->fetch();
    }


    /**
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     * 修改码商权重
     */

        public function editMsWeight(){
            $userid = $this->request->param('userid');
            $value = $this->request->param('value');
            $ulist = Db::name('ms')->where('userid',$userid)->find();
            if (empty($ulist)){
                $this->error('非法操作');
            }
            if (is_admin_login() != 1){
                if (is_admin_login() != $ulist['admin_id']){
                    $this->error('非法操作');
                }
            }
            if($value < 1 || $value > 9){
                return json(['code'=>404,'msg'=>'权重范围为1-9']);
            }
            $res = Db::name('ms')->where('userid',$userid)->update(['weight'=>$value]);
            if($res === false){
                return json([
                    'code' => 404,
                    'msg' => 'ERROR'
                ]);
            }else{
                return json([
                    'code' => 1
                ]);
            }
        }


    /**
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     * 修改码商状态
     */
    public function editMsStatus(){
        $userid = $this->request->param('userid');
        $status = $this->request->param('ms_status')==1?0:1;
        $ulist = Db::name('ms')->where('userid',$userid)->find();
        if (empty($ulist)){
            $this->error('非法操作');
        }
        if (is_admin_login() != 1){
            if (is_admin_login() != $ulist['admin_id']){
                $this->error('非法操作');
            }
        }
        $res = Db::name('ms')->where('userid',$userid)->update(['status'=>$status]);
        if($res === false){
        return json([
                'code' => 404
                    ]);
        }else{
         return json([
                'code' => 1
                ]);
        }
    }


    /**
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     * 修改码商接单状态
     */
    
        public function editMsJdStatus(){
        $userid = $this->request->param('userid');
        $status = $this->request->param('ms_jd_status')==1?0:1;
        // print_r($userid);die;
            $ulist = Db::name('ms')->where('userid',$userid)->find();
            if (empty($ulist)){
                $this->error('非法操作');
            }
            if (is_admin_login() != 1){
                if (is_admin_login() != $ulist['admin_id']){
                    $this->error('非法操作');
                }
            }
        $res = Db::name('ms')->where('userid',$userid)->update(['work_status'=>$status]);
        if($res === false){
        return json([
                'code' => 404
                    ]);
        }else{
            $where['status'] = 1;
            if (is_admin_login() != 1){
                $where['admin_id'] = is_admin_login();
            }
            $where['work_status'] = 1;
            $where['money'] = ['GT',0];
            $nolineMs = Db::name('ms')->where($where)->select();
            $where1['status'] = 1;
//            $where1['ms_id'] = ['in',$nolineMs];
//            $nolineCode = Db::name('ewm_pay_code')->where($where1)->count();
            foreach ($nolineMs as $k=>$v){
                $nolineCode = Db::name('ewm_pay_code')->where('ms_id',$v['userid'])->where($where1)->count();
                if ($nolineCode == 0){
                    unset($nolineMs[$k]);
                }
            }
            $nolineCode = count($nolineMs);
         return json([
                'code' => 1,
                'data' => $nolineCode
                ]);
        }
    }

    /**
     * 更新码子状态
     *
     */
    public function disactiveCode(){
        $coid = $this->request->param('coid');
        $status = $this->request->param('status')==1?0:1;
        // print_r($userid);die;
        $res = Db::name('ewm_pay_code')->where('id',$coid)->update(['status'=>$status]);
        if($res === false){
            return json([
                'code' => 404
            ]);
        }else{
            return json([
                'code' => 1
            ]);
        }
    }




    /**
     * @user luomu
     * @return
     * @time
     *
     */

    public function subnotify()
    {
        $order = Db::name('ewm_order')->where('id',$this->request->param('order_id'))->find();
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            if (!in_array($order['gema_userid'],$adminSonMs)){
                return $this->error('非法请求');
            }
        }

        $order_id = Db::name('orders')->where('trade_no',$order['order_no'])->value('id');
        $this->result($this->logicOrders->pushOrderNotifyV2($order_id));
    }



    /**
     * 统计金额根据筛选条件变动 旧
     */

    public function searchMsOrderMoney_old(){

        $code_type = $this->request->param('code_type');

        $where['e.code_type'] = $code_type;
        $where['e.add_time'] = $this->parseRequestDate3();
        if (trim($this->request->param('start')) != '' && trim($this->request->param('start')) != ''){
            $startTime = $this->request->param('start');
            $endTime = $this->request->param('end');
            $where['e.add_time'] = ['between time',[$startTime,$endTime]];
        }
        if (trim($this->request->param('order_no')) != ''){
            unset($where['create_time']);
            $where['e.order_no'] = trim($this->request->param('order_no'));
        }

        if (trim($this->request->param('username')) != ''){
            $where['e.gema_username'] = trim($this->request->param('username'));
        }

        if (trim($this->request->param('uid')) != ''){
            $where['o.uid'] = trim($this->request->param('uid'));
        }



        if (trim($this->request->param('pay_username')) != ''){
            $where['e.pay_username'] = trim($this->request->param('pay_username'));
        }

        if (trim($this->request->param('pay_user_name')) != ''){
            $where['e.pay_user_name'] = trim($this->request->param('pay_user_name'));
        }

        if (trim($this->request->param('status')) != ''){
            $where['e.status'] = $this->request->param('status');
        }

        if (is_admin_login() != 1){
            $where['u.admin_id'] = is_admin_login();
//            $adminsonuser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
//            $where['o.uid'] = ['in',$adminsonuser];
        }



        $fees['total'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->where($where)
            ->sum('e.order_price');


        $fees['paid'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->where($where)
            ->where('e.status',1)
            ->sum('e.order_price');


        $fees['total_num'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->where($where)
            ->count();

        $fees['success_num'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->where($where)
            ->where('e.status',1)
            ->count();
        if ($fees['success_num'] == 0 ){
            $fees['success_rate'] = 0;
        } else{
            $fees['success_rate'] = sprintf("%.2f",$fees['success_num']/$fees['total_num']*100);
        }

        return json($fees);
    }

    /**
     * 统计金额根据筛选条件变动 新
     */

    public function searchMsOrderMoney(){
        return $this->searchMsUidOrOrderMoney('kzk');
    }

    /**
     * 统计金额根据筛选条件变动 新
     */
    public function searchMsUidOrOrderMoney($type){
        
        $where['e.add_time'] = $this->parseRequestDate3();
        if (trim($this->request->param('start')) != '' && trim($this->request->param('start')) != ''){
            $startTime = $this->request->param('start');
            $endTime = $this->request->param('end');
            $where['e.add_time'] = ['between time',[$startTime,$endTime]];
        }
        if (trim($this->request->param('order_no')) != ''){
            unset($where['create_time']);
            $where['e.order_no'] = ['=', trim($this->request->param('order_no'))];
        }

        if (trim($this->request->param('username')) != ''){
            $where['e.gema_username'] = ['=', trim($this->request->param('username'))];
        }

        if (trim($this->request->param('uid')) != ''){
            $where['o.uid'] = ['=', trim($this->request->param('uid'))];
        }
        
        if (trim($this->request->param('pay_username')) != ''){
            $where['e.pay_username'] = ['=', trim($this->request->param('pay_username'))];
        }

        if (trim($this->request->param('pay_user_name')) != ''){
            $where['e.pay_user_name'] = ['=', trim($this->request->param('pay_user_name'))];
        }

        if (trim($this->request->param('status')) != ''){
            $where['e.status'] = ['=', $this->request->param('status')];
        }

        if (is_admin_login() != 1){
            $where['u.admin_id'] = is_admin_login();
        }
    
        $code_type = $this->request->param('code_type');
        
        
        $query = Db::name('ewm_order');


        
        if ($type == 'uidOrders') {
             $where['p.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
//            $query = $query->alias('e')->join('pay_code p','e.code_type = p.id')
//                ->where('p.code', 'in', ['alipayUid','alipayUidSmall']);
            $code_type && $where['p.code'] = $code_type;
        }else{
              $where['p.code'] = $type;
                $code_type && $where['e.code_type'] = ['=', $code_type];
        }

        

        $fees['total'] = $query->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->sum('e.order_price');


        $fees['paid'] = $query->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->where('e.status',1)
            ->sum('e.order_price');


        $fees['total_num'] = $query->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->count();

        $fees['success_num'] = $query->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->where('e.status',1)
            ->count();
        if ($fees['success_num'] == 0 ){
            $fees['success_rate'] = 0;
        } else{
            $fees['success_rate'] = sprintf("%.2f",$fees['success_num']/$fees['total_num']*100);
        }

        return json($fees);
    }

    public function searchMsUidOrderMoney_old(){

//        $code_type = $this->request->param('code_type');
//
//        $where['e.code_type'] = $code_type;
        $where['p.code'] = ['in',['alipayUid','alipayUidSmall']];
        $where['e.add_time'] = $this->parseRequestDate3();
        if (trim($this->request->param('start')) != '' && trim($this->request->param('start')) != ''){
            $startTime = $this->request->param('start');
            $endTime = $this->request->param('end');
            $where['e.add_time'] = ['between time',[$startTime,$endTime]];
        }
        if (trim($this->request->param('order_no')) != ''){
            unset($where['create_time']);
            $where['e.order_no'] = trim($this->request->param('order_no'));
        }

        if (trim($this->request->param('username')) != ''){
            $where['e.gema_username'] = trim($this->request->param('username'));
        }

        if (trim($this->request->param('uid')) != ''){
            $where['o.uid'] = trim($this->request->param('uid'));
        }



        if (trim($this->request->param('pay_username')) != ''){
            $where['e.pay_username'] = trim($this->request->param('pay_username'));
        }

        if (trim($this->request->param('pay_user_name')) != ''){
            $where['e.pay_user_name'] = trim($this->request->param('pay_user_name'));
        }

        if (trim($this->request->param('status')) != ''){
            $where['e.status'] = $this->request->param('status');
        }

        if (trim($this->request->param('code_type')) != ''){
            $where['p.code'] = $this->request->param('code_type');
        }

        if (is_admin_login() != 1){
            $where['u.admin_id'] = is_admin_login();
//            $adminsonuser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
//            $where['o.uid'] = ['in',$adminsonuser];
        }



        $fees['total'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->sum('e.order_price');


        $fees['paid'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->where('e.status',1)
            ->sum('e.order_price');


        $fees['total_num'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->count();

        $fees['success_num'] = Db::name('ewm_order')
            ->alias('e')
            ->join('orders o','e.order_no = o.trade_no','left')
            ->join('user u','o.uid = u.uid')
            ->join('pay_code p','e.code_type = p.id')
            ->where($where)
            ->where('e.status',1)
            ->count();
        if ($fees['success_num'] == 0 ){
            $fees['success_rate'] = 0;
        } else{
            $fees['success_rate'] = sprintf("%.2f",$fees['success_num']/$fees['total_num']*100);
        }

        return json($fees);
    }
    
    public function searchMsUidOrderMoney(){
        return $this->searchMsUidOrOrderMoney('uidOrders');
    }

    public function searchMsAlipayCodeOrderMoney(){
        return $this->searchMsUidOrOrderMoney('alipayCode');
    }
    

    /**
     * 获取商户列表
     */
    public function getmslist()
    {

        $where = [];
        !empty($this->request->param('username')) && $where['username']
            = ['like', '%' . $this->request->param('username') . '%'];
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }


        $data = $this->logicMs->getMsList($where, true, 'reg_date desc', false);
        foreach ($data as $k=>$v){
            $data[$k]['p_username'] = Db::name('ms')->where('userid',$v['pid'])->value('username');
        }
        $count = $this->logicMs->getMsCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]);
    }


    public function searchMsMoney(){
        $where['status'] = 1;
        !empty($this->request->param('username')) && $where['username']
            = ['like', '%' . $this->request->param('username') . '%'];
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }
        $msMoney = Db::name('ms')->where($where)->sum('money');
        $this->result(['code'=>CodeEnum::SUCCESS,'data'=>$msMoney]);
    }

    /**
     * 设置码商费率
     */

    public function assign_channels(){
        if ($this->request->isPost()){
            $data = $this->request->post('r/a');
            if (is_array($data)){
                foreach ($data as  $key=>$item) {

                    if ($item['ms_rate'] < 0){
                        return ['code' => CodeEnum::ERROR, 'msg'=>'费率最低为0'];
                    }

                    $mspid = Db::name('ms')->where('userid',$item['ms_id'])->value('pid');
                    if ($mspid > 0){
                            $parRate = Db::name('ms_rate')->where(['ms_id'=>$mspid,'code_type_id'=>$item['code_type_id']])->value('rate');
                            if ($item['ms_rate'] > $parRate){
                                return ['code' => CodeEnum::ERROR, 'msg'=>'费率不可高于其上级费率'];
                            }
                    }

                    $res = Db::name('ms_rate')->where(['ms_id'=>$item['ms_id'],'code_type_id'=>$item['code_type_id']])->select();
                    if ($res){
                        //修改
                        Db::name('ms_rate')->where(['ms_id'=>$item['ms_id'],'code_type_id'=>$item['code_type_id']])->update(['rate' => $item['ms_rate'], 'update_time' => time()]);
                    }else{
                        //新增
                        Db::name('ms_rate')->insert( [
                            'ms_id' => $item['ms_id'],
                            'code_type_id' => $item['code_type_id'],
                            'rate' => $item['ms_rate'],
                            'create_time' => time(),
                            'update_time' => time(),
                        ]);
                    }

                }
                return ['code' => CodeEnum::SUCCESS, 'msg' => '费率配置成功'];
            }
        }

//        $msRate = $this->modelMsRate->where('ms_id',$this->request->param('id'))->select();
//        $sonMsid = $this->request->param('userid');
        $sonMs = Db::name('ms')->where('userid',$this->request->param('id'))->find();
        if (empty($sonMs)){
            $this->error('什么都没有');
        }

        //所有渠道列表
//        $list = $this->logicPay->getChannelList(['status' => '1'], true, 'create_time desc', false);
        $list = Db::name('pay_code')->where('status',1)->select();
//                print_r($list);die;
        /*        $channel_array = [];
                foreach ($list as $k => $v) {
                    $channel_array[] = $v['id'];
                }*/
        //所有渠道列表
//        $channel = $this->logicPay->getAccountList(['cnl_id' => ['in', $channel_array]], true, 'create_time desc', false);

        //查询自己的费率

        $myRate = Db::name('ms_rate')->where('ms_id',$this->request->param('id'))->select();

        //查询当前下级的费率
//        $sonRate = Db::name('ms_rate')->where('ms_id',$sonMs['userid'])->select();


        if ($myRate){
		foreach ($list as $k=>$v){
		 $list[$k]['ms_rate'] = 0;
                foreach ($myRate as $key=>$val){
                    if ($v['id'] == $val['code_type_id']){
                        $list[$k]['ms_rate'] = sprintf("%.1f",$val['rate']);
                    }
                }
            }
        }else{
            foreach ($list as $key=>$val){
                $list[$key]['ms_rate'] = 0;
            }
        }


        $this->assign('list', $list);
        //print_r($list);die;
        return $this->fetch();
    }


    /**
     *
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function add()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicMs->addMs($this->request->post(),0,1,is_admin_login()));
        $where = [];
        $where['status'] = 1;
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }

        $ms = Db::name('ms')
                    ->where($where)
                    ->field('userid,username')
                    ->select();
        $this->assign('ms',$ms);
        return $this->fetch();
    }

    /**
     *
     *编辑码商
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function edit(Request $request)
    {
        $userid = trim($request->param('userid'));
        if (!$userid) {
            $this->error('参数错误');
        }
        $ulist = Db::name('ms')->where(array('userid' => $userid))->find();
        if (!$ulist) {
            $this->error('会员不存在');
        }


        if (is_admin_login() != 1){
            if (is_admin_login() != $ulist['admin_id']){
                $this->error('非法操作');
            }
        }

        if ($request->isPost()) {
//            print_r($request->param());die;
            if ($request->param('cash_pledge') < 0){
                $this->error('押金最小为0');
            }
            $data['username'] = trim($request->param('username'));
            $data['mobile'] = trim($request->param('mobile'));
            $data['status'] = $request->param('status');
            $data['is_daifu'] = $request->param('is_daifu');
            $data['cash_pledge'] = sprintf("%.2f",$request->param('cash_pledge'));
            $login_pwd = trim($request->param('login_pwd', ''));
            $relogin_pwd = trim($request->param('relogin_pwd', ''));
            if ($login_pwd && $login_pwd != $relogin_pwd) {
                $this->error('修改密码时,两次密码不一致');
            }

            if ($login_pwd) {
                $data['login_pwd'] = pwdMd52($login_pwd, $ulist['login_salt']);
            }

            $safety_pwd = trim($request->param('safety_pwd', ''));


            //安全密码
            if ($safety_pwd) {
                $data['security_pwd'] = pwdMd5($safety_pwd, $ulist['security_salt']); //safety_salt
            }


            $auth_ips = $this->request->param('auth_ips');
            $auth_ips = array_filter(explode("\r\n", $auth_ips));
            $tempIps = [];
            foreach ($auth_ips as $ip) {
                $ip = trim($ip);
                if (empty($ip)) {
                    continue;
                }
                if (!filter_var($ip, FILTER_VALIDATE_IP)) {
                    $this->error('ip格式填写错误');
                    die();
                }
                $tempIps[] = $ip;
            }
            $data['auth_ips'] = trim(implode(',', $tempIps));
            $data['updatetime'] = time();
            $data['bank_rate'] = request()->param('bank_rate', 0);
            $data['deposit_floating_money'] = request()->param('deposit_floating_money', 0.00);

            $re = Db::name('ms')->where(array('userid' => $userid))->update($data);
            if ($re) {
                $this->success('资料修改成功');
            } else {
                $this->error('资料修改失败');
            }
        } else {
            $this->assign('info', $ulist);
            return $this->fetch();
        }
    }

    /**
     * 删除码商
     */
    public function del(Request $request)
    {
        $userid = trim($request->param('userid'));
        //判断是否有下级会员
        $pUser = Db::name('ms')->where(['pid' => $userid, 'status' => ['neq', '-1']])->select();
        if ($pUser) {
            $this->error('会员有下级，不能删除');
        }
        Db::name('ms')->where(array('userid' => $userid))->update(['status' => '-1']);
        $this->success('会员删除成功');
    }


    /*
     * 码商订单列表 旧
     */

    public function orders_old(Request $request)
    {
        $startTime = date("Y-m-d 00:00:00",time());
        $endTime = date("Y-m-d 23:59:59",time());
        $where['add_time'] = ['between time',[$startTime,$endTime]];
        $where['code_type'] = 30;
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['gema_userid'] = ['in',$adminSonMs];
//            $where['m.admin_id'] = is_admin_login();
        }

        $query = Db::name('ewm_order');
        $fees['total'] = $query->where($where)->sum('order_price');
        $fees['paid'] = $query->where($where)->where('status',1)->sum('order_price');

        $fees['total_num'] = $query->where($where)->count();
        $fees['success_num'] = $query->where($where)->where('status',1)->count();


        $fees['success_rate'] =  $fees['success_num']==0?0: sprintf("%.2f",$fees['success_num']/$fees['total_num']*100);

        $this->assign('fees',$fees);
        return $this->fetch();
    }
    
    public function orders()
    {
        return $this->ordersOrUidOrder('kzk');
        
    }

    /*
     * 码商订单列表 和 uid 订单列表
     */
    protected function ordersOrUidOrder($type)
    {
        $startTime = date("Y-m-d 00:00:00",time());
        $endTime = date("Y-m-d 23:59:59",time());
        $where['a.add_time'] = ['between time',[$startTime,$endTime]];
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['a.gema_userid'] = ['in',$adminSonMs];
            $adminSonUser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
            $where['o.uid'] = ['in',$adminSonUser];
        }
        
        $query = Db::name('ewm_order');
//        if ($type == 'orders') {
//            $where['a.code_type'] = 30;
//        }
        if ($type == 'uidOrder') {
//            $query = $query->alias('a')->join('pay_code b','b.id = a.code_type')
//                ->where('b.code', 'in', ['alipayUid','alipayUidSmall']);
            $where['b.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
        }else{
            $where['b.code'] = $type;
        }
        $fees = [];
        
        $fees['total'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->join('orders o','a.order_no = o.trade_no')->where($where)->sum('order_price');
    
        $fees['total_num'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->join('orders o','a.order_no = o.trade_no')->where($where)->count();
    
        $where['a.status'] = ['=', 1];
        
        $fees['paid'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->where($where)->join('orders o','a.order_no = o.trade_no')->sum('order_price');
        $fees['success_num'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->join('orders o','a.order_no = o.trade_no')->where($where)->count();


        $fees['success_rate'] =  $fees['success_num']==0?0: sprintf("%.2f",$fees['success_num']/$fees['total_num']*100);

        $this->assign('fees',$fees);
        return $this->fetch();
    }



    /*
     * 码商订单列表
     */

    public function uidOrder_old(Request $request)
    {
        $startTime = date("Y-m-d 00:00:00",time());
        $endTime = date("Y-m-d 23:59:59",time());
        $where['a.add_time'] = ['between time',[$startTime,$endTime]];
        $where['b.code'] = ['in',['alipayUid','alipayUidSmall']];
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['a.gema_userid'] = ['in',$adminSonMs];
//            $where['m.admin_id'] = is_admin_login();
        }

        $query = Db::name('ewm_order');
        $fees['total'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->where($where)->sum('a.order_price');
        $fees['paid'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->where($where)->where('a.status',1)->sum('a.order_price');

        $fees['total_num'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->where($where)->count();
        $fees['success_num'] = $query->alias('a')->join('pay_code b','b.id = a.code_type')->where($where)->where('a.status',1)->count();


        $fees['success_rate'] =  $fees['success_num']==0?0: sprintf("%.2f",$fees['success_num']/$fees['total_num']*100);

        $this->assign('fees',$fees);
        return $this->fetch();
    }

    public function uidOrder()
    {
        return $this->ordersOrUidOrder('uidOrder');
    }



    public function alipayCodeOrder()
    {
        return $this->ordersOrUidOrder('alipayCode');
    }


    public function getOrdersList_old()
    {

        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }

        //时间搜索  时间戳搜素
        $where['a.add_time'] = $this->parseRequestDate3();


        !empty($this->request->param('username')) && $where['c.username']
            = ['like', '%'.$this->request->param('username').'%'];

        !empty($this->request->param('uid')) && $where['o.uid']
            = ['eq', $this->request->param('uid')];

        !empty($this->request->param('account_name')) && $where['b.account_name']
            = ['eq', $this->request->param('account_name')];

        !empty($this->request->param('pay_username')) && $where['a.pay_username']
            = ['eq', $this->request->param('pay_username')];

        !empty($this->request->param('pay_user_name')) && $where['a.pay_user_name']
            = ['eq', $this->request->param('pay_user_name')];

        if(!empty($this->request->param('order_no'))){
            unset($where['a.add_time']);
            $where['a.order_no']= ['eq', $this->request->param('order_no')];

        }
        $where['a.code_type'] = 30;
        if (is_admin_login() != 1){
//            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['a.gema_userid'] = ['in',$adminSonMs];
        }

        $fields = ['a.*', 'b.account_name', 'b.bank_name', 'account_number', 'c.username', 'eo.id as block_ip_id','u.username as shname','u.uid as shuid','n.is_status'];
        $data = $this->logicEwmOrder->getOrderList($where, $fields, 'a.add_time desc', false);

        !empty($this->request->param('pay_username')) && $where['pay_username']
            = ['eq', $this->request->param('pay_username')];


        $count = $this->logicEwmOrder->getOrdersCount($where);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }
    
    public function getOrdersList()
    {
        return $this->getUidOrOrdersList('kzk');
    }


    public function getalipayCodeOrdersList()
    {
        return $this->getUidOrOrdersList('alipayCode');
    }
    
    protected function getUidOrOrdersList($type)
    {
        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }

        //时间搜索  时间戳搜素
        $where['a.add_time'] = $this->parseRequestDate3();
    
    
        !empty($this->request->param('username')) && $where['c.username']
            = ['like', '%'.$this->request->param('username').'%'];
    
        !empty($this->request->param('uid')) && $where['o.uid']
            = ['eq', $this->request->param('uid')];
    
        !empty($this->request->param('account_name')) && $where['b.account_name']
            = ['eq', $this->request->param('account_name')];
    
        !empty($this->request->param('pay_username')) && $where['a.pay_username']
            = ['eq', $this->request->param('pay_username')];
    
        !empty($this->request->param('pay_user_name')) && $where['a.pay_user_name']
            = ['eq', $this->request->param('pay_user_name')];
    
        if(!empty($this->request->param('order_no'))){
            unset($where['a.add_time']);
            $where['a.order_no']= ['eq', $this->request->param('order_no')];
        
        }

        if (is_admin_login() != 1){
            $adminSonUser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
            $where['o.uid'] = ['in',$adminSonUser];
        }


        if ($type == 'uidOrders') {
            $where['p.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
            $fields = ['a.*', 'b.account_name', 'b.bank_name', 'account_number', 'c.username', 'eo.id as block_ip_id','u.username as shname','u.uid as shuid','n.is_status','p.name'];
        }else{
            $where['p.code'] = $type;
            $fields = ['a.*', 'b.account_name', 'b.bank_name', 'account_number', 'c.username', 'eo.id as block_ip_id','u.username as shname','u.uid as shuid','n.is_status'];
        }

        if(!empty($this->request->param('code_type'))){
//            unset($where['p.add_time']);
            $where['p.code']= ['eq', $this->request->param('code_type')];

        }

//        print_r($where);die;

        $data = $this->logicEwmOrder->getOrderList($where, $fields, 'a.add_time desc', false);
//        print_r($this->logicEwmOrder->getLastSql());die;

        !empty($this->request->param('pay_username')) && $where['pay_username']
            = ['eq', $this->request->param('pay_username')];
    
    
        $count = $this->logicEwmOrder->getOrdersCount($where);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }


    public function smsinfo(){
        $orderid = $this->request->param('id');
        $where = [];
        if (is_admin_login() != 1){
            $sonMS = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['ms_id'] = ['in',$sonMS];
        }
        $sms = Db::name('banktobank_sms')->where($where)->where('order_id',$orderid)->find();
        if (empty($sms)){
            $this->error('Error Empty Data!');
        }
        $this->assign('sms',$sms);
        return $this->fetch();
    }


    public function getuidOrdersList_old()
    {

        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }

        //时间搜索  时间戳搜素
        $where['a.add_time'] = $this->parseRequestDate3();

        !empty($this->request->param('username')) && $where['c.username']
            = ['like', '%'.$this->request->param('username').'%'];

        !empty($this->request->param('uid')) && $where['o.uid']
            = ['eq', $this->request->param('uid')];

        !empty($this->request->param('account_name')) && $where['b.account_name']
            = ['eq', $this->request->param('account_name')];

        !empty($this->request->param('pay_username')) && $where['a.pay_username']
            = ['eq', $this->request->param('pay_username')];

        !empty($this->request->param('pay_user_name')) && $where['a.pay_user_name']
            = ['eq', $this->request->param('pay_user_name')];

        if(!empty($this->request->param('order_no'))){
            unset($where['a.add_time']);
            $where['a.order_no']= ['eq', $this->request->param('order_no')];

        }

        $where['p.code'] = ['in',['alipayUid','alipayUidSmall']];
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['a.gema_userid'] = ['in',$adminSonMs];
        }

        if(!empty($this->request->param('code_type'))){
//            unset($where['p.add_time']);
            $where['p.code']= ['eq', $this->request->param('code_type')];

        }

        $fields = ['a.*', 'b.account_name', 'b.bank_name', 'account_number', 'c.username', 'eo.id as block_ip_id','u.username as shname','u.uid as shuid','n.is_status','p.name'];
        $data = $this->logicEwmOrder->getOrderList($where, $fields, 'a.add_time desc', false);

        !empty($this->request->param('pay_username')) && $where['pay_username']
            = ['eq', $this->request->param('pay_username')];


        $count = $this->logicEwmOrder->getOrdersCount($where);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }
    
    public function getuidOrdersList()
    {
        return $this->getUidOrOrdersList('uidOrders');
    }

    public function abnormalOrders()
    {
        return $this->fetch();
    }

    public function getAbnormalOrdersList()
    {

        $where['name_abnormal|money_abnormal'] = 1;

        //状态
        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }
        !empty($this->request->param('order_no')) && $where['order_no']
            = ['eq', $this->request->param('order_no')];
        //时间搜索  时间戳搜素
        $where['add_time'] = $this->parseRequestDate3();

        !empty($this->request->param('username')) && $where['c.username']
            = ['eq', $this->request->param('username')];

        !empty($this->request->param('amount')) && $where['order_pay_price']
            = ['eq', $this->request->param('amount')];

        !empty($this->request->param('account_name')) && $where['b.account_name']
            = ['eq', $this->request->param('account_name')];

        !empty($this->request->param('pay_username')) && $where['pay_username']
            = ['eq', $this->request->param('pay_username')];

        !empty($this->request->param('pay_user_name')) && $where['pay_user_name']
            = ['eq', $this->request->param('pay_user_name')];

        $fields = ['a.*', 'b.account_name', 'b.bank_name', 'account_number', 'c.username'];
        $data = $this->logicEwmOrder->getOrderList($where, $fields, 'add_time desc', false);

        !empty($this->request->param('pay_username')) && $where['pay_username']
            = ['eq', $this->request->param('pay_username')];


        $count = $this->logicEwmOrder->getOrdersCount($where);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }

    public function abnormalOrderSave()
    {
        $orderId = $this->request->post('id');
        if (is_admin_login() != 1){
            $uid = Db::name('orders')->where('id',$orderId)->value('uid');
            $adminid = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($adminid != is_admin_login()){
                $this->error('非法请求');
            }
        }
        $abnormal = $this->request->post('abnormal');
        $order = $this->modelEwmOrder->find($orderId);

        if (!$order or !in_array($abnormal, [1,2])){
            $this->error('操作失败');
        }
        ($abnormal == 1) && $order->name_abnormal = 1;
        ($abnormal == 2) && $order->money_abnormal = 1;
        $order->save();

        $this->success('操作成功');
    }

    /**
     * 后台管理员确认收款
     * @param Request $request
     */
    public function issueOrder(Request $request)
    {
        $orderId = $this->request->post('id');
        if (is_admin_login() != 1){

            $order_no = Db::name('ewm_order')->where('id',$orderId)->value('order_no');
            $uid = Db::name('orders')->where('trade_no',$order_no)->value('uid');

            $adminid = Db::name('user')->where('uid',$uid)->value('admin_id');

            if ($adminid != is_admin_login()){
                $this->error('非法请求');
            }
        }

        $coerce = $this->request->post('coerce');//是否强制补单
        $GemaOrder = new \app\common\logic\EwmOrder();
        $res = $GemaOrder->setOrderSucessByAdmin($orderId, $coerce);
        if ($res['code'] == CodeEnum::ERROR) {
            $this->error($res['msg']);
        }
        $this->success('操作成功');
    }

    /**
     * 后台管理员确认退款
     * @param Request $request
     */
    public function refundOrder(Request $request){
        $orderId = $this->request->post('id');
        if (is_admin_login() != 1){
            $uid = Db::name('orders')->where('id',$orderId)->value('uid');
            $adminid = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($adminid != is_admin_login()){
                $this->error('非法请求');
            }
        }
        $where['id'] = $orderId;
        $where['status'] = ['in',[0,2]];

        $order = $this->modelEwmOrder->where($where)->lock(true)->find();

        if ( empty($order)){
            $this->error('订单不存在');
        }

        $order->status = 3;
        $order->pay_time = time();
        $order->save();

        $this->success('更新成功');



    }


    /**
     * 码商流水列表
     * @param Request $request
     * @return mixed
     */
    public function bills(Request $request)
    {
        $uid = $request->param('uid', 0);

        if (!empty($uid))
        {
            $this->assign('uid', $uid);
            $map['b.userid'] = $uid;
        }

        $map['a.addtime'] = $this->parseRequestDate3();
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $map['b.userid'] = ['in',$adminSonMs];
        }

        //获取平台调整总加金额，总减金额
        list($inc, $des) = $this->logicMsSomeBill->changAmount($map);
        $this->assign('montey_types', MsMoneyType::getMoneyOrderTypes());
        $this->assign('inc', $inc);
        $this->assign('dec', $des);

        return $this->fetch();
    }






    /**
     * @param Request $request
     * @throws \think\exception\DbException
     */
    public function getBillsList(Request $request)
    {
        //时间搜索  时间戳搜素
        $map['addtime'] = $this->parseRequestDate3();
        $billType = $request->param('bill_type', 0, 'intval');
        $billType && $map['jl_class'] = $billType;
        $username = $request->param('username', '', 'trim');
        $username && $map ['b.username'] = $username;
        $info = $request->param('info', '', 'trim');
        $info && $map ['a.info'] = ['like', '%' . $info . '%'];

        $uid = $request->param('uid', 0, 'intval');
        $uid && $map ['a.uid'] = $uid;


        $fields = ['a.*', 'b.username'];
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $map['b.userid'] = ['in',$adminSonMs];
//            $map['uid'] = ['in',$adminSonMs];
        }
        $data = $this->logicMsSomeBill->getBillsList($map, $fields, 'addtime desc', false);
        if ($data) {
            $types = MsMoneyType::getMoneyOrderTypes();
            foreach ($data as $k => $v) {
                $data[$k]['jl_class_text'] = $types[$v['jl_class']];
            }
        }


        $count = $this->logicMsSomeBill->getBillsCount($map);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );

    }


    /**
     * 平台手动调整用户余额
     */
    public function changeBalance(Request $request)
    {
        $userId = $request->param('userid');
        $user = Db::name('ms')->where(['userid' => $userId])->find();

        if (!$user) {
            $this->error('会员不存在');
        }
        if (is_admin_login() != 1){
            if ($user['admin_id'] != is_admin_login()){
                $this->error('非法操作');
            }
        }
        $curretuserMoney = Db::name('ms')->where(['userid' => $userId])->value('money');
        if ($request->isPost()) {
            //看了存储引擎不支持事务算了 M()->startTrans();
            $data = $request->post();

            $result = $this->validate(
                [
                    '__token__' => $this->request->post('__token__'),
                ],
                [
                    '__token__' => 'require|token'
                ]);

            if (true !== $result) {
                $this->error($result);
            }

            if (bccomp(0.00, $data['money']) != -1) {
                $this->error('操作资金不可小于或等于0.00');
            }
            if ($data['op_type'] == 0 && bccomp($data['money'], $curretuserMoney) == 1) { //减少
                $this->error('减少资金不可小于用户本金');
            }

            Db::startTrans();
            $ret = accountLog($userId, MsMoneyType::ADJUST, $data['op_type'], $data['money'], $data['opInfo']);
            if ($ret) {
                Db::commit();
                $this->success('操作成功', url('index'));
            }

            Db::rollback();
            $this->error('操作失败');
        }

        $this->assign('curretuserMoney', $curretuserMoney);
        return $this->fetch();

    }


    /**
     * 授权码商的登录白名单
     * @param Request $request
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function changeWhiteIp(Request $request)
    {
        $userId = $request->param('ms_id');
        $user = Db::name('ms')->where(['userid' => $userId])->find();

        if (!$user) {
            $this->error('码商不存在');
        }

        if (is_admin_login() != 1){
            if ($user['admin_id'] != is_admin_login()){
                $this->error('非法操作');
            }
        }
        $aesKey = config('aes_key', 'kqwwFRmKyloO');
        $aes = new CryptAes($aesKey);
        $msWhiteIp = new MsWhiteIp;

        if ($request->isPost()) {
            Db::startTrans();
            try {
                //删除当前码商已经有的白名单
                $msWhiteIp->where('ms_id', $userId)->delete();
                //新增新的
                $ips = $request->post('ips', '', 'trim');
                if ($ips) {
                    $ips = array_unique(array_filter(explode(PHP_EOL, $ips)));
                    $ipArr = [];
                    foreach ($ips as $ip) {
                        if (!filter_var($ip, FILTER_VALIDATE_IP)) {
                            throw  new \Exception("{$ip}输入不合法");
                        }
                        $row['ms_id'] = $userId;
                        $row['encrypt_ip'] = $aes->encrypt($ip);
                        array_push($ipArr, $row);
                    }
                }
                $msWhiteIp->insertAll($ipArr);
                Db::commit();
            } catch (\Exception $ex) {
                Db::rollback();
                $this->error($ex->getMessage());
            }
            $this->success('操作成功', url('index'));
        }
        $ips = $msWhiteIp->where('ms_id', $userId)->column('encrypt_ip');
        $ips = array_map([$aes, 'decrypt'], $ips);
        $this->assign('ips', $ips);
        return $this->fetch();

    }


    /**
     * 码商二维码列表 旧
     * @param Request $request
     * @return mixed
     */
    public function paycodes_old(Request $request)
    {
        $where = [];
        if (is_admin_login() !=1){
            $sonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['ms_id'] = ['in',$sonMs];
        }
        $accont_sum = Db::name('ewm_pay_code')->where($where)->where(['code_type'=>30,'is_delete'=>0])->count('id');
        $account_on_sum = Db::name('ewm_pay_code')->where($where)->where(['code_type'=>30,'status'=>1,'is_delete'=>0])->count('id');
        $this->assign('accont_sum',$accont_sum);
        $this->assign('account_on_sum',$account_on_sum);
        return $this->fetch();
    }
    
    /**
     * 码商二维码列表 新 改造后
     * @return mixed
     */
    public function paycodes()
    {
        return $this->payCodesAndUidList('kzk');
    }
    
    /**
     * 码商二维码列表  和 码商uid列表
     * @return mixed
     */
    protected function payCodesAndUidList($htmlName)
    {
        $where = [];
        if (is_admin_login() !=1){
            $sonMs = Db::name('ms')
                ->where('admin_id',is_admin_login())
                ->column('userid');
            $where['a.ms_id'] = ['in',$sonMs];
        }
        $where['a.is_delete'] = 0;
        
        if ($htmlName == 'uid_list') {
            $where['b.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
        }else{
            $where['b.code'] = $htmlName;
        }

        $accont_sum = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->where($where)
            ->count();
        
        $account_on_sum = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->where($where)
            ->where('a.status',1)->count();
        
        $this->assign('accont_sum',$accont_sum);
        $this->assign('account_on_sum',$account_on_sum);
        if ($htmlName == 'uid_list'){
            return $this->fetch($htmlName);
        }else{
            return $this->fetch($htmlName.'_list');
        }

    }

    /**
     * @return void
     * @throws \think\Exception
     * 卡转卡账号列表联动统计 旧
     */
    public function kzkCodeListCount_old(){
        $where = [];
        $where['code_type'] = 30;
        $where['is_delete'] = 0;
        if (!empty($this->request->param('username'))){
            $where['user_name'] = $this->request->param('username');
        }

        if (!empty($this->request->param('account_name'))){
            $where['account_name'] = $this->request->param('account_name');
        }

        if (!empty($this->request->param('status'))){

            $where['status'] = $this->request->param('status');
            if ($this->request->param('status') == -1){
                unset($where['status']);
            }
        }

        $accont_sum = Db::name('ewm_pay_code')->where($where)->count('id');


        $account_on_sum = Db::name('ewm_pay_code')->where($where)->where(function ($query){
            $query->where('status',1);
        })->count('id');
        $data = [];
        $data['accont_sum'] = $accont_sum;
        $data['account_on_sum'] = $account_on_sum;
        return $this->result(['code'=>0,'data'=>$data]);
    }
    
    
    /**
     * @return void
     * @throws \think\Exception
     * 卡转卡账号列表联动统计 新
     */
    public function kzkCodeListCount(){
        return $this->kzkOrUidCodeListCount('kzk');
    }



    public function alipayCodeListCount(){
        return $this->kzkOrUidCodeListCount('alipayCode');
    }
    
    protected function kzkOrUidCodeListCount($type)
    {
        $where = [];
        $where['a.is_delete'] = 0;
        if (!empty($this->request->param('username'))){
            $where['a.user_name'] = ['=', $this->request->param('username')];
        }
    
        if (!empty($this->request->param('account_name'))){
            $where['a.account_name'] = ['=', $this->request->param('account_name')];
        }
    
        if (!empty($this->request->param('status'))){
            $where['a.status'] = ['=', $this->request->param('status')];
            if ($this->request->param('status') == -1){
                unset($where['status']);
            }
        }
    
        if (!empty($this->request->param('code_type'))){
            $where['b.code'] = ['=', $this->request->param('code_type')];
        }
    
        if (!empty($this->request->param('status'))){
            $where['a.status'] = ['=', $this->request->param('status')];
            if ($this->request->param('status') == -1){
                unset($where['a.status']);
            }
        }


        if ($type == 'uid') {
            $accont_sum = Db::name('ewm_pay_code')->alias('a')
                ->join('pay_code b','a.code_type = b.id')
                ->where('b.code', 'in', ['alipayUid','alipayUidSmall','alipayUidTransfer'])
                ->where($where)->count('a.id');
            $account_on_sum = Db::name('ewm_pay_code')->alias('a')
                ->join('pay_code b','a.code_type = b.id')
                ->where('b.code', 'in', ['alipayUid','alipayUidSmall','alipayUidTransfer'])->where($where)->where(function ($query){
                $query->where('a.status',1);
            })->count('a.id');
        }else{
            $accont_sum = Db::name('ewm_pay_code')->alias('a')
                ->join('pay_code b','a.code_type = b.id')
                ->where('b.code', $type)
                ->where($where)->count('a.id');
            $account_on_sum = Db::name('ewm_pay_code')->alias('a')
                ->join('pay_code b','a.code_type = b.id')
                ->where('b.code', $type)->where($where)->where(function ($query){
                    $query->where('a.status',1);
                })->count('a.id');
        }
    
        $data = [];
        $data['accont_sum'] = $accont_sum;
        $data['account_on_sum'] = $account_on_sum;
        return $this->result(['code'=>0,'data'=>$data]);
    }

    /**
     * @return void
     * @throws \think\Exception
     * uid账号列表联动统计 旧
     */
    public function uidCodeListCount_old(){
        $where = [];
        $where['b.code'] = ['in',['alipayUid','alipayUidSmall']];
        $where['a.is_delete'] = 0;
        if (!empty($this->request->param('username'))){
            $where['a.user_name'] = $this->request->param('username');
        }
        if (!empty($this->request->param('code_type'))){
            $where['b.code'] = $this->request->param('code_type');
        }
        if (!empty($this->request->param('account_name'))){
            $where['a.account_name'] = $this->request->param('account_name');
        }

        if (!empty($this->request->param('status'))){
            $where['a.status'] = $this->request->param('status');
            if ($this->request->param('status') == -1){
                unset($where['a.status']);
            }
        }

        $accont_sum = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->where($where)->count('a.id');


        $account_on_sum = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->where($where)->where(function ($query){
            $query->where('a.status',1);
        })->count('a.id');
        $data = [];
        $data['accont_sum'] = $accont_sum;
        $data['account_on_sum'] = $account_on_sum;
        return $this->result(['code'=>0,'data'=>$data]);
    }
    
    
    /**
     * @return void
     * @throws \think\Exception
     * uid账号列表联动统计 新
     */
    public function uidCodeListCount(){
        return $this->kzkOrUidCodeListCount('uid');
    }


    /**
     * 码商uid列表 旧
     * @param Request $request
     * @return mixed
     */
    public function uidList_old(Request $request)
    {
        $where = [];
        if (is_admin_login() !=1){
            $sonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['a.ms_id'] = ['in',$sonMs];
        }


        $where['b.code'] = ['in',['alipayUid','alipayUidSmall']];

        $accont_sum = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->where($where)->where(['a.is_delete'=>0])->count('a.id');
        
        $account_on_sum = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->where($where)->where(['a.status'=>1,'a.is_delete'=>0])->count('a.id');
        $this->assign('accont_sum',$accont_sum);
        $this->assign('account_on_sum',$account_on_sum);
        return $this->fetch();
    }
    
    
    /**
     * 码商uid列表 新 改造后
     * @return mixed
     */
    public function uidList(Request $request)
    {
        return $this->payCodesAndUidList('uid_list');
    }


    /**
     * uid列表测码
     */
    public function testuid(){


            $id = $this->request->param('id');

            $code = Db::name('ewm_pay_code')->where('id',$id)->find();
            if (empty($code)){
                $this->error('未知错误');
            }

            $this->assign('code',$code);


            return $this->fetch();


    }

    public function testuidpay(){
//        $url = $this->request->param('url');
//        $this->assign('url',$url);


            $code = Db::name('ewm_pay_code')->where('id',$this->request->param('code_id'))->find();
            $data['uid'] = $code['account_number'];

            $data['amount'] = sprintf("%.2f",$this->request->param('amount'));

            $data['orderNo'] = rand(2000000,2999999);

            $url = 'https://www.alipay.com/?appId=20000123&actionType=scan&biz_data={"s":"money","u":"'.$data['uid'].'","a":"'.$data['amount'].'","m":"商城购物'.$data['orderNo'].'"}';
            $encode_url = 'alipays://platformapi/startapp?appId=68687093&url='.urlencode($url);
            $data = str_replace('/&amp;/g','&',$encode_url);
                $this->assign('url',$data);
                return $this->fetch();

    }


    /**
     * 码子统计
     */

    public function kzkStatic(){
        return $this->fetch();
    }

    public function uidStatic(){
        return $this->fetch();
    }

    public  function get_ewm_static(){
        $code = $this->request->param('code_type');
        $where['code_type'] = $code;
        $where['is_delete'] = 0;
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['ms_id'] = ['in',$adminSonMs];
        }
        $ewmPayCode = Db::name('ewm_pay_code')->where($where)->select();

        $start = date('Y-m-d 00:00:00',time());
        $end = date('Y-m-d 23:59:59',time());
        if (!empty($this->request->param('start'))){
            $start = $this->request->param('start');
        }
        if (!empty($this->request->param('end'))){
            $end = $this->request->param('end');
        }

        $whereTime['add_time'] = ['between time',[$start,$end]];
        foreach ($ewmPayCode as $k=>$v){
            $ewmPayCode[$k]['total_number'] = Db::name('ewm_order')->where($whereTime)->where('code_id',$v['id'])->count();
            $ewmPayCode[$k]['total_amount'] = Db::name('ewm_order')->where($whereTime)->where('code_id',$v['id'])->sum('order_price');
            $ewmPayCode[$k]['success_number'] = Db::name('ewm_order')->where($whereTime)->where(['code_id'=>$v['id'],'status'=>1])->count();
            $ewmPayCode[$k]['success_amount'] = Db::name('ewm_order')->where($whereTime)->where(['code_id'=>$v['id'],'status'=>1])->sum('order_price');
            if ($ewmPayCode[$k]['success_number'] == 0 ){
                $ewmPayCode[$k]['success_rate'] = 0;
            }else{
                $ewmPayCode[$k]['success_rate'] = sprintf("%.2f",$ewmPayCode[$k]['success_number'] / $ewmPayCode[$k]['total_number'] * 100);
            }
        }

//        print_r($ewmPayCode);die;
        return json(['code'=>0,'data'=>$ewmPayCode,'count'=>count($ewmPayCode)]);

    }


    public  function get_uid_static(){
//        $code = $this->request->param('code_type');
//        $where['code_type'] = $code;

        $where['b.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
        $where['a.is_delete'] = 0;
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $where['a.ms_id'] = ['in',$adminSonMs];
        }
        if (!empty($this->request->param('code_type'))){
//            $whereTime['']
            $where['b.code'] = $this->request->param('code_type');

        }
        $ewmPayCode = Db::name('ewm_pay_code')->alias('a')->join('pay_code b','a.code_type = b.id')->field('a.*')->where($where)->select();

        $start = date('Y-m-d 00:00:00',time());
        $end = date('Y-m-d 23:59:59',time());
        if (!empty($this->request->param('start'))){
            $start = $this->request->param('start');
        }
        if (!empty($this->request->param('end'))){
            $end = $this->request->param('end');
        }


        $whereTime['add_time'] = ['between time',[$start,$end]];
        foreach ($ewmPayCode as $k=>$v){
            $ewmPayCode[$k]['total_number'] = Db::name('ewm_order')->where($whereTime)->where('code_id',$v['id'])->count();
            $ewmPayCode[$k]['total_amount'] = Db::name('ewm_order')->where($whereTime)->where('code_id',$v['id'])->sum('order_price');
            $ewmPayCode[$k]['success_number'] = Db::name('ewm_order')->where($whereTime)->where(['code_id'=>$v['id'],'status'=>1])->count();
            $ewmPayCode[$k]['success_amount'] = Db::name('ewm_order')->where($whereTime)->where(['code_id'=>$v['id'],'status'=>1])->sum('order_price');
            if ($ewmPayCode[$k]['success_number'] == 0 ){
                $ewmPayCode[$k]['success_rate'] = 0;
            }else{
                $ewmPayCode[$k]['success_rate'] = sprintf("%.2f",$ewmPayCode[$k]['success_number'] / $ewmPayCode[$k]['total_number'] * 100);
            }
        }

//        print_r($ewmPayCode);die;
        return json(['code'=>0,'data'=>$ewmPayCode,'count'=>count($ewmPayCode)]);

    }
    /**
     * 管理员删除二维码
     * @param Request $request
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function delPayCode(Request $request)
    {
        $id = trim($request->param('id'));
        $id = trim($request->param('id'));
        $GemapayCodeModel = new EwmPayCode();
        $codeInfo = $GemapayCodeModel->find($id);
        if (is_admin_login() != 1){
            $user = Db::name('ms')->where('userid',$codeInfo['ms_id'])->find();
            if (is_admin_login() != $user['admin_id']){
                $this->error('非法请求');
            }
        }


        $re = Db::name('ewm_pay_code')
            ->where('id', $id)
            ->delete();

        if ($re) {
            //从队列中删除此二维码
            $QueueLogic = new Queuev1Logic();
            $QueueLogic->delete($id, 3, 1);
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }


    /**
     * @param Request $request
     * @return mixed
     */
    public function getPaycodesLists_old(Request $request)
    {
        $map = [];
        $account_name = $request->param('account_name', 0, 'intval');
        $account_name && $map['a.account_name'] = ['like', '%' . $account_name . '%'];
        $map['a.code_type'] = 30;
        $map['a.is_delete'] = 0;
        if (is_admin_login() != 1){
            $map['b.admin_id'] = is_admin_login();
        }

        $status = $request->param('status', -1);
        ($status != -1) && $map['a.status'] = $status;
        $username = $this->request->param('username');
        if ($username) {
            $map['b.username'] = $username;
        }
        $fields = ['a.*', 'b.username'];
        $data = $this->logicEwmPayCodes->getCodeList($map, $fields, 'id desc', false);

        $count = $this->logicEwmPayCodes->getCodeCount($map);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }
    
    
    public function getPaycodesLists()
    {
        return $this->getPayCodesOrUidLists('kzk');
    }
    
    /**
     * @param string $type
     *
     * @return mixed
     */
    protected function getPayCodesOrUidLists(string $type)
    {
        $request = $this->request;
        $map = [];
        $account_name = $request->param('account_name', 0, 'intval');
        $account_name && $map['a.account_name'] = ['like', '%' . $account_name . '%'];
        if ($type == 'uid') {
            $map['c.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
            $fields = ['a.*', 'b.username','c.name'];
        }else{
            $map['c.code'] = $type;
            $fields = ['a.*', 'b.username'];
        }


        
        $map['a.is_delete'] = 0;
        if (is_admin_login() != 1){
            $map['b.admin_id'] = is_admin_login();
        }
        
        $status = $request->param('status', -1);
        ($status != -1) && $map['a.status'] = $status;
        $username = $this->request->param('username');
        if ($username) {
            $map['b.username'] = $username;
        }
        if(!empty($this->request->param('code_type'))){
//            unset($where['p.add_time']);
            $map['c.code']= ['eq', $this->request->param('code_type')];
        
        }
        $data = $this->logicEwmPayCodes->getCodeList($map, $fields, 'id desc', false);
        
        $count = $this->logicEwmPayCodes->getCodeCount($map);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }






    /**
     * @param Request $request
     * @return mixed
     */
    public function getuidLists_old(Request $request)
    {
        $map = [];
        $account_name = $request->param('account_name', 0, 'intval');
        $account_name && $map['a.account_name'] = ['like', '%' . $account_name . '%'];
        $map['c.code'] = ['in',['alipayUid','alipayUidSmall']];
        $map['a.is_delete'] = 0;
        if (is_admin_login() != 1){
            $map['b.admin_id'] = is_admin_login();
        }
        $status = $request->param('status', -1);
        ($status != -1) && $map['a.status'] = $status;
        $username = $this->request->param('username');
        if ($username) {
            $map['b.username'] = $username;
        }
        if(!empty($this->request->param('code_type'))){
//            unset($where['p.add_time']);
            $map['c.code']= ['eq', $this->request->param('code_type')];

        }
        $fields = ['a.*', 'b.username','c.name'];
        $data = $this->logicEwmPayCodes->getCodeList($map, $fields, 'id desc', false);

        $count = $this->logicEwmPayCodes->getCodeCount($map);
        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data,
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]
        );
    }
    
    public function getuidLists()
    {
        return $this->getPayCodesOrUidLists('uid');
    }


    public function alipaycodeList(){
        return $this->payCodesAndUidList('alipayCode');
    }


    public function getalipaycodeLists()
    {
        return $this->getPayCodesOrUidLists('alipayCode');
    }


    /**
     * 导出
     */
    public function exportOrder()
    {
        //  set_time_limit(0);
        // ini_set('max_execution_time', '5000');
        // ini_set('memory_limit', '4096M');
        //组合搜索
        //状态
        //状态

        if ($this->request->param('status') != "") {
            $where['a.status'] = ['eq', $this->request->param('status')];
        }
        !empty($this->request->param('order_no')) && $where['order_no']
            = ['eq', $this->request->param('order_no')];
        //时间搜索  时间戳搜素
        $where['add_time'] = $this->parseRequestDate3();


        if (!empty($this->request->param('username'))){
            if (is_admin_login() != 1){
                $admin_id = Db::name('ms')->where('username',$this->request->param('username'))->value('admin_id');
                if ($admin_id == is_admin_login()){
                    $where['c.username'] = ['eq', $this->request->param('username')];
                }
            }
        }

        !empty($this->request->param('amount')) && $where['order_pay_price']
            = ['eq', $this->request->param('amount')];

        !empty($this->request->param('account_name')) && $where['b.account_name']
            = ['eq', $this->request->param('account_name')];

        !empty($this->request->param('pay_username')) && $where['pay_username']
            = ['eq', $this->request->param('pay_username')];

        if (is_admin_login() != 1){
            $where['c.admin_id'] = is_admin_login();
            $where['u.admin_id'] = is_admin_login();
        }
        $fields = ['a.*', 'b.account_name', 'b.bank_name', 'account_number', 'c.username'];
        $orderList = $this->logicEwmOrder->getOrderList($where, $fields, 'add_time desc', false);


        //组装header 响应html为execl 感觉比PHPExcel类更快
        $orderStatus =['订单关闭','等待支付','支付完成','异常订单'];
        $strTable ='<table width="500" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">ID标识</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">订单号</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">所属码商</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">支付用户【商户上报】</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">支付金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收款信息</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">访问信息</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">创建时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">支付时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">付款人姓名</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">订单状态</td>';
        $strTable .= '</tr>';
        if(is_array($orderList)){
            foreach($orderList as $k=>$val){
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;'.$val['id'].'</td>';
                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;'.$val['order_no'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['username'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['pay_user_name'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['order_pay_price'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'. '账户:' . $val['account_name' ].' 银行:'.$val['bank_name' ]. ' 卡号:'.$val['account_number'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.'IP:' . $val['visite_ip']. ' 设备:' .$val['visite_clientos'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.date('Y-m-d H:i:s', $val['add_time']).'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.date('Y-m-d H:i:s', $val['pay_time']).'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['pay_username'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$orderStatus[$val['status']].'</td>';
                $strTable .= '</tr>';
                unset($orderList[$k]);
            }
        }
        $strTable .='</table>';
        downloadExcel($strTable,'order');
    }

    public function searchBalanceCal(Request $request)
    {
        $map['addtime'] = $this->parseRequestDate3();
        $billType = $request->param('bill_type', 0, 'intval');
        $billType && $map['jl_class'] = $billType;
        $username = $request->param('username', '', 'trim');
        $username && $map ['b.username'] = $username;
        $uid = $request->param('uid', '');
        $uid && $map ['b.userid'] = $uid;
        list($inc, $dec) = $this->logicMsSomeBill->changAmount($map);
        echo json_encode(['inc' => $inc, 'dec' => $dec]);
    }

    /**
     * 码商流水导出
     */
    public function exportMsBills(Request $request)
    {
        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $map['b.admin_id'] = ['in',$adminSonMs];
        }
        //时间搜索  时间戳搜素
        $map['addtime'] = $this->parseRequestDate3();
        $billType = $request->param('bill_type', 0, 'intval');
        $billType && $map['jl_class'] = $billType;
        $username = $request->param('username', '', 'trim');
        $username && $map ['b.username'] = $username;
        $info = $request->param('info', '', 'trim');
        $info && $map ['a.info'] = ['like', '%' . $info . '%'];

        $uid = $request->param('uid', 0, 'intval');
        $uid && $map ['a.uid'] = $uid;


        $fields = ['a.*', 'b.username'];
        $data = $this->logicMsSomeBill->getBillsList($map, $fields, 'addtime desc', false);


        foreach ($data as $key => $item){

        }

        //组装header 响应html为execl 感觉比PHPExcel类更快
        $strTable ='<table width="500" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">ID</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="100">用户名</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">账变类型</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">变动前</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">变动金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">变动后</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">流水备注</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">时间</td>';
        $strTable .= '</tr>';

        if(is_array($data)){

            foreach($data as $k=>$val){
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;'.$val['id'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['username'].' </td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['jl_class_text'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['pre_amount'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['num'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['last_amount'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['info'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'. date('Y-m-d H:i:s', $val['addtime']) .'</td>';
                $strTable .= '</tr>';
                unset($data[$k]);

            }
        }
        $strTable .='</table>';

        downloadExcel($strTable,'msBills');
    }

    /**
     *解绑此码商的TG群
     */
    public function unblindTgGroup()
    {
        $userId = $this->request->param('userid');
        if (!$userId) {
            $this->error('非法操作');
        }
        $result = \app\common\model\Ms::where(['userid' => $userId])->update(['tg_group_id' => '']);
        if ($result !== false) {
            $this->success('操作成功');
        }
        $this->error('错误请重试');

    }

    /**
     * 拉黑IP
     */
    public function blockIp(Request  $request)
    {
        $this->result($this->logicMs->blockIp($request->param()));
    }


    /**
     * UID商户报表
     */
    public function uidshstatic(){

//        $this->assign('userList',$userList);
        return $this->fetch();
    }

    /**
     * 获取uid订单商户统计列表
     */

    public function getuidshstatic(){
        $where = [];

        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }

        $userList = Db::name('user')->where($where)->field('uid,username')->select();
        if (!empty($this->request->param('username'))){
            $where1['username'] = $this->request->param('username');
            $userList = Db::name('user')->where($where1)->field('uid,username,admin_id')->select();
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
        $where2['c.code'] = ['in',['alipayUid','alipayUidSmall','alipayUidTransfer']];
        if (!empty($this->request->param('code_type'))){
            $where2['c.code'] = $this->request->param('code_type');
        }
        $where2['o.create_time'] = ['between time',[$start,$end]];
        foreach ($userList as $k=>$v){
            $userList[$k]['alipayUid_total'] = Db::name('orders')
                ->alias('o')
                ->join('ewm_order e','o.trade_no = e.order_no')
                ->join('pay_code c','e.code_type = c.id')
                ->where($where2)
                ->where(['o.uid'=>$v['uid']])
                ->sum('e.order_price');
            $userList[$k]['success_money'] = Db::name('orders')
                ->alias('o')
                ->join('ewm_order e','o.trade_no = e.order_no')
                ->join('pay_code c','e.code_type = c.id')
                ->where($where2)
                ->where(['o.uid'=>$v['uid'],'e.status'=>1,'o.status'=>2])
                ->sum('e.order_price');

            $userList[$k]['zongdanliang'] = Db::name('orders')
                ->alias('o')
                ->join('ewm_order e','o.trade_no = e.order_no')
                ->join('pay_code c','e.code_type = c.id')
                ->where($where2)
                ->where(['o.uid'=>$v['uid']])
                ->count('e.id');

            $userList[$k]['chenggongdanliang'] = Db::name('orders')
                ->alias('o')
                ->join('ewm_order e','o.trade_no = e.order_no')
                ->join('pay_code c','e.code_type = c.id')
                ->where($where2)
                ->where(['o.uid'=>$v['uid'],'e.status'=>1,'o.status'=>2])
                ->count('e.id');

            if ($userList[$k]['chenggongdanliang'] == 0 ){
                $userList[$k]['success_rate'] = 0;
            }else{
                $userList[$k]['success_rate'] = sprintf("%.2f",$userList[$k]['chenggongdanliang'] / $userList[$k]['zongdanliang'] * 100);
            }

            if ($userList[$k]['alipayUid_total']== 0 &&  $userList[$k]['success_money'] ==0  && $userList[$k]['zongdanliang'] == 0 && $userList[$k]['chenggongdanliang'] == 0){
                unset($userList[$k]);
            }

        }

//        print_r($userList);die;

        return json(['code'=>0,'data'=>$userList,'count'=>count($userList)]);
    }


    /**
     * 清除绑定Google
     */
    public function clearGoogleAuth()
    {
        $userId = $this->request->param('id');
        if (!$userId) {
            $this->error('非法操作');
        }

        $result = \app\common\model\Ms::where(['userid' => $userId])->update(['google_status' => 0, 'google_secretkey' => '']);
        if ($result !== false) {
            $this->success('操作成功');
        }
        $this->error('错误请重试');

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
        $orderWhere['status'] = 1;
//        $orderWhere['m.status'] = 1;
        $start = date('Y-m-d 00:00:00',time());
        $end = date('Y-m-d 23:59:59',time());
        if (!empty($this->request->param('start'))){
            $start = $this->request->param('start');

        }
        if (!empty($this->request->param('end'))){
            $end = $this->request->param('end');
        }


        if (is_admin_login() != 1){
            $adminSonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');
            $orderWhere['gema_userid'] = ['in',$adminSonMs];
            $where['admin_id'] = ['in',$adminSonMs];
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
            $orderWhere['gema_userid'] = ['in',$mss];
            $where['username'] = $this->request->param('username');
        }

        $orderWhere['add_time'] = ['between time',[$start,$end]];
        $order = Db::name('ewm_order')->alias('o')->field('order_price,gema_userid')->where($orderWhere)->select();
        $order = $this->GetRepeatValGroup($order,'gema_userid');
        $ms = [];
        foreach ($order as $k=>$v){
            $ms[$k]['total_amount'] = array_sum(array_column($v,'order_price'));
        }
        $mslist = [];
        foreach ($ms as $k=>$v){
            $mslist[$k]['username'] = Db::name('ms')->where('userid',$k)->value('username');
            $mslist[$k]['pid'] = Db::name('ms')->where('userid',$k)->value('pid');
            $mslist[$k]['total_amount'] = $v['total_amount'];
            $mslist[$k]['userid'] = $k;
            $mslist[$k]['uid_rate'] = Db::name('ms_rate')->where(['ms_id'=>$k,'code_type_id'=>32])->value('rate');
        }

        foreach ($mslist as $k=>$v){
            if ($v['pid'] != 0){
                $ffmsid = getNavPid($k);
                if(array_key_exists($ffmsid,$mslist)){
                    $mslist[$ffmsid]['total_amount'] = $mslist[$ffmsid]['total_amount'] + $v['total_amount'];
                }else{
                    $mslist[$ffmsid]['total_amount'] = 0 + $v['total_amount'];
                    $mslist[$ffmsid]['username'] = Db::name('ms')->where('userid',$ffmsid)->value('username');
                    $mslist[$ffmsid]['pid'] = 0;
                    $mslist[$ffmsid]['userid'] = $ffmsid;
                    $mslist[$ffmsid]['uid_rate'] = Db::name('ms_rate')->where(['ms_id'=>$ffmsid,'code_type_id'=>32])->value('rate');
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
            if ($v['pid'] != 0){
                $ffmsid = getNavPid($v['pid']);
                foreach ($data as $key=>$val){
                    if ($val['userid'] ==$ffmsid){
                        $data[$key]['money'] = $val['money'] + $v['money'];
                    }
                }
            }
            foreach ($mslist as $key=>$val){
                if ($key == $v['userid']){
                    $data[$k]['total_amount'] = $val['total_amount'];
                }
            }
        }

//        print_r($topMs);die;
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

    /**
     * 团队统计
     */
//    public function team(){
//        //查询今日完成订单
//        $orderWhere = [];
//        $orderWhere['status'] = 1;
//        $start = date('Y-m-d 00:00:00',time());
//        $end = date('Y-m-d 23:59:59',time());
//        $orderWhere['add_time'] = ['between time',[$start,$end]];
//        $order = Db::name('ewm_order')->where($orderWhere)->select();
////        $msWhere['status'] = 1;
////        if (is_admin_login() != 1){
////            $msWhere['admin_id'] = is_admin_login();
////        }
////        $msList = Db::name('ms')->where($msWhere)->field('userid,username,pid,admin_id,money')->select();
////        foreach ($msList as $key=>$val){
////            foreach ($order as $k=>$v){
////                if ($v['userid'] == $val['gema_userid']){
////
////                }
////            }
////        }
//        $order = $this->GetRepeatValGroup($order);
//        print_r($order);die;
//
//
//
//    }

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

