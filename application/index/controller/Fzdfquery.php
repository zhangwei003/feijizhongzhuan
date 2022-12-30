<?php

namespace app\index\controller;
use app\common\logic\DaifuOrders;
use think\Log;
use think\Db;
use think\Request;
class Fzdfquery
{
    public function query(){
        $key = '2C54YcfmcEGDSJ185fscU7YO40nl2mXq';
        $apiurl = 'http://203.74.125.18:28877/api/pay';
        $notifyurl = Request::instance()->domain().'/api/Daifunotify/notify/channel/FengZhengDfPay';
        $data = [
            'method' => 'pay_query',
            'app_id' => '99889289726263362',
        ];
        $where['status'] = 3;
        $where['is_to_channel'] = 2;
        $where['daifu_transfer_name'] = '风筝代付-备用金';
        $fzdforder = Db::name('daifu_orders')->where($where)->select();
        foreach ($fzdforder as $k=>$v){
                $data['order_sn'] = $v['out_trade_no'];
                $data['signature'] = $this->getSign($data,$key);
                $result = self::curlPost($apiurl,$data);
                Log::error('FengZhengDfPay Query Data'.$result);
                $result = json_decode($result, true);
                if ($result['code'] == 0){
                    if ($result['data']['pay_status'] == 2 || $result['data']['pay_status'] ==1 || $result['data']['pay_status'] ==3){
                        self::curlPost($notifyurl,$result);
                        return 'SUCCESS';
                    }

                }
        }
        return 'NULL';
    }

    private function getSign($data, $secret)
    {

        //签名步骤一：按字典序排序参数
        ksort($data);
        $string_a = '';
        foreach ($data as $k => $v) {
            $string_a .= "{$k}={$v}&";
        }
//        $string_a = substr($string_a,0,strlen($string_a) - 1);
        //签名步骤三：MD5加密
        $sign = md5($string_a . 'key=' . $secret);

        // 签名步骤四：所有字符转为大写
        $result = strtoupper($sign);

        return $result;
    }


    /**
     * curl post
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param string $url
     * @param string $postData
     * @param array $options
     * @return mixed
     */
    public static function curlPost($url = '', $postData = '', $options = array(),$timeOut=5)
    {
        if (is_array($postData)) {
            $postData = http_build_query($postData);
        }
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeOut); //设置cURL允许执行的最长秒数
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

}