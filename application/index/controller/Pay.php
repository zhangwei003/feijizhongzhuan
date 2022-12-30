<?php

namespace app\index\controller;
use think\Controller;
use think\Db;
class Pay extends Controller
{
    /**
     * var string $secret_key 加解密的密钥
     */
    protected $secret_key  = 'f3a59b69324c831e';

    /**
     * var string $iv 加解密的向量，有些方法需要设置比如CBC
     */
    protected $iv = '7fc7fe7d74f4da93';

    public function orderQuery(){
        $order = $this->request->param('key');
        $order = $this->decrypt($order);
        if (empty($order)){
            return json(['code'=>0,'msg'=>'数据错误']);
        }
        $ewm_order = Db::name('ewm_order')->where(['order_no'=>$order])->find();
        if (empty($ewm_order)){
            return json(['code'=>0,'msg'=>'数据错误']);
        }

        $orders = Db::name('orders')->where('trade_no',$order)->find();

        $admin_id = Db::name('user')->where('uid',$orders['uid'])->value('admin_id');

        $orderTime = Db::name('config')->where(['name'=>'order_invalid_time','admin_id'=>$admin_id])->value('value');
        if (!empty($orderTime)){
            $invalid_time = $orderTime * 60;
        }else{
            $invalid_time = 360;
        }

        if (empty($orders)){
            return json(['code'=>0,'msg'=>'数据错误']);
        }
        if (time() > $ewm_order['add_time'] + $invalid_time){
            return json(['code'=> -1,'data'=>['success_url'=>$orders['return_url']]]);
        }

        if ($ewm_order['status'] == 1){
            return json(['code'=>200,'data'=>['status'=>"1",'order_status_msg'=>'订单付款完成','success_url'=>$orders['return_url']]]);
        }

        return json(['code'=>1,'data'=>['deadline_time'=>$ewm_order['add_time'] + $invalid_time - time()]]);

    }

    private function decrypt($data)
    {
        return openssl_decrypt(base64_decode($data), "AES-128-CBC",$this->secret_key,true,$this->iv);
    }
}