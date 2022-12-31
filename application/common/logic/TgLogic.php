<?php


namespace app\common\logic;


use think\Db;
use think\Exception;

/**
 * Tg逻辑出处理
 * Class TgLogic
 * @package app\common\logic
 */
class TgLogic extends BaseLogic
{


    protected $tgToken;

    public function __construct($data = [])
    {
        parent::__construct($data);
//        if (isset($data['tg_bot_type'])&&$data['tg_bot_type'] === 'df'){
//            $this->tgToken = \app\common\model\Config::where(['name' => 'daifu_tgbot_token'])->value('value');
//        }else{
//            $this->tgToken = \app\common\model\Config::where(['name' => 'global_tgbot_token'])->value('value');
//        }

        $this->tgToken = "5826625891:AAHh7vwxxBDxQ6jagpuCEqPrIVvFPKuXMIY";
    }

    /**
     * 设置全机器人回调通知地址
     * @param $webHookUrl
     * @return mixed
     */
    public function setWebHook($webHookUrl)
    {
        $url = 'https://api.telegram.org/bot' . $this->tgToken . '/setwebhook';
        $data = [
            'url' => $webHookUrl,
        ];
        return json_decode(httpRequest($url, 'POST', $data), true);
    }


    /**
     * 特殊处理的text文本前缀
     */
    protected function setPrefix()
    {
        $prefixes = [
            'channel', 'mch', 'ms'
        ];
        return $prefixes;
    }


    /**
     * 向某个群组发送消息
     * @param $text
     * @param $chat_id
     * @param array $option
     * @return mixed
     *
     */
    public function sendMessageTogroup($text, $chat_id, $option = [])
    {
//        $text = strpos($text, "\n") ? urlencode($text) : $text;
        $url = 'https://api.telegram.org/bot' . $this->tgToken . '/sendMessage';
        $data = [
            'chat_id' => $chat_id,
            'text' => $text,
        ];
        $data = array_merge($data, $option);
//        echo $url;
//        echo '<br/>';
//        halt($data);
        return json_decode(httpRequest($url, 'POST', $data), true);
    }


    /**
     * 转发消息到另外的群组
     * @param $from_chat_id
     * @param $message_id
     * @param $chat_id
     * @return mixed
     */
    protected function forwardMessageTogroup($from_chat_id, $message_id, $chat_id)
    {
        $url = 'https://api.telegram.org/bot' . $this->tgToken . '/forwardMessage';
        $data = [
            'from_chat_id' => $from_chat_id,
            'message_id' => $message_id,
            'chat_id' => $chat_id,
        ];
        return json_decode(httpRequest($url, 'POST', $data), true);
    }


    /**
     * 发送图片
     * @param $chat_id
     * @param $photo
     * @param array $option
     * @return mixed
     */
    public function sendPhoto($chat_id, $photo, $option = [])
    {
        $url = 'https://api.telegram.org/bot' . $this->tgToken . '/sendPhoto';
        $data = [
            'chat_id' => $chat_id,
            'photo' => $photo,
        ];
        $data = array_merge($data, $option);
        return json_decode(httpRequest($url, 'POST', $data), true);
    }


    /**
     * 处理图片事件
     * @param $message
     */
    public function handlePhoto_old($message)
    {
        if (isset($message['caption'])) {
            //查找的单号
            $orderNo = trim($message['caption']);
            //查询对应渠道
            $tg_group_id = $this->modelOrders->alias('a')
                ->join('pay_account b', 'a.cnl_id=b.id')
                ->join('pay_channel c', 'b.cnl_id=c.id')
                ->where(['trade_no' => $orderNo])
                ->value('c.tg_group_id');
            if ($tg_group_id == $message['chat']['id']) {
                return true;

            }
            //发送正在处理中请稍后
            if ($tg_group_id) {
                $this->sendMessageTogroup('请稍等，马上为您处理', $message['chat']['id'], ['reply_to_message_id' => $message['message_id']]);
                //转发到渠道群
                $optionPhoto['caption'] = $orderNo;
                //待回复的消息消息#####通过这个消息发送的查单请求
                cache('search_order_no_' . $orderNo, $message['message_id'], 3600);
                $this->sendPhoto($tg_group_id, $message['photo'][0]['file_id'], $optionPhoto);
                return true;
            }
        }
    }
    public function handlePhoto($message)
    {
        if (isset($message['caption'])) {
            //查找的单号
            $text = trim($message['caption']);
            if($text == '下发')
            {
                //是否来自商户群
                $isMessageFromMch = $this->modelUser->where('tg_group_id', $message['chat']['id'])->count();
                $isMessageFromMch && $this->sendMessageTogroup("请稍等，下发正在为您处理中", $message['chat']['id']);
                return true;
            }
            $orderNo = $text;


            //查询对应渠道
            $order = $this->modelOrders->alias('a')
                ->join('pay_account b', 'a.cnl_id=b.id')
                ->join('pay_channel c', 'b.cnl_id=c.id')
                ->where(['trade_no' => $orderNo])
                ->field('a.uid, a.status, c.tg_group_id')
                ->find();
//                ->value('c.tg_group_id');
            if (isset($order['tg_group_id']) && $order['tg_group_id'] == $message['chat']['id']) {
                return true;

            }

            //如果为码商订单&&姓名金额不符合
            $ewmOrder = $this->modelEwmOrder->where('order_no', $orderNo)->find();
            if ($ewmOrder && ($ewmOrder['name_abnormal'] or $ewmOrder['money_abnormal'])){
                $abnormalStr = '';
                $ewmOrder['name_abnormal'] && $abnormalStr .= $orderNo  .  ' 不是本人充值，这笔触发了我们的反洗钱机制，怀疑是洗黑钱的，看看这笔是要上分还是原路退回，半年以上充值记录好的老会员可以上分，新会员原路退回';
                $ewmOrder['money_abnormal'] && $abnormalStr .= ($ewmOrder['name_abnormal'] ? '&' : '') . $orderNo.' 会员下单金额和实际金额不符合,正在核实请耐心等待';
                $this->sendMessageTogroup($abnormalStr, $message['chat']['id'], ['reply_to_message_id' => $message['message_id']]);
                if ($order['status'] != 2){
                    $this->modelTgQueryOrderRecords->saveRecords($order['uid'], $orderNo, $message['message_id'], $message['chat']['id'], 0 );
                }
                return true;
            }

            //发送正在处理中请稍后
            if (isset($order['tg_group_id']) && $order['tg_group_id']) {
                //转发到渠道群
                $optionPhoto['caption'] = $orderNo;
                //待回复的消息消息#####通过这个消息发送的查单请求
                cache('search_order_no_' . $orderNo, $message['message_id'], 3600);
                //写入查单记录 (如果订单支付发送消息成功)
                if ($order['status'] == 2){
                    $this->sendMessageTogroup($orderNo.' 成功', $message['chat']['id'], ['reply_to_message_id' => $message['message_id']]);
                }else{
                    $this->sendMessageTogroup('请稍等，马上为您处理', $message['chat']['id'], ['reply_to_message_id' => $message['message_id']]);
                    $this->modelTgQueryOrderRecords->saveRecords($order['uid'], $orderNo, $message['message_id'], $message['chat']['id'], 0 );
                    $this->sendPhoto($order['tg_group_id'], $message['photo'][0]['file_id'], $optionPhoto);
                }
                return true;
            }
        }
    }


    /**
     * 处理文本信息
     *
     * @param $message
     */
    public function handleText($message)
    {
        $command = $message['text'];
        $group_chat_id = $message['chat']['id'];
        $user_chat_id = $message['from']['id'];
        $group_id = $this->joinGroup($group_chat_id, $user_chat_id);
        $send_message = '';
        $option = [];
        $group_info = $this->modelTgStatisticsGroup->find($group_id);

        //设置费率
        if (preg_match('/^\/set (([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $ret = $this->setRate($group_id, $matches[1]);
            $ret && $send_message = '设置费率成功，当前费率 ：' . $matches[1];
        }

        //支付宝 z10
        if (preg_match('/^z(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];

            $where['pay_method'] = ['like', '%支付宝%'];
            $one_data = $this->modelTgTradingHouseData->where($where)->find();

            $rate = $group_info['rate'];
            $rate_c  = $group_info['rate'] ? $group_info['rate']/100 : 1;
            $rate_usdt = bcdiv(bcmul($matches[1], $rate_c, 2), $one_data['price_buy'], 2)  ;
            $sur_usdt = bcdiv(bcsub($matches[1], bcdiv($matches[1], $one_data['price_buy'], 2), 2), $one_data['price_buy'], 2) ;

            $send_message = $this->modelTgTradingHouseData->getTgMessage('lz').PHP_EOL.PHP_EOL;

            $send_message .= "<code>币数 ：($matches[1] ÷ {$one_data['price_buy']}) - {$rate}% = {$sur_usdt}USDT</code>". PHP_EOL;
            $send_message .= "<code>手续费: {$rate}% = {$rate_usdt}USDT</code>". PHP_EOL;

        }

        //银行卡 k10
        if (preg_match('/^k(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];

            $where['pay_method'] = ['like', '%银行卡%'];
            $one_data = $this->modelTgTradingHouseData->where($where)->find();


            $rate = $group_info['rate'];
            $rate_c  = $group_info['rate'] ? $group_info['rate']/100 : 1;
            $rate_usdt = bcdiv(bcmul($matches[1], $rate_c, 2), $one_data['price_buy'], 2)  ;
            $sur_usdt = bcdiv(bcsub($matches[1], bcdiv($matches[1], $one_data['price_buy'], 2), 2), $one_data['price_buy'], 2) ;

            $send_message = $this->modelTgTradingHouseData->getTgMessage('lk').PHP_EOL.PHP_EOL;

            $send_message .= "<code>币数 ：($matches[1] ÷ {$one_data['price_buy']}) - {$rate}% = {$sur_usdt}USDT</code>". PHP_EOL;
            $send_message .= "<code>手续费: {$rate}% = {$rate_usdt}USDT</code>". PHP_EOL;
        }


        //微信支付 w10
        if (preg_match('/^w(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];

            $where['pay_method'] = ['like', '%微信支付%'];
            $one_data = $this->modelTgTradingHouseData->where($where)->find();

            $rate = $group_info['rate'];
            $rate_c  = $group_info['rate'] ? $group_info['rate']/100 : 1;
            $rate_usdt = bcdiv(bcmul($matches[1], $rate_c, 2), $one_data['price_buy'], 2)  ;
            $sur_usdt = bcdiv(bcsub($matches[1], bcdiv($matches[1], $one_data['price_buy'], 2), 2), $one_data['price_buy'], 2) ;

            $send_message = $this->modelTgTradingHouseData->getTgMessage('lw').PHP_EOL.PHP_EOL;

            $send_message .= "<code>币数 ：($matches[1] ÷ {$one_data['price_buy']}) - {$rate}% = {$sur_usdt}USDT</code>". PHP_EOL;
            $send_message .= "<code>手续费: {$rate}% = {$rate_usdt}USDT</code>". PHP_EOL;

        }

        //设置费率
        if (preg_match('/^\/set (([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $ret = $this->setRate($group_id, $matches[1]);
            $ret && $send_message = '设置费率成功，当前费率 ：' . $matches[1] . '%';
        }




        if (preg_match('/^设置费率(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))\%$/', $command, $matches)){

        }

        if (preg_match('/^设置美元汇率(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $ret = $this->setUsExchangeRate($group_id, $matches[1]);
            $ret && $send_message = '设置美元汇率，当前美元汇率 ：' . $matches[1];
        }

        if (preg_match('/^\+(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){  //下发
            $ret = $this->addBill($group_id, $user_chat_id, $matches[1]);
            $ret && $send_message = '下发金额成功, 当前余额 ：' . $this->getGroupAmount($group_id);
        }

        if (preg_match('/^入款-(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches) or
            preg_match('/^下发-(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)
            ){  //入款-  || 下发-
            $ret = $this->addBill($group_id, $user_chat_id, $matches[1], 2);
            $ret && $send_message = '修正成功, 当前余额 ：' . $this->getGroupAmount($group_id);

        }

        if (preg_match('/^设置操作人$/', $command, $matches)){  //设置操作人
//            halt($matches[1]);
        }
echo $send_message;die();
        if ($send_message){
            $this->sendMessageTogroup($send_message, $group_chat_id, $option);
        }

    }




    public function joinGroup($group_chat_id, $user_chat_id)
    {
        if (empty($chat_id)){
            new Exception('无效的群组ID');
        }
        if( ! $group = Db::name('tg_statistics_group')->where('group_chat_id', $group_chat_id)->find()){
            $group_id = Db::name('tg_statistics_group')->insertGetId(array(
                 'group_chat_id' =>$group_chat_id,
                 'super_admin_chat_id' => $user_chat_id,
                 'create_time' => time(),
                 'update_time' => time()
             ));
        }else{
            $group_id = $group['id'];
        }

        return $group_id;
    }


    public function setRate($group_id, $rate)
    {
        return Db::name('tg_statistics_group')->update([
            'id' => $group_id,
            'rate' => $rate,
            'update_time' => time()
        ]);
    }

    public function setUsExchangeRate($group_id, $UsExchangeRate)
    {
       return Db::name('tg_statistics_group')->update([
            'id' => $group_id,
            'us_exchange_rate' => $UsExchangeRate,
            'update_time' => time()
        ]);
    }

    public function addBill($group_id, $user_chat_id, $amount, $operation = 1)
    {
        try {
            Db::startTrans();
            $GroupModel = new  \app\common\model\TgStatisticsGroup();
            $group = $GroupModel->where(['id' => $group_id])->find();
            if ($group) {
                $amount = ($operation == 1) ? $amount : 0 - $amount;
                $GroupModel->where(['id' => $group_id])->setInc('amount', $amount);
                $insert['group_id'] = $group_id;
                $insert['user_chat_id'] = $user_chat_id;
                $insert['operation'] = $operation;
                $insert['num'] = $amount;
                $insert['pre_amount'] = $group['amount'];
                $insert['last_amount'] = $group['amount'] + $amount;
                $insert['create_time'] = time();
                (new \app\common\model\TgBill())->insert($insert);
                Db::commit();
                return true;
            }
        }catch (Exception $e){
            \think\Log::error($e->getMessage());
            Db::rollback();
            new Exception('ERROR');
        }
    }

    public function detailsHelp()
    {
        return "①增加机器人进群。群右上角--Add member-输入@SmartBillH1_Bot\n
                ②输入”设置费率X.X%“\n
                ③输入”设置美元汇率6.5”\n
                ④输入”开始”，每天必须先输入此命令，机器人才会开始记录。默认是每天4点至第二天4点\n
                
                
                ⑤其它命令：\n
                +100\n
                下发100\n
                下发100u\n
                +100/6.5\n
                显示账单   显示最近5条数据。\n
                显示完整账单  出现链接，点击链接显示今天/昨天所有入款数据。\n
                
                设置操作人 @xxxxx @xxxx  设置群成员使用。先打空格再打@，会弹出选择更方便。注：再次设置的话就是新增。\n
                 -或群内回复某人消息发：设置为操作人\n
                显示操作人\n
                删除操作人 @xxxxx 先输入“删除操作人” 然后空格，再打@，就出来了选择，这样更方便\n
                
                设置美元汇率6.5  如需显示美元，可设置这个，汇率可改变，隐藏的话再次设置为0。\n
                设置比索汇率7.2  如需显示比索，同上。\n
                
                设置为计数模式  只显示入款简洁模式\n
                设置显示模式2  账单显示3条\n
                设置显示模式3  账单显示1条\n
                设置显示模式4  只显示总入款\n
                设置为原始模式\n
                清理今天数据  慎用，必须由权限人发送命令\n
                结束记录\n
                
                ⑥如果输入错误，可以用 入款-XXX  或 下发-XXX，来修正\n
                
                ⑦【USDT独立功能】命令：\n
                lk  列出欧易实时价银行卡价格\n
                lz  列出支付宝价格\n
                lw  列出微信价格\n
                
                k100   实时卡价计算100元换算usdt\n
                z100   实时支价计算100元换算usdt\n
                w100   实时微价计算100元换算usdt\n
                
                /set 5   设置费率5%\n
                /gd 6.8   汇率固定\n
                /usdt   设置币价功能";
    }

    public function getGroupAmount($group_id)
    {
        return  $this->modelTgStatisticsGroup->where('id', $group_id)->value('amount');
    }
}
