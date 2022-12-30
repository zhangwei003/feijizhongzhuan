<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/7
 * Time: 22:19
 */

namespace app\index\controller;


use app\common\logic\DaifuOrders;
use think\Db;
class Cron
{
    public function a()
    {
      $where['trade_no']='TX162211090133613479';
      $orderLists = Db::name('daifu_orders')->where($where)->select();
      $daifuNotify = new DaifuOrders();
     $d= $daifuNotify->retryNotify($orderLists[0]['id'],0); 
     var_dump($d);die();
    }
    public function notify()
    {
        //状态
	    $where['status'] = ['in',[0,2]];
	   // notify_result
//		  $where['notify_result'] = ['neq','SUCCESS'];
          $start = time()-(120*60);
          $end = time();
          $where['create_time'] =['between time',[$start,$end]];
          $where['send_notify_times'] = ['<',2];
          $where['uid'] = ['not in',100326];
        $daifuNotify = new DaifuOrders();


        $orderLists = Db::name('daifu_orders')
                                        ->where($where)
                                        ->where(function ($query){
                                            $query->where('notify_result',['neq','SUCCESS'],NULL,'or');
                                        })
                                        ->order('id desc')->limit(50)->select();

            if ($orderLists){
                foreach ($orderLists as $k=>$v){
                    if($v['status']==2)
                    {
                        $status=true;

                    }
                    else
                    {
                        $status=false;
                    }
                       $daifuNotify->retryNotify($v['id'],$status);
                    echo "订单号：".$v['out_trade_no']."</br>";
                }
            }

        echo 3;die();
    }



}
