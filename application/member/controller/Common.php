<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2019/12/5
 * Time: 23:04
 */

namespace app\member\controller;


use app\admin\model\AreaModel;
use app\common\library\enum\CodeEnum;
use app\index\logic\SysToolLogic;
use app\index\model\ConfigModel;
use app\ms\controller\Base;

class Common extends Base
{


    public function upload()
    {
        if($this->request->isPost()) {
            $this->result($this->logicFile->fileUpload('file',$this->request->param('path_name', '') ?? 'logo'));
        }
    }



    /**
     * 获取下级
     */
/*    public function getArea(){
        $id = $this->request->param('id','0');
        $AreaModel = new AreaModel();
        $result = $AreaModel->getArea($id);
        $this->success('请求成功',null,$result);
    }
*/

}
