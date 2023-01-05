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


use app\common\logic\Log;

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

    public function setJoinGroupMessage($group_id, $super_admin_chat_id, $message)
    {
        $ret = false;
        if (!empty($message)){
            try {
                $info = $this->find($group_id);
                if ($super_admin_chat_id == $info->super_admin_chat_id){
                    $info->join_group_text = $message;
                    $info->save();
                    $ret = true;
                }

            }catch (\Exception $e){

            }

        }

        return $ret;
    }

    public function welcomeNewMember($new_chat_member, $group_id, &$send_message, &$option)
    {
        $bot_info = $this->find($group_id);
        if ($bot_info){
            foreach ($new_chat_member as $new_member) {
                if (!$new_member['is_bot']) {
                    $keyboardMap = [
                        'group_id' => $group_id,
                        'status' =>1
                    ];

                    $keyboards =  $this->modelTgInlineKeyboards->where($keyboardMap)->field('text,url')->select();

                    if ($keyboards){
                        $keyboard = json_encode(["inline_keyboard" => array_chunk(collection($keyboards)->toArray(), 2) ]);
                    }else{
                        $keyboard = [];
                    }

                    $send_message = $bot_info['join_group_text'] ?? "";

                    $option = array(
                        'reply_markup' =>  $keyboard
                    );

                }
            }
        }

        return true;
    }

}
