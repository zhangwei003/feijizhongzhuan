<?php
/**
 *  +----------------------------------------------------------------------
 *  | 狂神系统系统 [ WE CAN DO IT JUST THINK ]
 *  +----------------------------------------------------------------------
 *  | Copyright (c) 2018 http://www.iredcap.cn All rights reserved.
 *  +----------------------------------------------------------------------
 *  | Licensed ( https://www.apache.org/licenses/LICENSE-2.0 )
 *  +----------------------------------------------------------------------
 *  | Author: Brian Waring <BrianWaring98@gmail.com>
 *  +----------------------------------------------------------------------
 */

namespace app\admin\controller;

use app\api\service\payment\DnPay;
use app\common\library\enum\CodeEnum;
use think\Db;
use think\helper\Time;

class Index extends BaseAdmin
{


    public function testpay(){
        if ($this->request->isPost()){
            $uid = $this->request->param('uid');
            $pay_code = $this->request->param('type');
            $amount = $this->request->param('amount');
            if (empty($uid) || empty($pay_code) || empty($amount)){
                return json(['code'=>404,'msg'=>'参数错误']);
            }
            $u = Db::name('user')->where('uid',$uid)->find();
            if (is_admin_login() != 1){
                if ($u['admin_id'] != is_admin_login()){
                    return json(['code'=>404,'msg'=>'非法请求']);
                }
            }
            $md5key = Db::name('api')->where('uid',$uid)->value('key');
            $host = $_SERVER["HTTP_HOST"];
            $requestUrl = 'http://'.$host.'/api/pay/unifiedorder';
            $data = array(
                'mchid' => $uid,
                'out_trade_no' => date('ymdHis').rand(1000,9999),
                'amount' => $amount,
                'channel' =>$pay_code,
                'notify_url' => $host.'/test/notify.php',
                'return_url' => $host.'/test/return.php',
                'time_stamp' => date("Ymdhis"),
                'body' => "addH",
            );
            ksort($data);
            $signData = "";
            foreach ($data as $key=>$value)
            {
                $signData = $signData.$key."=".$value;
                $signData = $signData . "&";
            }

            $signData = $signData."key=".$md5key;
            $sign = md5($signData);

            $data['sign'] = $sign;
            //初始化
            $curl = curl_init();
//设置抓取的url
            curl_setopt($curl, CURLOPT_URL, $requestUrl);
//设置头文件的信息作为数据流输出
            curl_setopt($curl, CURLOPT_HEADER, 0);
//设置获取的信息以文件流的形式返回，而不是直接输出。
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
//设置post方式提交
            curl_setopt($curl, CURLOPT_POST, 1);

            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

            $json = curl_exec($curl);

            //关闭URL请求
            curl_close($curl);
//显示获得的数据
            $data = json_decode($json, true);
//        print_r($data);die;
            if($data['code'] == 0)
            {
//                header("location: ".$data['data']['request_url']);
                return  json(['code'=>0,'pay_url'=>$data['data']['request_url']]);
            }
            else
            {
                return  json(['code'=>404,'msg'=>$data['msg']]);
            }
        }
        $where['status'] = 1;
        if (is_admin_login() != 1){
            $where['admin_id'] = is_admin_login();
        }
        $user = Db::name('user')->where($where)->select();
        $pay_code = Db::name('pay_code')->where('status',1)->select();
        $this->assign('paycode',$pay_code);
        $this->assign('user',$user);
        return $this->fetch();
    }

    /**
     * 访问首页  -  加载框架
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @return mixed
     */
    public function index()
    {
        //读取配置 判断是否开启渠道统计悬浮窗
        $is_channel_statistics = 0;
        $config = \app\common\model\Config::where(['name'=>'is_channel_statistics'])->find()->toArray();
        if($config){
            if($config['value'] == '1'){
                $is_channel_statistics = '1';
            }
        }
        $this->assign('is_channel_statistics',$is_channel_statistics);
        return $this->fetch();
    }

    /**
     * 欢迎主页  -  展示数据
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @return mixed
     */
    public function welcome()
    {

        $where['status'] = 2;
        if (is_admin_login() != 1){
            $adminsonuser = Db::name('user')->where('admin_id',is_admin_login())->column('uid');
            $where['uid'] = ['in',$adminsonuser];
        }
        // 今日平台收入--商户收入
        $platform_in_user = Db::name('orders')
                            ->where($where)
                            ->whereTime('create_time', 'today')->sum('platform_in');

        //查找今日成功订单
        $where1 = [];
        if (is_admin_login() != 1){
            $adminsonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');

            $where1['gema_userid'] = ['in',$adminsonMs];
        }
        $todaydayOrders = Db::name('ewm_order')
                                ->where($where1)
                                ->where(['status'=>1])
                                ->whereTime('add_time', 'today')
                                ->field('id,gema_userid,order_price,code_type')
                                ->select();
        //循环计算码商费用
        foreach($todaydayOrders as $k=>$v){
            $mspid = Db::name('ms')->where('userid',$v['gema_userid'])->value('pid');
            if ($mspid > 0){
                //查找顶级id
                $v['gema_userid'] = getNavPid($mspid);
            }
            //查找费率
            $orderMsRate = Db::name('ms_rate')->where(['code_type_id'=>$v['code_type'],'ms_id'=>$v['gema_userid']])->value('rate');
            if ($orderMsRate == 0){
                $todaydayOrders[$k]['msCost'] = 0;
            }else{
                // 码商费用
                $todaydayOrders[$k]['msCost'] = sprintf("%.2f",$v['order_price'] * ($orderMsRate / 100));
            }

        }
        //求和码商费用
        $todaymsCost = array_sum(array_column($todaydayOrders,'msCost'));
        //今日平台收入
        $today_platform_in = $platform_in_user - $todaymsCost;
        $today_platform_in = sprintf("%.2f",$today_platform_in);




        //昨日
        $platform_in_user = Db::name('orders')
                                    ->where($where)
                                    ->whereTime('create_time', 'yesterday')->sum('platform_in');
        // 码商费用
        //查找今日成功订单
        $yestdayOrders = Db::name('ewm_order')
            ->where($where1)
            ->where(['status'=>1])
            ->whereTime('add_time', 'yesterday')
            ->field('id,gema_userid,order_price,code_type')
            ->select();
        //循环计算码商费用
        foreach($yestdayOrders as $k=>$v){
            $mspid = Db::name('ms')->where('userid',$v['gema_userid'])->value('pid');
            if ($mspid > 0){
                //查找顶级id
                $v['gema_userid'] = getNavPid($mspid);
            }
            //查找费率
            $orderMsRate = Db::name('ms_rate')->where(['code_type_id'=>$v['code_type'],'ms_id'=>$v['gema_userid']])->value('rate');
            if ($orderMsRate == 0){
                $yestdayOrders[$k]['msCost'] = 0;
            }
            $yestdayOrders[$k]['msCost'] = sprintf("%.2f",$v['order_price'] * ($orderMsRate / 100));
        }
        $yestdaymsCost = array_sum(array_column($yestdayOrders,'msCost'));
        $yestday_platform_in = $platform_in_user - $yestdaymsCost;
        $yestday_platform_in = sprintf("%.2f",$yestday_platform_in);

        $where2['status'] = 1;
        if (is_admin_login() != 1){
            $adminsonMs = Db::name('ms')->where('admin_id',is_admin_login())->column('userid');

            $where2['gema_userid'] = ['in',$adminsonMs];
        }
        $todaySuccessAmount = Db::name('ewm_order')
                                ->where($where2)
                                ->whereTime('add_time', 'today')->sum('order_price');


        $this->assign('todaySuccessAmount',sprintf("%.2f",$todaySuccessAmount));
        $this->assign('today_platform_in',$today_platform_in);
        $this->assign('yesterday_platform_in',$yestday_platform_in);

        return $this->fetch('',$this->logicOrders->getWelcomeStat());
    }

    /**
     * 订单月统计
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getOrderStat(){

        $where = [];
        if (is_admin_login() != 1){
            $adminSonUid = Db::name('user')->where('uid',is_admin_login())->column('uid');
            $where['uid'] = ['in',$adminSonUid];
        }

        $res = $this->logicOrders->getOrdersMonthStat($where);

        $data = [
            'orders' => get_order_month_stat($res,'total_orders'),
            'fees' => get_order_month_stat($res,'total_amount'),
        ];
        $this->result(CodeEnum::SUCCESS,'',$data);
    }

    /**
     * 本月最近订单
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getOrdersList(){
        $where = [];
        //当月时间
        list($start, $end) = Time::month();

        $where['create_time'] = ['between time', [$start,$end]];

        if (is_admin_login() != 1){
            $adminSonUid = Db::name('user')->where('uid',is_admin_login())->column('uid');
            $where['uid'] = ['in',$adminSonUid];
        }
        $data = $this->logicOrders->getOrderList($where,true, 'create_time desc',false);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg'=> '',
                'data'=>$data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg'=> '暂无数据',
                'data'=>$data
            ]
        );
    }
}
