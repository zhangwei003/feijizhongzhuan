/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : statistical_bot

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2023-01-12 14:50:36
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Records of cm_menu
-- ----------------------------
INSERT INTO `cm_menu` VALUES ('1', '0', '100', '控制台', 'admin', '/', '0', 'console', '1', '1544365211', '1539583897');
INSERT INTO `cm_menu` VALUES ('2', '0', '100', '系统设置', 'admin', 'Site', '0', 'set', '1', '1663831801', '1539583897');
INSERT INTO `cm_menu` VALUES ('3', '2', '100', '基本设置', 'admin', 'Site', '0', 'set-fill', '1', '1663831811', '1539583897');
INSERT INTO `cm_menu` VALUES ('4', '3', '100', '网站设置', 'admin', 'Site/website', '0', '', '1', '1663831847', '1539583897');
INSERT INTO `cm_menu` VALUES ('5', '3', '100', '邮件服务', 'admin', 'Site/email', '0', '', '1', '1663831823', '1539583897');
INSERT INTO `cm_menu` VALUES ('6', '3', '100', '行为日志', 'admin', 'Log/index', '0', 'flag', '1', '1540563678', '1540563678');
INSERT INTO `cm_menu` VALUES ('7', '6', '100', '获取日志列表', 'admin', 'Log/getList', '1', '', '1', '1540566783', '1540566783');
INSERT INTO `cm_menu` VALUES ('8', '6', '100', '删除日志', 'admin', 'Log/logDel', '1', '', '1', '1540566819', '1540566819');
INSERT INTO `cm_menu` VALUES ('9', '6', '100', '清空日志', 'admin', 'Log/logClean', '1', '', '1', '1540566849', '1540566849');
INSERT INTO `cm_menu` VALUES ('10', '2', '100', '权限设置', 'admin', 'Admin', '0', 'set-sm', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('11', '10', '100', '管理员设置', 'admin', 'Admin/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('12', '11', '100', '获取管理员列表', 'admin', 'Admin/userList', '1', 'user', '1', '1540485169', '1540484869');
INSERT INTO `cm_menu` VALUES ('13', '11', '100', '新增管理员', 'admin', 'Admin/userAdd', '1', 'user', '1', '1540485182', '1540485125');
INSERT INTO `cm_menu` VALUES ('14', '11', '100', '编辑管理员', 'admin', 'Admin/userEdit', '1', 'user', '1', '1540485199', '1540485155');
INSERT INTO `cm_menu` VALUES ('15', '11', '100', '删除管理员', 'admin', 'AdminuserDel', '1', 'user', '1', '1540485310', '1540485310');
INSERT INTO `cm_menu` VALUES ('16', '10', '100', '角色管理', 'admin', 'Admin/group', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('17', '16', '100', '获取角色列表', 'admin', 'Admin/groupList', '1', '', '1', '1540485432', '1540485432');
INSERT INTO `cm_menu` VALUES ('18', '16', '100', '新增权限组', 'admin', 'Admin/groupAdd', '1', '', '1', '1540485531', '1540485488');
INSERT INTO `cm_menu` VALUES ('19', '16', '100', '编辑权限组', 'admin', 'Admin/groupEdit', '1', '', '1', '1540485515', '1540485515');
INSERT INTO `cm_menu` VALUES ('20', '16', '100', '删除权限组', 'admin', 'Admin/groupDel', '1', '', '1', '1540485570', '1540485570');
INSERT INTO `cm_menu` VALUES ('21', '10', '100', '菜单管理', 'admin', 'Menu/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('22', '21', '100', '获取菜单列表', 'admin', 'Menu/getList', '1', '', '1', '1540485652', '1540485632');
INSERT INTO `cm_menu` VALUES ('23', '21', '100', '新增菜单', 'admin', 'Menu/menuAdd', '1', '', '1', '1540534094', '1540534094');
INSERT INTO `cm_menu` VALUES ('24', '21', '100', '编辑菜单', 'admin', 'Menu/menuEdit', '1', '', '1', '1540534133', '1540534133');
INSERT INTO `cm_menu` VALUES ('25', '21', '100', '删除菜单', 'admin', 'Menu/menuDel', '1', '', '1', '1540534133', '1540534133');
INSERT INTO `cm_menu` VALUES ('26', '2', '100', '我的设置', 'admin', 'Admin/profile', '0', '', '1', '1540486245', '1539583897');
INSERT INTO `cm_menu` VALUES ('27', '26', '100', '基本资料', 'admin', 'Site/profile', '0', '', '1', '1663831867', '1539583897');
INSERT INTO `cm_menu` VALUES ('28', '26', '100', '修改密码', 'admin', 'Site/changePwd', '0', '', '1', '1663831887', '1539583897');
INSERT INTO `cm_menu` VALUES ('29', '0', '100', '支付设置', 'admin', 'Pay', '0', 'senior', '1', '1540483267', '1539583897');
INSERT INTO `cm_menu` VALUES ('30', '29', '100', '支付产品', 'admin', 'Pay/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('31', '30', '100', '获取支付产品列表', 'admin', 'Pay/getCodeList', '1', '', '1', '1545461560', '1545458869');
INSERT INTO `cm_menu` VALUES ('32', '30', '100', '新增支付产品', 'admin', 'Pay/addCode', '1', '', '1', '1545461705', '1545458888');
INSERT INTO `cm_menu` VALUES ('33', '30', '100', '编辑支付产品', 'admin', 'Pay/editCode', '1', '', '1', '1545461713', '1545458915');
INSERT INTO `cm_menu` VALUES ('34', '30', '100', '删除产品', 'admin', 'Pay/delCode', '1', '', '1', '1545461745', '1545458935');
INSERT INTO `cm_menu` VALUES ('35', '29', '100', '支付渠道', 'admin', 'Pay/channel', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('36', '35', '100', '获取渠道列表', 'admin', 'Pay/getChannelList', '1', '', '1', '1545461798', '1545458953');
INSERT INTO `cm_menu` VALUES ('37', '35', '100', '新增渠道', 'admin', 'Pay/addChannel', '1', '', '1', '1545461856', '1545458977');
INSERT INTO `cm_menu` VALUES ('38', '35', '100', '编辑渠道', 'admin', 'Pay/editChannel', '1', '', '1', '1545461863', '1545458992');
INSERT INTO `cm_menu` VALUES ('39', '35', '100', '删除渠道', 'admin', 'Pay/delChannel', '1', '', '1', '1545461870', '1545459004');
INSERT INTO `cm_menu` VALUES ('40', '29', '100', '渠道账户', 'admin', 'Pay/account', '0', '', '-1', '1667587295', '1545459058');
INSERT INTO `cm_menu` VALUES ('41', '40', '100', '获取渠道账户列表', 'admin', 'Pay/getAccountList', '1', '', '-1', '1667587657', '1545459152');
INSERT INTO `cm_menu` VALUES ('42', '40', '100', '新增账户', 'admin', 'Pay/addAccount', '1', '', '-1', '1667587652', '1545459180');
INSERT INTO `cm_menu` VALUES ('43', '40', '100', '编辑账户', 'admin', 'Pay/editAccount', '1', '', '-1', '1667587650', '1545459194');
INSERT INTO `cm_menu` VALUES ('44', '40', '100', '删除账户', 'admin', 'Pay/delAccount', '1', '', '-1', '1667587643', '1545459205');
INSERT INTO `cm_menu` VALUES ('45', '29', '100', '银行管理', 'admin', 'Pay/bank', '0', '', '1', '1540822566', '1540822549');
INSERT INTO `cm_menu` VALUES ('46', '45', '100', '获取银行列表', 'admin', 'Pay/getBankList', '1', '', '1', '1545462167', '1545459107');
INSERT INTO `cm_menu` VALUES ('47', '45', '100', '新增银行', 'admin', 'Pay/addBank', '1', '', '1', '1545462178', '1545459243');
INSERT INTO `cm_menu` VALUES ('48', '45', '100', '编辑银行', 'admin', 'Pay/editBank', '1', '', '1', '1545462220', '1545459262');
INSERT INTO `cm_menu` VALUES ('49', '45', '100', '删除银行', 'admin', 'Pay/delBank', '1', '', '1', '1545462230', '1545459277');
INSERT INTO `cm_menu` VALUES ('50', '0', '100', '内容管理', 'admin', 'Article', '0', 'template', '-1', '1666788045', '1539583897');
INSERT INTO `cm_menu` VALUES ('51', '50', '100', '文章管理', 'admin', 'Article/index', '0', '', '-1', '1666788037', '1539583897');
INSERT INTO `cm_menu` VALUES ('52', '51', '100', '获取文章列表', 'admin', 'Article/getList', '1', 'lis', '-1', '1667587272', '1540484939');
INSERT INTO `cm_menu` VALUES ('53', '51', '100', '新增文章', 'admin', 'Article/add', '1', '', '-1', '1667587269', '1540486058');
INSERT INTO `cm_menu` VALUES ('54', '51', '100', '编辑文章', 'admin', 'Article/edit', '1', '', '-1', '1667587263', '1540486097');
INSERT INTO `cm_menu` VALUES ('55', '51', '100', '删除文章', 'admin', 'Article/del', '1', '', '-1', '1667587265', '1545459431');
INSERT INTO `cm_menu` VALUES ('56', '50', '100', '公告管理', 'admin', 'Article/notice', '0', '', '-1', '1666788041', '1539583897');
INSERT INTO `cm_menu` VALUES ('57', '56', '100', '获取公告列表', 'admin', 'Article/getNoticeList', '1', '', '-1', '1667587260', '1545459334');
INSERT INTO `cm_menu` VALUES ('58', '56', '100', '新增公告', 'admin', 'Article/addNotice', '1', '', '-1', '1667587257', '1545459346');
INSERT INTO `cm_menu` VALUES ('59', '56', '100', '编辑公告', 'admin', 'Article/editNotice', '1', '', '-1', '1667587254', '1545459368');
INSERT INTO `cm_menu` VALUES ('60', '56', '100', '删除公告', 'admin', 'Article/delNotice', '1', '', '-1', '1667587251', '1545459385');
INSERT INTO `cm_menu` VALUES ('61', '0', '100', '商户管理', 'admin', 'User', '0', 'user', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('62', '61', '100', '商户列表', 'admin', 'User/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('63', '62', '100', '获取商户列表', 'admin', 'User/getList', '1', '', '1', '1540486400', '1540486400');
INSERT INTO `cm_menu` VALUES ('64', '62', '100', '新增商户', 'admin', 'User/add', '1', '', '1', '1540533973', '1540533973');
INSERT INTO `cm_menu` VALUES ('65', '62', '100', '商户修改', 'admin', 'User/edit', '1', '', '1', '1540533993', '1540533993');
INSERT INTO `cm_menu` VALUES ('66', '62', '100', '删除商户', 'admin', 'User/del', '1', '', '1', '1545462902', '1545459408');
INSERT INTO `cm_menu` VALUES ('67', '61', '100', '提现记录', 'admin', 'Balance/paid', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('68', '67', '100', '获取提现记录', 'admin', 'Balance/paidList', '1', '', '1', '1545462677', '1545458822');
INSERT INTO `cm_menu` VALUES ('69', '67', '100', '提现编辑', 'admin', 'Balance/editPaid', '1', '', '1', '1545462708', '1545458822');
INSERT INTO `cm_menu` VALUES ('70', '67', '100', '提现删除', 'admin', 'Balance/delPaid', '1', '', '1', '1545462715', '1545458822');
INSERT INTO `cm_menu` VALUES ('71', '61', '100', '商户账户', 'admin', 'Account/index', '0', '', '-1', '1667587320', '1539583897');
INSERT INTO `cm_menu` VALUES ('80', '71', '100', '商户账户列表', 'admin', 'Account/getList', '1', '', '-1', '1667587638', '1545459501');
INSERT INTO `cm_menu` VALUES ('81', '71', '100', '新增商户账户', 'admin', 'Account/add', '1', '', '-1', '1667587636', '1545459501');
INSERT INTO `cm_menu` VALUES ('82', '71', '100', '编辑商户账户', 'admin', 'Account/edit', '1', '', '-1', '1667587633', '1545459501');
INSERT INTO `cm_menu` VALUES ('83', '71', '100', '删除商户账户', 'admin', 'Account/del', '1', '', '-1', '1667587631', '1545459501');
INSERT INTO `cm_menu` VALUES ('84', '61', '100', '商户资金', 'admin', 'Balance/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('85', '84', '100', '商户资金列表', 'admin', 'Balance/getList', '1', '', '1', '1545462951', '1545459501');
INSERT INTO `cm_menu` VALUES ('86', '84', '100', '商户资金明细', 'admin', 'Balance/details', '1', '', '1', '1545462997', '1545459501');
INSERT INTO `cm_menu` VALUES ('87', '84', '100', '获取商户资金明细', 'admin', 'Balance/getDetails', '1', '', '1', '1545462997', '1545459501');
INSERT INTO `cm_menu` VALUES ('88', '61', '100', '商户API', 'admin', 'Api/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('89', '87', '100', '商户API列表', 'admin', 'Api/getList', '1', '', '1', '1545463054', '1545459501');
INSERT INTO `cm_menu` VALUES ('90', '87', '100', '编辑商户API', 'admin', 'Api/edit', '1', '', '1', '1545463065', '1545459501');
INSERT INTO `cm_menu` VALUES ('91', '61', '100', '商户认证', 'admin', 'User/auth', '0', '', '-1', '1667587801', '1542882201');
INSERT INTO `cm_menu` VALUES ('92', '90', '100', '商户认证列表', 'admin', 'getlist', '1', '', '1', '1545459501', '1545459501');
INSERT INTO `cm_menu` VALUES ('93', '90', '100', '编辑商户认证', 'admin', 'getlist', '1', '', '1', '1545459501', '1545459501');
INSERT INTO `cm_menu` VALUES ('94', '0', '100', '订单管理', 'admin', 'Orders', '0', 'form', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('95', '94', '100', '交易列表', 'admin', 'Orders/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('96', '95', '100', '获取交易列表', 'admin', 'Orders/getList', '1', '', '1', '1545463214', '1539583897');
INSERT INTO `cm_menu` VALUES ('97', '94', '100', '交易详情', 'admin', 'Orders/details', '1', '', '1', '1545463268', '1545459549');
INSERT INTO `cm_menu` VALUES ('98', '94', '100', '退款列表', 'admin', 'Orders/refund', '0', '', '-1', '1667587969', '1539583897');
INSERT INTO `cm_menu` VALUES ('99', '94', '100', '商户统计', 'admin', 'Orders/user', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('100', '99', '100', '获取商户统计', 'admin', 'Orders/userList', '1', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('101', '94', '100', '渠道统计', 'admin', 'Orders/channel', '0', '', '-1', '1667589056', '1539583897');
INSERT INTO `cm_menu` VALUES ('102', '101', '100', '获取渠道统计', 'admin', 'Orders/channelList', '1', '', '-1', '1667589114', '1539583897');
INSERT INTO `cm_menu` VALUES ('103', '61', '100', '商户统计', 'admin', 'User/cal', '0', '', '1', '1667587837', '1581872080');
INSERT INTO `cm_menu` VALUES ('104', '61', '100', '商户资金记录', 'admin', 'Balance/change', '0', '', '-1', '1667587808', '1583999358');
INSERT INTO `cm_menu` VALUES ('105', '0', '100', '代付管理', 'admin', 'DaifuOrders', '0', 'form', '1', '1667587616', '1581082458');
INSERT INTO `cm_menu` VALUES ('111', '105', '100', '订单列表', 'admin', 'DaifuOrders/index', '0', '', '1', '1581082501', '1581082501');
INSERT INTO `cm_menu` VALUES ('113', '105', '100', '充值银行卡', 'admin', 'DaifuOrders/depositecard', '0', '', '-1', '1667587602', '1585315597');
INSERT INTO `cm_menu` VALUES ('114', '105', '100', '充值列表', 'admin', 'deposite_order/index', '0', '', '-1', '1667587605', '1585329451');
INSERT INTO `cm_menu` VALUES ('115', '94', '100', '渠道资金', 'admin', 'Channel/fundIndex', '0', '', '-1', '1667589059', '1587199882');
INSERT INTO `cm_menu` VALUES ('116', '2', '100', '代付设置', 'admin', 'daifu_orders/setting', '0', '', '1', '1588083379', '1588083251');
INSERT INTO `cm_menu` VALUES ('117', '0', '100', '码商管理', 'admin', 'Ms', '0', 'senior', '1', '1540483267', '1539583897');
INSERT INTO `cm_menu` VALUES ('118', '117', '100', '码商列表', 'admin', 'Ms/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('121', '152', '100', '卡卡列表', 'admin', 'Ms/payCodes', '0', '', '1', '1667589553', '0');
INSERT INTO `cm_menu` VALUES ('125', '152', '100', '卡卡订单', 'admin', 'Ms/orders', '0', '', '1', '1667589450', '1539584897');
INSERT INTO `cm_menu` VALUES ('126', '117', '100', '码商流水', 'admin', 'Ms/bills', '0', '', '-1', '1667588043', '1539584897');
INSERT INTO `cm_menu` VALUES ('127', '62', '100', '商户余额', 'admin', 'balance/changeList', '1', '', '1', '1646069652', '1646069652');
INSERT INTO `cm_menu` VALUES ('128', '117', '100', '码商列表2', 'admin', 'ms/getmslist', '1', '', '1', '1646069778', '1646069778');
INSERT INTO `cm_menu` VALUES ('129', '117', '100', '获取二维码了表', 'admin', 'ms/getPaycodesLists', '1', '', '1', '1646069908', '1646069908');
INSERT INTO `cm_menu` VALUES ('130', '117', '100', '获取订单列表', 'admin', 'ms/getOrdersList', '1', '', '1', '1646069976', '1646069976');
INSERT INTO `cm_menu` VALUES ('131', '117', '100', '获取码商流水', 'admin', 'ms/getBillsList', '1', '', '1', '1646070033', '1646070033');
INSERT INTO `cm_menu` VALUES ('132', '67', '100', '提现详情', 'admin', 'balance/details_tixian', '1', '', '1', '1646070236', '1646070236');
INSERT INTO `cm_menu` VALUES ('133', '67', '100', '处理提现', 'admin', 'balance/deal', '1', '', '1', '1646070403', '1646070403');
INSERT INTO `cm_menu` VALUES ('134', '117', '100', '编辑码商', 'admin', 'ms/edit', '1', '', '1', '1646070586', '1646070586');
INSERT INTO `cm_menu` VALUES ('135', '2', '100', '确认命令', 'admin', 'api/checkOpCommand', '0', '', '1', '1658660543', '1646070809');
INSERT INTO `cm_menu` VALUES ('136', '117', '100', '确认订单', 'admin', 'ms/issueOrder', '1', '', '1', '1646070895', '1646070895');
INSERT INTO `cm_menu` VALUES ('137', '94', '100', '补单', 'admin', 'orders/budanDetails', '1', '', '1', '1646071307', '1646071307');
INSERT INTO `cm_menu` VALUES ('138', '94', '100', '补单发送', 'admin', 'orders/update', '1', '', '1', '1646071417', '1646071417');
INSERT INTO `cm_menu` VALUES ('139', '94', '100', '补发通知', 'admin', 'orders/subnotify', '1', '', '1', '1646071466', '1646071466');
INSERT INTO `cm_menu` VALUES ('140', '117', '100', '操作流水', 'admin', 'ms/changeBalance', '1', '', '1', '1646136901', '1646136901');
INSERT INTO `cm_menu` VALUES ('141', '62', '100', '商户列表2', 'admin', 'user/getList', '1', '', '1', '1646137050', '1646137050');
INSERT INTO `cm_menu` VALUES ('142', '62', '100', '增减商户资金', 'admin', 'balance/changeBalance', '1', '', '1', '1646148840', '1646148840');
INSERT INTO `cm_menu` VALUES ('143', '117', '100', '异常订单', 'admin', 'Ms/abnormalOrders', '0', '', '-1', '1667588104', '1657521636');
INSERT INTO `cm_menu` VALUES ('144', '105', '100', '获取代付订单列表', 'admin', 'DaifuOrders/getOrdersList', '1', '', '1', '1660748092', '1660747004');
INSERT INTO `cm_menu` VALUES ('145', '105', '100', '代付订单导出', 'admin', 'DaifuOrders/exportOrder', '1', '', '1', '1661027103', '1661027103');
INSERT INTO `cm_menu` VALUES ('146', '94', '100', '导出订单列表', 'admin', 'Orders/exportOrder', '1', '', '1', '1661027277', '1661027277');
INSERT INTO `cm_menu` VALUES ('147', '61', '100', '导出商户资金列表', 'admin', 'Balance/exportBalance', '1', '', '1', '1661156354', '1661027453');
INSERT INTO `cm_menu` VALUES ('148', '117', '100', '导出码商订单', 'admin', 'ms/exportOrder', '1', '', '1', '1661155160', '1661155160');
INSERT INTO `cm_menu` VALUES ('149', '67', '100', '导出提现记录', 'admin', 'Balance/exportBalanceCash', '1', '', '1', '1661351933', '1661156604');
INSERT INTO `cm_menu` VALUES ('150', '84', '100', '导出商户资金', 'admin', 'balance/exportBalanceChange', '1', '', '1', '1661157427', '1661157427');
INSERT INTO `cm_menu` VALUES ('151', '117', '100', '导出码商流水', 'admin', 'ms/exportMsBills', '1', '', '1', '1662285094', '1662285094');
INSERT INTO `cm_menu` VALUES ('152', '0', '100', '卡转卡', 'admin', 'kzk', '0', '', '1', '1667589143', '1667589143');
