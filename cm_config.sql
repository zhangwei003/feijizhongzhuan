/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : statistical_bot

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2023-01-12 14:52:10
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Records of cm_config
-- ----------------------------
INSERT INTO `cm_config` VALUES ('1', 'seo_title', '网站标题', '1', '1', '0', '三方', '', '', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('8', 'email_port', 'SMTP端口号', '1', '8', '1', '2', '1:25,2:465', '如：一般为 25 或 465', '1', '1378898976', '1545131349');
INSERT INTO `cm_config` VALUES ('2', 'seo_description', '网站描述', '2', '3', '0', '', '', '网站搜索引擎描述，优先级低于SEO模块', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('3', 'seo_keywords', '网站关键字', '2', '4', '0', '三方', '', '网站搜索引擎关键字，优先级低于SEO模块', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('4', 'app_index_title', '首页标题', '1', '2', '0', '三方', '', '', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('5', 'app_domain', '网站域名', '1', '5', '0', '', '', '网站域名', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('6', 'app_copyright', '版权信息', '2', '6', '0', '三方', '', '版权信息', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('7', 'email_host', 'SMTP服务器', '3', '7', '1', '2', '1:smtp.163.com,2:smtp.aliyun.com,3:smtp.qq.com', '如：smtp.163.com', '1', '1378898976', '1569507595');
INSERT INTO `cm_config` VALUES ('9', 'send_email', '发件人邮箱', '1', '9', '1', '12345@qq.com', '', '', '1', '1378898976', '1569507595');
INSERT INTO `cm_config` VALUES ('10', 'send_nickname', '发件人昵称', '1', '10', '1', '', '', '', '1', '1378898976', '1569507595');
INSERT INTO `cm_config` VALUES ('11', 'email_password', '邮箱密码', '1', '11', '1', 'xxxxxx', '', '', '1', '1378898976', '1569507595');
INSERT INTO `cm_config` VALUES ('12', 'rsa_public_key', '平台数据公钥', '2', '6', '0', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxV1hB4NP1NFgEM0mrx34z8gJMPBIhvDjAJcnMozk3jmUY9PkB7lZyfD6Fb+Xq21jIPX5zF4ggeYoK5keUH6TW9eJEr5JOqDl2YgKAdLfxLuJ4r8X1S3wflVp2/BURIbP1VGh6qNAxS3o8miL7x5BZ+jOhs4/LCq8YkncZioui5eAQ+/BoE++uM5IeSWZEVf8JsGo+MrOG2E/eOqetrB08Tm68igM6OMbKr05HKupcZm63zzDIHRJGKRjvdFjVoVznGsAC3phyh3bzYrjxykH00mLyw39/77MiBMp/uWVMh6wwiAjY2B25IKXXGCd0JSYvlpJWtCKbxlcAGDWSWkS0wIDAQAB', '', '平台数据公钥（RSA 2048）', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('13', 'rsa_private_key', '平台数据私钥', '2', '6', '0', 'MIIEpAIBAAKCAQEAxV1hB4NP1NFgEM0mrx34z8gJMPBIhvDjAJcnMozk3jmUY9PkB7lZyfD6Fb+Xq21jIPX5zF4ggeYoK5keUH6TW9eJEr5JOqDl2YgKAdLfxLuJ4r8X1S3wflVp2/BURIbP1VGh6qNAxS3o8miL7x5BZ+jOhs4/LCq8YkncZioui5eAQ+/BoE++uM5IeSWZEVf8JsGo+MrOG2E/eOqetrB08Tm68igM6OMbKr05HKupcZm63zzDIHRJGKRjvdFjVoVznGsAC3phyh3bzYrjxykH00mLyw39/77MiBMp/uWVMh6wwiAjY2B25IKXXGCd0JSYvlpJWtCKbxlcAGDWSWkS0wIDAQABAoIBAFeeoB/8vOlHVrW+zii6Tqa4MNRoKFq4AJ9Xe5BmmojJ2UYEYNzI/cK4V95l44i4lGSirxZ6x0XEDxtj6+BigTsp0fHfRpVfrwtG6OJsYultNMbUfVkn/venJcr9w/t0OjqC9jY76dpgCmXr4gvzS6g848tXLxaFloKwNcepfGZ9wQb8Kt+5ONzn3BUcczu4DhuWfkt6oQ4j1KPl0UIdLZ7tevG1guUUr15p6VGsvQtMh4U7Lct/+0XUp4chut6fvoAIbEHnAE8rkAZBjrICwsYKNANNBEgVhtn5sK12RVZdUEd3vBWry9YOk1dgsEmi+chqQFlD18bO5/phIXEpK4kCgYEA7mugHzBcr53tSJVwh4IkyXQOs+gW5wSqbjHhTafN29w4qOJ9ZAxELogz4gQ25Yn95l1gpOY0cyH5x6QHsPFuJJBJp9sEiGplYSsCalK1qJaQewvAMd1Ctqk5A67QHgE/4xh+id9l+e1a9SKNqg3X3X1QdLddzwoq0i1Oj407KnUCgYEA0+rLqcJC0swSIchWpWLKQ/kgu093CXVvDoTugWPuHi4Ua49/9nPv0zSjMX5GXzGZ7CAQca/Gwg24R6bvc8wgwe9OYf8/ILQ3XUHmZJIHMXD/HuZqBMn/Swu62MJalOYTOsKp4hxNvxJkZPpku6gr5C611LaOsbE6iQDyeqmtzycCgYAeVGClNxDDYnK6BhCvnFWzrujj6AVp1AUeSYggydT9QBGRImbTIGBYDwmSmfil0J0U/hH6SDKp5suQowQ7dSsOybAlA06bT/Wfm8oN3oGvdZ/hl0gWz8/ZzsMq/cUJ3BzVdds7DMk7Nv+YKZId7O7mBTgD8QOk/+UcoZjZ2ByLtQKBgQCPP99OMJfVQMdc+LzBbWdGzYf3tj7EMRLSYL+MzY0v73w0PTuF0FckkSdjlHVjcfcXa5FSGD0l/fo8zTZ+M1VNY0O78LuuksP+EUb5YtDj9fsu2xh9hkJBa3txfOeYUXJcPSxzQSi46Wjd7XjcdVC+HWkikgkhSqlD5VUD3+Ey7wKBgQDtarpiVV19/IWiRbKy7rKJcG1HnezqfoA7outJK6yG7ne1vTjkGD/BLTSJm032htPFRmrwxhDOz0EilCjCz+ID2iPWKzhiZpf5yZ/qoFrFdofNWhLyAzNzxDhAZbcVG6ebjkMfHj84sChenGk31HfuplMD0GBe8DlC7UGerxCu1A==', '', '平台数据私钥（RSA 2048）', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('16', 'logo', 'ç«ç¹LOGO', '4', '6', '0', '', '', 'ä¸ä¼ ç«ç¹logo', '1', '1378898976', '1576391324');
INSERT INTO `cm_config` VALUES ('14', 'withdraw_fee', '提现手续费', '1', '6', '0', '5', '', '提现手续费', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('15', 'thrid_url_gumapay', 'åºå®ç è¯·æ±å°å', '1', '6', '0', '/index.php', '', 'åºå®ç ç¬¬ä¸æ¹apiè¯·æ±å°å', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('18', 'auth_key', 'éä¿¡ç§é¥', '1', '7', '0', 'XforgXQl2746FBIT', '', 'ä¸è·å¹³å°éä¿¡ç§é¥', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('19', 'four_noticy_time', '四方通知时间', '1', '8', '0', '201', '', '四方码商回调通知时间(单位分钟)', '1', '1378898976', '1585677353');
INSERT INTO `cm_config` VALUES ('20', 'max_withdraw_limit', '提现最大金额', '0', '0', '0', '600000000', '', '', '1', '0', '1585677353');
INSERT INTO `cm_config` VALUES ('21', 'min_withdraw_limit', '提现最小金额', '0', '0', '0', '99', '', '', '1', '0', '1585677353');
INSERT INTO `cm_config` VALUES ('22', 'balance_cash_type', '提现申请类型', '3', '0', '0', '2', '1:选择账号,2:手动填写账号', '', '1', '0', '1585677353');
INSERT INTO `cm_config` VALUES ('23', 'request_pay_type', '发起支付订单类型', '3', '0', '0', '2', '1:平台订单号,2:下游订单号', '', '1', '0', '1584606747');
INSERT INTO `cm_config` VALUES ('24', 'notify_ip', '回调ip', '0', '54', '0', '', '', '', '1', '0', '1585677353');
INSERT INTO `cm_config` VALUES ('25', 'is_single_handling_charge', '是否开启单笔手续费', '3', '51', '0', '1', '1:开启,0:不开启', '', '1', '0', '1585677353');
INSERT INTO `cm_config` VALUES ('26', 'whether_open_daifu', '是否开启代付', '3', '50', '0', '1', '1:开启,2:不开启', '', '1', '0', '1585677353');
INSERT INTO `cm_config` VALUES ('27', 'index_view_path', '前台模板', '3', '0', '0', 'view', 'view:默认,baisha:白沙,view1:版本2', '', '1', '0', '1585833746');
INSERT INTO `cm_config` VALUES ('28', 'is_open_channel_fund', '渠道资金是否开启', '3', '0', '0', '0', '0:关闭,1:开启', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('29', 'is_paid_select_channel', '提现审核选择渠道', '3', '0', '0', '1', '0:不选择,1:选择', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('30', 'balance_cash_adminlist', '提现列表url', '0', '0', '0', '/api/withdraw/getAdminList', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('31', 'balance_cash_revocation', '提现撤回url', '0', '0', '0', '/api/withdraw/revocation', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('32', 'daifu_notify_ip', '代付回调ip白名单', '1', '0', '0', '127.0.0.1', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('33', 'daifu_host', '代付接口地址', '1', '0', '0', '', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('34', 'daifu_key', '跑分密钥', '1', '0', '0', '3e9c1885afa5920909f9b9aa2907cf19', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('35', 'daifu_notify_url', '回调地址', '1', '0', '0', '', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('36', 'transfer_ip_list', '中转ip白名单', '2', '0', '0', '127.0.0.1', '', '多个使用逗号隔开', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('37', 'proxy_debug', '是否开启中转回调', '3', '0', '0', '1', '1:开启,0:不开启', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('38', 'orginal_host', '中转回调地址', '0', '0', '0', 'http://68.178.164.187:89/index.php', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('39', 'daifu_admin_id', '代付admin_id', '1', '0', '0', '5', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('40', 'is_channel_statistics', '是否开启渠道统计', '3', '0', '0', '0', '1:开启,0:不开启', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('41', 'admin_view_path', '后台模板', '3', '0', '0', 'view', 'view:默认,baisha:白沙', '', '1', '0', '1585833746');
INSERT INTO `cm_config` VALUES ('42', 'index_domain_white_list', '前台域名白名单', '1', '0', '0', '', '', '如https://www.baidu.com/ 请输入www.baidu.com', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('43', 'pay_domain_white_list', '下单域名白名单', '0', '0', '0', '', '', '如https://www.baidu.com/ 请输入www.baidu.com', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('44', 'admin_domain_white_list', '后台域名白名单', '0', '0', '0', '', '', '如https://www.baidu.com/ 请输入www.baidu.com', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('1111', 'global_tgbot_token', '全 局机器人token唯一标识', '1', '0', '0', '1673522495:AAE6-JDXf3z5ZSk7pFoLkwR6XYzkv_jMg_g', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('1112', 'tg_order_warning_robot_token', '订单报警机器人token', '0', '0', '0', '1673522495:AAE6-JDXf3z5ZSk7pFoLkwR6XYzkv_jMg_g', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('1113', 'tg_order_warning_rebot_in_chat', '订单机器人所在群组', '0', '0', '0', '-449166252', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('1114', 'withdraw_usdt_rate', 'ustd下发手续费', '1', '6', '0', '0', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('1115', 'daifu_ms_id', '代付码商ID', '1', '0', '0', '', '', '', '1', '1657884061', '1657884061');
INSERT INTO `cm_config` VALUES ('1116', 'daifu_tgbot_token', '代付机器人token', '1', '0', '0', '5488115037:AAHCWwtjhGtj3ZcrYUTD4815pAPjtOk2bvc', '', '', '1', '1660383105', '1660383105');
INSERT INTO `cm_config` VALUES ('1117', 'daifu_min_amount', '代付最小金额', '1', '0', '0', '1', '', '', '1', '1661930871', '1661930871');
INSERT INTO `cm_config` VALUES ('1118', 'daifu_max_amount', '代付最大金额', '1', '0', '0', '500000', '', '', '1', '1661930895', '1661930895');
INSERT INTO `cm_config` VALUES ('1120', 'daifu_err_reason', '代付失败原因', '6', '0', '3', '收款账户与户名不符,收款卡问题请更换卡再提交,支付中断,转账失败,收款方账户异常,银行维护,手机号对应多个绑定支付宝,收款账号未实名,收款账号收到支付宝风控', '', '', '1', '0', '0');
INSERT INTO `cm_config` VALUES ('1121', 'thrid_url_uid', 'UID中转地址', '1', '6', '0', '/index.php', '', 'UID中转地址', '1', '1378898976', '1378898976');
