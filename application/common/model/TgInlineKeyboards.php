<?php


namespace app\common\model;



class TgInlineKeyboards extends BaseModel
{

    public function setKeyboard($group_id, $text, $url, $show_num)
    {
        $ret = false;
        $group_info = $this->modelTgStatisticsGroup->find($group_id);
        if ($group_info){
            if (!$this->where('text', $text)->where('status', 1)->find()){
                $ret = $this->save(array(
                    'group_id' => $group_id,
                    'text' => $text,
                    'url' => $url,
                    'show_num'=> $show_num
                ));
            }
        }

        return $ret;
    }

    public function delKeyboard($group_id, $text)
    {
        $ret = false;
        $group_info = $this->modelTgStatisticsGroup->find($group_id);
        if ($group_info){
            return $this->where('text', $text)->update(['status' => -1]);
        }

        return $ret;
    }
}