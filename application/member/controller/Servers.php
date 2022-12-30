<?php
/**
 * @copyright © 2022 by 技术先锋 All rights reserved。
 * @Created   by PhpStorm.
 * @author    StarsPhp
 * @date      2022/12/7
 */
declare (strict_types=1);

namespace app\member\controller;

use app\common\library\enum\CodeEnum;
use app\common\logic\GoogleAuth;
use app\common\logic\MsMoneyType;
use app\common\model\Ms;
use app\ms\Logic\SecurityLogic;
use think\Db;

class Servers extends Base
{
    /**
     * var string $secret_key 加解密的密钥
     */
    protected $secret_key  = 'f3a59b69324c831e';
    
    /**
     * var string $iv 加解密的向量，有些方法需要设置比如CBC
     */
    protected $iv = '7fc7fe7d74f4da93';
    
    public function index()
    {

        return $this->fetch();
    }

    public function setInfo(){
        $info = Db::name('ms')->where('userid',$this->agent_id)->select();
        return $this->result(['code'=>0,'data'=>$info]);
    }



    public function edit_work_status(){
        $status = $this->request->param('status') == 1?0:1;
        $res = Ms::where(['userid' => $this->agent_id])->update(['work_status'=>$status]);
        if($res === false){
            return json([
                'code' => 404
            ]);
        }else{
            return json([
                'code' => 1
            ]);
        }

    }





    public function editPass()
    {
        if ($this->request->isPost()) {
            $oldPassword = $this->request->post('old_password');
            $newPassword = $this->request->post('new_password');
            $newRePassword = $this->request->post('re_new_password');
            return $this->updateLoginPassword($this->agent->userid, $oldPassword, $newPassword, $newRePassword);
        }
        $this->assign('info', $this->agent);
        return $this->fetch('editPass');
    }
    
    public function updateLoginPassword($userId, $oldPassword, $newPassword, $newRePassword)
    {
        if (empty($oldPassword)) {
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '请输入登录密码'];
        }
        
        if (strlen($newPassword) < 6 || strlen($newPassword) > 16) {
            return ['code' => CodeEnum::ERROR, 'msg' => '密码必须大于6位,小于16位！'];
        }

        if ($newPassword != $newRePassword) {
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '两次输入登录密码不一致'];
        }
        
        $User = $this->modelMs;
        // $User->startTrans();
        //验证旧密码
        if (!$this->check_pwd_one($oldPassword, $userId)) {
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '旧登录密码错误'];
        }

        //=============登录密码加密==============
        if ($newPassword) {
            $salt = substr(md5(time().''), 0, 3);
            $data['login_salt'] = $salt;
            $data['login_pwd'] = pwdMd52($newPassword, $salt);
        }

        
        $where['userid'] = $userId;
        $res = $User->where($where)->update($data);
        if ($res) {
            //     $User->commit();
//            Cache::set('user_LoginPassword_'.$userId,'0');
            return ['code' => \app\common\library\enum\CodeEnum::SUCCESS, 'msg' => '修改成功'];
        } else {
            //   $User->rollback();
            return ['code' => \app\common\library\enum\CodeEnum::ERROR, 'msg' => '修改失败'];
        }
    }
    
    //验证登录密码是否正确
    public function check_pwd_one($value, $userId)
    {
        $where['userid'] = $userId;
        
        $modelMs = new \app\common\model\Ms();
        $u_info = $modelMs->where($where)->field('login_pwd,login_salt')->find();
        $salt = $u_info['login_salt'];
        $pwd = $u_info['login_pwd'];
        if ($pwd == pwdMd52($value, $salt)) {
            return true;
        } else {
            return false;
        }
    }
    
    
    public function bindGoogle()
    {
        $google = new GoogleAuth();
        if($this->request->isPost()){
            $data =  $this->request->post();
            if(empty($data['google_secretkey']))
            {
                return ['code' => CodeEnum::ERROR, 'msg' => '参数错误！'];
            }
            if(empty($data['google_code']))
            {
                return ['code' => CodeEnum::ERROR, 'msg' => '请输入GOOGLE验证码！'];
            }
            $ret =  $google->checkGoogleCode($this->decrypt($data['google_secretkey']), $data['google_code']);
            if($ret === false)
            {
                return ['code' => CodeEnum::ERROR, 'msg' => '绑定GOOGLE失败,请扫码重试！'];
            }
            unset($data['google_code']);
            $data['google_status'] = 1;
//            $ret = $this->modelAdmin->where(['id'=>$adminId])->update($data);
            $res = Db::name('ms')->where(['userid'=>$this->agent_id])->update($data);
            if($res === false)
            {
                return ['code' => CodeEnum::ERROR, 'msg' => '绑定失败！'];
            }
            return ['code' => CodeEnum::SUCCESS, 'msg' => '绑定成功'];

        }
        //获取商户详细信息
    
        $this->assign('admin',$this->agent);
        if($this->agent['google_status'] == 0)
        {
            $google['google_secret'] = $this->encrypt($google->createSecretkey());
            $google['google_qr'] = $google->getQRCodeGoogleUrl($this->decrypt($google['google_secret']));
            $this->assign('google',$google);
        }
        return $this->fetch('bindGoogle');
    }
    
    
    private function encrypt($data)
    {
        return base64_encode(openssl_encrypt($data,"AES-128-CBC",$this->secret_key,1,$this->iv));
        
    }
    
    private function decrypt($data)
    {
        return openssl_decrypt(base64_decode($data), "AES-128-CBC", $this->secret_key, 1, $this->iv);
    }
    
    public function editPayPass()
    {
        if ($this->request->isPost()) {
            $SecurityLogic = new SecurityLogic();
            $security = $this->request->post('security');
            $re_security = $this->request->post('re_security');
            $old_security = $this->request->post('old_security');
        
            return $SecurityLogic->changeSecurity($this->agent->userid, $security, $re_security, $old_security);
        }
        $this->assign('data', $this->agent);
        return $this->fetch('editPayPass');
    }

    

    //划分余额
    public function dividedBalance(){
        if ($this->request->isPost()){
            $result = $this->validate(
                [
                    '__token__' => $this->request->post('__token__'),
                    'dividedBalance' => $this->request->post('dividedBalance'),
                ],
                [
                    '__token__' => 'require|token',
                    'dividedBalance' => 'require'
                ],[
                'dividedBalance.require' => '金额不能为空！',
            ]);
            if (true !== $result) {
                $this->error($result);
            }
            $money = $this->request->param('dividedBalance');
            if (!empty($money)){
                //查询自己余额
                Db::startTrans();
                try {
                    $my = Db::name('ms')->where('userid',$this->agent_id)->find();
                    if ($my['money'] < $money){
                        $this->error('余额不足');
                    }
                    if ($my['pid'] <= 0){
                        $this->error('未知错误');
                    }
                    $superior = Db::name('ms')->where('userid',$my['pid'])->find();
                    if (empty($superior)){
                        $this->error('上级信息有误');
                    }
                    $info = '码商（ID：'.$this->agent_id.'）手动给上级（'.$superior['userid'].'），增加余额'.$money;
                    $ret = accountLog($superior['userid'], MsMoneyType::TRANSFER, 1, $money, $info);

                    $infos = '码商（ID：'.$this->agent_id.'）手动给上级（'.$superior['userid'].'），扣减自身余额'.$money;
                    $rets = accountLog($this->agent_id, MsMoneyType::TRANSFER, 0, $money, $infos);
                    if ($ret && $rets) {
                        Db::commit();
                    }
                } catch (\Exception $e){
                    Db::rollback(); // 回滚事务
                    $this->error($e->getMessage(),'index/index');
                }
                $this->success('余额划分成功',url('index/index'));
            }
        }
        return $this->fetch();
    }
}
