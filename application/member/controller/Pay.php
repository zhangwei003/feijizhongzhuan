<?php
/**
 *
 * @Created   by PhpStorm.
 * @author    StarsPhp
 * @date      2022/12/8
 */
declare (strict_types=1);

namespace app\member\controller;

use app\common\library\enum\CodeEnum;
use app\common\model\EwmPayCode;
use think\Db;
use think\Request;

class Pay extends Base
{

    protected $pay_code = null;

    public function __construct(Request $request = null)
    {
        $this->pay_code = $request->param('pay_code');
        $codes = $this->modelPayCode->where('status', 1)->column('code');
        if (!in_array($this->pay_code, $codes)) {
            $this->error('错误的通道编码!');
        }
        parent::__construct($request);
    }

    public function index()
    {
        return $this->fetch();
    }

    public function pay()
    {
        $pay_code_id = Db::name('pay_code')->where('code', $this->pay_code)->value('id');
        $where['code_type'] = $pay_code_id;
        //今日收款笔数
        $today_sk = Db::name('ewm_order')->whereTime('add_time', 'today')->where($where)->where(['gema_userid'=>$this->agent_id,'status'=>1])->count();
        //今日收款总额
        $today_sk_ze = Db::name('ewm_order')->whereTime('add_time', 'today')->where($where)->where(['gema_userid'=>$this->agent_id,'status'=>1])->sum('order_pay_price');
        //今日提成
        $today_tc = Db::name('ewm_order')->whereTime('add_time', 'today')->where($where)->where(['gema_userid'=>$this->agent_id,'status'=>1])->sum('bonus_fee');
        //总押金
        $total_yj = $this->agent->cash_pledge;
        //可用接单押金
        $normal_yj = $this->agent->cash_pledge;
        //最低接单押金
        $lowest_yj = $this->agent->cash_pledge;
        //在线人数
        $online_num = Db::name('ewm_pay_code')->where($where)->where(['status' => 1, 'is_delete' => 0,'ms_id'=>$this->agent_id])->count();
        //work_status
        $work_status = $this->agent->work_status;
        $head_data_arr = compact('today_sk', 'today_sk_ze', 'today_tc', 'total_yj', 'normal_yj', 'lowest_yj', 'online_num', 'work_status');
        $this->assign('head_data', $head_data_arr);

        return $this->{$this->pay_code}();
    }

    public function aliRedEnvelope()
    {
        return $this->fetch('aliRedEnvelope');
    }

    public function weChatGroup()
    {
        return $this->fetch('weChatGroup');
    }

    public function aliUid()
    {
        return $this->fetch('aliUid');
    }

    public function aliXhb()
    {
        return $this->fetch('aliXhb');
    }

    public function aliXhbUid()
    {
        return $this->fetch('aliXhbUid');
    }

    /**
     *卡转卡
     * @return mixed
     */
    public function kzk()
    {
        return $this->fetch('kzk');
    }

    /**
     * 支付宝扫码
     * @return mixed
     */
    public function alipayCode()
    {
        return $this->fetch('alipayCode');
    }

    /**
     * 支付宝uid
     * @return mixed
     */
    public function alipayUid()
    {
        return $this->fetch('alipayUid');
    }

    /**
     * 支付宝小额UID
     */
    public function alipayUidSmall()
    {
        return $this->fetch('alipayUidSmall');
    }

    /**
     * 支付宝UID转账
     */
    public function alipayUidTransfer()
    {
        return $this->fetch('alipayUidTransfer');
    }

    public function lists()
    {
        $request = Request::instance();
        $status = $request->param('status', -1, 'intval');
        $paycode = $request->param('pay_code', -1, 'intval');
        $map = [];
        //订单编号
        $order_no = addslashes(trim($request->param('order_no', '')));
        $order_no && $map['order_no'] = ['like', '%' . $order_no . '%'];

        //code_id
        $code_id = addslashes(trim($request->param('code_id', '')));
        $code_id && $map['o.code_id'] = $code_id;

        //昵称
        $account_name = addslashes(trim($request->param('account_name', '')));
        $account_name && $map['o.account_name'] = ['like', '%' . $account_name . '%'];

        //账号
        $bank_name = addslashes(trim($request->param('bank_name', '')));
        $bank_name && $map['o.bank_name'] = ['like', '%' . $bank_name . '%'];

        //账号
        $account_number = addslashes(trim($request->param('account_number', '')));
        $bank_name && $map['o.bank_name'] = ['like', '%' . $bank_name . '%'];

        $map['p.code'] = $this->pay_code;

        $payname = Db::name('pay_code')->where('id', $paycode)->value('code');
        $this->assign('pay_code', $payname);

        //用户名
        $order_price = addslashes(trim($request->param('order_price', '')));
        !empty($order_price) && $map['o.order_price'] = $order_price;

        //订单金额
        $gema_username = addslashes(trim($request->param('gema_username', '')));
        !empty($gema_username) && $map['o.gema_username'] = ['like', '%' . $gema_username . '%'];

        $note = addslashes(trim($request->param('note', '')));
        !empty($note) && $map['o.note'] = ['like', '%' . $note . '%'];

        //收款人姓名
        $payUserName = addslashes(trim($request->param('pay_username', '')));
        $payUserName && $map['pay_username'] = addslashes(trim($payUserName));

        //正式姓名
        $pay_user_name = addslashes(trim($request->param('pay_user_name', '')));
        $pay_user_name && $map['pay_user_name'] = ['eq', $pay_user_name];

        $amount = addslashes(trim($request->param('amount', '')));
        $amount && $map['order_price'] = $amount;
        //新增其他条件
        ($status != -1) && $map['o.status'] = intval($status);

        $this->assign('status', $status);
        //时间
        $startTime = date('Y-m-d 00:00:00', time());
        $endTime = date('Y-m-d 23:59:59', time());
        if (!empty($request->param('start_time')) && !empty($request->param('end_time'))) {
            $startTime = $request->param('start_time');
            $endTime = $request->param('end_time');
        }
        $map['add_time'] = ['between time',[$startTime,$endTime]];;
        if (!empty($request->param('code_type')) && $request->param('code_type') != 1) {
            $map['p.code'] = $request->param('code_type');
            $this->assign('code_type', $request->param('code_type'));
        }
        $fileds = ["o.*", "u.mobile", "u.account", "p.name"];
        $map['gema_userid'] = $this->agent_id;

        if ($this->request->isAjax()) {
            $list = Db::name('ewm_order')->alias('o')->field($fileds)
                ->join("ms u", "o.gema_userid=u.userid", "left")
                ->join("pay_code p", "o.code_type=p.id", "left")
                ->where($map)
                ->order('id desc')
                ->paginate($this->request->param('limit', 10));

            $data = $list->items();
            foreach ($data as $key => &$vals) {
                $vals['s_type_name'] = '无';
                $vals['s_type_name'] = '无';
                $code = EwmPayCode::where(['id' => $vals['code_id']])->find();
                $vals['account_number'] = $code['account_number'];
                $vals['bank_name'] = $code['bank_name'];
                $vals['account_name'] = $code['account_name'];
                $vals['qr_image'] = $code['image_url'];
                $vals['strArea'] = '无';
                $vals['group_name'] = '无';
                //用户真实姓名
                $vals['real_name'] = ctype_alnum($vals['pay_user_name']) ? $vals['pay_username'] : $vals['pay_user_name'];
                $vals['pay_time'] = $vals['pay_time'] ? date('Y-m-d H:i:s', $vals['pay_time']) : '---';
                $vals['add_time'] = $vals['add_time'] ? date('Y-m-d H:i:s', $vals['add_time']) : '---';
            }

            $this->result($list || !empty($list) ?
                [
                    'code' => CodeEnum::SUCCESS,
                    'msg' => '',
                    'count' => $list->total(),
                    'data' => $data
                ] : [
                    'code' => CodeEnum::ERROR,
                    'msg' => '暂无数据',
                    'count' => $list->count(),
                    'data' => []
                ]
            );
        }

    }

    /**
     * 确认收款
     */
    public function issueOrder()
    {
        $orderId = intval($this->request->post('id'));
        $security = $this->request->post('pass');

        $GemaOrder = new \app\common\logic\EwmOrder();
        $res = $GemaOrder->setOrderSucessByUser($orderId, $this->agent->userid, $security, 0, 0);

        if ($res['code'] == CodeEnum::ERROR) {
            $this->error($res['msg']);
        }
        $orderNo = Db::name('ewm_order')->where('id', $orderId)->value('order_no');
        action_log('补单', '码商' . $this->agent->userid . '强制成功订单：' . $orderNo);
        $this->success('操作成功');
    }

    /**
     * 导出订单
     */
    public function exportOrder()
    {
        $request = Request::instance();
        $status = $request->param('status', -1, 'intval');
        $paycode = $request->param('pay_code', -1, 'intval');
        $map = [];
        //订单编号
        $order_no = addslashes(trim($request->param('order_no', '')));
        $order_no && $map['order_no'] = ['like', '%' . $order_no . '%'];

        //code_id
        $code_id = addslashes(trim($request->param('code_id', '')));
        $code_id && $map['o.code_id'] = $code_id;

        //昵称
        $account_name = addslashes(trim($request->param('account_name', '')));
        $account_name && $map['o.account_name'] = ['like', '%' . $account_name . '%'];

        //账号
        $bank_name = addslashes(trim($request->param('bank_name', '')));
        $bank_name && $map['o.bank_name'] = ['like', '%' . $bank_name . '%'];

        //账号
        $account_number = addslashes(trim($request->param('account_number', '')));
        $bank_name && $map['o.bank_name'] = ['like', '%' . $bank_name . '%'];

        $map['p.code'] = $this->pay_code;

        $payname = Db::name('pay_code')->where('id', $paycode)->value('code');
        $this->assign('pay_code', $payname);

        //用户名
        $order_price = addslashes(trim($request->param('order_price', '')));
        !empty($order_price) && $map['o.order_price'] = $order_price;

        //订单金额
        $gema_username = addslashes(trim($request->param('gema_username', '')));
        !empty($gema_username) && $map['o.gema_username'] = ['like', '%' . $gema_username . '%'];

        $note = addslashes(trim($request->param('note', '')));
        !empty($note) && $map['o.note'] = ['like', '%' . $note . '%'];

        //收款人姓名
        $payUserName = addslashes(trim($request->param('pay_username', '')));
        $payUserName && $map['pay_username'] = addslashes(trim($payUserName));

        //正式姓名
        $pay_user_name = addslashes(trim($request->param('pay_user_name', '')));
        $pay_user_name && $map['pay_user_name'] = ['eq', $pay_user_name];

        $amount = addslashes(trim($request->param('amount', '')));
        $amount && $map['order_price'] = $amount;
        //新增其他条件
        ($status != -1) && $map['o.status'] = intval($status);

        $this->assign('status', $status);
        //时间
        $startTime = date('Y-m-d 00:00:00', time());
        $endTime = date('Y-m-d 23:59:59', time());
        if (!empty($request->param('start_time')) && !empty($request->param('end_time'))) {
            $startTime = $request->param('start_time');
            $endTime = $request->param('end_time');
        }
        $map['add_time'] = ['between time',[$startTime,$endTime]];;
        if (!empty($request->param('code_type')) && $request->param('code_type') != 1) {
            $map['p.code'] = $request->param('code_type');
            $this->assign('code_type', $request->param('code_type'));
        }
        $fileds = ["o.*", "u.mobile", "u.account", "p.name"];
        $map['gema_userid'] = $this->agent_id;
        $data = Db::name('ewm_order')->alias('o')->field($fileds)
                ->join("ms u", "o.gema_userid=u.userid", "left")
                ->join("pay_code p", "o.code_type=p.id", "left")
                ->where($map)
                ->order('id desc')
                ->select();
        foreach ($data as $key => &$vals) {
            $vals['s_type_name'] = '无';
            $vals['s_type_name'] = '无';
            $code = EwmPayCode::where(['id' => $vals['code_id']])->find();
            $vals['account_number'] = $code['account_number'];
            $vals['bank_name'] = $code['bank_name'];
            $vals['account_name'] = $code['account_name'];
            $vals['qr_image'] = $code['image_url'];
            $vals['strArea'] = '无';
            $vals['group_name'] = '无';
            //用户真实姓名
            $vals['real_name'] = ctype_alnum($vals['pay_user_name']) ? $vals['pay_username'] : $vals['pay_user_name'];
            $vals['pay_time'] = $vals['pay_time'] ? date('Y-m-d H:i:s', $vals['pay_time']) : '---';
            $vals['add_time'] = $vals['add_time'] ? date('Y-m-d H:i:s', $vals['add_time']) : '---';
        }

        //组装header 响应html为execl 感觉比PHPExcel类更快
        $orderStatus = ['待支付', '已支付', '已关闭', '已退款'];
        $strTable = '<table width="500" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:120px;">订单号</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">订单金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="100">收款人</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收款账号</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">收款方</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">下单时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">支付时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">实际支付金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">备注</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">订单状态</td>';
        $strTable .= '</tr>';
        if (is_array($data)) {
            foreach ($data as $k => $val) {
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['order_no'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['order_price'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['account_name'] . ' </td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['account_number'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['bank_name']. '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'. $val['add_time'] .'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['pay_time'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['order_pay_price'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $val['note'] . '</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">' . $orderStatus[$val['status']] . '</td>';
                $strTable .= '</tr>';
                unset($data[$k]);
            }
        }
        $strTable .= '</table>';
        downloadExcel($strTable, 'orders_' . $this->pay_code);
    }
}
