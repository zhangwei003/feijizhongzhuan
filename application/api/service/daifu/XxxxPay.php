<?php

namespace app\api\service\daifu;
use app\api\service\DaifuPayment;
use think\Log;
class XxxxPay extends DaifuPayment
{
    public function pay($params){
        $Md5key = $this->config['api_key'];
        $data = [
            'amount' => $params['amount'],
            'bank_number' => $params['bank_number'],
            'bank_code' => $params['bank_name'],
            'bank_owner' => $params['bank_owner'],
            'mchid' => $this->config['merchant_id'],
            'out_trade_no' => $params['out_trade_no'],
            'notify_url' => $this->config['notify_url'],
            'body' => $params['body'],
            'subject' => $params['subject']
        ];
        ksort($data);
        $signData = http_build_query($data);
        $signData = $signData . '&' . $Md5key;
        $sign = md5($signData);

        $data['sign'] = $sign;
        $apiurl = $this->config['api_url'];
        $result = self::curlPost($apiurl,$data);
        Log::error('XXXXDaifu Return Data :'.$result);
        $result = json_decode($result,true);

        if ($result['code'] != 1){
            return ['code'=>0,'msg'=>$result['msg']];
        }
        return ['code'=>1,'msg'=>'请求成功'];
    }



    public function notify(){
        $notifyData = $_POST;
        Log::error("Daifu XxxxPay Notify Data : ".json_encode($notifyData,true));
        if ($notifyData['code'] == 1){
            echo "SUCCESS";
            $data['out_trade_no'] = $notifyData['out_trade_no'];
            $data['status'] = $notifyData['status'];
            $data['error_reason'] = $notifyData['error_reason'];
            return $data;
        }
        echo "Error";
        Log::error('Daifu XxxxPay Notify Error Data:' . json_encode($notifyData,true));
    }

}