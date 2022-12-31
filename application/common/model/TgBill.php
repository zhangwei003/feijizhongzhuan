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
        $today_time = date('H:i', time());
        $send_message = "<code>{$today_date}日小记</code>" ;
        $today_bill = $this->modelTgBill->whereTime('create_time', 'd')->select();
        foreach ($today_bill as $bill){
            $send_message .= "<code>{$today_time}    {$bill['num']}</code>" ;
        }

        $bishu =  $this->modelTgBill->whereTime('create_time', 'd')->count();

        $total_rk = $this->modelTgBill->where('operation', 1)->whereTime('create_time', 'd')->sum('num');
        $total_ck = $this->modelTgBill->where('operation', 2)->whereTime('create_time', 'd')->sum('num');
        $rk_rate_amount =  bcmul($total_rk, $group_info['rk_rate']/100);
        $total_rk -= $rk_rate_amount;

        $bijia = $one_data = $this->modelTgTradingHouseData->limit(1)->value('price_buy');

        $y_usdt_num = bcdiv($total_rk, $bijia, 2);
        $yi_usdt_num = bcdiv($total_ck, $bijia, 2);
        $w_usdt_num = bcdiv(bcsub( $total_rk, $total_ck, 2), $bijia);
        $send_message .= "<code>总入款{$total_rk}</code>";
        $send_message .= "<code>手续费{$group_info['rk_rate']}%</code>";
        $send_message .= "<code>当前币价{$bijia}</code>";
        $send_message .= "<code>应下发{$total_rk} ｜ {$y_usdt_num}U</code>";
        $send_message .= "<code>已下发{$total_ck} ｜ {$yi_usdt_num}U</code>";
        $send_message .= "<code>未下发" .bcsub( $total_rk, $total_ck, 2) ." ｜ {$w_usdt_num}U</code>";
        $send_message .= "<code>共计{$bishu}笔</code>";

        return $send_message;
    }

}
