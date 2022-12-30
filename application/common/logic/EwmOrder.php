<?php
namespace app\common\logic;


use app\admin\model\ShopOrderModel;
use app\agent\model\ShopAccountModel;
use app\common\library\enum\CodeEnum;
use app\common\library\enum\OrderStatusEnum;
use app\common\model\EwmPayCode;
use app\common\model\GemapayOrderModel;
use app\ms\Logic\SecurityLogic;
use think\Cache;
use think\Db;
use think\Log;

/**
 * 二维码订单逻辑处理
 * Class EwmOrder
 * @package app\common\logic
 */
class EwmOrder extends BaseLogic
{
    /**
     * @param $array
     * @param $keys
     * @param int $sort
     * @return mixed
     * 二维数组排序
     */
    public function arraySort($array, $keys, $sort = SORT_DESC)
    {
        $keysValue = [];
        foreach ($array as $k => $v) {
            $keysValue[$k] = $v[$keys];
        }
        array_multisort($keysValue, $sort, $array);
        return $array;
    }


    /**
     * 获取可以使用的二维码
     * @param $money
     * @param $codeType
     * @param $ip
     * @param $admin_id
     * @return array|bool
     */
    public function getGoodCodeV3($money, $codeType, $ip, $member_id,$admin_id=0)
    {
        $EwmOrderModel = new \app\common\model\EwmOrder();
        $GemapayCode = new EwmPayCode();
        $gemapayOrderLogic = new EwmOrder();
        //获取可以使用二维码
        $isAllowPoint = true;
        //如果匹配不到整数,去匹配小数点
        if ($isAllowPoint) {
//            $member_id 为所有可用码商
//            获取全部可用码商二维码
            $codeInfos = $GemapayCode->getRandomCodeV2($codeType, $member_id);
            if ($codeInfos === false) {
                return false;
            }
            $codeInfos = array_unique($codeInfos);
//            去掉最大金额，最小金额，去掉日接单次数，单日总金额
            foreach ($codeInfos as $k=>$v){
                //最大限额
                if (!empty($v['max_money'] )&&  $v['max_money'] * 100 != 0){
                    if ($money > $v['max_money']){
                        unset($codeInfos[$k]);
                        continue;
                    }
                }
                //订单笔数限制
                if ($v['success_order_num'] != 0){
                    $code_num = $EwmOrderModel->where('code_id',$v['id'])->whereTime('add_time', 'today')->count();
                    if ($code_num >= $v['success_order_num']){
                        unset($codeInfos[$k]);
                        continue;
                    }
                }
                //日限额
                if($v['limit__total'] != 0) {
                    $money_today = $EwmOrderModel->where('code_id='.$v['id'].' and status =1 and add_time>'.strtotime(date('Y-m-d')))->sum('order_pay_price');
                    if( $money+$money_today >$v['limit__total'] ){
                        unset($codeInfos[$k]);
                        continue;
                    }
                }

            }
            if (empty($codeInfos)) return false;
            //卡转卡去除相同金额
//            $codeTypename = Db::name('pay_code')->where('id',$codeType)->value('code');
//            if ($codeType == 'kzk' || $codeType == 'alipayUidTransfer'){
                $payPrices = $gemapayOrderLogic->getAvaibleMoneys($money);
                $OrderData = $EwmOrderModel
                    ->where('gema_userid','in',$member_id)
                    ->where('add_time','>',time()-600)
                    ->where('status',0)
                    ->where('code_type',$codeType)
                    ->field('code_id,order_pay_price,add_time')
                    ->select();

                foreach ($payPrices as $k=>$price){
                    foreach ($OrderData as $p){
                        foreach ($codeInfos as $val){
                            if ($p['order_pay_price']==$price && $p['code_id'] == $val['id']){
                                unset($payPrices[$k]);
                                continue;
                            }
                        }
                    }

                }
                if (empty($payPrices)) return false;
                $payPrices = array_unique($payPrices);
                shuffle($payPrices);
                $reallPayMoney = reset($payPrices);
//            }else{
//                $reallPayMoney  = $money;
//            }
//            Log::error('排掉后的金额:'.json_encode($payPrices,true));

        } else {
            $reallPayMoney = $money;
        }



        //$reallPayMoney = $money;;
        $userIds = [];
        foreach ($codeInfos as $code) {
            $userIds[] = $code['ms_id'];
        }
        //去重
        $userIds = array_unique($userIds);
        sort($userIds);
        $lastUserId = cache($codeType.$admin_id."_last_userid");
        if (empty($lastUserId)) {
            $lastUserId = $userIds[0];
        } else {
            $flag = false;
            foreach ($userIds as $key => $userId) {
                if ($userId > $lastUserId) {
                    $flag = true;
                    $lastUserId = $userId;
                    break;
                }
            }
            if ($flag == false) {
                $lastUserId = $userIds[0];
            }
        }
        cache($codeType.$admin_id.'_last_userid', $lastUserId);

        //这里按照正序排序
        $codeInfos = $this->arraySort($codeInfos, 'id', SORT_ASC);
        $codeInfo = [];
        //该用户上次使用的codeid
        $lastUserIdCodeId = cache($codeType.$admin_id."_last_userid_codeid_" . $lastUserId);
        if ($lastUserIdCodeId) {
            foreach ($codeInfos as $code) {
                if ($code['ms_id'] == $lastUserId && $code['id'] > $lastUserIdCodeId) {
                    $codeInfo = $code;
                    break;
                }
            }
            if (!$codeInfo) {
                foreach ($codeInfos as $code) {
                    if ($code['ms_id'] == $lastUserId) {
                        $codeInfo = $code;
                        break;
                    }
                }
            }
        } else {
            foreach ($codeInfos as $code) {
                if ($code['ms_id'] == $lastUserId) {
                    $codeInfo = $code;
                    break;
                }
            }
        }

        cache($codeType.$admin_id."_last_userid_codeid_" . $lastUserId, $codeInfo['id']);
        return [$reallPayMoney, $codeInfo, null];
    }



    /**
     * 获取可以使用的二维码
     * @param $money
     * @param $codeType
     * @param $ip
     * @param $admin_id
     * @return array|bool
     */
    public function getGoodCodeV4($money, $codeType, $ip, $member_id,$admin_id=0)
    {
        $GemapayCode = new EwmPayCode();
        $gemapayOrderLogic = new EwmOrder();
        //获取可以使用二维码
        $isAllowPoint = true;
        sleep(5);
	//如果匹配不到整数,去匹配小数点
        if ($isAllowPoint) {
                 $payPrices = $gemapayOrderLogic->getAvaibleMoneys($money);
                 foreach ($payPrices as $price) {
                     $codeInfos = $GemapayCode->getRandomCode($price, $codeType, $member_id,$admin_id);
                     if ($codeInfos === false){
                         continue;
                     }
                     if (!empty($codeInfos)) {
                         $reallPayMoney = $price;
                         break;
                     }
                 }
             } else {
                 $reallPayMoney = $money;
             }
             if ($codeInfos === false) {
                 return false;
             }
        return [$reallPayMoney, $codeInfos, null];
    }




    public function getGoodCodeV2($money, $codeType, $ip, $member_id,$admin_id=0)
    {
        $GemapayCode = new EwmPayCode();
        $gemapayOrderLogic = new EwmOrder();
        //获取可以使用二维码
        //    $codeInfos = $GemapayCode->getAviableCode($money, $codeType, $member_id);
        //  if (empty($codeInfos)) {
        //      return false;
//	}
//	var_dump($codeInfos);;
        $isAllowPoint = true;
        //如果匹配不到整数,去匹配小数点

        if (empty($codeInfos)) {
            if ($isAllowPoint) {
                $payPrices = $gemapayOrderLogic->getAvaibleMoneys($money);
                foreach ($payPrices as $price) {
                    $codeInfos = $GemapayCode->getAviableCode($price, $codeType, $member_id);
                    if (!empty($codeInfos)) {

                        $reallPayMoney = $price;
                        break;
                    }
                }
            } else {
                $reallPayMoney = $money;
            }
            if (empty($codeInfos)) {
                return false;
            }
        } else {
            $reallPayMoney = $money;
        }

        //$reallPayMoney = $money;;
        $userIds = [];
        foreach ($codeInfos as $code) {
            $userIds[] = $code['ms_id'];
        }
        //去重
        $userIds = array_unique($userIds);
        sort($userIds);
//        echo json_encode($userIds);
        $lastUserId = cache($admin_id."_last_userid");
        if (empty($lastUserId)) {
            $lastUserId = $userIds[0];
        } else {
            $flag = false;
            foreach ($userIds as $key => $userId) {
                if ($userId > $lastUserId) {
                    $flag = true;
                    $lastUserId = $userId;
                    break;
                }
            }
            if ($flag == false) {
                $lastUserId = $userIds[0];
            }
        }





//        Log::error('$lastUserId :'. $lastUserId);
        cache($admin_id.'_last_userid', $lastUserId);

        //这里按照正序排序
        $codeInfos = $this->arraySort($codeInfos, 'id', SORT_ASC);
        $codeInfo = [];
        //该用户上次使用的codeid
        $lastUserIdCodeId = cache($admin_id."_last_userid_codeid_" . $lastUserId);
        if ($lastUserIdCodeId) {
            foreach ($codeInfos as $code) {
                if ($code['ms_id'] == $lastUserId && $code['id'] > $lastUserIdCodeId) {
                    $codeInfo = $code;
                    break;
                }
            }
            if (!$codeInfo) {
                foreach ($codeInfos as $code) {
                    if ($code['ms_id'] == $lastUserId) {
                        $codeInfo = $code;
                        break;
                    }
                }
            }
        } else {
            foreach ($codeInfos as $code) {
                if ($code['ms_id'] == $lastUserId) {
                    $codeInfo = $code;
                    break;
                }
            }
        }

        cache($admin_id."_last_userid_codeid_" . $lastUserId, $codeInfo['id']);

//var_dump($reallPayMoney);die();
        return [$reallPayMoney, $codeInfo, null];
    }

    /**
     * @param $money
     * @param $tradeNo
     * @param $codeType
     * @param $merchantOrderNo
     * @param $admin_id
     * @param $notify_url
     * @param int $memeber_id
     * @return array
     * luomu 修改订单重复版本
     */
    public function createOrders($money, $tradeNo, $codeType, $merchantOrderNo, $admin_id, $notify_url, $member_ids = 0,$pay_username = '' )
    {
        $GemapayCode = new EwmPayCode();
        $GemapayOrderModel = new \app\common\model\EwmOrder();
        $msModel = new \app\common\model\Ms();
        $adminModel = new \app\common\model\Admin();
        $GemapayCode->startTrans();
	//码商余额是否大于押金浮动金额
	//没有指定码商
	if(empty( $member_ids))
	{
	  $msList = $msModel->where(['status'=>1,'work_status'=>1,'money'=>['>=',$money+2000],'admin_id'=>$admin_id])->select();
	}
	else
	{
	   $msList = $msModel->where(['status'=>1,'work_status'=>1,'money'=>['>=',$money],'userid'=>['in',$member_ids],'admin_id'=>$admin_id])->select();
	}
	if(empty($msList))
	{
	    $GemapayCode->rollback();
	    return ['code' => CodeEnum::ERROR, 'msg' => '没足够的码商可以接这笔订单'];
	}
	$member_ids = [];
        foreach($msList as $key=>$val)
	{
	    $member_ids[]= $val['userid'];

	}
	$member_ids = implode($member_ids,',');

        $insId = $GemapayOrderModel->addGemaPayOrder(0, $money, $tradeNo, 0, 0, "", "", $codeType, $tradeNo, $merchantOrderNo, $admin_id, $notify_url, 0, $pay_username);
        if (empty($insId)) {
            $GemapayCode->rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '更新订单数据失败'];
        }
        $where['order_no'] = $tradeNo;
        $order = $GemapayOrderModel->where($where)->find();
       
        $adminwhere['id'] =  $admin_id;
        $admin =  $adminModel->lock(true)->where($adminwhere)->find();        

	$ip = '--';
        list($money, $code, $area) = $this->getGoodCodeV4($order['order_price']-0.01, $order['code_type'], $ip, $member_ids, $admin_id);
        if ($code == false) {
            $GemapayOrderModel->isUpdate(true, ['id' => $order['id']])->save(['note' => '系统没有可用的支付二维码']);
            $GemapayOrderModel->commit();
            return ['code' => CodeEnum::ERROR, 'msg' => '系统没有可用的支付二维码'];
	}
        $data['order_pay_price'] = $money;
        $data['gema_username'] = $code['user_name'];
        $data['gema_userid'] = $code['ms_id'];
        $data['code_id'] = $code['id'];
        $data['visite_area'] = $area;
        $data['visite_ip'] = $ip;
        $data['visite_time'] = time();
        if (false == $GemapayOrderModel->where(['id' => $order['id']])->update($data)) {

		$GemapayOrderModel->rollback();
		Log::error('二维码订单报错id:'. $order['id'].' 数据:'.json_encode($data));
            return ['code' => CodeEnum::ERROR, 'msg' => '更新失败'];

        }

        //扣除用户余额
        $message = "抢单" . $tradeNo . "成功";


        /*        if (false == accountLog($code['ms_id'], MsMoneyType::ORDER_DEPOSIT, MsMoneyType::OP_SUB, $order['order_price'], $message)) {
                    $GemapayCode->where(true, ['id' => $order['id']])->update(['note' => 'error']);
                    $GemapayCode->commit();
                    return ['code' => CodeEnum::ERROR, 'msg' => 'error'];
                }*/

        $GemapayCode->incTodayOrder($code['id']);
//        $GemapayCode->commit();
        $GemapayCode->commit();
        return ['code' => CodeEnum::SUCCESS, 'data' => [
            'code' => $code,
            'money' => $money
        ]];

    }


    /**
     * @param $money
     * @param $tradeNo
     * @param $codeType
     * @param $merchantOrderNo
     * @param $admin_id
     * @param $notify_url
     * @param int $memeber_id
     * @return array
     */
    public function createOrder($money, $tradeNo, $codeType, $merchantOrderNo, $admin_id, $notify_url, $member_ids = 0,$pay_username = '' )
    {
        $GemapayCode = new EwmPayCode();
        $GemapayOrderModel = new \app\common\model\EwmOrder();
        $msModel = new \app\common\model\Ms();
        $adminModel = new \app\common\model\Admin();
        $GemapayCode->startTrans();
        //码商余额是否大于押金浮动金额
        //没有指定码商
        if(empty( $member_ids))
        {
            $msList = $msModel->where(['status'=>1,'work_status'=>1,'money'=>['>=',$money+2000],'admin_id'=>$admin_id])->select();
        }
        else
        {
            $msList = $msModel->where(['status'=>1,'work_status'=>1,'money'=>['>=',$money],'userid'=>['in',$member_ids],'admin_id'=>$admin_id])->select();
        }
        if(empty($msList))
        {
            $GemapayCode->rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '没足够的码商可以接这笔订单'];
        }
        $member_ids = [];
        foreach($msList as $key=>$val)
        {
//        if ($val['cash_pledge'] != 0 ){
//            if ($val['money'] < $val['cash_pledge']){
//                unset($msList[$key]);
//            }
//        }

            $member_ids[]= $val['userid'];

        }
        $member_ids = implode(',', $member_ids);

        $insId = $GemapayOrderModel->addGemaPayOrder(0, $money, $tradeNo, 0, 0, "", "", $codeType, $tradeNo, $merchantOrderNo, $admin_id, $notify_url, 0, $pay_username);
        if (empty($insId)) {
            $GemapayCode->rollback();
            $GemapayOrderModel->rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '更新订单数据失败'];
        }
        $where['order_no'] = $tradeNo;
//        $GemapayOrderModel->startTrans();
        $order = $GemapayOrderModel->where($where)->find();

//        $adminwhere['id'] =  $admin_id;
//        $admin =  $adminModel->lock(true)->where($adminwhere)->find();
//sleep(3);
        $ip = '--';
        list($money, $code, $area) = $this->getGoodCodeV3($order['order_price']-0.01, $order['code_type'], $ip, $member_ids, $admin_id);
        if ($code == false) {
            $GemapayOrderModel->isUpdate(true, ['id' => $order['id']])->save(['note' => '系统没有可用的支付二维码']);
//            $GemapayOrderModel->rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '系统没有可用的支付二维码'];
        }
        $data['order_pay_price'] = $money;
        $data['gema_username'] = $code['user_name'];
        $data['gema_userid'] = $code['ms_id'];
        $data['code_id'] = $code['id'];
        $data['visite_area'] = $area;
        $data['visite_ip'] = $ip;
        $data['visite_time'] = time();
        if (false == $GemapayOrderModel->where(['id' => $order['id']])->update($data)) {
//            $GemapayOrderModel->rollback();
            Log::error('二维码订单报错id:'. $order['id'].' 数据:'.json_encode($data));
            return ['code' => CodeEnum::ERROR, 'msg' => '更新失败'];

        }
//        $GemapayOrderModel->commit();
        //扣除用户余额
        $message = "抢单" . $tradeNo . "成功";


        /*        if (false == accountLog($code['ms_id'], MsMoneyType::ORDER_DEPOSIT, MsMoneyType::OP_SUB, $order['order_price'], $message)) {
                    $GemapayCode->where(true, ['id' => $order['id']])->update(['note' => 'error']);
                    $GemapayCode->commit();
                    return ['code' => CodeEnum::ERROR, 'msg' => 'error'];
                }*/

        $GemapayCode->incTodayOrder($code['id']);
//        $GemapayCode->commit();

        $GemapayCode->commit();
        return ['code' => CodeEnum::SUCCESS, 'data' => [
            'code' => $code,
            'money' => $money
        ]];

    }



    /**
     * 获取可用金额列表
     * @param $money
     * @return array
     */
    public function getAvaibleMoneys($money)
    {
        $data = [];
        $limit = 20;
        $moneyStart = $money - $limit * 0.005+0.01;
        for ($i = 0; $i <= $limit; $i++) {
            if ($moneyStart + $i * 0.01 != $money+0.01) {
                $data[] = sprintf("%.2f", floatval($moneyStart + $i * 0.01));
            }
        }

        return $data;
    }


    /**
     * 用户完成订单
     * @param $orderId
     * @param $note
     * @param $userid
     */
    public function setOrderSucessByUser($orderId, $userid, $security=0, $next_user_id = 0, $coerce = false)
    {
        //判断订单状态
        $GemaPayOrder = new \app\common\model\EwmOrder();
        $SecurityLogic = new SecurityLogic();

        //判断交易密码
        $result = $SecurityLogic->checkSecurityByUserId($userid, $security);

        //判断用收款ip是否和最近登录的ip是否一致
        if ($result['code'] == CodeEnum::ERROR) {
            return $result;
        }

        $where['id'] = $orderId;
        $where['status'] = $GemaPayOrder::WAITEPAY;
        //判断是否强制补单
        if (1) {
            unset($where['status']);
        }
        $where['gema_userid'] = $userid;
        if ($next_user_id) {
            //  $where['gema_userid'] = $next_user_id;
        }

        Db::startTrans();
        $orderInfo = $GemaPayOrder->where($where)->lock(true)->find();
        if ($orderInfo['status'] == $GemaPayOrder::PAYED) {
            Db::rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '订单已完成'];
        }
        Db::commit();


        if (empty($orderInfo)) {
            return ['code' => CodeEnum::ERROR, 'msg' => '订单信息有误'];
        }

        if ($orderInfo['gema_userid'] != $userid) {
            return ['code' => CodeEnum::ERROR, 'msg' => '操作非法'];
        }

        //判断用户余额是否足够

        $UserModel = new \app\common\model\Ms();
        $userMoney = $UserModel->where(['userid' => $userid])->value('money');
        if ($userMoney < $orderInfo['order_price']) {
         //   return ['code' => CodeEnum::ERROR, 'msg' => '用户余额不足'];
        }

        return $this->setOrderSucess($orderInfo, "用户手动调单",$userid);
    }

    /**
     * @param $orderInfo
     * @param bool $notSend
     * @return array|bool
     */
    protected function orderProfit($orderInfo, $notSend = false)
    {
//        $userModel = new \app\common\model\Ms();
//        $user = $userModel->find($orderInfo['gema_userid']);
//          $cnlid = Db::name('orders')
//            ->alias('o')
//            ->join('pay_account a','o.cnl_id = a.id')
//            ->where('o.trade_no',$orderInfo['order_no'])
//            ->value('a.cnl_id');
//        $cnlid = Db::name('ewm_order')->where(['order_no',$orderInfo['order_no']])
             $msrate = Db::name('ms_rate')->where(['ms_id'=>$orderInfo['gema_userid'],'code_type_id'=>$orderInfo['code_type']])->value('rate');
             if (!$msrate || $msrate == 0){
                 return true;
             }

                $money = sprintf('%.2f',$orderInfo['order_pay_price'] * $msrate / 100);


            //查询
            $ms= Db::name('ms')->where('userid',$orderInfo['gema_userid'])->find();

            if ($ms['level'] > 1){
                    $this->orderMsTid($orderInfo,$ms['pid'],$orderInfo['code_type']);
            }

//
//        $money = sprintf('%.2f', $user['bank_rate'] * $orderInfo['order_pay_price'] / 100);
        if ((bccomp($money, 0.00, 2) == 1)) {
            //$tip_message = "订单【{$orderInfo['order_no']}】中获得佣金{$money}元";
            $tip_message = $orderInfo['order_no'];
            if (!accountLog($orderInfo['gema_userid'], MsMoneyType::USER_BONUS, MsMoneyType::OP_ADD, $money, $tip_message)) {
                return false;
            }
        }

        return $money;
    }



    


    /** 计算码商代理费率
     * @author luomu 2022/10/30
     */
    public function orderMsTid($order,$mtid,$cnlid){
        //查找该码商跟代理的费率
        //码商费率
        $msRate = Db::name('ms_rate')->where(['ms_id'=>$order['gema_userid'],'code_type_id'=>$cnlid])->value('rate');
        //代理费率
        $agentRate = Db::name('ms_rate')->where(['ms_id'=>$mtid,'code_type_id'=>$cnlid])->value('rate');

        $rate = (floatval($agentRate) - floatval($msRate) >0) ? floatval($agentRate) - floatval($msRate) : 0;//码商费率
        $ffid =  $this->modelMs->where(['userid'=>$mtid])->value('pid');
        if($rate<=0){
            if($ffid>0){
                //上级代理的父代理结算
                $mtid = $ffid;
                $this->orderAgentFid($order,$ffid,$agentRate,$mtid,$cnlid);
            }
            return true;
        }
        //计算代理盈利
        $gain = floatval($order['order_pay_price']) * $rate / 100;

        //获取代理余额信息
        $tidInfo = $this->modelMs->where('userid',$mtid)->value('money');

        //给代理增加余额
        $updata = [
            'money'  => floatval($tidInfo) + $gain,//总金额
        ];

        // 修改账户信息
        $res = $this->modelMs->where(['userid'=>$mtid])->update($updata);

        if($res) {
            //写入金额流水
            $somebill_data = [
                'uid'            => $mtid,
                'jl_class'               =>9,
                'num'               => $gain,
                'pre_amount'        => $tidInfo,
                'last_amount'         => $updata['money'],
                'jc_class'             => '+',
                'info'            => '子码商（ID：'.$order['gema_userid'].'）-【'.$order['gema_username'].'】产生交易订单（'.$order['order_no'].'），盈利'.$gain,
                'addtime'            => time(),

            ];
            Db::name('ms_somebill')->insert($somebill_data);

        }
        //查找上级代理是否存在父代理

        if($ffid>0){
            //上级代理的父代理结算
            $this->orderAgentFid($order,$ffid,$agentRate,$mtid,$cnlid);
        }

    }


    /** 计算码商上级代理盈利
     * @author luomu 2022/10/30
     */
    private function orderAgentFid($order,$fid,$tidRate,$mtid,$cnlid){
        //查找父代理的费率
        $fidRate = Db::name('ms_rate')->where([ 'code_type_id' => $cnlid, 'ms_id' => $fid])->value('rate');

        $rate = (floatval($fidRate) - floatval($tidRate)>0) ? floatval($fidRate) - floatval($tidRate) : 0;//码商费率
        $ffid =  Db::name('ms')->where(['userid'=>$fid])->value('pid');
        if($rate<=0){
            if($ffid>0){
                //上级代理的父代理结算
                $mtid = $fid;
                self::orderAgentFid($order,$ffid,$fidRate,$mtid,$cnlid);
            }
            return true;
        }

        //计算代理盈利
        $gain = floatval($order['order_pay_price']) * $rate / 100;
    
        //获取代理余额信息
        $tidInfo = $this->modelMs->where('userid',$fid)->value('money');

        //给代理增加余额
        $updata = [
            'money'  => floatval($tidInfo) + $gain,//总金额
        ];

        // 修改代理账户信息
        $res = $this->modelMs->where(['userid'=>$fid])->update($updata);

        if($res) {
            $msname = $this->modelMs->where('userid',$mtid)->value('username');
            //写入金额流水表 还没写
            $somebill_data = [
                'uid'            => $fid,
                'jl_class'               => 9,//2 提现
                'num'               => $gain,//变动金额
                'pre_amount'        => $tidInfo,//变动金额
                'last_amount'         => $updata['money'],//变动金额
                'jc_class'             => '+',
                'info'            => '子码商（ID：'.$mtid.'）-【'.$msname.'】产生交易订单（'.$order['order_no'].'），盈利'.$gain,
                'addtime'            => time(),

            ];
            Db::name('ms_somebill')->insert($somebill_data);

        }
        //查找上级代理是否存在父代理
        if($ffid>0){
            //上级代理的父代理结算
            $mtid = $fid;
            self::orderAgentFid($order,$ffid,$fidRate,$mtid,$cnlid);
        }

    }




    /**
     * 记录失败次数
     * @param $code_id
     * @param $type
     * @param $admin_id
     */
    public function recordFailedNum($code_id, $type, $admin_id)
    {
        $GemapayCodeModel = new EwmPayCode();
        $code = $GemapayCodeModel->where(['id' => $code_id])->find();
        if ($code) {
            $code->failed_order_num++;
            $code->updated_at = time();
            $code->save();
            $code->commit();
        }
    }


    /**
     * 设置订单为成功状态
     * @param $orderId
     * @param string $note
     * @return array
     */
    public function setOrderSucess($orderInfo,$note,$userid,$RemarkNmae='码商')
    {
        $GemapayOrderModel = new \app\common\model\EwmOrder();

        Db::startTrans();
        $orderInfo = $GemapayOrderModel->lock(true)->find($orderInfo['id']);

        //如果订单为关闭状态则手动强制完成需要扣除
        /* if ($orderInfo['status'] == $GemapayOrderModel::CLOSED) {
             $message = "后台强制完成订单" . $orderInfo['out_trade_no'] . ",扣除订单金额";
             $res = accountLog($orderInfo['gema_userid'], MsMoneyType::ORDER_FORCE_FINISH,
                 MsMoneyType::OP_SUB, $orderInfo["order_price"], $message);
             if ($res == false) {
                 Db::rollback();
                 return ['code' => CodeEnum::ERROR, 'msg' => '!更新数据失败'];
             }
         }*/

        //$message = "订单" . $orderInfo['out_trade_no'] . "完成";
        $message = $orderInfo['out_trade_no'];
        if (false == accountLog($orderInfo['gema_userid'], MsMoneyType::ORDER_DEPOSIT, MsMoneyType::OP_SUB, $orderInfo['order_price'], $message)) {
            $GemapayCode->where(true, ['id' => $order['id']])->update(['note' => 'error']);
            $GemapayCode->commit();
            return ['code' => CodeEnum::ERROR, 'msg' => 'error'];
        }
        //给码商返佣金
        $bonus = $this->orderProfit($orderInfo);
        if ($bonus === false) {
        //    Db::rollback();
          //  return ['code' => CodeEnum::ERROR, 'msg' => '!发放佣金失败'];
        }

        $res = $GemapayOrderModel->setOrderSucess($orderInfo['id'], $note, $bonus);


        if ($res == false) {
            Db::rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '!更新数据失败!'];
        }

        $orderModel = model('orders');
        $result = $orderModel->where('trade_no', $orderInfo['order_no'])->find();
        if (!empty($result) && $result['status'] == 1){
            $OrdersNotify = new  \app\common\logic\OrdersNotify();
            $logicQueue = new  \app\common\logic\Queue();
            $bdRemarks = '后台确认收款通知支付系统单号'.$orderInfo['order_no'];
            if ($userid != 0){
                $bdRemarks = $RemarkNmae.'用户'.$userid.'确认收款通知支付系统单号'.$orderInfo['order_no'];
            }

            if(empty($bdRemarks))
            {
                return ['code' => CodeEnum::ERROR, 'msg' => '必须填写备注' ];
            }
            $model = new \app\api\logic\Notify();
            $res = $model->updateOrderInfo($result, 2);
            if ($res === true){

                $OrdersNotify->saveOrderNotify($result);
                $logicQueue->pushJobDataToQueue('AutoOrderNotify' , $result , 'AutoOrderNotify');
                //单独修改补单备注(编辑封闭新增放开原则)todo 此处后期事务处理最好
                $orderModel->where('trade_no', $orderInfo['order_no'])->setField('bd_remarks', $bdRemarks);
                Db::commit();
                return ['code' => CodeEnum::SUCCESS, 'msg' => '数据更新成功'];
            }

        }



    }


    /**
     * 获取订单总金额
     */
    public function getTotalPrice($where)
    {
        $GemapayOrderModel = new \app\common\model\EwmOrder();
        //总订单金额 总订单数量
        $total_order = $GemapayOrderModel->where($where)
            ->field('cast(sum(order_price) AS decimal(15,2)) as  total_price, count(id) as total_number ')
            ->find()->toArray();
        //成功的订单
        $success_order = $GemapayOrderModel->where($where)->where(['status' => $GemapayOrderModel::PAYED])
            ->field('cast(sum(order_price) AS decimal(15,2)) as  success_price, count(id) as success_number ')
            ->find()->toArray();

        $result = [
            'total_price' => $total_order['total_price'] ? $total_order['total_price'] : 0,
            'total_number' => $total_order['total_number'] ? $total_order['total_number'] : 0,
            'success_price' => $success_order['success_price'] ? $success_order['success_price'] : 0,
            'success_number' => $success_order['success_number'] ? $success_order['success_number'] : 0,
        ];
        return $result;
    }


    /**
     *
     * 获取订单列表
     *
     * @param array $where
     * @param bool $field
     * @param string $order
     * @param int $paginate
     * @return mixed
     * @author 勇敢的小笨羊
     */
    public function getOrderList($where = [], $field = true, $order = 'add_time desc', $paginate = 1)
    {
        $this->modelEwmOrder->alias('a');
        $this->modelEwmOrder->limit = !$paginate;
        $this->modelEwmOrder->append = ['add_time', 'visite_time', 'pay_time'];
        $join = [
            ['ewm_pay_code b', 'a.code_id = b.id', 'left'],
            ['ms c', 'a.gema_userid = c.userid', 'left'],
            ['ewm_block_ip eo', 'eo.block_visite_ip = a.visite_ip', 'left'],
            ['orders o','a.order_no = o.trade_no','left'],
            ['user u','o.uid = u.uid','left'],
            ['orders_notify n','o.id = n.order_id','left'],
            ['pay_code p','a.code_type = p.id','left'],
//            ['banktobank_sms s','a.id = s.order_id','left'],
//            ['ms m', 'c.pid = m.userid', 'left'],
        ];
        $this->modelEwmOrder->join = $join;
        return $this->modelEwmOrder->getList($where, $field, $order, $paginate);
    }

    /**
     * 获取单总数
     *
     * @param $where
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getOrdersCount($where = [])
    {
        return $this->modelEwmOrder->alias('a')
            ->where($where)
            ->join('ewm_pay_code b', 'a.code_id = b.id', 'left')
            ->join('ms c', 'a.gema_userid = c.userid', 'left')
            ->join('orders o','a.order_no = o.trade_no','left')
            ->join('pay_code p','b.code_type = p.id','left')
            ->count();

    }


    /**
     * 管理员完成订单+补单
     * @param $orderId
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function setOrderSucessByAdmin($orderId, $coerce = 0)
    {
        //判断订单状态
        $GemaPayOrder = new \app\common\model\EwmOrder();

        $where['id'] = $orderId;
        $where['status'] = $GemaPayOrder::WAITEPAY;
        //判断是否强制补单
        if (1) {
            unset($where['status']);
        }

        Db::startTrans();
        $orderInfo = $GemaPayOrder->where($where)->lock(true)->find();
        if ($orderInfo['status'] == $GemaPayOrder::PAYED) {
            Db::rollback();
            return ['code' => CodeEnum::ERROR, 'msg' => '订单已完成'];
        }
        Db::commit();



        if (empty($orderInfo)) {
            return ['code' => CodeEnum::ERROR, 'msg' => '订单信息有误'];
        }

        //判断用户余额是否足够
        return $this->setOrderSucess($orderInfo, "用户手动调单",0);
    }


    /**
     * 取消订单
     * @param $order
     */
    public function cancleOrder($order)
    {
        Db::startTrans();
        $GemapayOrderModel = new \app\common\model\EwmOrder();
        $where["order_no"] = $order;
        $order = $GemapayOrderModel->where($where)->lock(true)->find();

        if (empty($order) || $order['status'] != $GemapayOrderModel::WAITEPAY) {
            Db::rollback();
            return false;
        }
        //取消订单
        $statusRet = $GemapayOrderModel->where(['id' => $order['id']])->setField('status', 2);

        if ($statusRet != false) {
            //如果为二维码订单 记录失败次数
            if (in_array($order['code_type'], ["1", "2", "3","4"])) {
                $this->recordFailedNum($order['code_id'], false, $order['admin_id']);
            }

            //记录日志
            /*   $message = "关闭订单：" . $order['order_no'];
               if ($order['gema_userid']) {
                   //如果没有配置或者配置为1 的话 抢单扣除余额 那关闭订单需要返回余额
                   $ret = accountLog($order['gema_userid'], MsMoneyType::ORDER_DEPOSIT_BACK,
                       MsMoneyType::OP_ADD, $order['order_price'], $message);
                   if ($ret != false) {
                       Db::commit();
                       return true;
                   }
               }*/
        }
        Db::rollback();
        return false;
    }


    /**
     * 10分钟关闭码商二维码订单
     */
    public function closeOrder()
    {

        $indate = 10;
        $where = [];
        $GemapayOrderModel = new \app\common\model\EwmOrder();
        $where['code_type'] = 3;
        $where['add_time'] = ['lt', time() - (60 * $indate)];
        $where['status'] = $GemapayOrderModel::WAITEPAY;
        $orderList = $GemapayOrderModel->where($where)->select();
        if ($orderList) {
            foreach ($orderList as $k => $v) {
                $res = $this->cancleOrder($v['order_no']);
            }
        }
echo 3;
        $GemapayOrderModel = new \app\common\model\EwmOrder();
        $where['code_type'] = 4;
        $where['add_time'] = ['lt', time() - (60 * 5)];
        $where['status'] = $GemapayOrderModel::WAITEPAY;
        $orderList = $GemapayOrderModel->where($where)->select();
        if ($orderList) {
            foreach ($orderList as $k => $v) {
                $res = $this->cancleOrder($v['order_no']);
            }
        }
    }
}
