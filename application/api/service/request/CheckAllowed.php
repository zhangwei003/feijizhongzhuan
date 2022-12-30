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


namespace app\api\service\request;
use app\common\library\exception\ForbiddenException;
use think\Log;
use think\Request;

/**
 * 检验接口允许IP
 *
 * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
 *
 */
class CheckAllowed extends ApiCheck
{

    /**
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param Request $request
     * @return mixed|void
     * @throws ForbiddenException
     */
    public function doCheck(Request $request)
    {
	return true;
        // 获取Ip Map
        $checkAllowedIpMap = $this->logicApi->getallowedRequstIpMap();
        //客户端IP
        $ip = $request->ip();
        //ip参数拆分成数组
        $check_ip_arr= explode('.',$ip);
        if(!in_array($ip, $checkAllowedIpMap)) {
            $allowed = false;
            foreach ($checkAllowedIpMap as $val){
                if(strpos($val,'*')!==false){
                    //发现有*号替代符
                    $arr = array();
                    $arr = explode('.', $val);
                    $allowed = true;
                    //用于记录循环检测中是否有匹配成功的
                    for ( $i=0; $i<4; $i++ ){
                        if( $arr[$i] != '*' ){
                            //不等于* 就要进来检测，如果为*符号替代符就不检查
                            if( $arr[$i] != $check_ip_arr[$i] ){
                                $allowed = false;
                                break;
                                //终止检查本个ip 继续检查下一个ip
                            }
                        }
                    }
                    //end for
                    if( $allowed) {
                        //如果是true则终止匹配
                        break;
                    }
                }
            }
            //存在性
            if ( !$allowed ) {
                throw new ForbiddenException([
                    'msg'=>'无效的请求[请求IP不被授权]',
                    'errorCode'=> 400003
                ]);
            }
        }

    }
}
