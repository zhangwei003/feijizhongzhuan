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


namespace app\common\model;

use app\common\library\exception\OrderException;
use think\Db;
use think\Log;

class DepositeOrders extends BaseModel
{


    /**
     * 订单状态检查
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param $orderNo
     * @return Orders|null
     * @throws OrderException
     * @throws \think\exception\DbException
     */
    public function checkOrderValid($orderNo)
    {
        $order = self::get(['trade_no' => $orderNo]);
        if (!$order) {
            throw new OrderException([
                'msg' => 'Order Do Not Exist',
                'errorCode' => 200002
            ]);
        }

        if ($order['status'] === 2) {
            throw new OrderException([
                'msg' => 'Order Error',
                'errorCode' => 200003,
                'code' => 400
            ]);
        }
        return $order;
    }

    /**
     * 获取平台订单
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param string $tradeOrderNo 平台订单号
     * @return Orders|bool|null
     * @throws \think\exception\DbException
     */
    public function getTradeOrder($tradeOrderNo){
        $order = self::get(['trade_no' => $tradeOrderNo]);
        if ($order) {
            return $order;
        }
        return false;
    }

    /**
     * 获取商户订单
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param string $outTradeOrderNo 商户订单号
     * @return Orders|bool|null
     * @throws \think\exception\DbException
     */
    public function getOutTradeOrder($outTradeOrderNo){
        $order = self::get(['out_trade_no' => $outTradeOrderNo]);
        if ($order) {
            return $order;
        }
        return false;
    }

    /**
     * 改变订单状态
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param array $where
     * @param array $data
     */
    public function changeOrderStatusValue($data = [],$where = []){
        self::allowField(true)->save($data, $where);
    }


    /**
     * @param $out_trade_no
     * 验证订单号是否重复
     */
    public function checkOutTradeNo($uid,$out_trade_no){
        return $this->where(['uid'=>$uid,'out_trade_no'=>$out_trade_no])->find();
    }

    /**
     * 创建订单
     */
    public function createOrder($data){
        return $this->create($data);
    }


}