/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : statistical_bot

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2023-01-03 22:25:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cm_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cm_action_log`;
CREATE TABLE `cm_action_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '执行会员id',
  `module` varchar(30) NOT NULL DEFAULT 'admin' COMMENT '模块',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '行为',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '执行的URL',
  `ip` char(30) NOT NULL DEFAULT '' COMMENT '执行行为者ip',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='行为日志表';

-- ----------------------------
-- Table structure for cm_admin
-- ----------------------------
DROP TABLE IF EXISTS `cm_admin`;
CREATE TABLE `cm_admin` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `leader_id` mediumint(8) NOT NULL DEFAULT '1',
  `username` varchar(20) DEFAULT '0',
  `nickname` varchar(40) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `google_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'googleç¶æ1 ç»å® 0æªç»å®',
  `google_secret_key` varchar(100) NOT NULL DEFAULT '' COMMENT 'ç®¡çågoogleç§é¥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理员信息';

-- ----------------------------
-- Table structure for cm_api
-- ----------------------------
DROP TABLE IF EXISTS `cm_api`;
CREATE TABLE `cm_api` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL COMMENT '商户id',
  `key` varchar(32) DEFAULT NULL COMMENT 'API验证KEY',
  `sitename` varchar(30) NOT NULL,
  `domain` varchar(100) NOT NULL COMMENT '商户验证域名',
  `daily` decimal(12,3) NOT NULL DEFAULT '20000.000' COMMENT '日限访问（超过就锁）',
  `secretkey` text NOT NULL COMMENT '商户请求RSA私钥',
  `auth_ips` text NOT NULL,
  `role` int(4) NOT NULL COMMENT '角色1-普通商户,角色2-特约商户',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商户API状态,0-禁用,1-锁,2-正常',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_verify_sign` int(11) DEFAULT '1' COMMENT '是否验证sign 1 验证 0 不验证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_domain_unique` (`id`,`domain`,`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';

-- ----------------------------
-- Table structure for cm_article
-- ----------------------------
DROP TABLE IF EXISTS `cm_article`;
CREATE TABLE `cm_article` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `author` char(20) NOT NULL DEFAULT 'admin' COMMENT '作者',
  `title` char(40) NOT NULL DEFAULT '' COMMENT '文章名称',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `content` text NOT NULL COMMENT '文章内容',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面图片id',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件id',
  `img_ids` varchar(200) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_index` (`id`,`title`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章表';

-- ----------------------------
-- Table structure for cm_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `cm_auth_group`;
CREATE TABLE `cm_auth_group` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `describe` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='权限组表';

-- ----------------------------
-- Table structure for cm_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `cm_auth_group_access`;
CREATE TABLE `cm_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户组id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组授权表';

-- ----------------------------
-- Table structure for cm_balance
-- ----------------------------
DROP TABLE IF EXISTS `cm_balance`;
CREATE TABLE `cm_balance` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `enable` decimal(12,3) unsigned DEFAULT '0.000' COMMENT '可用余额(已结算金额)',
  `disable` decimal(12,3) unsigned DEFAULT '0.000' COMMENT '冻结金额(待结算金额)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态 1正常 0禁止操作',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_index` (`id`,`uid`) USING BTREE,
  UNIQUE KEY `uid_index` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户资产表';

-- ----------------------------
-- Table structure for cm_balance_cash
-- ----------------------------
DROP TABLE IF EXISTS `cm_balance_cash`;
CREATE TABLE `cm_balance_cash` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `cash_no` varchar(80) NOT NULL COMMENT '取现记录单号',
  `amount` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '取现金额',
  `account` int(2) NOT NULL DEFAULT '0' COMMENT '取现账户（关联商户结算账户表）',
  `remarks` varchar(255) NOT NULL COMMENT '取现说明',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '取现状态',
  `create_time` int(10) unsigned NOT NULL COMMENT '申请时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '处理时间',
  `commission` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT 'æç°æç»­è´¹',
  `audit_remarks` varchar(255) DEFAULT NULL COMMENT 'å®¡æ ¸å¤æ³¨',
  `bank_name` varchar(32) DEFAULT NULL COMMENT '开户行',
  `bank_number` varchar(32) DEFAULT NULL COMMENT '卡号',
  `bank_realname` varchar(32) DEFAULT NULL COMMENT '姓名',
  `voucher` varchar(255) DEFAULT NULL COMMENT '跑分平台凭证',
  `voucher_time` int(11) DEFAULT '0' COMMENT '凭证上传时间',
  `channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '渠道编号 ',
  `cash_file` varchar(255) NOT NULL DEFAULT '' COMMENT 'è½¬æ¬¾å­è¯',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提现方式  0:银行卡  1:usdt',
  `withdraw_usdt_address` varchar(255) NOT NULL DEFAULT '' COMMENT 'usdt提款地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_index` (`id`,`uid`,`cash_no`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户账户取现记录';

-- ----------------------------
-- Table structure for cm_balance_change
-- ----------------------------
DROP TABLE IF EXISTS `cm_balance_change`;
CREATE TABLE `cm_balance_change` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `type` varchar(20) NOT NULL DEFAULT 'enable' COMMENT '资金类型',
  `preinc` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动前金额',
  `increase` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '增加金额',
  `reduce` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '减少金额',
  `suffixred` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动后金额',
  `remarks` varchar(255) NOT NULL COMMENT '资金变动说明',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_flat_op` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'æ¯å¦åå°äººå·¥è´¦å',
  `order_no` varchar(255) DEFAULT NULL,
  `type_reason` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `change_index` (`id`,`uid`,`type`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COMMENT='商户资产变动记录表';

-- ----------------------------
-- Table structure for cm_bank
-- ----------------------------
DROP TABLE IF EXISTS `cm_bank`;
CREATE TABLE `cm_bank` (
  `bank_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(50) NOT NULL DEFAULT '' COMMENT '银行名称',
  `bank_color` varchar(200) NOT NULL DEFAULT '' COMMENT '银行App展示渐变色',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT '银行网银地址',
  `logo` varchar(100) NOT NULL DEFAULT '' COMMENT '银行logo',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '银行状态0为启用，1为禁用',
  `create_user` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_user` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `is_maintain` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否维护',
  `maintain_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '维护开始时间',
  `maintain_end` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '维护结束时间',
  PRIMARY KEY (`bank_id`) USING BTREE,
  KEY `status` (`is_del`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='接受的在线提现银行表';

-- ----------------------------
-- Table structure for cm_banker
-- ----------------------------
DROP TABLE IF EXISTS `cm_banker`;
CREATE TABLE `cm_banker` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '银行ID',
  `name` varchar(80) NOT NULL COMMENT '银行名称',
  `remarks` varchar(140) NOT NULL COMMENT '备注',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认账户,0-不默认,1-默认',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '银行可用性',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `bank_code` varchar(32) DEFAULT NULL COMMENT '银行编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COMMENT='系统支持银行列表';

-- ----------------------------
-- Table structure for cm_config
-- ----------------------------
DROP TABLE IF EXISTS `cm_config`;
CREATE TABLE `cm_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置标题',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `value` text NOT NULL COMMENT '配置值',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置选项',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '配置说明',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `conf_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=1122 DEFAULT CHARSET=utf8 COMMENT='基本配置表';

-- ----------------------------
-- Table structure for cm_dafiu_account
-- ----------------------------
DROP TABLE IF EXISTS `cm_dafiu_account`;
CREATE TABLE `cm_dafiu_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_name` varchar(45) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `controller` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_daifu_orders
-- ----------------------------
DROP TABLE IF EXISTS `cm_daifu_orders`;
CREATE TABLE `cm_daifu_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `notify_url` varchar(500) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `bank_number` varchar(45) DEFAULT NULL,
  `bank_owner` varchar(45) DEFAULT NULL,
  `bank_id` int(10) DEFAULT NULL,
  `bank_name` varchar(45) DEFAULT NULL,
  `out_trade_no` varchar(45) DEFAULT NULL,
  `trade_no` varchar(45) DEFAULT NULL,
  `body` varchar(45) DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  `service_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  `single_service_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔手续费',
  `notify_result` text COMMENT '回调返回内容 SUCCESS为成功 其他为失败',
  `ms_id` int(10) NOT NULL DEFAULT '0' COMMENT 'ms_id',
  `error_reason` varchar(255) NOT NULL DEFAULT '' COMMENT 'reson',
  `finish_time` int(10) NOT NULL DEFAULT '0' COMMENT 'finish_time',
  `matching_time` int(10) NOT NULL DEFAULT '0' COMMENT 'matching_time',
  `df_bank_id` int(10) NOT NULL DEFAULT '0' COMMENT 'df_bank_id',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_deposite_card
-- ----------------------------
DROP TABLE IF EXISTS `cm_deposite_card`;
CREATE TABLE `cm_deposite_card` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1表示可使用状态，0表示禁止状态',
  `bank_id` int(10) NOT NULL DEFAULT '0' COMMENT '银行卡ID',
  `bank_account_username` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡用户名',
  `bank_account_number` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡账号',
  `bank_account_address` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡地址',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `uid` int(10) NOT NULL DEFAULT '0' COMMENT 'df_bank_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值卡信息';

-- ----------------------------
-- Table structure for cm_deposite_orders
-- ----------------------------
DROP TABLE IF EXISTS `cm_deposite_orders`;
CREATE TABLE `cm_deposite_orders` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `p_admin_id` mediumint(8) DEFAULT NULL COMMENT '跑分平台管理员id',
  `trade_no` varchar(255) NOT NULL DEFAULT '' COMMENT '申请充值订单号',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示正在申请 1成功 2表示失败',
  `bank_id` int(10) NOT NULL DEFAULT '0' COMMENT '银行卡ID',
  `bank_account_username` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡用户名',
  `bank_account_number` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡账号',
  `bank_account_address` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡地址',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `recharge_account` varchar(64) DEFAULT NULL COMMENT '充值账号',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `card_id` int(11) DEFAULT NULL COMMENT '充值银行卡id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请充值信息';

-- ----------------------------
-- Table structure for cm_ewm_block_ip
-- ----------------------------
DROP TABLE IF EXISTS `cm_ewm_block_ip`;
CREATE TABLE `cm_ewm_block_ip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ms_id` int(11) NOT NULL COMMENT '码商 ',
  `block_visite_ip` varchar(100) NOT NULL COMMENT '拉黑的ip',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_ewm_order
-- ----------------------------
DROP TABLE IF EXISTS `cm_ewm_order`;
CREATE TABLE `cm_ewm_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `add_time` int(10) DEFAULT NULL,
  `order_no` varchar(100) DEFAULT NULL COMMENT '订单号',
  `order_price` decimal(10,2) DEFAULT NULL COMMENT '订单价格',
  `status` int(11) DEFAULT '0',
  `gema_userid` int(11) DEFAULT '0' COMMENT '所属用户',
  `qr_image` text,
  `pay_time` int(10) DEFAULT NULL COMMENT '支付时间',
  `code_id` int(10) DEFAULT NULL,
  `order_pay_price` decimal(10,2) DEFAULT NULL COMMENT '实际支付价格',
  `gema_username` varchar(45) DEFAULT NULL COMMENT '个码用户名',
  `note` varchar(45) DEFAULT NULL,
  `out_trade_no` varchar(200) DEFAULT NULL,
  `code_type` int(10) DEFAULT NULL,
  `bonus_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_back` int(1) NOT NULL DEFAULT '0',
  `is_upload_credentials` int(1) NOT NULL DEFAULT '0',
  `credentials` varchar(500) DEFAULT NULL,
  `sure_ip` varchar(45) NOT NULL DEFAULT '0',
  `is_handle` int(1) DEFAULT '0',
  `visite_ip` varchar(32) DEFAULT NULL COMMENT '访问ip',
  `visite_area` varchar(200) DEFAULT NULL COMMENT '访问区域',
  `visite_time` int(11) DEFAULT NULL COMMENT '访问时间',
  `merchant_order_no` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '支付平台下游商户商户订单号',
  `visite_clientos` varchar(50) DEFAULT NULL COMMENT '访问设备',
  `grab_a_single_type` int(11) NOT NULL DEFAULT '1' COMMENT '抢单类型 1 抢单扣余额 2 抢单不扣余额',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `notify_result` text COMMENT '回调返回内容成功为 SUCCESS',
  `visite_token` varchar(255) DEFAULT NULL COMMENT '访问token',
  `notify_url` varchar(255) DEFAULT NULL COMMENT '回调地址',
  `member_id` int(11) DEFAULT NULL COMMENT '支付商户id',
  `pay_username` varchar(255) NOT NULL DEFAULT '' COMMENT '付款人姓名',
  `pay_user_name` varchar(20) NOT NULL COMMENT '商户上报的支付用户名',
  `sure_order_role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1：用户完成订单  2：管理员完成订单',
  `name_abnormal` tinyint(1) NOT NULL DEFAULT '0' COMMENT '姓名不符合',
  `money_abnormal` tinyint(1) NOT NULL DEFAULT '0' COMMENT '金额不符合',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_no` (`order_no`) USING BTREE,
  KEY `search` (`order_no`,`gema_username`,`status`,`add_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cm_ewm_pay_code
-- ----------------------------
DROP TABLE IF EXISTS `cm_ewm_pay_code`;
CREATE TABLE `cm_ewm_pay_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ms_id` int(11) NOT NULL DEFAULT '0' COMMENT '属于哪个用户',
  `status` int(1) DEFAULT '0' COMMENT '是否正常使用　０表示正常，１表示禁用',
  `account_name` varchar(50) NOT NULL DEFAULT '' COMMENT '收款账户',
  `bank_name` varchar(50) NOT NULL DEFAULT '' COMMENT '开户行',
  `account_number` varchar(255) NOT NULL DEFAULT '' COMMENT '收款号码',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `user_name` varchar(45) NOT NULL DEFAULT '' COMMENT '用户名',
  `bonus_points` tinyint(3) NOT NULL DEFAULT '0' COMMENT '提成1000分之一',
  `success_order_num` int(10) NOT NULL DEFAULT '0' COMMENT '支付成功笔数',
  `updated_at` int(11) NOT NULL COMMENT '最后更新时间',
  `is_lock` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否锁定',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `forbidden_reason` varchar(32) DEFAULT NULL COMMENT '禁用原因',
  `order_today_all` smallint(5) NOT NULL DEFAULT '0' COMMENT '今日单量',
  `failed_order_num` smallint(5) NOT NULL DEFAULT '0' COMMENT '二维码失败次数',
  `code_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '二维码类型',
  `image_url` varchar(520) NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='码商二维码表';

-- ----------------------------
-- Table structure for cm_gemapay_code
-- ----------------------------
DROP TABLE IF EXISTS `cm_gemapay_code`;
CREATE TABLE `cm_gemapay_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '属于哪个用户',
  `type` int(1) DEFAULT NULL COMMENT '1表示微信，２表示支付宝，３表示云散付，４表示百付通',
  `qr_image` varchar(255) DEFAULT NULL COMMENT '二维码地址',
  `last_used_time` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '是否正常使用　０表示正常，１表示禁用',
  `last_online_time` int(11) DEFAULT NULL COMMENT '最后一次在线的时间',
  `pay_status` int(11) DEFAULT NULL COMMENT '０表示未使用，１表示使用占用中',
  `limit_money` decimal(10,2) DEFAULT NULL,
  `paying_num` int(10) DEFAULT NULL COMMENT '正在支付的数量',
  `user_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_jobs
-- ----------------------------
DROP TABLE IF EXISTS `cm_jobs`;
CREATE TABLE `cm_jobs` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_menu
-- ----------------------------
DROP TABLE IF EXISTS `cm_menu`;
CREATE TABLE `cm_menu` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(100) NOT NULL DEFAULT '100' COMMENT '排序',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '模块',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `is_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `icon` char(30) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COMMENT='基本菜单表';

-- ----------------------------
-- Table structure for cm_ms
-- ----------------------------
DROP TABLE IF EXISTS `cm_ms`;
CREATE TABLE `cm_ms` (
  `userid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL COMMENT '上级ID',
  `account` varchar(255) NOT NULL DEFAULT '0' COMMENT '用户账号',
  `mobile` char(20) NOT NULL COMMENT '用户手机号',
  `u_yqm` varchar(225) NOT NULL COMMENT '邀请码',
  `username` varchar(255) NOT NULL DEFAULT '',
  `login_pwd` varchar(225) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `login_salt` char(5) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户余额',
  `reg_date` int(11) NOT NULL COMMENT '注册时间',
  `reg_ip` varchar(20) NOT NULL COMMENT '注册IP',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户锁定  1 不锁  0拉黑  -1 删除',
  `activate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否激活 1-已激活 0-未激活',
  `use_grade` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `tg_num` int(11) NOT NULL COMMENT '总推人数',
  `rz_st` int(1) NOT NULL DEFAULT '0' COMMENT '资料完善状态，1OK2no',
  `zsy` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '总收益',
  `add_admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '添加该用户的管理元id',
  `work_status` int(1) NOT NULL DEFAULT '0',
  `security_salt` varchar(225) NOT NULL,
  `security_pwd` varchar(225) NOT NULL,
  `token` varchar(45) DEFAULT NULL,
  `is_allow_work` tinyint(1) DEFAULT '0' COMMENT '是否被禁止工作',
  `last_online_time` int(11) DEFAULT NULL,
  `tg_level` tinyint(1) DEFAULT NULL COMMENT 'ç¨·ä»£çç­çº§,ç³»ç»ç»éè¯·ç æ³¨åçç¨·ä¸º1,çº§ä¾æ¬¡ç±»æ¨',
  `updatetime` int(11) DEFAULT NULL COMMENT 'ä¿®æ¹æ¶é´',
  `google_status` int(11) DEFAULT '0' COMMENT 'googleå¯é¥ç¶æ',
  `google_secretkey` varchar(100) DEFAULT NULL COMMENT 'å¯é¥',
  `auth_ips` varchar(255) DEFAULT '' COMMENT 'ç¨·è®¿é®ç½åå',
  `blocking_reason` varchar(100) DEFAULT NULL COMMENT 'å»ç»ååå ',
  `cash_pledge` decimal(10,2) NOT NULL COMMENT '押金',
  `payment_amount_limit` decimal(10,2) NOT NULL COMMENT '可完成金额上线',
  `bank_rate` float(4,2) unsigned NOT NULL DEFAULT '1.00' COMMENT '银行卡费率',
  `deposit_floating_money` decimal(8,2) NOT NULL COMMENT '码商押金浮动金额',
  `tg_group_id` varchar(50) NOT NULL DEFAULT '' COMMENT '当前码商tg群id',
  `ms_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '当前码商tg群secret',
  `weight` int(11) NOT NULL DEFAULT '1' COMMENT '码商权重',
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '等级',
  PRIMARY KEY (`userid`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for cm_ms_rate
-- ----------------------------
DROP TABLE IF EXISTS `cm_ms_rate`;
CREATE TABLE `cm_ms_rate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ms_id` int(11) NOT NULL DEFAULT '0' COMMENT '码商id',
  `channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '通道id',
  `rate` decimal(10,3) NOT NULL DEFAULT '1.000' COMMENT '费率',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_ms_somebill
-- ----------------------------
DROP TABLE IF EXISTS `cm_ms_somebill`;
CREATE TABLE `cm_ms_somebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `jl_class` int(11) NOT NULL COMMENT '流水类别：1佣金2团队奖励3充值4提现5订单匹                                                                                                             配 6平台操作 7关闭订单',
  `info` varchar(225) NOT NULL COMMENT '说明',
  `addtime` varchar(225) NOT NULL COMMENT '事件时间',
  `jc_class` varchar(225) NOT NULL COMMENT '分+ 或-',
  `num` float(10,2) NOT NULL COMMENT '币量',
  `pre_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '变化前',
  `last_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT 'åå¨变化后¢',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='码商流水账单';

-- ----------------------------
-- Table structure for cm_ms_white_ip
-- ----------------------------
DROP TABLE IF EXISTS `cm_ms_white_ip`;
CREATE TABLE `cm_ms_white_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ms_id` int(11) NOT NULL COMMENT '码商的id',
  `md5_ip` varchar(50) NOT NULL COMMENT '码商ip白名单MD5值',
  PRIMARY KEY (`id`),
  KEY `ms_id` (`ms_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cm_notice
-- ----------------------------
DROP TABLE IF EXISTS `cm_notice`;
CREATE TABLE `cm_notice` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `author` varchar(30) DEFAULT NULL COMMENT '作者',
  `content` text NOT NULL COMMENT '公告内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公告状态,0-不展示,1-展示',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告表';

-- ----------------------------
-- Table structure for cm_orders
-- ----------------------------
DROP TABLE IF EXISTS `cm_orders`;
CREATE TABLE `cm_orders` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `puid` mediumint(8) NOT NULL DEFAULT '0' COMMENT '代理ID',
  `uid` mediumint(8) NOT NULL COMMENT '商户id',
  `trade_no` varchar(30) NOT NULL COMMENT '交易订单号',
  `out_trade_no` varchar(30) NOT NULL COMMENT '商户订单号',
  `subject` varchar(64) NOT NULL COMMENT '商品标题',
  `body` varchar(256) NOT NULL COMMENT '商品描述信息',
  `channel` varchar(30) NOT NULL COMMENT '交易方式(wx_native)',
  `cnl_id` int(3) NOT NULL COMMENT '支付通道ID',
  `extra` text COMMENT '特定渠道发起时额外参数',
  `amount` decimal(12,3) unsigned NOT NULL COMMENT '订单金额,单位是元,12-9保留3位小数',
  `income` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '实付金额',
  `user_in` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '商户收入',
  `agent_in` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '代理收入',
  `platform_in` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '平台收入',
  `currency` varchar(3) NOT NULL DEFAULT 'CNY' COMMENT '三位货币代码,人民币:CNY',
  `client_ip` varchar(32) NOT NULL COMMENT '客户端IP',
  `return_url` varchar(128) NOT NULL COMMENT '同步通知地址',
  `notify_url` varchar(128) NOT NULL COMMENT '异步通知地址',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单状态:0-已取消-1-待付款，2-已付款',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `bd_remarks` varchar(455) NOT NULL,
  `visite_time` int(10) NOT NULL DEFAULT '0' COMMENT 'è®¿é®æ¶é´',
  `real_need_amount` decimal(12,3) NOT NULL COMMENT 'éè¦ç¨·æ¯ä»éé¢',
  `image_url` varchar(445) NOT NULL COMMENT 'éè¦ç¨·æ¯ä»éé¢',
  `request_log` varchar(445) NOT NULL COMMENT 'log',
  `visite_show_time` int(10) NOT NULL DEFAULT '0' COMMENT 'å è½½å®æ¶é´',
  `request_elapsed_time` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '请求时间',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no_index` (`out_trade_no`,`trade_no`,`uid`,`channel`) USING BTREE,
  UNIQUE KEY `trade_no_index` (`trade_no`) USING BTREE,
  KEY `stat` (`cnl_id`,`create_time`) USING BTREE,
  KEY `stat1` (`cnl_id`,`status`,`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易订单表';

-- ----------------------------
-- Table structure for cm_orders_notify
-- ----------------------------
DROP TABLE IF EXISTS `cm_orders_notify`;
CREATE TABLE `cm_orders_notify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `is_status` int(3) unsigned NOT NULL DEFAULT '404',
  `result` varchar(300) NOT NULL DEFAULT '' COMMENT '请求相响应',
  `times` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '请求次数',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易订单通知表';

-- ----------------------------
-- Table structure for cm_pay_account
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_account`;
CREATE TABLE `cm_pay_account` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '账号ID',
  `cnl_id` bigint(10) NOT NULL COMMENT '所属渠道ID',
  `co_id` text NOT NULL COMMENT '支持的方式(有多个)',
  `name` varchar(30) NOT NULL COMMENT '渠道账户名称',
  `rate` decimal(4,3) NOT NULL COMMENT '渠道账户费率',
  `urate` decimal(4,3) NOT NULL DEFAULT '0.998',
  `grate` decimal(4,3) NOT NULL DEFAULT '0.998',
  `daily` decimal(12,3) NOT NULL COMMENT '当日限额',
  `single` decimal(12,3) NOT NULL COMMENT '单笔限额',
  `timeslot` text NOT NULL COMMENT '交易时间段',
  `param` text NOT NULL COMMENT '账户配置参数,json字符串',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `max_deposit_money` decimal(12,3) NOT NULL,
  `min_deposit_money` decimal(12,3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道账户表';

-- ----------------------------
-- Table structure for cm_pay_channel
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_channel`;
CREATE TABLE `cm_pay_channel` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `name` varchar(30) NOT NULL COMMENT '支付渠道名称',
  `action` varchar(30) NOT NULL COMMENT '控制器名称,如:Wxpay用于分发处理支付请求',
  `urate` decimal(4,3) NOT NULL DEFAULT '0.998' COMMENT '默认商户分成',
  `grate` decimal(4,3) NOT NULL DEFAULT '0.998' COMMENT '默认代理分成',
  `timeslot` text NOT NULL COMMENT '交易时间段',
  `return_url` varchar(255) NOT NULL COMMENT '同步地址',
  `notify_url` varchar(255) NOT NULL COMMENT '异步地址',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '渠道状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `notify_ips` varchar(445) NOT NULL,
  `ia_allow_notify` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'æ¸ éæ¯å¦åè®¸åè°',
  `channel_fund` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '渠道资金',
  `wirhdraw_charge` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '提现手续费',
  `tg_group_id` varchar(50) NOT NULL DEFAULT '' COMMENT '当前渠tg群id',
  `channel_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '渠道密钥',
  `limit_moneys` varchar(255) NOT NULL DEFAULT '' COMMENT '固定金额 不填写默认不限制',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道表';

-- ----------------------------
-- Table structure for cm_pay_channel_change
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_channel_change`;
CREATE TABLE `cm_pay_channel_change` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` mediumint(8) NOT NULL COMMENT '渠道ID',
  `preinc` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动前金额',
  `increase` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '增加金额',
  `reduce` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '减少金额',
  `suffixred` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动后金额',
  `remarks` varchar(255) NOT NULL COMMENT '资金变动说明',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_flat_op` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否后台人工账变',
  `status` varchar(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='渠道资金变动记录';

-- ----------------------------
-- Table structure for cm_pay_channel_price_weight
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_channel_price_weight`;
CREATE TABLE `cm_pay_channel_price_weight` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `pay_code_id` bigint(10) NOT NULL DEFAULT '0' COMMENT '支付产品id',
  `cnl_id` bigint(10) NOT NULL DEFAULT '0' COMMENT '支付渠道id',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `cnl_weight` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '渠道权重值',
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='支付产品下列渠道在固定金额下的权重';

-- ----------------------------
-- Table structure for cm_pay_code
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_code`;
CREATE TABLE `cm_pay_code` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `cnl_id` text,
  `name` varchar(30) NOT NULL COMMENT '支付方式名称',
  `code` varchar(30) NOT NULL COMMENT '支付方式代码,如:wx_native,qq_native,ali_qr;',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '方式状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `cnl_weight` varchar(255) NOT NULL COMMENT 'å½åpaycodeå¯¹åºæ¸ éæé',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COMMENT='交易方式表';

-- ----------------------------
-- Table structure for cm_shop
-- ----------------------------
DROP TABLE IF EXISTS `cm_shop`;
CREATE TABLE `cm_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT '店铺名称',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '店铺类型',
  `onlinedate` int(11) DEFAULT NULL COMMENT '最后在线时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1在线，2不在线，3停止健康，4停用',
  `password` varchar(45) DEFAULT NULL,
  `token` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺';

-- ----------------------------
-- Table structure for cm_tg_bill
-- ----------------------------
DROP TABLE IF EXISTS `cm_tg_bill`;
CREATE TABLE `cm_tg_bill` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `operation` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 加 2减少',
  `num` decimal(11,2) NOT NULL COMMENT '金额',
  `group_id` int(11) DEFAULT NULL,
  `user_chat_id` char(20) DEFAULT NULL,
  `pre_amount` decimal(11,2) DEFAULT NULL,
  `last_amount` decimal(11,2) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cm_tg_query_order_records
-- ----------------------------
DROP TABLE IF EXISTS `cm_tg_query_order_records`;
CREATE TABLE `cm_tg_query_order_records` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `order_no` char(40) NOT NULL COMMENT '查询的订单号',
  `tg_message_id` char(30) NOT NULL COMMENT '查单的消息ID',
  `tg_group_id` char(30) NOT NULL COMMENT '查单的群组ID',
  `success` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单成功 1是 0否',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33870 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_tg_statistics_group
-- ----------------------------
DROP TABLE IF EXISTS `cm_tg_statistics_group`;
CREATE TABLE `cm_tg_statistics_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_chat_id` char(20) NOT NULL COMMENT '群ID',
  `super_admin_chat_id` char(20) NOT NULL,
  `admin_chat_ids` text NOT NULL,
  `amount` decimal(11,2) NOT NULL,
  `rate` double(5,2) NOT NULL COMMENT '费率',
  `us_exchange_rate` double(5,2) NOT NULL COMMENT '美元汇率',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `rk_rate` double(5,2) NOT NULL COMMENT '入款费率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cm_tg_trading_house_data
-- ----------------------------
DROP TABLE IF EXISTS `cm_tg_trading_house_data`;
CREATE TABLE `cm_tg_trading_house_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `merchant_name` varchar(255) NOT NULL,
  `price_buy` decimal(10,2) NOT NULL,
  `pay_method` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cm_transaction
-- ----------------------------
DROP TABLE IF EXISTS `cm_transaction`;
CREATE TABLE `cm_transaction` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL COMMENT '商户id',
  `order_no` varchar(80) DEFAULT NULL COMMENT '交易订单号',
  `amount` decimal(12,3) DEFAULT NULL COMMENT '交易金额',
  `platform` tinyint(1) DEFAULT NULL COMMENT '交易平台:1-支付宝,2-微信',
  `platform_number` varchar(200) DEFAULT NULL COMMENT '交易平台交易流水号',
  `status` tinyint(1) DEFAULT NULL COMMENT '交易状态',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_index` (`order_no`,`platform`,`uid`,`amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易流水表';

-- ----------------------------
-- Table structure for cm_user
-- ----------------------------
DROP TABLE IF EXISTS `cm_user`;
CREATE TABLE `cm_user` (
  `uid` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '商户uid',
  `puid` mediumint(8) NOT NULL DEFAULT '0',
  `account` varchar(50) NOT NULL COMMENT '商户邮件',
  `username` varchar(30) NOT NULL COMMENT '商户名称',
  `auth_code` varchar(32) DEFAULT NULL COMMENT '8位安全码，注册时发送跟随邮件',
  `password` varchar(50) NOT NULL COMMENT '商户登录密码',
  `phone` varchar(250) NOT NULL COMMENT '手机号',
  `qq` varchar(250) NOT NULL COMMENT 'QQ',
  `is_agent` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '代理商',
  `is_verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '验证账号',
  `is_verify_phone` tinyint(1) NOT NULL DEFAULT '0' COMMENT '验证手机',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商户状态,0-未激活,1-使用中,2-禁用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_need_google_verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'æ¯å¦éè¦googleéªè¯ 0 ä¸éè¦  1 éè¦',
  `google_account` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'æ¯å¦éè¦googleéªè¯ 0 ä¸éè¦  1 éè¦',
  `auth_login_ips` varchar(255) NOT NULL DEFAULT '' COMMENT 'ç»å½é´æip',
  `is_verify_bankaccount` enum('1','0') NOT NULL DEFAULT '0' COMMENT '是否审核银行卡账户',
  `google_secret_key` varchar(100) NOT NULL DEFAULT '0' COMMENT 'googleç§é¥',
  `last_online_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后在线时间',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '·æåç»å½æ¶é´',
  `pao_ms_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '如果跑分出码对于码商的ids,逗号拼接',
  `is_can_df_from_index` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许前端发起代付0=》不允许 1=》允许',
  `mch_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '商户tg密钥',
  `tg_group_id` varchar(50) NOT NULL DEFAULT '' COMMENT '商户群组id',
  `mark_abnormal` int(10) DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_name_unique` (`account`,`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';

-- ----------------------------
-- Table structure for cm_user_account
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_account`;
CREATE TABLE `cm_user_account` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `bank_id` mediumint(8) NOT NULL DEFAULT '1' COMMENT '开户行(关联银行表)',
  `account` varchar(250) NOT NULL COMMENT '开户号',
  `address` varchar(250) NOT NULL COMMENT '开户所在地',
  `remarks` varchar(250) NOT NULL COMMENT '备注',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认账户,0-不默认,1-默认',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `account_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户结算账户表';

-- ----------------------------
-- Table structure for cm_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_auth`;
CREATE TABLE `cm_user_auth` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `realname` varchar(30) NOT NULL DEFAULT '1' COMMENT '开户行(关联银行表)',
  `sfznum` varchar(18) NOT NULL COMMENT '开户号',
  `card` text NOT NULL COMMENT '认证详情',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户认证信息表';

-- ----------------------------
-- Table structure for cm_user_daifuprofit
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_daifuprofit`;
CREATE TABLE `cm_user_daifuprofit` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `service_rate` decimal(4,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '费率',
  `service_charge` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔手续费',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户代付费率表';

-- ----------------------------
-- Table structure for cm_user_padmin
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_padmin`;
CREATE TABLE `cm_user_padmin` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '·ID',
  `p_admin_id` mediumint(8) NOT NULL COMMENT 'è·å¹³å°ç®¡çåid',
  `p_admin_appkey` varchar(255) NOT NULL DEFAULT '' COMMENT 'è·å¹³å°çç®¡çåappkeyç§é¥',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1æ­£å¸¸ 0ç¦æ­¢æä½',
  `create_time` int(10) unsigned NOT NULL COMMENT 'å»ºæ¶é´',
  `update_time` int(10) unsigned NOT NULL COMMENT 'æ´æ°æ¶é´',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_user_pay_code
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_pay_code`;
CREATE TABLE `cm_user_pay_code` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '·ID',
  `co_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'æ¯ä»pay_codeä¸»é®ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:å¼å¯ 0:å³é­',
  `create_time` int(10) unsigned NOT NULL COMMENT 'å»ºæ¶é´',
  `update_time` int(10) unsigned NOT NULL COMMENT 'æ´æ°æ¶é´',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='·æ¯ä»æ¸ éè¡¨å³èpay_code';

-- ----------------------------
-- Table structure for cm_user_pay_code_appoint
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_pay_code_appoint`;
CREATE TABLE `cm_user_pay_code_appoint` (
  `appoint_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) NOT NULL COMMENT '用户',
  `pay_code_id` int(11) NOT NULL COMMENT '支付代码',
  `cnl_id` int(11) NOT NULL COMMENT '指定渠道',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`appoint_id`),
  KEY `where` (`pay_code_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cm_user_profit
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_profit`;
CREATE TABLE `cm_user_profit` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `cnl_id` int(10) unsigned NOT NULL,
  `urate` decimal(4,3) unsigned NOT NULL DEFAULT '0.000',
  `grate` decimal(4,3) unsigned NOT NULL DEFAULT '0.000',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `single_handling_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔手续费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户分润表';
