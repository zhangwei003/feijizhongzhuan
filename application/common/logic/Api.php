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

namespace app\common\logic;

use app\common\library\enum\CodeEnum;
use think\Db;
use think\Log;

class Api extends BaseLogic
{

    /**
     * 获取所有支持的商户请求识标
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @return mixed
     */
    public function getAppKeyMap(){
        return $this->modelApi->getColumn([], 'id,key', $key = 'id');
    }

    /**
     * 获取所有支持的商户登录
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @return mixed
     */
    public function getallowedIpMap(){
        $allowedIpMap =  $this->modelApi->getColumn([], 'id,auth_ips');
        $checkAllowedIpMap = [];
        foreach ($allowedIpMap as $v) {
            $allowedIp = explode(',',$v);
            for ($i=0;$i< count($allowedIp);$i++){
                $checkAllowedIpMap[] = $allowedIp[$i];
            }
        }
        return $checkAllowedIpMap;
    }

    /**
     * 重置密钥
     */
    public function resetKey($id){

        if(!$id){
            return ['code'=>CodeEnum::ERROR,'msg'=>'非法操作'];
        }
        $result =$this->modelApi->where(['id'=>$id])->update(['key'=>md5(request()->time()."password")]);
        if(!$result){
            return ['code'=>CodeEnum::ERROR,'msg'=>'操作失败'];
        }
        return ['code'=>CodeEnum::SUCCESS,'msg'=>'操作成功'];
    }


    public function getallowedRequstIpMap(){
        $allowedIpMap =   config('custom.request_white_ip_list');
        return $allowedIpMap;
    }

    /**
     * 获取商户API列表
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param array $where
     * @param array|bool $field
     * @param string $order
     * @param int|bool $paginate
     * @return mixed
     */
    public function getApiList($where, $field = true, $order = 'create_time', $paginate = 15){
        return $this->modelApi->getList($where, $field, $order, $paginate);
    }

    /**
     * 获取商户API总数
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param $where
     * @return mixed
     */
    public function getApiCount($where = []){
        $Api = new \app\common\model\Api();
        return $Api->getCount($where);
    }

    /**
     *
     * 获取商户支持API
     *
     * @author 勇敢的小笨羊
     * @param array $where
     * @param bool $field
     * @return mixed
     */
    public function getApiInfo($where = [], $field = true){
        $Api = new \app\common\model\Api();
        return $Api->getInfo($where, $field);
    }

    /**
     * 编辑商户
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param $data
     * @return array
     */
    public function editApi($data){

        //TODO  验证数据
        $validate = $this->validateApiValidate->scene('edit')->check($data);
        if(!empty($data["auth_ips"]))
        {
           $ips = explode(",", $data["auth_ips"]);
           foreach ($ips as $ip)
           {
               if(!empty($ip))
               {
                   $pattern = '/^(?:(?:25[0-9]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(?:25[0-9]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$/';
                   if (!preg_match($pattern, $ip))
                   {
                       return [ 'code' => CodeEnum::ERROR, 'msg' => "IP 格式错误"];
                   }
               }
           }
        }
        if (!$validate) {

            return [ 'code' => CodeEnum::ERROR, 'msg' => $this->validateApiValidate->getError()];
        }

        //TODO 修改数据
        Db::startTrans();
        try{
            //加密KEY
            // $data['key']    = data_md5_key($data['secretkey']);
            //提交保存
            $this->modelApi->setInfo($data);

            Db::commit();

            action_log('修改', '修改接口信息，接口公钥修改');

            return [ 'code' => CodeEnum::SUCCESS, 'msg' => '编辑成功'];
        }catch (\Exception $ex){
            Db::rollback();
            Log::error($ex->getMessage());
            return [ 'code' => CodeEnum::ERROR , config('app_debug') ? $ex->getMessage() : '未知错误'];
        }
    }
}