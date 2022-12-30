<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/1/30
 * Time: 0:09
 */

//商户名称
$appid  = $_POST['appid'];
//支付时间戳
$callbacks  = $_POST['callbacks'];
//支付状态
$pay_type  = $_POST['pay_type'];
//支付金额
$amount  = $_POST['amount'];
//支付时提交的订单信息
$success_url  = $_POST['success_url'];
//平台订单交易流水号
$error_url  = $_POST['error_url'];
//该笔交易手续费用
$out_trade_no  = $_POST['out_trade_no'];
//签名算法
$amount  = $_POST['amount'];
//回调时间戳
$sign  = $_POST['sign'];


$callback_url = '提交的地址';

$data = [
    'appid'        => $appid,
    'callbacks'     => $callbacks,
    'pay_type' => $pay_type,
    'amount'       => $amount,
    'callback_url' => $callback_url,
    'success_url'  => $success_url,
    'error_url'    => $error_url,
    'out_trade_no'      => $out_trade_no,
    'sign'      => $sign,
];

//第一步，检测商户appid否一致
if ($appid != '1043390') exit('error:appid');
//第二步，验证签名是否一致

if (verifySign($data,'HIMTXNzZuuvJTnkHQSVDbiYm8wbVkF3T') != $sign) exit('error:sign');


//if (verifySign($data,'商户密钥') != $sign) exit('error:sign'); 

echo 'success';


function verifySign($data, $secret) {
    // 验证参数中是否有签名
    if (!isset($data['sign']) || !$data['sign']) {
        return false;
    }
    // 要验证的签名串
    $sign = $data['sign'];
    unset($data['sign']);
    // 生成新的签名、验证传过来的签名
    $sign2 = getSign($secret, $data);

    if ($sign != $sign2) {
        return false;
    }
    return true;
}


function getSign($secret, $data)
{

    // 去空
    $data = array_filter($data);

    //签名步骤一：按字典序排序参数
    ksort($data);
    $string_a = http_build_query($data);
    $string_a = urldecode($string_a);

    //签名步骤二：在string后加入mch_key
    $string_sign_temp = $string_a . "&key=" . $secret;

    //签名步骤三：MD5加密
    $sign = md5($string_sign_temp);

    // 签名步骤四：所有字符转为大写
    $result = strtoupper($sign);

    return $result;
}
