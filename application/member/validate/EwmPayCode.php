<?php


namespace app\member\validate;


use think\Validate;


/**
 * 二维码验证规则
 * Class EwmPayCode
 * @package app\ms\validate
 */
class EwmPayCode extends Validate
{

    protected $rule = [
        'bank_name' => 'require|max:25',
        'account_name' => 'require|max:5|checkIsChinese',
        'account_number' => 'require|integer|max:30',
        'security' => 'require|max:25',
        'min_money' => 'require|number',
        'max_money' => 'require|number',
        'limit__total' => 'require|number',
        'success_order_num' =>  'require|integer',
        'image_url' => 'require'
    ];

    protected $message = [
        'account_name.require' => '开户姓名必填',
        'account_name.max' => '开户姓名最大五位',
        'account_number.require' => '银行卡必填',
        'account_number.integer' => '银行卡卡号必须是整数',
        'bank_name.require' => '开户行必填',
        'security.require' => '安全码必填',
        'min_money.require' => '单笔最小金额不能为空',
        'min_money.number' => '单笔最小金额只能为数字',
        'max_money.require' => '单笔最大金额不能为空',
        'max_money.number' => '单笔最大金额只能为数字',
        'limit__total.require' => '日限额金额不能为空',
        'limit__total.number' => '日限额金额只能为数字',
        'success_order_num.require' => '笔数上限不能为空',
        'success_order_num.integer' => '笔数上限只能为整数',
    ];

    protected function checkIsChinese($value)
    {
        return checkIsChinese($value) ? true : '开户姓名必须为中文';
    }


    protected function vlidateError($value)
    {
        return vlidateError($value) ? true : '开户姓名必须为中文';
    }

    protected $scene = [
            'kzk_add' => ['bank_name', 'account_name', 'account_number', 'security', 'success_order_num'],
            'alipayCode_add' =>  [
                'bank_name'=>'require',
                'account_name' => 'require',
                'account_number' => 'require',
                'security', 'success_order_num'
            ],
            'alipayPassRed_add' => [
                'account_name'=>'require',
                'account_number' => 'require', 'security',  'success_order_num'
            ],
            'alipayUid_add' => [
                'bank_name'=>'require',
                'account_name' => 'require',
                'account_number' => 'require',
                'security', 'success_order_num'
            ],
            'alipayUidSmall_add' => [
                'bank_name'=>'require',
                'account_name' => 'require',
                'account_number' => 'require',
                'security', 'success_order_num'
            ],
            'alipayUidTransfer_add' => [
                'bank_name'=>'require',
                'account_name' => 'require',
                'account_number' => 'require',
                'security', 'success_order_num'
            ],
    ];
}


