<?php


namespace app\common\model;


class TgTradingHouseData extends BaseModel
{
    public function getTgMessage($type = 'l')
    {
        switch ($type){
            case 'lz':
                $where['pay_method'] = ['LIKE', '%支付宝%'];
                $pay_method = '支付宝';
                break;
            case 'lk':
                $where['pay_method'] = ['LIKE', '%银行卡%'];
                $pay_method = '银行卡';
                break;
            case 'lw':
                $where['pay_method'] = ['LIKE', '%微信支付%'];
                $pay_method = '微信支付';
                break;
            case 'l':
            default:
            $pay_method = '所有支付';
                $where = [];
                break;
        }
        $lists = $this->getList($where, true, '', false);
        $message = '<h3>OTC商家实时价格</h3>';
        $message .=  "<p>筛选:$pay_method</p>";
        foreach ($lists as $item){
            $message .=  "<p>{$item['merchant_name']}：{$item['price_buy']}</p>";
        }

        return $message;
    }
}