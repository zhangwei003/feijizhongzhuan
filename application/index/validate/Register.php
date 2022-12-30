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


class Register extends Base
{
    /**
     * 验证规则
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @var array
     */
    protected $rule =   [
        'username'  => 'require|length:1,10',
//        'account'  => 'require|email',
        'password'  => 'require|length:6,12',
        //'phone'     => 'require|number|length:11',
    ];

    /**
     * 验证消息
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @var array
     */
    protected $message  =   [
//        'account.require'     => '邮箱不能为空',
//        'account.email'       => '邮箱不正确',
        'username.require'    => '用户名不能为空',
        'username.length'     => '用户名长度为1-30个字符之间',
//        'username.unique'     => '用户名已存在',
        'password.require'    => '登录密码不能为空',
        'password.length'     => '登陆密码长度6-12',
        //'phone.require'       => '手机号不能为空',
       // 'phone.length'        => '手机号长度不足',
    ];

}