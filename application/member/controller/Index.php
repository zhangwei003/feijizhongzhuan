<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2019/12/2
 * Time: 21:40
 */

namespace app\member\controller;


use app\agent\Logic\CodeLogic;
use app\common\library\enum\CodeEnum;
use app\common\library\enum\MoneyOrderTypes;
use app\common\logic\MsMoneyType;
use app\common\model\GemapayOrderModel;
use app\common\model\UserModel;
use app\common\model\UserProfitModel;
use app\index\model\SomebillModel;
use app\member\Logic\GoogleAuth;
use app\member\logic\Ms;
use app\ms\Logic\SecurityLogic;
use think\Controller;
use think\Db;

class Index extends Base
{


    public function index()
    {
        //今日成功代付金额
        // $successWhere['status'] = 2;
        // $successWhere['ms_id'] = $this->agent_id;
        // $successWhere['create_time'] = $this->parseRequestDate4();
        // $todaySuccessMoney = 0;
        // $todaySuccessMoney           = $this->modelDaifuOrders->where($successWhere)->sum('amount');
        //昨天
        // $successWhere['create_time'] = $this->parseRequestDate5();
        //  $yerterdaySuccessMoney       = $this->modelDaifuOrders->where($successWhere)->sum('amount');
        //商户今日新增金额
        // $yerterdaySuccessMoney = 0;
        // $this->assign(compact('todaySuccessMoney', 'yerterdaySuccessMoney'));
        return $this->fetch();
    }

    public function welcome()
    {
        $Account = Db::name('ms')->where('userid', $this->agent_id)->field('money,cash_pledge')->find();
        $this->assign('account', $Account);
        //今日统计
        $todayOrderAmount = Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid', $this->agent_id)->sum('order_price');
        $data['today_amount'] = sprintf("%.2f", $todayOrderAmount);
        $data['today_order_count'] = Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid', $this->agent_id)->count();
        $data['today_order_commission'] = Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid', $this->agent_id)->sum('bonus_fee');
        $data['today_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'today')->where('status', 2)->where('ms_id',$this->agent_id)->sum('amount'));
        $data['today_daifu_count']= Db::name('daifu_orders')->whereTime('create_time', 'today')->where('status', 2)->where('ms_id',$this->agent_id)->count();

        //所有下级
        $sonMs = $this->getIds($this->agent_id);
        $todaySonOrderAmount = Db::name('ewm_order')->whereTime('add_time', 'today')->where('status', 1)->where('gema_userid', 'in', $sonMs)->sum('order_price');
        $data['today_son_amount'] = sprintf("%.2f", $todaySonOrderAmount);

        //昨日统计
        $yesterdayOrderAmount = Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid', $this->agent_id)->sum('order_price');
        $data['yesterday_amount'] = sprintf("%.2f", $yesterdayOrderAmount);
        $data['yesterday_order_count'] = Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid', $this->agent_id)->count();
        $data['yesterday_order_commission'] = Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid', $this->agent_id)->sum('bonus_fee');
        $data['yesterday_daifu']= sprintf("%.2f",Db::name('daifu_orders')->whereTime('create_time', 'yesterday')->where('status', 2)->where('ms_id',$this->agent_id)->sum('amount'));
        $data['yesterday_daifu_count']= Db::name('daifu_orders')->whereTime('create_time', 'yesterday')->where('status', 2)->where('ms_id',$this->agent_id)->count();
        $yesterdaySonOrderAmount = Db::name('ewm_order')->whereTime('add_time', 'yesterday')->where('status', 1)->where('gema_userid', 'in', $sonMs)->sum('order_price');
        $data['yesterday_son_amount'] = sprintf("%.2f", $yesterdaySonOrderAmount);


        $this->assign('data', $data);

        return $this->fetch();
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


    public function codelists()
    {
        $codeList = Db::name('ms_rate')
            ->alias('r')
            ->join('ms m', 'm.userid = r.ms_id')
            ->join('pay_code c', 'r.code_type_id = c.id')
            ->where(['r.ms_id' => $this->agent_id, 'c.status' => 1])
            ->field('r.rate,r.create_time,c.name,c.code')
            ->select();
//        print_r($codeList);die;
        $this->assign('codeList', $codeList);
        return $this->fetch();
    }


    //验证登录密码是否正确
    public function check_pwd_one($value, $userId)
    {
        $where['userid'] = $userId;

        $modelMs = new \app\common\model\Ms();
        $u_info = $modelMs->where($where)->field('login_pwd,login_salt')->find();
        $salt = $u_info['login_salt'];
        $pwd = $u_info['login_pwd'];
        if ($pwd == pwdMd52($value, $salt)) {
            return true;
        } else {
            return false;
        }
    }


    public function updateLoginPassword($userId, $oldPassword, $newPassword, $newRePassword)
    {
        if (empty($oldPassword)) {
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '请输入登录密码'];
        }

        if (strlen($newPassword) < 6 || strlen($newPassword) > 16) {
            return ['code' => CodeEnum::ERROR, 'msg' => '密码必须大于6位,小于16位！'];
        }

        //密码强度
//        if(judgepassword($newPassword)<4)
//        {
//            return ['code' => CodeEnum::ERROR, 'msg' =>'新密码强度不够！' ];
//
//        }


        if ($newPassword != $newRePassword) {
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '两次输入登录密码不一致'];
        }

        $User = $this->modelMs;
        // $User->startTrans();
        //验证旧密码
        if (!$this->check_pwd_one($oldPassword, $userId)) {
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '旧登录密码错误'];
        }

        //=============登录密码加密==============
        if ($newPassword) {
            $salt = substr(md5(time()), 0, 3);
            $data['login_salt'] = $salt;
            $data['login_pwd'] = pwdMd52($newPassword, $salt);
        }

        $where['userid'] = $userId;
        $res = $User->where($where)->update($data);
        if ($res) {
            //     $User->commit();
//            Cache::set('user_LoginPassword_'.$userId,'0');
            return ['code' => \app\common\library\enum\CodeEnum::SUCCESS, 'msg' => '修改成功'];
        } else {
            //   $User->rollback();
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '修改失败'];
        }
    }

    /**
     * 密码修改
     */
    public function editPassword()
    {
        if ($this->request->isPost()) {
            $oldPassword = $this->request->post('old_password');
            $newPassword = $this->request->post('new_password');
            $newRePassword = $this->request->post('re_new_password');

            $res = $this->updateLoginPassword($this->agent->userid, $oldPassword, $newPassword, $newRePassword);

            if ($res['code'] == CodeEnum::ERROR) {
                $this->error($res['msg']);
//                ajaxReturn($res['msg'],0);
            }

            $this->success('操作成功');
        }
        return $this->fetch();
    }


    /**
     * 修改安全吗
     * @return mixed}
     */
    public function editSafety()
    {
        if ($this->request->isPost()) {
            $SecurityLogic = new SecurityLogic();
            $security = $this->request->post('security');
            $re_security = $this->request->post('re_security');
            $old_security = $this->request->post('old_security');

            $res = $SecurityLogic->changeSecurity($this->agent->userid, $security, $re_security, $old_security);
            if ($res['code'] == CodeEnum::ERROR) {
                $this->error($res['msg']);
            }
            $this->success('操作成功', url("Index/index"));
        }
        $this->assign('data', $this->agent);
        return $this->fetch();
    }

    public function replaceMenu()
    {
        $Menu_string = file_get_contents(ROOT_PATH . '/public/static/member/api/init.json');
        $payCode = $this->modelPayCode->where(['status'=>1])->where('id','LT','255')->field('name,code')->select();
        $data = json_decode($Menu_string, true);
        unset($data['menuInfo'][0]['child'][3]['child'], $data['menuInfo'][0]['child'][2]['child']);
        if (!empty($payCode)){
            foreach ($payCode as $code){
                $data['menuInfo'][0]['child'][3]['child'][] = [
                        "title"=>$code['name'],
                        "href"=>"/member/Channel/channel.html?pay_code={$code['code']}",
                        "icon"=>"fa fa-vimeo-square",
                        "target"=>"_self"
                ];
                $data['menuInfo'][0]['child'][2]['child'][] = [
                    "title"=>$code['name'],
                    "href"=>"/member/Pay/pay.html?pay_code={$code['code']}",
                    "icon"=>"fa fa-ioxhost",
                    "target"=>"_self"
                ];
            }

        }
        $Menu_string = json_encode($data);
        echo $Menu_string;

    }

}
