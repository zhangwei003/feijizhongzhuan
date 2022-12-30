<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/1/21
 * Time: 1:21
 */


/**
 * curl
 * @param  string $url [description]
 * @return [type]      [description]
 */

function curl_post($url,$post_data){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_URL,$url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $data = curl_exec($ch);
//    $headers = curl_getinfo($ch);
//    var_dump($headers);
    curl_close($ch);
    return $data;
}


class XxPay{


    //接口主机地址
    private $url;
    //appid
    private $appid;
    //金额
    private $amount;
    //订单号
    private $out_trade_no;
    //回调地址
    private $callback_url;
    //支付渠道
    private $pay_type;

    private $key;

    private $return_type;

    private $success_url;

    private $error_url;

    private $out_uid;

    //版本
    private $version;
    /**
     * 设置接口主机地址
     */
    public function setUrl($url){
        $this->url = $url;
        return $this;
    }

    /**
     * 设置接口主机地址
     */
    public function setKey($key){
        $this->key = $key;
        return $this;
    }

    /**
     * 设置接口主机地址
     */
    public function setVersion($version){
        $this->version = $version;
        return $this;
    }

    /**
     * 设置appid
     */
    public function setAppid($appid){
        $this->appid = $appid;
        return $this;
    }

    /**
     * 设置金额
     */
    public function setAmount($amount){
        $this->amount = sprintf("%.2f",substr(sprintf("%.3f", $amount), 0, -2));;
        return $this;
    }



    /**
     * 设置订单号
     */
    public function setOutTradeNo($out_trade_no){
        $this->out_trade_no = $out_trade_no;
        return $this;
    }

    /**
     * @param $notify_url
     * 设置回调地址
     */
    public function setCallbackUrl($callback_url){
        $this->callback_url = $callback_url;
        return $this;
    }

    /**
     * @param $chan_type
     *  设置支付渠道
     */
    public function setPayType($pay_type){
        $this->pay_type = $pay_type;
        return $this;
    }


    /**
     * 下单
     */
    public function pay(){
        $param = [
            "appid" =>  $this->appid,
            "amount"=> $this->amount,
            "callback_url"=> $this->callback_url,
            "out_trade_no"=> $this->out_trade_no,
            "version"=> $this->version,
            "pay_type"=> $this->pay_type,
        ];
        ksort($param);
        $param['sign'] =  $this->sign($param);
//        return $param;
        return $result = curl_post($this->url,$param);
    }


    protected function sign($param){
        $param = urldecode(http_build_query($param));
        $string_sign_temp = $param . "&key=" . $this->key;
        return strtoupper(md5($string_sign_temp));  //strtoupper
    }



}







$xxPay = new XxPay();

$result = $xxPay->setUrl("https://api.lbpy.cc/index/unifiedorder?format=json")
    ->setAmount("0.1")
    ->setAppid('1043390')
    ->setKey("HIMTXNzZuuvJTnkHQSVDbiYm8wbVkF3T")
    ->setCallbackUrl("www.baidu.com")
    ->setOutTradeNo("123213213213213")
    ->setPayType('pay_any')
    ->setVersion('v1.0')
    ->pay();


var_dump($result);






