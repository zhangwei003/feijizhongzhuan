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

namespace app\index\validate;


class Login extends Base
{
    /**
     * 验证规则
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @var array
     */
    protected $rule =   [

        'username'  => 'require',
        'password'  => 'require|length:6,12',
        'vercode'   => 'require|captcha',
    ];

    /**
     * 验证消息
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @var array
     */
    protected $message  =   [

        'username.require'    => '登录名不能为空',
//        'username.email'      => '登录名必须是邮箱',
        'password.require'    => '登录密码不能为空',
        'password.length'     => '登陆密码长度6-12',
        'vercode.require'     => '验证码不能为空',
        'vercode.captcha'     => '验证码不正确',
    ];

}