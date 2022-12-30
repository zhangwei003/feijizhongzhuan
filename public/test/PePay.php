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
    $headers = curl_getinfo($ch);
    var_dump($headers);
    curl_close($ch);
    return $data;
}

function curlPost($url = '', $postData = '', $options = array())
{
    if (is_array($postData)) {
        $postData = http_build_query($postData);
    }
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30); //设置cURL允许执行的最长秒数
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);

    if (!empty($options)) {
        curl_setopt_array($ch, $options);
    }
    //https请求 不验证证书和host
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    $data = curl_exec($ch);

    $headers = curl_getinfo($ch);
    curl_close($ch);
    return $data;
}





class Rsa {

    /**
     * 获取私钥
     * @return bool|resource
     */
    private static function getPrivateKey()
    {
        $abs_path = dirname(__FILE__) . '/rsa/cert/rsa_private_key.pem';
        $content = file_get_contents($abs_path);
        $public_key = "-----BEGIN PRIVATE KEY-----\n" . wordwrap($content, 64, "\n", true) . "\n-----END PRIVATE KEY-----";
        return openssl_pkey_get_private($public_key);
    }

    /**
     * 获取公钥
     * @return bool|resource
     */
    private static function getPublicKey()
    {
        $abs_path = dirname(__FILE__) . '/rsa/cert/rsa_public_key.pem';

        $content = file_get_contents($abs_path);
        $public_key = "-----BEGIN PUBLIC KEY-----\n" . wordwrap($content, 64, "\n", true) . "\n-----END PUBLIC KEY-----";
        return openssl_pkey_get_public($public_key);
    }

    /**
     * 私钥加密
     * @param string $data
     * @return null|string
     */
    public static function privEncrypt($data = '')
    {
        if (!is_string($data)) {
            return null;
        }
        return openssl_private_encrypt($data,$encrypted,self::getPrivateKey()) ? base64_encode($encrypted) : null;
    }

    /**
     * 公钥加密
     * @param string $data
     * @return null|string
     */
    public static function publicEncrypt($data = '')
    {
        if (!is_string($data)) {
            return null;
        }
        return openssl_public_encrypt($data,$encrypted,self::getPublicKey()) ? base64_encode($encrypted) : null;
    }

    /**
     * 私钥解密
     * @param string $encrypted
     * @return null
     */
    public static function privDecrypt($encrypted = '')
    {
        if (!is_string($encrypted)) {
            return null;
        }
        return (openssl_private_decrypt(base64_decode($encrypted), $decrypted, self::getPrivateKey())) ? $decrypted : null;
    }

    /**
     * 公钥解密
     * @param string $encrypted
     * @return null
     */
    public static function publicDecrypt($encrypted = '')
    {
        if (!is_string($encrypted)) {
            return null;
        }
        return (openssl_public_decrypt(base64_decode($encrypted), $decrypted, self::getPublicKey())) ? $decrypted : null;
    }

}


class PePay{


    //接口主机地址
    private $url;
    //金额
    private $amount;
    //商户号
    private $buss_id;
    //订单号
    private $buss_order_id;
    //回调地址
    private $notify_url;
    //支付渠道
    private $chan_type;


    private $addpepay = 'pay/addpepay';

    /**
     * 设置接口主机地址
     */
    public function setUrl($url){
        $this->url = $url;
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
     * 设置商户号
     */
    public function setBussId($buss_id){
        $this->buss_id = $buss_id;
        return $this;
    }

    /**
     * 设置订单号
     */
    public function setBussOrderId($buss_order_id){
        $this->buss_order_id = $buss_order_id;
        return $this;
    }

    /**
     * @param $notify_url
     * 设置回调地址
     */
    public function setNotifyUrl($notify_url){
        $this->notify_url = $notify_url;
        return $this;
    }

    /**
     * @param $chan_type
     *  设置支付渠道
     */
    public function setChanType($chan_type){
        $this->chan_type = $chan_type;
        return $this;
    }


    /**
     * 下单
     */
    public function addpepay(){
        $param = [
            "amount"=> $this->amount,
            "buss_id"=> $this->buss_id,
            "buss_order_id"=> $this->buss_order_id,
            "notify_url"=> $this->notify_url,
            "chan_type"=> $this->chan_type,
        ];
        ksort($param);
        $param['sign'] =  $this->sign($param);
        return $result = curl_post($this->url.$this->addpepay,json_encode($param));
    }


    protected function sign($param){
        $param = http_build_query($param);
        $sign = Rsa::privEncrypt($param);
        return $sign;
    }



}







$pePay = new pePay();
$result = $pePay->setUrl('http://pepay.jinlanzhou.com/')
    ->setAmount('123')
    ->setBussId('5e14509a00000000')
    ->setBussOrderId('adeff0098asdsad')
    ->setChanType('zfb00002')
    ->setNotifyUrl('https://www.baidu.com/')
    ->addpepay();

var_dump($result);






