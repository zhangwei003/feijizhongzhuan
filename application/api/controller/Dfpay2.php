<?php /*reated by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/10
 * Time: 20:40
 */

namespace app\api\controller;


use app\common\controller\DaifuBaseApi;
use app\common\logic\DaifuOrders;
use think\Exception;
use think\Log;

class Dfpay2 extends DaifuBaseApi
{
    protected $verification = ['pay'];

    /**
     * 代付
     */
    public function pay2()
    {
        Log::error("fancha kaishi");
        $DaifuOrders = new DaifuOrders();
        if(!empty($_POST['withdrawQueryUrl']))
        {
            $data = [
                'merchantId' => $_POST['mchid'], //商家号
                'money' => $_POST['amount'], //金额
                'orderNo' => $_POST['out_trade_no'], //订单号
                'token' =>  $_POST['callToken'], //Token，由系统产生并传送
                'target' => $_POST['bank_number'], //钱包地址或银行卡号
                'ownerName' => $_POST['bank_owner'], //选填 提款人姓名，银行卡要，虚拟币不需要
            ];
       $result = json_decode(self::curl($_POST['withdrawQueryUrl'],$data),true);
                  if ($result['status'] != 1){
                Log::error("fancha shibai". json_encode($result));
                json_encode($result);;die();
                  echo 3;die();
                  }
            unset($_POST['callToken']);
            unset($_POST['withdrawQueryUrl']);

        }
        //  unset($_POST['callToken']);
        //  unset($_POST['withdrawQueryUrl']);
//      unset($_POST['']);


        $result = $DaifuOrders->createOrder($_POST);
        if ($result['code'] != '1') {
            $this->error($result['msg']);
        }
        $this->success('请求成功', null, $result['data']);
    }



    public function curl($url,array $data)
    {
        $ch = curl_init();
        curl_setopt($ch,CURLOPT_URL,$url);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch,CURLOPT_POST,1);
        curl_setopt($ch,CURLOPT_POSTFIELDS, $data);
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }
}