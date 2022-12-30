<?php
return [
    'admin_api_config' =>[
//        [
//            'name' => 'zhuankayemian',
//            'type' => 30,
//            'title' => '转卡页面',
//            'value' => 1
//        ],
        [
            'name' => 'order_invalid_time',
            'type' => 30,
            'title' => '订单超时时间(分钟)',
            'value' => 5
        ],
        [
            'name' => 'get_pay_name_type',
            'type' => 30,
            'title' => '获取支付用户姓名方式',
            'value' => 1
        ],
        [
            'name' => 'kzk_is_pay_name',
            'type' => 30,
            'title' => '支付页面是否提交姓名(1为开启，2为关闭)',
            'value' => 1
        ],
        [
            'name' => 'admin_daifu_number',
            'type' => 255,
            'title' => '码商代付抢单笔数限制',
            'value' => 1
        ],
        [
            'name' => 'daifu_success_uplode',
            'type' => 255,
            'title' => '代付成功上传图片(1为关闭，2为开启)',
            'value' => 1
        ],


    ]
];