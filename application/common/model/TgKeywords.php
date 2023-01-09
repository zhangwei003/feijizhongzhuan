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

namespace app\common\model;


class TgKeywords extends BaseModel
{

    //设置删除关键字
    public function setDelKeywords($group_id, $keyword)
    {
        $ret = false;
        if (!empty($keyword)){
            try {
                $keywordRet = $this->modelTgKeywords->where(array('group_id' => $group_id, 'keyword' => $keyword))->find();
                if (!$keywordRet){
                    $this->save(array(
                        'group_id' => $group_id,
                        'keyword' => $keyword,
                        'status' => 1,
                        'expiration_time' => 0
                    ));

                }
            }catch (\Exception $e){
                \think\Log::error('设置关键字删除error:' . $e->getMessage());
            }
        }

        return $ret;
    }


    //触发关键字删除
    function keywordFilter($keyword, $group_id)
    {
        $del = false;
        $map = array(
            'group_id' => $group_id,
            'status' => 1,
            'expiration_time' => 0
        );
        $orMap = array(
            'expiration_time' => ['gt', time()]
        );
        $keywordsRet = $this->where($map)->whereOr($orMap)->select();

        if ($keywordsRet){
           foreach ($keywordsRet as $v){
               if ( count(explode($v['keyword'], str_replace(' ', '', $keyword))) > 1 ){
                    $del = true;
               }
           }

        }

        return $del;
    }

    //禁言几天
    public function setDelKeywordsNum($group_id, $num, $keyword)
    {
        $ret = false;
        if (!empty($num)){
            try {
                $keywordRet = $this->modelTgKeywords->where(array('group_id' => $group_id, 'keyword' => $keyword))->find();
                if (!$keywordRet){
                    $keywordRet->expiration_time = time()+$num*86400;
                    $keywordRet->save();
                    $ret = true;
                 }
            }catch (\Exception $e){
                \think\Log::error('设置关键字删除error:' . $e->getMessage());
            }
        }

        return $ret;
    }
}