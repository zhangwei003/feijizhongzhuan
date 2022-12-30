<?php

namespace app\api\controller;
use app\api\service\ApiPayment;
use app\common\controller\BaseApi;
use app\common\library\enum\CodeEnum;
use app\common\logic\EwmOrder;
use app\ms\Logic\SecurityLogic;
use think\Log;
use think\Db;
class Bank extends BaseApi
{

  public function banksms(){

      $key= $this->request->param('key');

      if (empty($key)){
           $this->error('未知错误');
      }
      Log::error('post_key:'.urldecode($key));
      $replace = '+';
      $search = 'asdefg';
      $key = str_ireplace($search, $replace, $key);
      $ms = explode("_",encrypt($key,'D'));
      if (empty($ms)){
          $this->error('error');
      }

      $ms_id = $ms[0];

      if (empty($ms_id)){
          $this->error('未知错误');
      }

      Log::error('解密的码商id:'.$ms_id);


      $data =  $this->request->post();

      if(empty($data)){
          $this->error('没数据');
      }

      if (empty($data['source'])){
          $this->error('数据错误');
      }

      if (empty($data['context'])){
          $this->error('ERROR');
      }
      Log::error('apk发送的post数据:'.json_encode($data,320));

      $ms = Db::name('ms')->where(['userid'=>$ms_id,'reg_date'=>$ms[1]])->find();

      if (empty($ms)){
          Log::error('解密的码商id失败'.$key);
          $this->error('请核对请求链接内容'.$key);
      }

      if ($ms['status'] == 0){
          $this->error('账号被禁用');
      }

      if ($ms['work_status'] == 0){
          $this->error('账号未开工');
      }

      // preg_match('/\d+/',$data['source'],$phoneCode);


       $pay_name_type = Db::name('config')->where(['name'=>'get_pay_name_type','admin_id'=>$ms['admin_id']])->value('value');
      $info =  $this->getInfo( $data['context'],$data['source']);
      $balance = $this->getBalance( $data['context'],$data['source']);
      Log::error('匹配信息:'.json_encode($info,true));
      if(empty($info) || empty($info['sms_money'])|| empty($info['banker_num']))
      {
        $this->error('未匹配到任何信息banknunm='.$info['banker_num'].'&money='.$info['sms_money'].'&balance='.$balance);
      }
      $banker_num  = $info['banker_num'];
      $banker_name  = $info['banker_name'];
      $smsMoney  = $info['sms_money'];
      $smsTime  = $info['sms_time'];
      $where = [];
      if (array_key_exists('pay_name',$info)){
          if (!empty($info['pay_name'])){
              if ($pay_name_type == 2){
                  $where['pay_user_name'] = $info['pay_name'];
              }else{
                  $where['pay_username'] = $info['pay_name'];
              }
          }
      }
      $no_number_flag =  $info['no_number'];
      if (1){
          $codes = Db::name('ewm_pay_code')
                  ->where([
                      'ms_id'=>$ms['userid'],
                      'code_type'=>30,
                      'bank_name' => $banker_name,
                     'is_delete' => 0
                  ])
		  ->select();
	  $bool = [];
	  $bank_len =strlen($banker_num);
	  foreach($codes as $code)
	  {
	      if( substr($code['account_number'],0-$bank_len) == $banker_num)
	      {
                 
	          $bool = $code;
	      }
	      if($no_number_flag)
	      {
	        $bool =  $code;
	      }
	  }
          if (empty($bool)){
              $this->error('未找到匹配的银行卡 bank_num='.$banker_num.'and bank_name='.$banker_name.'&money='.$smsMoney.'&balance='.$balance);
          }
         //出
	  Db::name('ewm_pay_code')->where(['id'=>$bool['id']])->update(['balance'=>$balance]);
          

          //查订单 10分钟内的;

          $start = date('Y-m-d H:i:s',time()-360);
          $end = date('Y-m-d H:i:s',time());

          $find_order = Db::name('ewm_order')
              ->where($where)
              ->where([
                  'code_id'=>$bool['id'],
                  'code_type'=>30,
                  'order_pay_price'=>trim($smsMoney),
                  'status'=>0,
                  'gema_userid'=>$ms['userid']
              ])
              ->whereTime('add_time','between',[$start,$end])
              ->order('id desc')
              ->select();
          if (empty($find_order)){
              $this->error('无匹配订单'.'code id='.$bool['id'].'&bank num='.$banker_num.'&bankname='.$banker_name.'&money='.$smsMoney);
          }
          if (count($find_order) > 1){
              $this->error('订单超出，请手动操作');
          }
          //判断用户余额是否足够
          $UserModel = new \app\common\model\Ms();
          $userMoney = $UserModel->where(['userid' => $ms['userid']])->value('money');
          if ($userMoney < $find_order[0]['order_price']) {
                 return ['code' => CodeEnum::ERROR, 'msg' => '用户余额不足'];
	  }


	 if(empty($find_order[0]['pay_username']))
         {
          $this->error('订单匹配错误，未写名字'.'code id='.$bool['id'].'&bank num='.$banker_num.'&bankname='.$banker_name.'&money='.$smsMoney);
   	   }

          //记录回调
          Log::notice('短信自动监控于：'.date('Y-m-d:H:i:s',time()).'回调订单：'.$find_order[0]['order_no']);

          $insetData = [
              'phone' => $data['source'],
              'context' => $data['context'],
              'ms_id' => $ms['userid'],
              'create_time' => date('Y-m-d H:i:s',time()),
              'ip'=> $this->request->ip(),
              'order_id' => $find_order[0]['id']
          ];

          $res = Db::name('banktobank_sms')->insert($insetData);
          if (!$res){
              $this->error('日志记录失败');
          }
          $ewm = new EwmOrder();
          return $ewm->setOrderSucess($find_order[0], "短信自动回调",$ms['userid'],'短信');
      }
        return ['code' => CodeEnum::ERROR, 'msg' => '非法请求'];
  }

  protected  function getBalance($content, $source){

	  $smsTemplate = require('./data/conf/smsTemplate.php');
         foreach ($smsTemplate as $k=>$v){
		 if ($source===$v['phone']) 
		 {
			if( isset($v['preg_balance'])){
			 foreach ($v['preg_balance'] as $key=>$val){
				 $balance = $this->mysubstr($content, $val['balance_start'], $val['balance_end']);
				//;die(); 
                       if(!is_numeric(trim($balance)))
                       {
                          continue ;
		       }
                       return trim($balance);
                    }
                   }
                 
		 }
	 }
  }

     protected  function getInfo($content, $source){

         $smsTemplate = require_once('./data/conf/smsTemplate.php');

         foreach ($smsTemplate as $k=>$v){
		 if ($source===$v['phone']) {
                    foreach ($v['preg'] as $key=>$val){
                       $info['banker_num'] = isset($val['no_number'])?'0000000':$this->mysubstr($content, $val['number_start'], $val['number_end']);
                       $info['banker_name'] = $v['source'];
                       $info['sms_money'] = str_replace(",","",$this->mysubstr($content, $val['money_start'], $val['money_end']));
		       $info['sms_time'] = $this->mysubstr($content, $val['time_start'], $val['time_end']);

               if (array_key_exists('pay_name_start',$val) && array_key_exists('pay_name_end',$val) ){

                   $info['pay_name'] = $this->mysubstr($content, $val['pay_name_start'], $val['pay_name_end']);
               }
            if(!empty($info['sms_money']) && !empty($info['sms_money'])){
                if (array_key_exists('pay_name_jhdz',$val)){
                    preg_match('/[0-9]/', $content, $matches, PREG_OFFSET_CAPTURE);
                    $name_end = strpos($content,$matches[0][0]);
                    $info['pay_name'] = substr($content,0,$name_end);
                }
            }

		       $info['no_number'] = isset($val['no_number'])? 1:0;
                       if(empty($info['banker_num']) || !is_numeric(trim($info['banker_num'])) || !is_numeric(trim($info['sms_money'])) )
		       {
		          continue ;
		       }
		       return $info;
		    }
             }
	 }
         return false;
  }
    protected function mysubstr($str, $start, $end)
    {
      if(empty($start))
      {
         
	    return false;
      
      }
    
      $arr = explode($start,$str);
    if (empty($arr) || !isset($arr[1])) {
        return false;
    }
    $str = $arr[1];
    if (strpos($str,$end) !== false) {
        return substr($str,0,strpos($str,$end));
    }else{
        return $str;
    } 
    
       return $a;
    }

    private function decrypt($data)
    {
        return openssl_decrypt(base64_decode($data), "AES-128-CBC", config('secret_key'), true, config('iv'));
    }


}
