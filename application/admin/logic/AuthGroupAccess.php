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

namespace app\admin\logic;

/**
 * 授权逻辑
 */
class AuthGroupAccess extends BaseAdmin
{

    /**
     * 获得权限菜单列表
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param int $uid
     * @return array
     */
    public function getAuthMenuList($uid = 0)
    {
        
        $sort = 'sort';
        
        if (is_admin_login() == 1) {
            
            return $this->logicMenu->getMenuList([], true, $sort);
        }
        
        // 获取用户组列表
        $group_list = $this->getUserGroupInfo($uid);
        
        $menu_ids = [];
        
        foreach ($group_list as $group_info) {
            
            // 合并多个分组的权限节点并去重
            !empty($group_info['rules']) && $menu_ids = array_unique(array_merge($menu_ids, explode(',', trim($group_info['rules'], ','))));
        }
        
        // 若没有权限节点则返回
        if (empty($menu_ids)) {
            
            return $menu_ids;
        }
        
        // 查询条件
        $where = ['id' => ['in', $menu_ids]];
        
        return $this->logicMenu->getMenuList($where, true, $sort);
    }
    
    /**
     * 获得权限菜单URL列表
     */
    public function getAuthMenuUrlList($auth_menu_list = [])
    {
        
        $auth_list = [];
        
        foreach ($auth_menu_list as $info) {
            
            $auth_list[] = $info['url'];
        }

        return $auth_list;
    }

    /**
     * 获取管理所属权限组信息
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param int $uid
     * @return mixed
     */
    public function getUserGroupInfo($uid = 0)
    {
        
        $this->modelAuthGroupAccess->alias('a');
        
        is_array($uid) ? $where['a.uid'] = ['in', $uid] : $where['a.uid'] = $uid;

        
        $field = 'a.uid, a.group_id, g.name, g.describe, g.rules';
        
        $join = [
                    [ 'auth_group g', 'a.group_id = g.id'],
                ];
        
        $this->modelAuthGroupAccess->join = $join;
        
        return $this->modelAuthGroupAccess->getList($where, $field, '', false);
    }

    /**
     * 获取授权列表
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param array $where
     * @param string $field
     * @param string $order
     * @param bool $paginate
     * @return mixed
     */
    public function getAuthGroupAccessList($where = [], $field = 'uid,group_id', $order = 'uid', $paginate = false)
    {
        
        return $this->modelAuthGroupAccess->getList($where, $field, $order, $paginate);
    }


    /**
     * 获取用户授权
     * @param $userId
     * @return mixed
     */
    public function getAuthGroupAccessInfoByUid($userId)
    {
        return $this->modelAuthGroupAccess->getInfo(['uid' => $userId]);
    }


    /**
     * 根据groupId获取用户权限组
     * @param int $groupId
     * @return mixed
     */
    public function getUserGroupInfoByGroupId($groupId = 0)
    {

        $this->modelAuthGroupAccess->alias('g');

        is_array($groupId) ? $where['g.group_id'] = ['in', $groupId] : $where['g.group_id'] = $groupId;


        $field = 'g.uid, g.group_id, a.nickname';

        $join = [
            ['admin a', 'g.uid = a.id'],
        ];

        $this->modelAuthGroupAccess->join = $join;

        return $this->modelAuthGroupAccess->getList($where, $field, '', false);
    }
}
