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


use app\common\library\RsaUtils;
use think\Request;

class Api extends Base
{

    /**
     * 接口基本
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function index()
    {
        $this->apiCommon();
        return $this->fetch();
    }

    /**
     * 重置密钥 已删除
     */


    /**
     * 可用渠道
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function channel()
    {

        //查询当前商户对应的支付产品
        $where['a.status'] = 1;
        $uid = is_login();
        $where['uid'] = $uid;
        $userCodes = $this->logicUser->userPayCodes($where, 'co_id,code,b.name as code_name', 'a.create_time desc', false);
        $userCodes = collection($userCodes)->toArray();
        if (is_array($userCodes) && !empty($userCodes)) {
            //随机一个支付产品的渠道账户对应的当前商户的费率
            foreach ($userCodes as $k => $paycode) {
                $urate = $this->logicUser->userCodeProfit($paycode['co_id'], $uid);
                $userCodes[$k]['urate'] = $urate;

            }
        }
        $this->assign('list', $userCodes);
        return $this->fetch();
    }


    /**
     * API公共
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function apiCommon()
    {
        $this->assign('api', $this->logicApi->getApiInfo(['uid' => is_login()]));

        $this->assign('rsa', $this->logicConfig->getConfigInfo(['name' => 'rsa_public_key'], 'value'));
        $this->assign('notify_ip', $this->logicConfig->getConfigInfo(['name' => 'notify_ip'], 'value'));
    }




}
