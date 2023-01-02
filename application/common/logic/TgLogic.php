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

        //设置入款费率
        if (preg_match('/^\/payset (([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $ret = $this->setRkRate($group_id, $matches[1]);
            $ret && $send_message = "入款规则手续费：$matches[1]%";
        }

        //交易行全部
        if (strcasecmp($command ,'l') == 0){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $send_message = $this->modelTgTradingHouseData->getTgMessage();
        }

        //交易行支付宝
        if (strcasecmp($command ,'lz') == 0){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $send_message = $this->modelTgTradingHouseData->getTgMessage('lz');
        }

        //交易行银行卡
        if (strcasecmp($command ,'lk') == 0){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $send_message = $this->modelTgTradingHouseData->getTgMessage('lk');
        }

        //交易行微信
        if (strcasecmp($command, 'lw') == 0){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $send_message = $this->modelTgTradingHouseData->getTgMessage('lw');
        }

        //支付宝 z10
        if (preg_match('/^z(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];

            $where['pay_method'] = ['like', '%支付宝%'];
            $one_data = $this->modelTgTradingHouseData->where($where)->find();

            if ($one_data){
                $rate = $group_info['rate'];
                $rate_usdt = $rate ?  bcdiv(bcmul($matches[1], $rate/100, 2), $one_data['price_buy'], 2) : 0;
                $sur_usdt =  bcdiv(bcsub($matches[1],  $rate ?  bcdiv($matches[1], $rate, 2) : 0, 2), $one_data['price_buy'], 2);
                $send_message = $this->modelTgTradingHouseData->getTgMessage('lz').PHP_EOL.PHP_EOL;
                $send_message .= "<code>币数 ：($matches[1] ÷ {$one_data['price_buy']}) - {$rate}% = {$sur_usdt}USDT</code>". PHP_EOL;
                $send_message .= "<code>手续费: {$rate}% = {$rate_usdt}USDT</code>". PHP_EOL;
            }

        }

        //银行卡 k10
        if (preg_match('/^k(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];

            $where['pay_method'] = ['like', '%银行卡%'];
            $one_data = $this->modelTgTradingHouseData->where($where)->find();


            if ($one_data){
                $rate = $group_info['rate'];
                $rate_usdt = $rate ?  bcdiv(bcmul($matches[1], $rate/100, 2), $one_data['price_buy'], 2) : 0;
                $sur_usdt =  bcdiv(bcsub($matches[1],  $rate ?  bcdiv($matches[1], $rate, 2) : 0, 2), $one_data['price_buy'], 2);
                $send_message = $this->modelTgTradingHouseData->getTgMessage('lk').PHP_EOL.PHP_EOL;
                $send_message .= "<code>币数 ：($matches[1] ÷ {$one_data['price_buy']}) - {$rate}% = {$sur_usdt}USDT</code>". PHP_EOL;
                $send_message .= "<code>手续费: {$rate}% = {$rate_usdt}USDT</code>". PHP_EOL;
            }
        }


        //微信支付 w10
        if (preg_match('/^w(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $where['pay_method'] = ['like', '%微信支付%'];
            $one_data = $this->modelTgTradingHouseData->where($where)->find();
            if ($one_data){
                $rate = $group_info['rate'];
                $rate_usdt = $rate ?  bcdiv(bcmul($matches[1], $rate/100, 2), $one_data['price_buy'], 2) : 0;
                $sur_usdt =  bcdiv(bcsub($matches[1],  $rate ?  bcdiv($matches[1], $rate, 2) : 0, 2), $one_data['price_buy'], 2);
                $send_message = $this->modelTgTradingHouseData->getTgMessage('lw').PHP_EOL.PHP_EOL;
                $send_message .= "<code>币数 ：($matches[1] ÷ {$one_data['price_buy']}) - {$rate}% = {$sur_usdt}USDT</code>". PHP_EOL;
                $send_message .= "<code>手续费: {$rate}% = {$rate_usdt}USDT</code>". PHP_EOL;
            }
        }

        //直接除法表达式
        if (preg_match('/^(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))\/(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $USDT =  bcdiv($matches[1], $matches[4],2);
            $send_message = "<code>结果 ：$command = {$USDT}</code>". PHP_EOL;
        }

        //直接乘法表达式
        if (preg_match('/^(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))\*(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $USDT =  bcmul ($matches[1], $matches[4],2);
            $send_message = "<code>结果 ：$command = {$USDT}</code>". PHP_EOL;
        }

        //直接加法表达式
        if (preg_match('/^(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))\+(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];

            $USDT =  bcadd($matches[1], $matches[4],2);
            $send_message = "<code>结果 ：$command = {$USDT}</code>". PHP_EOL;
        }

        //直接减法表达式
        if (preg_match('/^(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))\-(([1-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)){
            $option = [
                'parse_mode' => 'HTML'
            ];
            $USDT =  bcsub($matches[1], $matches[4],2);
            $send_message .= "<code>结果 ：$command = {$USDT}</code>". PHP_EOL;
        }

        if (preg_match('/^\+(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches) or
            preg_match('/^入款(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)
        ){  //入款
            $ret = $this->addBill($group_id, $user_chat_id, $matches[1]);
            $option = [
                'parse_mode' => 'HTML'
            ];
            if ($ret){
                $send_message = $this->modelTgBill->getBill($group_id);
            }
        }

        if (preg_match('/^\-(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches) or
            preg_match('/^下发(([0-9]\d*\.?\d*)|(0\.\d*[1-9]))$/', $command, $matches)
        ){  //入款
            $ret = $this->addBill($group_id, $user_chat_id, $matches[1], 2);
            $option = [
                'parse_mode' => 'HTML'
            ];
            if ($ret){
                $send_message = $this->modelTgBill->getBill($group_id);
            }
        }

        if (preg_match('/^账单$/', $command, $matches) ){  //账单
            $option = [
                'parse_mode' => 'HTML'
            ];
            $send_message = $this->modelTgBill->getBill($group_id);
        }
//halt($send_message);
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

    public function setRkRate($group_id, $rate)
    {
        return Db::name('tg_statistics_group')->update([
            'id' => $group_id,
            'rk_rate' => $rate,
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

    public function getGroupAmount($group_id)
    {
        return  $this->modelTgStatisticsGroup->where('id', $group_id)->value('amount');
    }
}
