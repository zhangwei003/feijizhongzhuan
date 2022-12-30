

CREATE TABLE `cm_banktobank_sms` (
                                     `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                     `phone` varchar(255) NOT NULL COMMENT '来短信的号码',
                                     `context` text COMMENT '短信内容',
                                     `ip` varchar(255) DEFAULT NULL,
                                     `ms_id` int(11) DEFAULT NULL COMMENT '码商id',
                                     `create_time` datetime DEFAULT NULL,
                                     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `cm_ewm_pay_code` ADD `bank_four_code` INT( 11 ) NOT NULL COMMENT '银行卡后四位' AFTER `limit__total` ;

ALTER TABLE `cm_action_log` ADD `admin_id` INT( 11 ) NOT NULL COMMENT '管理员id' AFTER `status` ;

ALTER TABLE `cm_ewm_pay_code` ADD `min_money` DECIMAL( 10, 2 ) NOT NULL COMMENT '最小请求金额' AFTER `bank_four_code` ;
ALTER TABLE `cm_ewm_pay_code` ADD `max_money` DECIMAL( 10, 2 ) NOT NULL COMMENT '最大请求金额' AFTER `min_money` ;
ALTER TABLE `cm_ewm_pay_code` ADD `deleteTime` INT( 11 ) NOT NULL COMMENT '删除时间' AFTER `max_money` ;

ALTER TABLE `cm_ms` ADD `is_daifu` INT( 4 ) NOT NULL DEFAULT '1' COMMENT '是否允许代付' AFTER `admin_id` ;

ALTER TABLE `cm_ms_rate` CHANGE `channel_id` `code_type_id` INT( 11 ) NOT NULL DEFAULT '0' COMMENT '支付编码id';

ALTER TABLE `cm_admin` ADD COLUMN `agent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '代理id' AFTER `status`;

ALTER TABLE `cm_ewm_pay_code` ADD `balance` DECIMAL( 10, 2 ) NOT NULL COMMENT '余额';

ALTER TABLE `cm_banktobank_sms` ADD `order_id` INT( 11 ) NOT NULL DEFAULT '0' COMMENT '短信自动回调订单ID' AFTER `ms_id` ;


ALTER TABLE `cm_config` ADD `admin_id` INT( 11 ) NOT NULL DEFAULT '1' COMMENT '所属管理员ID' AFTER `update_time` ;
ALTER TABLE cm_config DROP INDEX conf_name;

ALTER TABLE `cm_ewm_pay_code` CHANGE `bank_name` `bank_name` VARCHAR( 2083 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '开户行';

ALTER TABLE `cm_user` ADD `is_daifu` TINYINT( 1 ) NOT NULL DEFAULT '0' COMMENT '是否允许代付' AFTER `is_verify_phone` ;


ALTER TABLE `cm_daifu_orders` ADD `send_notify_times` INT( 1 ) NOT NULL DEFAULT '0' COMMENT '代付订单回调次数' AFTER `remark` ;
INSERT INTO `cm_pay_code` (
    `id` ,
    `cnl_id` ,
    `name` ,
    `code` ,
    `remarks` ,
    `status` ,
    `create_time` ,
    `update_time` ,
    `cnl_weight`
)
VALUES (
           '255', NULL , '代付', 'daifu', '代付', '1', '1666212478', '1666212478', ''
       );

ALTER TABLE `cm_daifu_orders` ADD `transfer_chart` VARCHAR( 2083 ) NOT NULL COMMENT '代付转账截图' AFTER `send_notify_times` ;

ALTER TABLE `cm_daifu_orders` ADD `is_to_channel` TINYINT( 1 ) NOT NULL DEFAULT '1' COMMENT '是否中转订单' AFTER `transfer_chart` ;

ALTER TABLE `cm_daifu_orders` ADD `daifu_transfer_id` INT( 11 ) NOT NULL DEFAULT '0' COMMENT '代付中转ID' AFTER `is_to_channel` ;

ALTER TABLE `cm_daifu_orders` DROP `daifu_transfer_id` ;

ALTER TABLE `cm_daifu_orders` ADD `daifu_transfer_name` VARCHAR( 255 ) NOT NULL COMMENT '代付中转通道名称' AFTER `is_to_channel` ;

ALTER TABLE `cm_user` ADD `withdrawal_charge` DECIMAL( 10, 2 ) NOT NULL DEFAULT '5.00' COMMENT '提现手续费' AFTER `status` ;


ALTER TABLE `cm_ewm_pay_code` ADD `expiration_time` INT( 11 ) NOT NULL COMMENT '失效时间' AFTER `balance` ;

ALTER TABLE `cm_user` ADD `is_hide_withdrawal` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否隐藏提现' AFTER `status` ;

CREATE TABLE `cm_tg_trading_house_data` (
    `merchant_name` varchar(255) NOT NULL,
    `price_buy` decimal(10,2) NOT NULL,
    `pay_method` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;