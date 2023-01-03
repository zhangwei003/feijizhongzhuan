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


class TgStatisticsGroup extends BaseModel
{

    public function setAdminChatIds($group_id, $super_admin_chat_id, $admin_chat_ids)
    {
        $info = $this->find($group_id);
        if ($info) {
            if ($super_admin_chat_id == $info->super_admin_chat_id){
                if (!in_array($admin_chat_ids, explode(',', $info->admin_chat_ids))){
                    $info->admin_chat_ids =  implode(',', array_filter(array_merge(explode(',', $info->admin_chat_ids), [$admin_chat_ids])));
                    $info->save();
                    return true;
                }
            }
        }

        return  false;
    }

    public function privilegeVerifier($group_id, $user_chat_id, $admin_chat_ids)
    {
        $info = $this->find($group_id);
        if ($info) {
            if ($user_chat_id == $info->super_admin_chat_id){
                return true;
            }else if ($admin_chat_ids && in_array($admin_chat_ids, explode(',', $info->admin_chat_ids))){
                return true;
            }

        }
        return  false;
    }
}
