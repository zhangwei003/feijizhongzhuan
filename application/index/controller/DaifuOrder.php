<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/7
 * Time: 22:19
 */

namespace app\index\controller;


use think\Db;

class DaifuOrder extends Base
{


    /**
     * @return mixed
     *  代付订单列表
     */
    public function index()
    {
        $where = ['uid' => is_login()];
        //组合搜索


        !empty($this->request->get('channel')) && $where['channel']
            = ['eq', $this->request->get('channel')];

        //时间搜索  时间戳搜素
        $date = $this->request->param('d/a');

        $start = empty($date['start']) ? date('Y-m-d 00:00:00', time()) : $date['start'];
        $end = empty($date['end']) ? date('Y-m-d 23:59:59', time()) : $date['end'];
        $where['create_time'] = ['between', [strtotime($start), strtotime($end)]];
        //状态
        if (!empty($this->request->get('status')) || $this->request->get('status') === '0') {
            $where['status'] = $this->request->get('status');
        }

        if (!empty($this->request->get('trade_no'))){
            unset($where['create_time']);
            $where['out_trade_no'] = ['like', '%' . $this->request->get('trade_no') . '%'];
        }
//        print_r($where);


//        var_dump($where);die();
        $orderLists = $this->logicDaifuOrders->getOrderList($where, true, 'create_time desc', 10);
        //查询当前符合条件的订单的的总金额  编辑封闭 新增放开 原则
        $cals = $this->logicDaifuOrders->calOrdersData($where);

        $admin_id = Db::name('user')->where('uid',is_login())->value('admin_id');
        $daifu_success_uplode = Db::name('config')->where(['name'=>'daifu_success_uplode','admin_id'=>$admin_id])->value('value');
        if (!empty($daifu_success_uplode) && $daifu_success_uplode == 2){
            $this->assign('daifu_chars',$daifu_success_uplode);
        }else{
            $this->assign('daifu_chars',1);
        }
        $this->assign('list', $orderLists);
        $this->assign('cal', $cals);
        $this->assign('code', []);//$this->logicDaifuOrders->getCodeList([]));
        $this->assign('start', $start);
        $this->assign('end', $end);
        return $this->fetch();
    }


    /**
     * 申请代付
     */
    public function apply()
    {
        //用户信息
        $userInfo = $this->logicUser->getUserInfo(['uid' => session('user_info.uid')]);

        //google验证其二维码
        require_once EXTEND_PATH . 'PHPGangsta/GoogleAuthenticator.php';
        $ga = new \PHPGangsta_GoogleAuthenticator();
        $where = ['uid' => is_login()];
        if ($this->request->isPost()) {
            if ($userInfo['is_need_google_verify'] && $userInfo['google_secret_key']) {
                //google身份验证
                $code = input('b.google_code');
                $secret = session('google_secret');
                $checkResult = $ga->verifyCode($secret, $code, 1);
                if ($checkResult == false) {
                    $this->result(0, 'google身份验证失败 ！！！');
                }
            }
            //校验令牌
            $token = input('__token__');
//            if(session('__token__')!= $token){
//                $this->result(0,'请不要重复发起代付,请刷新页面重试 ！！！');
//            }
            session('__token__', null);
            $userDfIp = require('./data/conf/userDfip.php');
            //校验是否允许发起代付从前端
            if ($userInfo->is_can_df_from_index != 1 || !in_array(is_login(),$userDfIp['userid'])) {
                $this->result(0, '您不允许在前端发起代付申请 ！！！');
            }

            if ($this->request->post('b/a')['uid'] == is_login()) {
                $this->result($this->logicDaifuOrders->manualCreateOrder($this->request->post('b/a'), $userInfo));
            } else {
                $this->result(0, '非法操作，请重试！');
            }
        }
        //详情
        $this->common($where);
        //收款账户

        $this->assign('user', $userInfo);
        //银行
        $this->assign('banker', $this->logicBanker->getBankerList());

        if ($userInfo['is_need_google_verify'] && $userInfo['google_secret_key']){
            session('google_secret', $userInfo['google_secret_key']);
//            $this->assign('google_qr', $ga->getQRCodeGoogleUrl($userInfo['account'], $userInfo['google_secret_key']));
        }

        return $this->fetch();
    }



    /**
     * Common
     *
     * @param array $where
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function common($where = [])
    {
        //资产信息
        $this->assign('info', $this->logicBalance->getBalanceInfo($where));
        //银行
        $this->assign('banker', $this->logicBanker->getBankerList());

    }


    /**
     * 导出订单
     */
    public function exportOrder()
    {
        $where = ['uid' => is_login()];
        //组合搜索
        !empty($this->request->get('trade_no')) && $where['out_trade_no']
            = ['like', '%' . $this->request->get('trade_no') . '%'];

        !empty($this->request->get('channel')) && $where['channel']
            = ['eq', $this->request->get('channel')];

        //时间搜索  时间戳搜素
        $date = $this->request->param('d/a');

        $start = empty($date['start']) ? date('Y-m-d', time()) : $date['start'];
        $end = empty($date['end']) ? date('Y-m-d', time() + 3600 * 24) : $date['end'];
        $where['create_time'] = ['between', [strtotime($start), strtotime($end)]];
        //状态
        if (!empty($this->request->get('status')) || $this->request->get('status') === '0') {
            $where['status'] = $this->request->get('status');
        }
        //导出默认为选择项所有
        $orderList = $this->logicDaifuOrders->getOrderList($where, true, 'create_time desc', false);

        //组装header 响应html为execl 感觉比PHPExcel类更快
        $orderStatus = ['订单关闭', '等待支付', '支付完成', '异常订单'];
        $strTable = '<table width="500" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">ID标识</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="100">订单号</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">金额</td>';
//        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收入</td>';
//        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">支付渠道</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">创建时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">更新时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">状态</td>';
        $strTable .= '</tr>';
        if (is_array($orderList)) {
            foreach ($orderList as $k => $val) {
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;' . $val['id'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['out_trade_no'] . ' </td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['amount'] . '</td>';
//                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['user_in'].'</td>';
//                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['channel'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['create_time'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['update_time'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $orderStatus[$val['status']] . '</td>';
                $strTable .= '</tr>';
                unset($orderList[$k]);
            }
        }
        $strTable .= '</table>';
        downloadExcel($strTable, 'daifuorder');
    }
}
