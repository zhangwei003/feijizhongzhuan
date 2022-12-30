<?php
return [
        [
            'phone' => '106980096668',
            'source' => '山东省农村信用社',
	    'preg' => [
		    [
		        'number_start'=>'您尾号',
			'number_end'=>'的银联卡',
		        'money_start'=>'人民币',
			'money_end'=>'元',
			'time_start'=>'联卡在',
			'time_end'=>'发生',
		    ]
	    ],
	    'time_function'=> 'date',
	],
        [
            'phone' => '95577',
            'source' => '华夏银行',
            'preg' => [
                    [
                        'number_start'=>'您的账户',
                        'number_end'=>'于',
                        'money_start'=>'收入人民币',
                        'money_end'=>'元',
                        'time_start'=>'联卡在',
                        'time_end'=>'发生',
                    ]
            ],
            'preg_balance' => [
                    [
                        'balance_start'=>'余额',
                        'balance_end'=>'元',
                    ]
            ],

            'time_function'=> 'date',
        ],

        [
            'phone' => '96669',
            'source' => '安徽省农村信用社',
            'preg' => [
                    [
                        'number_start'=>'您账号',
                        'number_end'=>'于',
                        'money_start'=>'收入',
                        'money_end'=>'元',
                        'time_start'=>'联卡在',
                        'time_end'=>'发生',
                    ]
            ],
            'preg_balance' => [
                    [
                        'balance_start'=>'余',
                        'balance_end'=>'元',
                    ]
            ],

            'time_function'=> 'date',
        ],

	 [
            'phone' => '1069183996588',
            'source' => '潍坊银行',
            'preg' => [
                    [
                        'number_start'=>'您尾号',
                        'number_end'=>'的账户',
                        'money_start'=>'存入人民币',
                        'money_end'=>'。',
                        'time_start'=>'日',
                        'time_end'=>'支取',
                    ]
            ],
            'time_function'=> 'date',
	 ],
	 [
            'phone' => '95580',
            'source' => '邮政储蓄银行',
            'preg' => [
                    [
                        'number_start'=>'您尾号',
                        'number_end'=>'账户',
                        'money_start'=>'收入金额',
                        'money_end'=>'元',
                        'time_start'=>'】',
                        'time_end'=>'您尾号',
                    ]
	    ],
	    'preg_balance' => [
                    [
                        'balance_start'=>'余额',
                        'balance_end'=>'元',
                    ]
            ],
            'time_function'=> 'date',
         ],
         [
            'phone' => '106980196688',
            'source' => '贵州农村商业银行',
            'preg' => [
                    [
                        'number_start'=>'您尾号',
                        'number_end'=>'账户',
                        'money_start'=>'收入',
                        'money_end'=>'元',
                        'time_start'=>'账户',
                        'time_end'=>'收到',
		    ],
		    [
                        'number_start'=>'您尾号',
                        'number_end'=>'账户',
                        'money_start'=>'转入',
                        'money_end'=>'元',
                        'time_start'=>'账户',
                        'time_end'=>'收到',
                    ],
            ],
            'preg_balance' => [
                    [
                        'balance_start'=>'余额',
                        'balance_end'=>'元',
                    ],
                    [
                        'balance_start'=>'余额',
                        'balance_end'=>'。',
                    ]
            ],
            'time_function'=> 'date',
         ],

         [
            'phone' => '95561',
            'source' => '兴业银行',
            'preg' => [
                    [
                        'number_start'=>'账户*',
                        'number_end'=>'*汇款',
                        'money_start'=>'汇入收入',
                        'money_end'=>'元',
                        'time_start'=>'】',
                        'time_end'=>'您尾号',
                        'no_number'=>1,
		    ],
		    [
                        'number_start'=>'账户*',
                        'number_end'=>'*跨行代',
                        'money_start'=>'收入',
                        'money_end'=>'元，余额',
                        'time_start'=>'】',
                        'time_end'=>'您尾号',
                        'no_number'=>1,
                    ],

            ],
            'time_function'=> 'date',
	 ],

	 [
            'phone' => '95599',
            'source' => '中国农业银行',
            'preg' => [
                    [
                        'number_start'=>'您尾号',
                        'number_end'=>'账户',
                        'money_start'=>'交易人民币',
                        'money_end'=>'，',
                        'time_start'=>'日',
                        'time_end'=>'向您尾号',
                    ]
	    ],
	    'preg_balance' => [
                    [
                        'balance_start'=>'，余额',
                        'balance_end'=>'。',
                    ]
            ],

            'time_function'=> 'date',
	 ],
	 [
            'phone' => '农业银行',
            'source' => '中国农业银行',
            'preg' => [
                    [
                        'number_start'=>'您尾号',
                        'number_end'=>'账户',
                        'money_start'=>'交易人民币',
                        'money_end'=>'，',
                        'time_start'=>'日',
                        'time_end'=>'向您尾号',
                    ]
	    ],
	    'preg_balance' => [
                    [
                        'balance_start'=>'，余额',
                        'balance_end'=>'。',
                    ]
            ],

            'time_function'=> 'date',
	 ],


	  [
            'phone' =>'106980096033',
            'source' => '贵阳银行',
            'preg' => [
                    [
                        'number_start'=>'尾号',
                        'number_end'=>'于',
                        'money_start'=>'存入',
                        'money_end'=>']',
                        'time_start'=>'于',
                        'time_end'=>'存入',
                    ],
                    [
                        'number_start'=>'尾号',
                        'number_end'=>'于',
                        'money_start'=>'存入',
                        'money_end'=>'[',
                        'time_start'=>'于',
                        'time_end'=>'存入',
                    ],
            ],
            
            'preg_balance' => [
                    [
                        'balance_start'=>'余额',
                        'balance_end'=>'。',
                    ]
            ],

            'time_function'=> 'date',
         ],
         
         [
            'phone' =>'106980000866',
            'source' => '厦门国际银行',
            'preg' => [
                    [
                        'number_start'=>'您尾号为',
                        'number_end'=>'的账户',
                        'money_start'=>'金额CNY',
                        'money_end'=>'，活期余额',
                        'time_start'=>'于',
                        'time_end'=>'存入',
		    ],
		     [
                        'number_start'=>'您尾号为',
                        'number_end'=>'的账户',
                        'money_start'=>'CNY',
                        'money_end'=>',银联入账',
                        'time_start'=>'于',
                        'time_end'=>'存入',
		     ],
		     [
                        'number_start'=>'您尾号',
                        'number_end'=>'的账户',
                        'money_start'=>'金额CNY',
                        'money_end'=>'，活期',
                        'time_start'=>'于',
                        'time_end'=>'存入',

                     ],

	    ],
	     'preg_balance' => [
                    [
                        'balance_start'=>'活期余额为CNY',
                        'balance_end'=>'。本机',
                    ]
            ],


            'time_function'=> 'date',
	 ],

	 [
            'phone' =>'95566',
            'source' => '中国银行',
            'preg' => [
                    [
                        'number_start'=>'账户',
                        'number_end'=>'，于',
                        'money_start'=>'人民币',
                        'money_end'=>'元',
                        'time_start'=>'于',
                        'time_end'=>'存入',
                    ],
                [
                    'number_start'=>'借记卡账户',
                    'number_end'=>'，于',
                    'money_start'=>'人民币',
                    'money_end'=>'元,交',
                    'time_start'=>'于',
                    'time_end'=>'收入',
                ],
                [
                    'number_start'=>'账户',
                    'number_end'=>'于',
                    'money_start'=>'人民币',
                    'money_end'=>'元',
                    'time_start'=>'于',
                    'time_end'=>'存入',
                    'no_number'=>1,
                ],

	    ],
	     'preg_balance' => [
                    [
                        'balance_start'=>'交易后余额',
                        'balance_end'=>'【中国银',
                    ]
            ],
            'time_function'=> 'date',

         ],
    [
        'phone' =>'10691175712',
        'source' => '渣打银行',
        'preg' => [
            [
                'number_start'=>'您尾号为 ',
                'number_end'=>' 的账户',
                'money_start'=>'收入 CNY ',
                'money_end'=>'。',
                'time_start'=>'[',
                'time_end'=>']',
                'no_number'=>1,
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'【',
                'balance_end'=>'】',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'1069800096511',
        'source' => '长沙银行',
        'preg' => [
            [
                'number_start'=>'您尾号',
                'number_end'=>'的银联卡活期账户',
                'money_start'=>'转账转入',
                'money_end'=>'元，',
                'time_start'=>'活期账户',
                'time_end'=>'转账转入',
                'pay_name_start' => '付方：',
                'pay_name_end' =>' '
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'余额',
                'balance_end'=>'元，',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'10691175013',
        'source' => '汇丰银行',
        'preg' => [
            [
                'number_start'=>'***-',
                'number_end'=>' CNY',
                'money_start'=>'CNY ',
                'money_end'=>'+',
                'time_start'=>'【',
                'time_end'=>'】',
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'【',
                'balance_end'=>'】，',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'95533',
        'source' => '建设银行',
        'preg' => [
            [
                'number_start'=>'向您尾号',
                'number_end'=>'的储蓄卡',
                'money_start'=>'存入人民币',
                'money_end'=>'元,',
                'time_start'=>'[',
                'time_end'=>']',
                'pay_name_jhdz'=>1,
            ],
            [
                'number_start'=>'您尾号',
                'number_end'=>'的储蓄卡',
                'money_start'=>'收入人民币',
                'money_end'=>'元,活期',
                'time_start'=>'的储蓄卡',
                'time_end'=>'支付宝提现',
            ],


        ],
        'preg_balance' => [
            [
                'balance_start'=>'余额',
                'balance_end'=>'元',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'96262',
        'source' => '陕西信合',
        'preg' => [
            [
                'number_start'=>'信合】您',
                'number_end'=>'账户',
                'money_start'=>'转入',
                'money_end'=>'元,',
                'time_start'=>'账户',
                'time_end'=>',他行',
                'pay_name_start' => '对方户名:',
                'pay_name_end' =>',附言'
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'元,余额',
                'balance_end'=>'].元对',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'106980096288',
        'source' => '河南农信',
        'preg' => [
            [
                'number_start'=>'农信】您尾号',
                'number_end'=>'于',
                'money_start'=>'转入',
                'money_end'=>'元，余额',
                'time_start'=>'于',
                'time_end'=>'通过本行',
                'pay_name_start' => '（',
                'pay_name_end' =>'）转入'
            ],
            [
                'number_start'=>'农信】您尾号',
                'number_end'=>'于',
                'money_start'=>'转入',
                'money_end'=>'元，余额',
                'time_start'=>'于',
                'time_end'=>'通过本行',
                'pay_name_start' => '（',
                'pay_name_end' =>'）转入'
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'，余额',
                'balance_end'=>'元。',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'956056',
        'source' => '天津银行',
        'preg' => [
            [
                'number_start'=>'（尾数',
                'number_end'=>'）银联',
                'money_start'=>'存入人民币',
                'money_end'=>'元，',
                'time_start'=>'客户，',
                'time_end'=>'您借记',
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'余额为人民币',
                'balance_end'=>'元，特',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'95555',
        'source' => '招商银行',
        'preg' => [
            [
                'number_start'=>'您账户',
                'number_end'=>'于',
                'money_start'=>'实时转入人民币',
                'money_end'=>'，余额',
                'time_start'=>'于',
                'time_end'=>'他行',
                'pay_name_start' => '付方',
                'pay_name_end' =>' '
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'余额',
                'balance_end'=>'，付方',
            ]
        ],
        'time_function'=> 'date',

    ],
    [
        'phone' =>'95526',
        'source' => '北京银行',
        'preg' => [
            [
                'number_start'=>'您尾号为',
                'number_end'=>'普卡于',
                'money_start'=>'银联入账收入',
                'money_end'=>'元。',
                'time_start'=>'普卡于',
                'time_end'=>'银联入账',
                'pay_name_start' => '对方户名:',
                'pay_name_end' =>'。'
            ],

        ],
        'preg_balance' => [
            [
                'balance_start'=>'活期余额',
                'balance_end'=>'元。',
            ]
        ],
        'time_function'=> 'date',

    ],

];
