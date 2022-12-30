<?php
/**
 * @Created   by PhpStorm.
 * @author    StarsPhp
 * @date      2022/12/12
 * @time      0:43
 */
declare (strict_types=1);

namespace app\member\controller;

use app\common\library\enum\CodeEnum;
use app\common\logic\Queuev1Logic;
use think\Db;
use think\Request;

class Channel extends Base
{
    protected $pay_code = null;
    public function __construct(Request $request = null)
    {
        $this->pay_code = $request->param('pay_code');
        $codes = $this->modelPayCode->where('status', 1)->column('code');
        if (!in_array( $this->pay_code,  $codes)){
            $this->error('错误的通道编码!');
        }
        parent::__construct($request);
    }


    public function index()
    {
        return $this->fetch();
    }

    public function channel()
    {
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
     * 卡转卡
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
     * 支付宝口令红包
     * @return mixed
     */
    public function alipayPassRed()
    {
        return $this->fetch('alipayPassRed');
    }

    /**
     * 支付宝UID
     * @return mixed
     */
    public function alipayUid()
    {
        return $this->fetch('alipayUid');
    }

    /**
     * 支付宝小额UID
     * @return mixed
     */
    public function alipayUidSmall()
    {
        return $this->fetch('alipayUidSmall');
    }

    /**
     * 支付宝UID转账
     * @return mixed
     */
    public function alipayUidTransfer()
    {
        return $this->fetch('alipayUidTransfer');
    }

    public function add(Request $request=null)
    {
        if ($this->request->isPost()){
            $params = $request->param();
            $validate = $this->validateEwmPayCode->scene($this->pay_code . '_add')->check($params);
            if (false === $validate){
                return $this->error( $this->validateEwmPayCode->getError());
            }
            $code = Db::name('pay_code')->where('code',$this->pay_code)->value('id');
            if (empty($code)){
                $this->error('不支持的通道');
            }
            $result = $this->logicCodeLogic->addQRcode($params,$code);
            if ($result['code'] == CodeEnum::ERROR) {
                $this->error("上传失败," . $result['msg']);
            }
            $this->success($result['msg']);
        }
        $smsTemplate = require_once('./data/conf/smsTemplate.php');
        $this->assign('banksList', $smsTemplate);
        $this->assign('code',  $this->pay_code);
        return $this->fetch('add_'. $this->pay_code);
    }

    /**
     *
     * 通道列表
     * @throws \think\exception\DbException
     */
    public function lists(Request $request)
    {
        if ($this->request->isAjax()){
            $id = $request->param('id', '', 'intval');
            $bank_name = $request->param('bank_name', '', 'trim');
            $account_name = $request->param('account_name', '', 'trim');
            $account_number = $request->param('account_number', '', 'trim');
            $status = $request->param('status', -1, 'intval');
            !empty($id) && $where['a.id'] = $id;
            !empty($bank_name) && $where['a.bank_name'] = $bank_name ;
            !empty($account_name) && $where['a.account_name'] = $account_name ;
            !empty($account_number) && $where['a.account_number'] = $account_number ;
            $status != -1 && $where['a.status'] = $status;

            $where['a.ms_id'] = $this->agent_id;
            $where['a.is_delete'] = 0;
            $where['pc.code'] = $this->pay_code;

            $data = $this->modelEwmPayCode
                ->alias('a')
                ->join('pay_code pc', 'pc.id = a.code_type' ,'left')
                ->where($where)->order('a.id', 'desc')
                ->field('a.*, pc.code')
                ->paginate($this->request->param('limit', 10));
            $result = $data->items();
            foreach ($result as $k=>$v){
                $result[$k]['receiving_number'] = Db::name('ewm_order')->where(['code_id'=>$v['id'],'status'=>1])->count();
                $result[$k]['receiving_amount'] = sprintf("%.2f",Db::name('ewm_order')->where(['code_id'=>$v['id'],'status'=>1])->sum('order_price'));
            }
            $this->result($data || !empty($data) ?
                [
                    'code' => CodeEnum::SUCCESS,
                    'msg' => '',
                    'count' => $data->total(),
                    'data' =>$result
                ] : [
                    'code' => CodeEnum::ERROR,
                    'msg' => '暂无数据',
                    'count' => $data->count(),
                    'data' => []
                ]
            );
        }
    }


    /**
     * 删除二维码
     * @param Request $request
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function del(Request $request)
    {
        $id =intval(trim($request->param('id')));
        $codeInfo =  Db::name('ewm_pay_code')->where(['id'=>$id])->find();
        if ($codeInfo['ms_id'] != $this->agent_id) {
            $this->error('删除失败,信息错误');
        }
        $re = Db::name('ewm_pay_code')->where(['id'=>$id])->update(['is_delete'=>1,'status'=>0]);
        if ($re) {
            $QueueLogic = new Queuev1Logic();
            $codeInfo['type'] = 3;
            $QueueLogic->delete($id, $codeInfo['type'], 1);
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    public function upload()
    {
        if($this->request->isPost()) {
            $this->result($this->logicFile->fileUpload('file', 'ewm'));
        }
    }



//    public function payCodeOrder(){
//        $pay_code_id = $this->request->param('code_id');
//        $this->assign('code_id',$pay_code_id);
//        return$this->fetch();
//    }
//
//    public function getPayCodeOrder(Request $request){
//        $where = [];
//        $where['code_id'] = $request->param('code_id');
//        $where['gema_userid'] = $this->agent_id;
//        $startTime = date('Y-m-d 00:00:00',time());
//        $endTime = date('Y-m-d 23:59:59',time());
//        $where['add_time'] = ['between', [$startTime, $endTime]];
//        if (!empty($request->param('startDate'))){
//            $startTime = $request->param('startDate');
//            $where['add_time'] = ['egt', strtotime($startTime)];
//        }
//
//        if (!empty($request->param('endDate'))){
//            $endTime = $request->param('endDate');
//            $where['add_time'] = ['elt',strtotime($endTime)];
//        }
//
//        if ($startTime && $endTime) {
//            $where['add_time'] = ['between', [strtotime($startTime), strtotime($endTime)]];
//        }
//
//        if (!empty($request->param('order_no'))){
//            unset($where['add_time']);
//            $where['order_no'] = $request->param('order_no');
//        }
//        if (!empty($request->param('pay_username'))){
//            $where['pay_username'] = $request->param('pay_username');
//        }
//
//        if (!empty($request->param('status'))){
//            $where['status'] = $request->param('status');
//        }
//
//        $limit = $request->param('limit');
//        $page = $request->param('page');
//        $start=$limit*($page-1);
//
//        $List = Db::name('ewm_order')->where($where)->limit($start,$limit)->select();
//
//        $count = Db::name('ewm_order')->where($where)->count();
//
//        if ($count <= 0){
//            return json([
//                'code'=>1,
//                'msg'=>'暂无数据'
//            ]);
//        }
//
//        return json([
//            'code'=>0,
//            'msg'=>'请求成功',
//            'data'=>$List,
//            'count'=>$count
//        ]);
//    }
}
