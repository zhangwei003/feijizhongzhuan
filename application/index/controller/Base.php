<?php

/**
 *  +----------------------------------------------------------------------
 *  | 狂神系统系统 [ WE CAN DO IT JUST THINK ]
 *  +----------------------------------------------------------------------
 *  | Copyright (c) 2018 http://www.iredcap.cn All rights reserved.
 *  +----------------------------------------------------------------------
 *  | Licensed ( https://www.apache.org/licenses/LICENSE-2.0 )
 *  +----------------------------------------------------------------------
 *  | Author: Brian Waring <BrianWaring98@gmail.com>
 *  +----------------------------------------------------------------------
 */

namespace app\index\controller;

use app\common\controller\Common;
use think\helper\Time;

class Base extends Basis
{

    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub

        //登录判断
        !is_login() && $this->redirect(url('index/Login/login'));


//        if ($this->checkAuth() === false){
//            clear_user_login_session();
//            $this->redirect(url('index/Login/login'));
//        };

        // 登录信息
        $this->assign('user_info', $this->logicUser->getUserInfo(['uid' => is_login()]));
        //商户最后在线时间
        $User = new \app\common\model\User();
        $User->where(['uid' => is_login()])->update(['last_online_time'=>time()]);
    }

    /**
     * 是否本人操作
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function checkAuth(){
        if($this->request->isPost()){
//            print_r($this->request->post('i/a'));die;

            if ($this->request->post('i/a')['uid'] != is_login()){
                return false;
            }
        }
    }

    /**
     * 解析查询请求日期
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @return array
     */
    protected function parseRequestDate(){

        $date = $this->request->param('d/a');

        $start = empty($date['start']) ? strtotime(date("Y-m-d")) : strtotime($date['start']);
        $end = empty($date['end']) ? strtotime(date("Y-m-d 23:59:59")) : strtotime($date['end']);
        return [
            'between', [$start, $end]
        ];
    }

}