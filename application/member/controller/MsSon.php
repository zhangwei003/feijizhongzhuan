<?php

namespace app\member\controller;
use app\common\library\enum\CodeEnum;
use app\common\logic\MsMoneyType;
use app\common\model\Ms;
use think\Cache;
use think\Db;
use think\Request;
use think\Log;
class MsSon extends Base
{

    public function index(){
        return $this->fetch();
    }

    public function getMsSonList(Request $request){
        $where = [];
        if (!empty($request->param('username'))){
            $where['username'] = $request->param('username');
        }

        if ($request->param('work_status') !=null && $request->param('work_status') >=0){
            $where['work_status'] = $request->param('work_status');
        }
        $limit = $request->param('limit');
        $page = $request->param('page');
        $start=$limit*($page-1);
        $sonIds = $this->getIds($this->agent_id);
        if (empty($sonIds)){
            return json([
                'code'=>1,
                'msg'=>'暂无数据'
            ]);
        }
//        $sonIds = array_reverse($sonIds);
        $msSonList = Db::name('ms')->where($where)->where('userid','in',$sonIds)->limit($limit,$start)->order('userid desc')->select();
        foreach ($msSonList as $k=>$v){
            $msSonList[$k]['yesterday_amount']= sprintf("%.2f",Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid',$v['userid'])->sum('order_price'));
            $msSonList[$k]['today_amount']= sprintf("%.2f",Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid',$v['userid'])->sum('order_price'));
            $msSonList[$k]['yesterday_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'yesterday')->where('status', 2)->where('ms_id',$v['userid'])->sum('amount'));
            $msSonList[$k]['today_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'today')->where('status', 2)->where('ms_id',$v['userid'])->sum('amount'));
            $msSonList[$k]['pid'] = Db::name('ms')->where('userid',$v['pid'])->value('username');
        }

        $count = Db::name('ms')->where('userid','in',$sonIds)->where($where)->count();
        return json([
            'code'=>0,
            'msg'=>'请求成功',
            'data'=>$msSonList,
            'count'=>$count
        ]);

    }


    /**
     * 下级余额明细
     */
        public function balanceDetails(){

            $bill_types = MsMoneyType::getMoneyOrderTypes();
//            print_r($bill_types);die;
            $this->assign('billTypes', $bill_types);
            $this->assign('userid', $this->request->param('userid'));
            return $this->fetch();
        }

        public function getBalanceDetails(Request $request){
            $userid = $request->param('userid');
            if (empty($userid)){
                return json([
                        'code'=>1,
                        'msg'=>'暂无数据'
                    ]);
            }
            $sonIds = $this->getIds($this->agent_id);
            if (!in_array($userid,$sonIds)){
                        return json([
                            'code'=>1,
                            'msg'=>'暂无数据'
                        ]);
            }
            $where['a.uid'] = $userid;
            if (!empty($request->param('bill_type'))){
                $where['a.jl_class'] = $request->param('bill_type');
            }
            if (!empty($request->param('jc_class'))){
                $where['a.jc_class'] = $request->param('jc_class');
            }
            $startTime = date('Y-m-d 00:00:00',time());
            $endTime = date('Y-m-d 23:59:59',time());
            $where['a.addtime'] = ['between', [$startTime, $endTime]];
            if (!empty($request->param('startDate'))){
                $startTime = $request->param('startDate');
                $where['a.addtime'] = ['egt', strtotime($startTime)];
            }

            if (!empty($request->param('endDate'))){
                $endTime = $request->param('endDate');
                $where['a.addtime'] = ['elt',strtotime($endTime)];
            }

            if ($startTime && $endTime) {
                $where['a.addtime'] = ['between', [strtotime($startTime), strtotime($endTime)]];
            }
            $limit = $request->param('limit');
            $page = $request->param('page');
            $start=$limit*($page-1);
            $bills = Db::name('ms_somebill')
                ->alias('a')
                ->join('ms m','a.uid = m.userid')
                ->field('a.*,m.username')
                ->where($where)
                ->limit($start,$limit)
                ->order('id desc')
                ->select();


            $count = Db::name('ms_somebill')->alias('a')->where($where)->count();
            if ($count <= 0){
                return json([
                    'code'=>1,
                    'msg'=>'暂无数据'
                ]);
            }
            $bill_types = MsMoneyType::getMoneyOrderTypes();
            foreach ($bills as $k=>$v){
                foreach ($bill_types as $key => $val){
                    if ($v['jl_class'] == $key){
                        $bills[$k]['jl_class'] = $val;
                        continue;
                    }
                }
            }
            return json([
                'code'=>0,
                'msg'=>'请求成功',
                'data'=>$bills,
                'count'=>$count
            ]);
        }

    /**
     * @user luomu
     * @return 设置下级费率
     * @time
     */

    public function sysSonRate(){
        if ($this->request->isPost()){
            $data = $this->request->post('r/a');
            if (is_array($data)){
                foreach ($data as  $key=>$item) {
                    if ($item['son_rate'] < 0){
                        return ['code' => CodeEnum::ERROR, 'msg'=>'费率最低为0'];
                    }
                    if ($item['son_rate'] > $item['my_rate']){
                        return ['code' => CodeEnum::ERROR, 'msg'=>'下级费率不可大于自己费率'];
                    }

                    $res = Db::name('ms_rate')->where(['ms_id'=>$item['ms_id'],'code_type_id'=>$item['code_type_id']])->select();
                    if ($res){
                        //修改
                        Db::name('ms_rate')->where(['ms_id'=>$item['ms_id'],'code_type_id'=>$item['code_type_id']])->update(['rate' => $item['son_rate'], 'update_time' => time()]);
                    }else{
                        //新增
                        Db::name('ms_rate')->insert( [
                            'ms_id' => $item['ms_id'],
                            'code_type_id' => $item['code_type_id'],
                            'rate' => $item['son_rate'],
                            'create_time' => time(),
                            'update_time' => time(),
                        ]);
                    }

                }
                return ['code' => CodeEnum::SUCCESS, 'msg' => '费率配置成功'];
            }
        }
        $sonMsid = $this->request->param('userid');
        $sonMs = Db::name('ms')->where('userid',$sonMsid)->find();
        if (empty($sonMs)){
            return ['code' => CodeEnum::ERROR, 'msg'=>'暂无数据'];
        }
        if ($sonMs['pid'] != $this->agent_id){
            return ['code' => CodeEnum::ERROR, 'msg'=>'非法操作'];
        }
        //所有渠道列表
        $list = Db::name('pay_code')->where('status',1)->where('id','lt','255')->select();
        //查询自己的费率
        $myRate = Db::name('ms_rate')->where('ms_id',$this->agent_id)->select();
        //查询当前下级的费率
        $sonRate = Db::name('ms_rate')->where('ms_id',$sonMs['userid'])->select();
        if ($myRate){
            foreach ($list as $k=>$v){
                $list[$k]['my_rate'] = 0;
                foreach ($myRate as $key=>$val){
                    if ($v['id'] == $val['code_type_id']){
                        $list[$k]['my_rate'] = $val['rate'];
                    }
                }
            }
        }else{
            foreach ($list as $key=>$val){
                $list[$key]['my_rate'] = 0;
            }
        }

        if ($sonRate){
            foreach ($list as $k=>$v){
                $list[$k]['son_rate'] =0;
                foreach ($sonRate as $key=>$val){
                    if ($v['id'] == $val['code_type_id']){
                        $list[$k]['son_rate'] = $val['rate'];
                    }
                }
            }
        }else{
            foreach ($list as $key=>$val){
                $list[$key]['son_rate'] = 0;
            }
        }

        $this->assign('list', $list);
        return $this->fetch();

    }


    /**
     * 下级订单列表
     */
    public function orders(){
        $pay_code = Db::name('pay_code')->where(['status'=>1,'id'=>['lt','255']])->select();
        $this->assign('pay_code',$pay_code);
        return $this->fetch();
    }

    public function getSonOrders(Request $request){
        $where = [];
        $startTime = date('Y-m-d 00:00:00',time());
        $endTime = date('Y-m-d 23:59:59',time());
        $where['a.add_time'] = ['between', [$startTime, $endTime]];
        if (!empty($request->param('startDate'))){
            $startTime = $request->param('startDate');
            $where['a.add_time'] = ['egt', strtotime($startTime)];
        }

        if (!empty($request->param('endDate'))){
            $endTime = $request->param('endDate');
            $where['a.add_time'] = ['elt',strtotime($endTime)];
        }

        if ($startTime && $endTime) {
            $where['a.add_time'] = ['between', [strtotime($startTime), strtotime($endTime)]];
        }
        if (!empty($request->param('code_type'))){
            $where['a.code_type'] = $request->param('code_type');
        }

        if (!empty($request->param('trade_no'))){
            $where['a.order_no'] = $request->param('trade_no');
        }

        if (!empty($request->param('merchant_order_no'))){
            $where['a.merchant_order_no'] = $request->param('merchant_order_no');
        }

        if (!empty($request->param('username'))){
            $where['m.username'] = $request->param('username');
        }

        if ($request->param('status') !=null && $request->param('status') >=0){
            $where['a.status'] = $request->param('status');
        }
        $sonIds = $this->getIds($this->agent_id);
        if (empty($sonIds)){
            return json([
                'code'=>1,
                'msg'=>'暂无数据'
            ]);
        }
        $where['a.gema_userid'] = ['in',$sonIds];
        $limit = $request->param('limit');
        $page = $request->param('page');
        $start=$limit*($page-1);

        $sonOrders = Db::name('ewm_order')
            ->alias('a')
            ->join('ms m','a.gema_userid = m.userid')
            ->join('pay_code p','a.code_type = p.id')
            ->field('a.*,m.username,p.name')
            ->where($where)
            ->limit($start,$limit)
            ->order('a.add_time desc')
            ->select();


        $count = Db::name('ewm_order')
            ->alias('a')
            ->join('ms m','a.gema_userid = m.userid')
            ->join('pay_code p','a.code_type = p.id')
            ->where($where)
            ->count('a.id');

        return json([
            'code'=>0,
            'msg'=>'请求成功',
            'data'=>$sonOrders,
            'count'=>$count
        ]);


    }



    /**
     * 团队统计
     */
    public function stats(){
        return $this->fetch();
    }

    public function getTeamStats(Request $request){

        $where = [];
        if (!empty($request->param('username'))){
            $where['username'] = $request->param('username');
        }

        if (!empty($request->param('level'))){
            $where['level'] = $request->param('level');
        }

        $sonMsIds = $this->getIds($this->agent_id);

        if (empty($sonMsIds)){
            return json([
                'code'=>1,
                'msg'=>'暂无数据'
            ]);
        }
        $where['userid'] = ['in',$sonMsIds];
        $limit = $request->param('limit');
        $page = $request->param('page');
        $start=$limit*($page-1);
        $sonMsList = Db::name('ms')->where($where)->limit($start,$limit)->order('userid desc')->select();

        foreach($sonMsList as $key=>$val){
            $isAgent = Db::name('ms')->where('pid',$val['userid'])->select();
            if (empty($isAgent)){
                $sonMsList[$key]['team_people_number'] = 0;
                $sonMsList[$key]['yesterday_amount'] = sprintf("%.2f",Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid',$val['userid'])->sum('order_price'));
                $sonMsList[$key]['today_amount'] = sprintf("%.2f",Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid',$val['userid'])->sum('order_price'));
                $sonMsList[$key]['yesterday_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'yesterday')->where('status', 2)->where('ms_id',$val['userid'])->sum('amount'));
                $sonMsList[$key]['today_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'today')->where('status', 2)->where('ms_id',$val['userid'])->sum('amount'));
             }else{
                $this->son_id = [];
                $Msteams = $this->getIds($val['userid']);
                $sonMsList[$key]['team_people_number'] = sizeof($Msteams);
                array_unshift($Msteams,$val['userid']);
                $sonMsList[$key]['money'] = sprintf("%.2f",Db::name('ms')->where('userid','in',$Msteams)->sum('money'));
                $sonMsList[$key]['cash_pledge'] = sprintf("%.2f",Db::name('ms')->where('userid','in',$Msteams)->sum('cash_pledge'));
                $sonMsList[$key]['yesterday_amount'] = sprintf("%.2f",Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid','in',$Msteams)->sum('order_price'));
                $sonMsList[$key]['today_amount'] = sprintf("%.2f",Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid','in',$Msteams)->sum('order_price'));
                $sonMsList[$key]['yesterday_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'yesterday')->where('status', 2)->where('ms_id','in',$Msteams)->sum('amount'));
                $sonMsList[$key]['today_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'today')->where('status', 2)->where('ms_id','in',$Msteams)->sum('amount'));
            }
        }
        $count = sizeof($sonMsList);
        return json([
            'code'=>0,
            'msg'=>'请求成功',
            'data'=>$sonMsList,
            'count'=>$count
        ]);

    }


    /**
     * 添加下级码商
     */
    public function addSonUser(Request $request){
        if ($request->isPost()){
            $level = Db::name('ms')->where('userid',$this->agent_id)->value('level');
            if ($level >= 5){
                $this->error("你无权添加下级！");
            }
            $chachong = Db::name('ms')->where('username',$request->post('ms_name'))->find();
            if ($chachong){
                $this->error("此账号名不可添加！请更改！");
            }
            $users = [
                'username'      => $request->post('ms_name'),
                'login_pwd'    => $request->post('ms_password'),
                'relogin_pwd' => $request->post('ms_repassword'),
                'pid'   => $this->agent_id,
                'status' => 1
            ];

            return $this->logicMs->addMs($users);

        }
        return $this->fetch();
    }



    /**
     * @var array 修改下级接单状态
     */
    public function edit_son_work_status(){
        if ($this->request->isPost()){
            $status = $this->request->param('status') == 1?0:1;
            $userid = $this->request->param('userid');
            $sonIds = $this->getIds($this->agent_id);
            if (!in_array($userid,$sonIds)){
                return json([
                    'code' => 404
                ]);
            }
            $res = Ms::where(['userid' => $userid])->update(['work_status'=>$status]);
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
    }


    public $son_id = array();

    public function getIds($parentid)
    {
        $list = Db::name("ms")->where(["pid" => $parentid])->field('userid')->select();
        foreach ($list as $key => $value) {
            $this->son_id[] = $value['userid'];
            $this->getIds($value['userid']);
        }
        return $this->son_id;
    }
}