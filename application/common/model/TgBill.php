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


class TgBill extends BaseModel
{

    public function getBill($group_id){
        $group_info = $this->modelTgStatisticsGroup->find($group_id);

        $today_date = date('Y-m-d', time());
        $send_message = "<code>{$today_date}日小记</code>\n"  ;
        $whereCommon['group_id'] = $group_id;
        $today_bill = $this->modelTgBill
            ->where($whereCommon)
            ->whereTime('create_time', 'd')->order('id desc')->limit(10)->select();
        foreach ($today_bill as $bill){
            $today_time = date('H:i', strtotime($bill['create_time']));
            $send_message .= "<code>{$today_time}    {$bill['num']}</code>\n" ;
        }

        $bishu =  $this->modelTgBill->where($whereCommon)->whereTime('create_time', 'd')->count();

        $total_rk = $this->modelTgBill->where(array_merge($whereCommon, array('operation' => 1)))->whereTime('create_time', 'd')->sum('num');
        $total_ck = $this->modelTgBill->where(array_merge($whereCommon, array('operation' => 2)))->whereTime('create_time', 'd')->sum('num');

        $rk_rate_amount =  bcmul($total_rk, $group_info['rk_rate']/100);

        $y_total_rk = $total_rk - $rk_rate_amount;

        $bijia = $this->modelTgTradingHouseData->limit(1)->order('price_buy desc')->value('price_buy');

        $y_usdt_num = bcdiv($y_total_rk, $bijia, 2);

        $yi_usdt_num = abs(bcdiv($total_ck, $bijia, 2));

        $w_usdt_num = bcdiv(bcadd( $y_total_rk, $total_ck, 2), $bijia, 2);

        $send_message .= "<code>总入款{$total_rk}</code>\n";
        $send_message .= "<code>手续费{$group_info['rk_rate']}%</code>\n";
        $send_message .= "<code>当前币价{$bijia}</code>\n";
        $send_message .= "<code>应下发{$y_total_rk} ｜ {$y_usdt_num}U</code>\n";
        $send_message .= "<code>已下发" . abs($total_ck)." ｜ {$yi_usdt_num}U</code>\n";
        $send_message .= "<code>未下发" .bcadd( $y_total_rk, $total_ck, 2) ." ｜ {$w_usdt_num}U</code>\n";
        $send_message .= "<code>共计{$bishu}笔</code>\n";

        return $send_message;
    }

}
