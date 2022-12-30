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

use app\common\library\enum\CodeEnum;
use think\Db;

class Api extends BaseAdmin
{
	/**
	 * 账户API
	 *
	 * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
	 *
	 * @return mixed
	 */
	public function index()
	{
		return $this->fetch();
	}

	/**
	 * API列表
	 *
	 * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
	 *
	 */
	public function getList()
	{
		$where = [];
		//组合搜索
		!empty($this->request->param('uid')) && $where['uid']
			= ['eq', $this->request->param('uid')];

        if (is_admin_login() != 1){
            $adminSonUser = Db::name('user')->where(['admin_id'=>is_admin_login()])->column('uid');
            $where['uid'] = ['in',$adminSonUser];
        }

		$data = $this->logicApi->getApiList($where, '*', 'create_time desc', false);

		$count = $this->logicApi->getApiCount($where);

		$this->result($data || !empty($data) ?
			[
				'code' => CodeEnum::SUCCESS,
				'msg' => '',
				'count' => $count,
				'data' => $data
			] : [
				'code' => CodeEnum::ERROR,
				'msg' => '暂无数据',
				'count' => $count,
				'data' => $data
			]
		);
	}

	/**
	 * 编辑商户API信息
	 *
	 * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
	 *
	 * @return mixed
	 */
	public function edit()
	{
		// post 是提交数据
        if (is_admin_login() !=1){
            $uid = Db::name('api')->where('id',$this->request->param('id'))->value('uid');
            $u_aid = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($u_aid != is_admin_login()){
                return [ 'code' => CodeEnum::ERROR, 'msg' => "非法操作"];
            }
        }
		$this->request->isPost() && $this->result($this->logicApi->editApi($this->request->post()));
		//获取商户API信息
		$this->assign('api', $this->logicApi->getApiInfo(['id' => $this->request->param('id')]));

		return $this->fetch();
	}

    /**
     * 重置密钥
     */
	public function resetKey(){
        if (is_admin_login() !=1){
            $uid = Db::name('api')->where('id',$this->request->param('id'))->value('uid');
            $u_aid = Db::name('user')->where('uid',$uid)->value('admin_id');
            if ($u_aid != is_admin_login()){
                return [ 'code' => CodeEnum::ERROR, 'msg' => "非法操作"];
            }
        }
        $this->request->isPost() && $this->result($this->logicApi->resetKey($this->request->post('id')));
    }


	/**
	 * 检查操作指令 针对后台安全性的校验
	 */
	public function checkOpCommand()
	{
		$postCommand = $this->request->param('command/s');
		$command = config('custom.op_command');
		$code = ($postCommand == $command) ? CodeEnum::SUCCESS : CodeEnum::ERROR;
		$msg = ($postCommand == $command) ? "success" : "口令错误";
		$this->result($code, $msg);
	}

}