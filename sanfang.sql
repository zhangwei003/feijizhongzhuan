/*
Navicat MySQL Data Transfer

Source Server         : 120.53.107.54sanfang
Source Server Version : 50650
Source Host           : 120.53.107.54:3306
Source Database       : sanfang

Target Server Type    : MYSQL
Target Server Version : 50650
File Encoding         : 65001

Date: 2022-11-07 02:15:59
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
) ENGINE=InnoDB AUTO_INCREMENT=286102 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='行为日志表';

-- ----------------------------
-- Records of cm_action_log
-- ----------------------------
INSERT INTO `cm_action_log` VALUES ('285999', '1', 'admin', '新增', '新增菜单,name =>支付宝UID', '/admin/menu/menuAdd', '127.0.0.1', '1', '1667630719', '1667630719');
INSERT INTO `cm_action_log` VALUES ('286000', '1', 'admin', '编辑', '编辑菜单,name =>支付宝UID', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667630811', '1667630811');
INSERT INTO `cm_action_log` VALUES ('286001', '1', 'admin', '新增', '新增菜单,name =>支付宝uid订单', '/admin/menu/menuAdd', '127.0.0.1', '1', '1667630857', '1667630857');
INSERT INTO `cm_action_log` VALUES ('286002', '1', 'admin', '编辑', '编辑菜单,name =>支付宝uid订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667630875', '1667630875');
INSERT INTO `cm_action_log` VALUES ('286003', '1', 'admin', '编辑', '编辑菜单,name =>支付宝uid订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667630875', '1667630875');
INSERT INTO `cm_action_log` VALUES ('286004', '1', 'admin', '编辑', '编辑菜单,name =>支付宝uid订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667630876', '1667630876');
INSERT INTO `cm_action_log` VALUES ('286005', '1', 'admin', '编辑', '编辑菜单,name =>支付宝uid订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667630876', '1667630876');
INSERT INTO `cm_action_log` VALUES ('286006', '1', 'admin', '编辑', '编辑菜单,name =>支付宝uid订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667630876', '1667630876');
INSERT INTO `cm_action_log` VALUES ('286007', '1', 'admin', '新增', '新增菜单,name =>支付宝Uid列表', '/admin/menu/menuAdd', '127.0.0.1', '1', '1667630938', '1667630938');
INSERT INTO `cm_action_log` VALUES ('286008', '1', 'admin', '编辑', '编辑菜单,name =>支付宝uid订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667631012', '1667631012');
INSERT INTO `cm_action_log` VALUES ('286009', '1', 'admin', '删除', '删除菜单,where:id=154', '/admin/menu/menuDel?id=154', '127.0.0.1', '1', '1667631131', '1667631131');
INSERT INTO `cm_action_log` VALUES ('286010', '1', 'admin', '新增', '新增菜单,name =>支付宝UID订单', '/admin/menu/menuAdd', '127.0.0.1', '1', '1667631244', '1667631244');
INSERT INTO `cm_action_log` VALUES ('286011', '1', 'admin', '编辑', '编辑菜单,name =>支付宝Uid列表', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667631265', '1667631265');
INSERT INTO `cm_action_log` VALUES ('286012', '1', 'admin', '编辑', '编辑菜单,name =>支付宝Uid列表', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667631380', '1667631380');
INSERT INTO `cm_action_log` VALUES ('286013', '1', 'admin', '编辑', '编辑菜单,name =>支付宝UID订单', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667631395', '1667631395');
INSERT INTO `cm_action_log` VALUES ('286014', '1', 'admin', '编辑', '编辑菜单,name =>支付宝Uid列表', '/admin/menu/menuEdit', '127.0.0.1', '1', '1667631415', '1667631415');
INSERT INTO `cm_action_log` VALUES ('286015', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667634509', '1667634509');
INSERT INTO `cm_action_log` VALUES ('286016', '1', 'admin', '新增', '新增商户。UID:100281', '/admin/user/add', '123.139.47.174', '1', '1667634546', '1667634546');
INSERT INTO `cm_action_log` VALUES ('286017', '1', 'admin', '新增', '新增管理员信息，admin001', '/admin/admin/userAdd', '123.139.47.174', '1', '1667642968', '1667642968');
INSERT INTO `cm_action_log` VALUES ('286018', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667642984', '1667642984');
INSERT INTO `cm_action_log` VALUES ('286019', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667642995', '1667642995');
INSERT INTO `cm_action_log` VALUES ('286020', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667643006', '1667643006');
INSERT INTO `cm_action_log` VALUES ('286021', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667643016', '1667643016');
INSERT INTO `cm_action_log` VALUES ('286022', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667643037', '1667643037');
INSERT INTO `cm_action_log` VALUES ('286023', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667643066', '1667643066');
INSERT INTO `cm_action_log` VALUES ('286024', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667648262', '1667648262');
INSERT INTO `cm_action_log` VALUES ('286025', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667648283', '1667648283');
INSERT INTO `cm_action_log` VALUES ('286026', '1', 'admin', '新增', '支付方式,data:name=%E6%94%AF%E4%BB%98%E5%AE%9DUID&code=alipayUid&status=1&remarks=%E6%94%AF%E4%BB%98%E5%AE%9DUID&cnl_id=', '/admin/pay/addCode', '123.139.47.174', '1', '1667648335', '1667648335');
INSERT INTO `cm_action_log` VALUES ('286027', '1', 'admin', '新增', '支付渠道支付宝UID', '/admin/pay/addChannel', '123.139.47.174', '1', '1667648360', '1667648360');
INSERT INTO `cm_action_log` VALUES ('286028', '1', 'admin', '新增', '支付渠道账户,支付宝UID', '/admin/pay/addAccount', '123.139.47.174', '1', '1667648386', '1667648386');
INSERT INTO `cm_action_log` VALUES ('286029', '1', 'admin', '编辑', '支付方式,data:id=31&name=%E6%94%AF%E4%BB%98%E5%AE%9DUID&code=alipayUid&cnl_id=34&status=1&remarks=%E6%94%AF%E4%BB%98%E5%AE%9DUID', '/admin/pay/editCode', '123.139.47.174', '1', '1667648392', '1667648392');
INSERT INTO `cm_action_log` VALUES ('286030', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667648412', '1667648412');
INSERT INTO `cm_action_log` VALUES ('286031', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667648441', '1667648441');
INSERT INTO `cm_action_log` VALUES ('286032', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667648478', '1667648478');
INSERT INTO `cm_action_log` VALUES ('286033', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667648519', '1667648519');
INSERT INTO `cm_action_log` VALUES ('286034', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667650076', '1667650076');
INSERT INTO `cm_action_log` VALUES ('286035', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667650083', '1667650083');
INSERT INTO `cm_action_log` VALUES ('286036', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667650093', '1667650093');
INSERT INTO `cm_action_log` VALUES ('286037', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667650635', '1667650635');
INSERT INTO `cm_action_log` VALUES ('286038', '1', 'admin', '新增', '新增权限组,name => 管理员', '/admin/admin/groupAdd', '123.139.47.174', '1', '1667650678', '1667650678');
INSERT INTO `cm_action_log` VALUES ('286039', '1', 'admin', '授权', '管理员ID4用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667650710', '1667650710');
INSERT INTO `cm_action_log` VALUES ('286040', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667650904', '1667650904');
INSERT INTO `cm_action_log` VALUES ('286041', '4', 'admin', '新增', '新增商户。UID:100283', '/admin/user/add', '123.139.47.174', '1', '1667650925', '1667650925');
INSERT INTO `cm_action_log` VALUES ('286042', '4', 'admin', '新增', '新增管理员信息，admin002', '/admin/admin/userAdd', '127.0.0.1', '1', '1667650955', '1667650955');
INSERT INTO `cm_action_log` VALUES ('286043', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667650972', '1667650972');
INSERT INTO `cm_action_log` VALUES ('286044', '1', 'admin', '授权', '管理员ID5用户组权限', '/admin/admin/userAuth', '127.0.0.1', '1', '1667650987', '1667650987');
INSERT INTO `cm_action_log` VALUES ('286045', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667651002', '1667651002');
INSERT INTO `cm_action_log` VALUES ('286046', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667651049', '1667651049');
INSERT INTO `cm_action_log` VALUES ('286047', '1', 'admin', '新增', '新增菜单,name =>添加码商', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667651170', '1667651170');
INSERT INTO `cm_action_log` VALUES ('286048', '1', 'admin', '编辑', '编辑菜单,name =>支付宝Uid列表', '/admin/menu/menuEdit', '123.139.47.174', '1', '1667651203', '1667651203');
INSERT INTO `cm_action_log` VALUES ('286049', '1', 'admin', '编辑', '编辑菜单,name =>支付宝UID订单', '/admin/menu/menuEdit', '123.139.47.174', '1', '1667651217', '1667651217');
INSERT INTO `cm_action_log` VALUES ('286050', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667651396', '1667651396');
INSERT INTO `cm_action_log` VALUES ('286051', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667651717', '1667651717');
INSERT INTO `cm_action_log` VALUES ('286052', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667653564', '1667653564');
INSERT INTO `cm_action_log` VALUES ('286053', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667654184', '1667654184');
INSERT INTO `cm_action_log` VALUES ('286054', '1', 'admin', '编辑', '编辑菜单,name =>支付宝Uid列表', '/admin/menu/menuEdit', '123.139.47.174', '1', '1667654218', '1667654218');
INSERT INTO `cm_action_log` VALUES ('286055', '1', 'admin', '编辑', '编辑菜单,name =>支付宝UID订单', '/admin/menu/menuEdit', '123.139.47.174', '1', '1667654226', '1667654226');
INSERT INTO `cm_action_log` VALUES ('286056', '1', 'admin', '新增', '新增权限组,name => 支付宝uid', '/admin/admin/groupAdd', '123.139.47.174', '1', '1667654260', '1667654260');
INSERT INTO `cm_action_log` VALUES ('286057', '1', 'admin', '授权', '管理员ID5用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667654286', '1667654286');
INSERT INTO `cm_action_log` VALUES ('286058', '1', 'admin', '授权', '管理员ID5用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667654325', '1667654325');
INSERT INTO `cm_action_log` VALUES ('286059', '1', 'admin', '编辑', '编辑菜单,name =>支付宝UID列表', '/admin/menu/menuEdit', '123.139.47.174', '1', '1667654347', '1667654347');
INSERT INTO `cm_action_log` VALUES ('286060', '1', 'admin', '删除', '权限组删除', '/admin/admin/groupDel?id=6', '123.139.47.174', '1', '1667654462', '1667654462');
INSERT INTO `cm_action_log` VALUES ('286061', '1', 'admin', '新增', '新增菜单,name =>过去支付宝UID订单', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667654546', '1667654546');
INSERT INTO `cm_action_log` VALUES ('286062', '1', 'admin', '新增', '新增菜单,name =>获取支付宝UID列表', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667654622', '1667654622');
INSERT INTO `cm_action_log` VALUES ('286063', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667654728', '1667654728');
INSERT INTO `cm_action_log` VALUES ('286064', '5', 'admin', '新增', '新增商户。UID:100284', '/admin/user/add', '123.139.47.174', '1', '1667654770', '1667654770');
INSERT INTO `cm_action_log` VALUES ('286065', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667655111', '1667655111');
INSERT INTO `cm_action_log` VALUES ('286066', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667655713', '1667655713');
INSERT INTO `cm_action_log` VALUES ('286067', '1', 'admin', '新增', '支付渠道账户,支付宝UID', '/admin/pay/addAccount', '127.0.0.1', '1', '1667655982', '1667655982');
INSERT INTO `cm_action_log` VALUES ('286068', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667656389', '1667656389');
INSERT INTO `cm_action_log` VALUES ('286069', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667656986', '1667656986');
INSERT INTO `cm_action_log` VALUES ('286070', '1', 'admin', '新增', '新增菜单,name =>获取商户总统计', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667657168', '1667657168');
INSERT INTO `cm_action_log` VALUES ('286071', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667657190', '1667657190');
INSERT INTO `cm_action_log` VALUES ('286072', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667657201', '1667657201');
INSERT INTO `cm_action_log` VALUES ('286073', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667713938', '1667713938');
INSERT INTO `cm_action_log` VALUES ('286074', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667716669', '1667716669');
INSERT INTO `cm_action_log` VALUES ('286075', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667716753', '1667716753');
INSERT INTO `cm_action_log` VALUES ('286076', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667723051', '1667723051');
INSERT INTO `cm_action_log` VALUES ('286077', '4', 'admin', '登录', '管理员admin001登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667724009', '1667724009');
INSERT INTO `cm_action_log` VALUES ('286078', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667724031', '1667724031');
INSERT INTO `cm_action_log` VALUES ('286079', '1', 'admin', '新增', '新增菜单,name =>删除码商', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667755769', '1667755769');
INSERT INTO `cm_action_log` VALUES ('286080', '1', 'admin', '新增', '新增菜单,name =>设置码商接单状态', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667755991', '1667755991');
INSERT INTO `cm_action_log` VALUES ('286081', '1', 'admin', '新增', '新增菜单,name =>码商费率设置', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756073', '1667756073');
INSERT INTO `cm_action_log` VALUES ('286082', '1', 'admin', '新增', '新增菜单,name =>码商流水页', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756148', '1667756148');
INSERT INTO `cm_action_log` VALUES ('286083', '1', 'admin', '新增', '新增菜单,name =>设置码商权重', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756199', '1667756199');
INSERT INTO `cm_action_log` VALUES ('286084', '1', 'admin', '新增', '新增菜单,name =>配置码商白名单', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756269', '1667756269');
INSERT INTO `cm_action_log` VALUES ('286085', '1', 'admin', '授权', '管理员ID5用户组权限', '/admin/admin/userAuth', '123.139.47.174', '1', '1667756368', '1667756368');
INSERT INTO `cm_action_log` VALUES ('286086', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667756377', '1667756377');
INSERT INTO `cm_action_log` VALUES ('286087', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667756467', '1667756467');
INSERT INTO `cm_action_log` VALUES ('286088', '1', 'admin', '新增', '新增菜单,name =>白名单校验口令', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756515', '1667756515');
INSERT INTO `cm_action_log` VALUES ('286089', '1', 'admin', '新增', '新增菜单,name =>标记商户异常', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756669', '1667756669');
INSERT INTO `cm_action_log` VALUES ('286090', '1', 'admin', '新增', '新增菜单,name =>商户通道管理', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756710', '1667756710');
INSERT INTO `cm_action_log` VALUES ('286091', '1', 'admin', '新增', '新增菜单,name =>商户分润设置', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756760', '1667756760');
INSERT INTO `cm_action_log` VALUES ('286092', '1', 'admin', '新增', '新增菜单,name =>商户代付分成设置', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667756814', '1667756814');
INSERT INTO `cm_action_log` VALUES ('286093', '5', 'admin', '修改', '修改商户信息。UID:100284', '/admin/user/edit', '127.0.0.1', '1', '1667757369', '1667757369');
INSERT INTO `cm_action_log` VALUES ('286094', '5', 'admin', '修改', '修改接口信息，接口公钥修改', '/admin/api/edit', '127.0.0.1', '1', '1667757464', '1667757464');
INSERT INTO `cm_action_log` VALUES ('286095', '1', 'admin', '新增', '新增菜单,name =>重置密钥', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667757548', '1667757548');
INSERT INTO `cm_action_log` VALUES ('286096', '1', 'admin', '新增', '新增菜单,name =>删除码商收款账号', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667757757', '1667757757');
INSERT INTO `cm_action_log` VALUES ('286097', '1', 'admin', '新增', '新增菜单,name =>拉黑码商订单ip', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667757857', '1667757857');
INSERT INTO `cm_action_log` VALUES ('286098', '1', 'admin', '新增', '新增菜单,name =>码商订单退款', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667757901', '1667757901');
INSERT INTO `cm_action_log` VALUES ('286099', '1', 'admin', '新增', '新增菜单,name =>订单姓名不符', '/admin/menu/menuAdd', '123.139.47.174', '1', '1667757955', '1667757955');
INSERT INTO `cm_action_log` VALUES ('286100', '5', 'admin', '登录', '管理员admin002登录成功', '/admin/login/login.html', '123.139.47.174', '1', '1667758412', '1667758412');
INSERT INTO `cm_action_log` VALUES ('286101', '1', 'admin', '登录', '管理员admin登录成功', '/admin/login/login.html', '127.0.0.1', '1', '1667758476', '1667758476');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='管理员信息';

-- ----------------------------
-- Records of cm_admin
-- ----------------------------
INSERT INTO `cm_admin` VALUES ('1', '0', 'admin', 'admin', '465dc3c3c43e4452824744afad1fe97b', '13333333333', '12345@qq.com', '1', '1552016220', '1667758476', '0', '6CMVNLPGQ2GCOUTN');
INSERT INTO `cm_admin` VALUES ('2', '1', 'chadan001', 'chadan001', '4a5163b75e4c48ccb919b0ed8388602e', null, 'chadan001@gmail.com', '-1', '1646065622', '1667587487', '0', '');
INSERT INTO `cm_admin` VALUES ('3', '1', 'duizhang001', 'Duizhang001', '07777630388f88a5ddb1f5652ca926a9', null, 'duizhang001@zhong.com', '-1', '1660592390', '1667587484', '0', '');
INSERT INTO `cm_admin` VALUES ('4', '1', 'admin001', 'admin001', 'd31f4b567830340af5ec399e4e4da8d6', null, '5555@qq.com', '1', '1667642968', '1667724009', '0', '');
INSERT INTO `cm_admin` VALUES ('5', '1', 'admin002', 'admin002', 'd31f4b567830340af5ec399e4e4da8d6', null, '888888@qq.com', '1', '1667650955', '1667758412', '0', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';

-- ----------------------------
-- Records of cm_api
-- ----------------------------
INSERT INTO `cm_api` VALUES ('281', '100281', '6864559a65a91f35ee7b48a571482ee7', '', '', '20000.000', '', '', '0', '0', '1667634546', '1667634546', '1');
INSERT INTO `cm_api` VALUES ('283', '100283', '7202c9d3ccbf3917793eb11c740f6441', '', '', '20000.000', '', '', '0', '0', '1667650925', '1667650925', '1');
INSERT INTO `cm_api` VALUES ('284', '100284', '3e1f0ca4ba9610e38faeb9dad5f9cb65', '', '', '20000.000', '', '127.0.0.2', '0', '0', '1667654770', '1667757464', '1');

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
-- Records of cm_article
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='权限组表';

-- ----------------------------
-- Records of cm_auth_group
-- ----------------------------
INSERT INTO `cm_auth_group` VALUES ('1', '1', '', '超级管理员', '拥有至高无上的权利', '1', '超级权限', '1541001599', '1538323200');
INSERT INTO `cm_auth_group` VALUES ('2', '2', '', '查单专用', '查单专用', '1', '1,2,135,61,62,127,142,84,85,86,87,89,90,92,93,104,94,95,96,137,138,139,117,118,121,125,126,128,129,130,131,136,140,143', '1660570532', '1538323200');
INSERT INTO `cm_auth_group` VALUES ('3', '0', '', '编辑', '负责编辑文章和站点公告', '1', '1,15,16,17,32', '1544360098', '1540381656');
INSERT INTO `cm_auth_group` VALUES ('4', '0', '', '对账专用', '对账专用', '1', '61,67,68,149,84,85,86,87,89,90,92,93,150,104,147,94,95,96,97,146,105,111,144,145,117,118,121,125,126,128,129,130,131,134,140,143,148,151', '1663261861', '1660592422');
INSERT INTO `cm_auth_group` VALUES ('5', '0', '', '管理员', '管理员', '1', '1,61,62,63,64,65,66,127,141,142,67,68,69,70,132,133,149,84,85,86,87,89,90,92,93,150,88,103,160,147,173,174,175,176,177,105,111,144,145,117,118,128,129,130,131,134,136,140,148,151,157,166,167,168,169,170,171,172,178,179,180,181,152,121,125,153,155,159,156,158', '1667758504', '1667650678');
INSERT INTO `cm_auth_group` VALUES ('6', '0', '', '支付宝uid', '支付宝uid', '-1', '153,155,156', '1667654462', '1667654260');

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
-- Records of cm_auth_group_access
-- ----------------------------
INSERT INTO `cm_auth_group_access` VALUES ('2', '2', '1', '1567687331', '1567687331');
INSERT INTO `cm_auth_group_access` VALUES ('3', '4', '1', '1660885986', '1660885986');
INSERT INTO `cm_auth_group_access` VALUES ('4', '5', '1', '1667650710', '1667650710');
INSERT INTO `cm_auth_group_access` VALUES ('5', '5', '1', '1667756368', '1667756368');

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
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4 COMMENT='商户资产表';

-- ----------------------------
-- Records of cm_balance
-- ----------------------------
INSERT INTO `cm_balance` VALUES ('281', '100281', '0.000', '0.000', '1', '1667634546', '1667634546');
INSERT INTO `cm_balance` VALUES ('283', '100283', '0.000', '0.000', '1', '1667650925', '1667650925');
INSERT INTO `cm_balance` VALUES ('284', '100284', '611.000', '0.000', '1', '1667654770', '1667654770');

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
-- Records of cm_balance_cash
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COMMENT='商户资产变动记录表';

-- ----------------------------
-- Records of cm_balance_change
-- ----------------------------
INSERT INTO `cm_balance_change` VALUES ('82', '100277', 'enable', '0.000', '1000000.000', '0.000', '1000000.000', '后台管理员账变', '0', '1666374058', '1666374058', '1', '', '0');
INSERT INTO `cm_balance_change` VALUES ('83', '100277', 'disable', '0.000', '100.000', '0.000', '100.000', '代付订单2210220141038455下单成功,冻结金额增加', '0', '1666374063', '1666374063', '0', '2210220141038455', '0');
INSERT INTO `cm_balance_change` VALUES ('84', '100277', 'enable', '1000000.000', '0.000', '100.000', '999900.000', '代付订单2210220141038455下单成功,余额减少', '0', '1666374063', '1666374063', '0', '2210220141038455', '0');
INSERT INTO `cm_balance_change` VALUES ('85', '100277', 'enable', '999900.000', '100.000', '0.000', '1000000.000', '代付订单2210220141038455失败,返还余额', '0', '1666374127', '1666374127', '0', '2210220141038455', '0');
INSERT INTO `cm_balance_change` VALUES ('86', '100277', 'disable', '100.000', '0.000', '100.000', '0.000', '代付订单2210220141038455失败,冻结金额减少', '0', '1666374127', '1666374127', '0', '2210220141038455', '0');
INSERT INTO `cm_balance_change` VALUES ('87', '100277', 'disable', '0.000', '100.000', '0.000', '100.000', '代付订单2210220149329525下单成功,冻结金额增加', '0', '1666374572', '1666374572', '0', '2210220149329525', '0');
INSERT INTO `cm_balance_change` VALUES ('88', '100277', 'enable', '1000000.000', '0.000', '100.000', '999900.000', '代付订单2210220149329525下单成功,余额减少', '0', '1666374572', '1666374572', '0', '2210220149329525', '0');
INSERT INTO `cm_balance_change` VALUES ('89', '100277', 'disable', '100.000', '100.000', '0.000', '200.000', '代付订单2210220149339678下单成功,冻结金额增加', '0', '1666374573', '1666374573', '0', '2210220149339678', '0');
INSERT INTO `cm_balance_change` VALUES ('90', '100277', 'enable', '999900.000', '0.000', '100.000', '999800.000', '代付订单2210220149339678下单成功,余额减少', '0', '1666374573', '1666374573', '0', '2210220149339678', '0');
INSERT INTO `cm_balance_change` VALUES ('91', '100277', 'disable', '200.000', '100.000', '0.000', '300.000', '代付订单2210220149338212下单成功,冻结金额增加', '0', '1666374573', '1666374573', '0', '2210220149338212', '0');
INSERT INTO `cm_balance_change` VALUES ('92', '100277', 'enable', '999800.000', '0.000', '100.000', '999700.000', '代付订单2210220149338212下单成功,余额减少', '0', '1666374573', '1666374573', '0', '2210220149338212', '0');
INSERT INTO `cm_balance_change` VALUES ('93', '100277', 'disable', '300.000', '100.000', '0.000', '400.000', '代付订单2210220149332830下单成功,冻结金额增加', '0', '1666374573', '1666374573', '0', '2210220149332830', '0');
INSERT INTO `cm_balance_change` VALUES ('94', '100277', 'enable', '999700.000', '0.000', '100.000', '999600.000', '代付订单2210220149332830下单成功,余额减少', '0', '1666374573', '1666374573', '0', '2210220149332830', '0');
INSERT INTO `cm_balance_change` VALUES ('95', '100277', 'disable', '400.000', '100.000', '0.000', '500.000', '代付订单2210220149331755下单成功,冻结金额增加', '0', '1666374573', '1666374573', '0', '2210220149331755', '0');
INSERT INTO `cm_balance_change` VALUES ('96', '100277', 'enable', '999600.000', '0.000', '100.000', '999500.000', '代付订单2210220149331755下单成功,余额减少', '0', '1666374573', '1666374573', '0', '2210220149331755', '0');
INSERT INTO `cm_balance_change` VALUES ('97', '100277', 'enable', '999500.000', '100.000', '0.000', '999600.000', '代付订单2210220149332830失败,返还余额', '0', '1666375079', '1666375079', '0', '2210220149332830', '0');
INSERT INTO `cm_balance_change` VALUES ('98', '100277', 'disable', '500.000', '0.000', '100.000', '400.000', '代付订单2210220149332830失败,冻结金额减少', '0', '1666375079', '1666375079', '0', '2210220149332830', '0');
INSERT INTO `cm_balance_change` VALUES ('106', '100277', 'enable', '999600.000', '10000.000', '0.000', '1009600.000', '后台管理员账变', '0', '1666378290', '1666378290', '1', '', '0');
INSERT INTO `cm_balance_change` VALUES ('107', '100277', 'enable', '1009600.000', '100.000', '0.000', '1009700.000', '代付订单2210220149331755失败,返还余额', '0', '1666425463', '1666425463', '0', '2210220149331755', '0');
INSERT INTO `cm_balance_change` VALUES ('108', '100277', 'disable', '400.000', '0.000', '100.000', '300.000', '代付订单2210220149331755失败,冻结金额减少', '0', '1666425463', '1666425463', '0', '2210220149331755', '0');
INSERT INTO `cm_balance_change` VALUES ('109', '100277', 'disable', '300.000', '100.000', '0.000', '400.000', '代付订单2210251630173936下单成功,冻结金额增加', '0', '1666686617', '1666686617', '0', '2210251630173936', '0');
INSERT INTO `cm_balance_change` VALUES ('110', '100277', 'enable', '1009700.000', '0.000', '100.000', '1009600.000', '代付订单2210251630173936下单成功,余额减少', '0', '1666686617', '1666686617', '0', '2210251630173936', '3');
INSERT INTO `cm_balance_change` VALUES ('111', '100277', 'disable', '400.000', '100.000', '0.000', '500.000', '代付订单2210251653569455下单成功,冻结金额增加', '0', '1666688036', '1666688036', '0', '2210251653569455', '0');
INSERT INTO `cm_balance_change` VALUES ('112', '100277', 'enable', '1009600.000', '0.000', '100.000', '1009500.000', '代付订单2210251653569455下单成功,余额减少', '0', '1666688036', '1666688036', '0', '2210251653569455', '3');
INSERT INTO `cm_balance_change` VALUES ('113', '100277', 'enable', '1009500.000', '1000.000', '0.000', '1010500.000', '后台管理员账变', '0', '1666689613', '1666689613', '1', '', '1');
INSERT INTO `cm_balance_change` VALUES ('114', '100277', 'enable', '1010500.000', '1000.000', '0.000', '1011500.000', '2000121212', '0', '1666689642', '1666689642', '1', '', '4');
INSERT INTO `cm_balance_change` VALUES ('115', '100277', 'enable', '1011500.000', '100.000', '0.000', '1011600.000', '代付订单2210220149329525失败,返还余额', '0', '1666775034', '1666775034', '0', '2210220149329525', '4');
INSERT INTO `cm_balance_change` VALUES ('116', '100277', 'disable', '500.000', '0.000', '100.000', '400.000', '代付订单2210220149329525失败,冻结金额减少', '0', '1666775034', '1666775034', '0', '2210220149329525', '0');
INSERT INTO `cm_balance_change` VALUES ('117', '100277', 'disable', '400.000', '0.000', '100.000', '300.000', '代付订单2210251630173936成功,冻结金额减少', '0', '1666775204', '1666775204', '0', '2210251630173936', '0');
INSERT INTO `cm_balance_change` VALUES ('118', '100277', 'disable', '300.000', '0.000', '100.000', '200.000', '代付订单2210251653569455成功,冻结金额减少', '0', '1666775230', '1666775230', '0', '2210251653569455', '0');
INSERT INTO `cm_balance_change` VALUES ('119', '100277', 'disable', '200.000', '100.000', '0.000', '300.000', '代付订单2210262016078510下单成功,冻结金额增加', '0', '1666786568', '1666786568', '0', '2210262016078510', '0');
INSERT INTO `cm_balance_change` VALUES ('120', '100277', 'enable', '1011600.000', '0.000', '100.000', '1011500.000', '代付订单2210262016078510下单成功,余额减少', '0', '1666786568', '1666786568', '0', '2210262016078510', '3');
INSERT INTO `cm_balance_change` VALUES ('121', '100277', 'disable', '300.000', '0.000', '100.000', '200.000', '代付订单2210262016078510成功,冻结金额减少', '0', '1666786799', '1666786799', '0', '2210262016078510', '0');
INSERT INTO `cm_balance_change` VALUES ('122', '100277', 'disable', '200.000', '100.000', '0.000', '300.000', '代付订单2210262020268087下单成功,冻结金额增加', '0', '1666786826', '1666786826', '0', '2210262020268087', '0');
INSERT INTO `cm_balance_change` VALUES ('123', '100277', 'enable', '1011500.000', '0.000', '100.000', '1011400.000', '代付订单2210262020268087下单成功,余额减少', '0', '1666786826', '1666786826', '0', '2210262020268087', '3');
INSERT INTO `cm_balance_change` VALUES ('124', '100277', 'disable', '300.000', '100.000', '0.000', '400.000', '代付订单2210262020313788下单成功,冻结金额增加', '0', '1666786831', '1666786831', '0', '2210262020313788', '0');
INSERT INTO `cm_balance_change` VALUES ('125', '100277', 'enable', '1011400.000', '0.000', '100.000', '1011300.000', '代付订单2210262020313788下单成功,余额减少', '0', '1666786831', '1666786831', '0', '2210262020313788', '3');
INSERT INTO `cm_balance_change` VALUES ('126', '100277', 'disable', '400.000', '100.000', '0.000', '500.000', '代付订单2210262020319189下单成功,冻结金额增加', '0', '1666786832', '1666786832', '0', '2210262020319189', '0');
INSERT INTO `cm_balance_change` VALUES ('127', '100277', 'enable', '1011300.000', '0.000', '100.000', '1011200.000', '代付订单2210262020319189下单成功,余额减少', '0', '1666786832', '1666786832', '0', '2210262020319189', '3');
INSERT INTO `cm_balance_change` VALUES ('128', '100277', 'disable', '500.000', '100.000', '0.000', '600.000', '代付订单2210262020352200下单成功,冻结金额增加', '0', '1666786835', '1666786835', '0', '2210262020352200', '0');
INSERT INTO `cm_balance_change` VALUES ('129', '100277', 'enable', '1011200.000', '0.000', '100.000', '1011100.000', '代付订单2210262020352200下单成功,余额减少', '0', '1666786835', '1666786835', '0', '2210262020352200', '3');
INSERT INTO `cm_balance_change` VALUES ('130', '100277', 'disable', '600.000', '100.000', '0.000', '700.000', '代付订单E20221101152524B01925下单成功,冻结金额增加', '0', '1667287524', '1667287524', '0', 'E20221101152524B01925', '0');
INSERT INTO `cm_balance_change` VALUES ('131', '100277', 'enable', '1011100.000', '0.000', '100.000', '1011000.000', '代付订单E20221101152524B01925下单成功,余额减少', '0', '1667287524', '1667287524', '0', 'E20221101152524B01925', '3');
INSERT INTO `cm_balance_change` VALUES ('132', '100277', 'disable', '700.000', '200200.000', '0.000', '200900.000', '代付订单E20221101152539B01700下单成功,冻结金额增加', '0', '1667287539', '1667287539', '0', 'E20221101152539B01700', '0');
INSERT INTO `cm_balance_change` VALUES ('133', '100277', 'enable', '1011000.000', '0.000', '200200.000', '810800.000', '代付订单E20221101152539B01700下单成功,余额减少', '0', '1667287539', '1667287539', '0', 'E20221101152539B01700', '3');
INSERT INTO `cm_balance_change` VALUES ('134', '100277', 'disable', '200900.000', '500.000', '0.000', '201400.000', '代付订单E20221101152549B01765下单成功,冻结金额增加', '0', '1667287549', '1667287549', '0', 'E20221101152549B01765', '0');
INSERT INTO `cm_balance_change` VALUES ('135', '100277', 'enable', '810800.000', '0.000', '500.000', '810300.000', '代付订单E20221101152549B01765下单成功,余额减少', '0', '1667287549', '1667287549', '0', 'E20221101152549B01765', '3');
INSERT INTO `cm_balance_change` VALUES ('136', '100277', 'disable', '201400.000', '400.000', '0.000', '201800.000', '代付订单E20221101152558B0169下单成功,冻结金额增加', '0', '1667287558', '1667287558', '0', 'E20221101152558B0169', '0');
INSERT INTO `cm_balance_change` VALUES ('137', '100277', 'enable', '810300.000', '0.000', '400.000', '809900.000', '代付订单E20221101152558B0169下单成功,余额减少', '0', '1667287558', '1667287558', '0', 'E20221101152558B0169', '3');
INSERT INTO `cm_balance_change` VALUES ('138', '100277', 'disable', '201800.000', '200.000', '0.000', '202000.000', '代付订单E20221101152610B0155下单成功,冻结金额增加', '0', '1667287570', '1667287570', '0', 'E20221101152610B0155', '0');
INSERT INTO `cm_balance_change` VALUES ('139', '100277', 'enable', '809900.000', '0.000', '200.000', '809700.000', '代付订单E20221101152610B0155下单成功,余额减少', '0', '1667287570', '1667287570', '0', 'E20221101152610B0155', '3');
INSERT INTO `cm_balance_change` VALUES ('140', '100277', 'disable', '202000.000', '0.000', '100.000', '201900.000', '代付订单2210220149339678成功,冻结金额减少', '0', '1667287597', '1667287597', '0', '2210220149339678', '0');
INSERT INTO `cm_balance_change` VALUES ('141', '100277', 'enable', '809700.000', '100.000', '0.000', '809800.000', '代付订单2210220149338212失败,返还余额', '0', '1667287681', '1667287681', '0', '2210220149338212', '4');
INSERT INTO `cm_balance_change` VALUES ('142', '100277', 'disable', '201900.000', '0.000', '100.000', '201800.000', '代付订单2210220149338212失败,冻结金额减少', '0', '1667287681', '1667287681', '0', '2210220149338212', '0');
INSERT INTO `cm_balance_change` VALUES ('143', '100277', 'disable', '201800.000', '0.000', '200.000', '201600.000', '代付订单E20221101152610B0155成功,冻结金额减少', '0', '1667287945', '1667287945', '0', 'E20221101152610B0155', '0');
INSERT INTO `cm_balance_change` VALUES ('144', '100277', 'disable', '201600.000', '0.000', '100.000', '201500.000', '代付订单E20221101152524B01925成功,冻结金额减少', '0', '1667288067', '1667288067', '0', 'E20221101152524B01925', '0');
INSERT INTO `cm_balance_change` VALUES ('145', '100284', 'enable', '0.000', '200.000', '0.000', '200.000', '单号2211052152151992支付成功，金额转入', '0', '1667718786', '1667718786', '0', '', '0');
INSERT INTO `cm_balance_change` VALUES ('146', '100284', 'enable', '200.000', '100.000', '0.000', '300.000', '单号2211052152105720支付成功，金额转入', '0', '1667721349', '1667721349', '0', '', '0');
INSERT INTO `cm_balance_change` VALUES ('147', '100284', 'enable', '300.000', '100.000', '0.000', '400.000', '单号2211052152058709支付成功，金额转入', '0', '1667721436', '1667721436', '0', '', '0');
INSERT INTO `cm_balance_change` VALUES ('148', '100284', 'enable', '400.000', '100.000', '0.000', '500.000', '单号2211052149581976支付成功，金额转入', '0', '1667721885', '1667721885', '0', '', '0');
INSERT INTO `cm_balance_change` VALUES ('149', '100284', 'enable', '500.000', '100.000', '0.000', '600.000', '单号2211052151375735支付成功，金额转入', '0', '1667722218', '1667722218', '0', '', '0');
INSERT INTO `cm_balance_change` VALUES ('150', '100284', 'enable', '600.000', '10.000', '0.000', '610.000', '单号2211061634338784支付成功，金额转入', '0', '1667723692', '1667723692', '0', '', '0');
INSERT INTO `cm_balance_change` VALUES ('151', '100284', 'enable', '610.000', '1.000', '0.000', '611.000', '后台管理员账变,冲正输入订单号', '0', '1667757449', '1667757449', '1', '', '1');

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
-- Records of cm_bank
-- ----------------------------

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
-- Records of cm_banker
-- ----------------------------
INSERT INTO `cm_banker` VALUES ('2', '工商银行', '工商银行', '1', '1', '1535983287', '1649746591', 'ICBC');
INSERT INTO `cm_banker` VALUES ('3', '农业银行', '农业银行', '1', '1', '1535983287', '1649746588', 'ABC');
INSERT INTO `cm_banker` VALUES ('4', '招商银行', '', '1', '1', '1535983287', '1649746523', 'CMB');
INSERT INTO `cm_banker` VALUES ('5', '中国民生', '', '1', '1', '1535983287', '1649746601', 'CMBC');
INSERT INTO `cm_banker` VALUES ('6', '建设银行 ', '中国建设银行', '1', '1', '1535983287', '1650077959', 'CCB');
INSERT INTO `cm_banker` VALUES ('7', '兴业银行', '', '1', '1', '1535983287', '1649746607', 'CIB');
INSERT INTO `cm_banker` VALUES ('9', '中国光大', '', '1', '1', '1535983287', '1649746612', 'CEB');
INSERT INTO `cm_banker` VALUES ('10', '邮政银行', '中国邮政储蓄银行', '1', '1', '1535983287', '1650077901', 'PSBC   ');
INSERT INTO `cm_banker` VALUES ('11', '中国银行', '', '1', '1', '1535983287', '1649746619', 'BOC');
INSERT INTO `cm_banker` VALUES ('12', '平安银行', '', '1', '1', '1535983287', '1649746622', 'PAB');
INSERT INTO `cm_banker` VALUES ('13', '中国农业', '', '1', '1', '1535983287', '1649746628', 'ABC');
INSERT INTO `cm_banker` VALUES ('14', '北京银行', '', '1', '1', '1535983287', '1649746631', 'BOB');
INSERT INTO `cm_banker` VALUES ('15', '上海浦东发展银行', '', '1', '1', '1535983287', '1649746636', 'SPDB');
INSERT INTO `cm_banker` VALUES ('16', '宁波银行', '', '1', '1', '1535983287', '1649746639', 'NBCB');
INSERT INTO `cm_banker` VALUES ('17', '中信银行', '', '1', '1', '1535983287', '1649746645', 'CITIC');
INSERT INTO `cm_banker` VALUES ('18', '华夏银行', '', '1', '1', '1535983287', '1649746649', 'HXB');
INSERT INTO `cm_banker` VALUES ('19', '交通银行', '', '1', '1', '1535983287', '1649746672', 'COMM');
INSERT INTO `cm_banker` VALUES ('21', '桂林银行', '', '1', '1', '1584005500', '1649747087', 'GUILIN');
INSERT INTO `cm_banker` VALUES ('23', '山西省农村信用社', '', '1', '1', '1649747351', '1649747351', 'sx');
INSERT INTO `cm_banker` VALUES ('24', '辽宁省农村信用社', '', '1', '1', '1649747369', '1649747369', 'ln');
INSERT INTO `cm_banker` VALUES ('25', '吉林省农村信用社', '', '1', '1', '1649747453', '1649747453', 'jl');
INSERT INTO `cm_banker` VALUES ('26', '黑龙江省农村信用社', '', '1', '1', '1649747472', '1649747472', 'hlj');
INSERT INTO `cm_banker` VALUES ('27', '江苏省农村信用社', '', '1', '1', '1649747483', '1649747483', 'js');
INSERT INTO `cm_banker` VALUES ('28', '浙江省农村信用社', '', '1', '1', '1649747496', '1649747496', 'zj');
INSERT INTO `cm_banker` VALUES ('29', '安徽省农村信用社', '', '1', '1', '1649747509', '1649747509', 'ah');
INSERT INTO `cm_banker` VALUES ('30', '福建省农村信用社', '', '1', '1', '1649747524', '1649747524', 'fj');
INSERT INTO `cm_banker` VALUES ('31', '江西省农村信用社', '', '1', '1', '1649747535', '1649747535', 'jx');
INSERT INTO `cm_banker` VALUES ('32', '山东省农村信用社', '', '1', '1', '1649747550', '1649747550', 'sd');
INSERT INTO `cm_banker` VALUES ('33', '河南省农村信用社', '', '1', '1', '1649747576', '1649747576', 'hn');
INSERT INTO `cm_banker` VALUES ('34', '湖北省农村信用社', '', '1', '1', '1649747592', '1649747592', 'hb');
INSERT INTO `cm_banker` VALUES ('35', '湖南省农村信用社', '', '1', '1', '1649747604', '1649747604', 'hn');
INSERT INTO `cm_banker` VALUES ('36', '广东省农村信用社', '', '1', '1', '1649747618', '1649747618', 'gd');
INSERT INTO `cm_banker` VALUES ('37', '海南省农村信用社', '', '1', '1', '1649747637', '1649747637', 'hns');
INSERT INTO `cm_banker` VALUES ('38', '四川省农村信用社', '', '1', '1', '1649747653', '1649747653', 'sc');
INSERT INTO `cm_banker` VALUES ('39', '贵州省农村信用社', '', '1', '1', '1649747664', '1649747664', 'gz');
INSERT INTO `cm_banker` VALUES ('40', '云南省农村信用社', '', '1', '1', '1649747688', '1649747688', 'yn');
INSERT INTO `cm_banker` VALUES ('41', '陕西省农村信用社', '', '1', '1', '1649747709', '1649747709', 'sxs');
INSERT INTO `cm_banker` VALUES ('42', '甘肃省农村信用社', '', '1', '1', '1649747721', '1649747721', 'gs');
INSERT INTO `cm_banker` VALUES ('43', '青海省农村信用社', '', '1', '1', '1649747737', '1649747737', 'qh');
INSERT INTO `cm_banker` VALUES ('44', '内蒙古自治区农村信用社', '', '1', '1', '1649747752', '1649747752', 'nmg');
INSERT INTO `cm_banker` VALUES ('45', '广西壮族自治区农村信用社', '', '1', '1', '1649747767', '1649747767', 'gx');
INSERT INTO `cm_banker` VALUES ('46', '西藏自治区农村信用社', '', '1', '1', '1649747785', '1649747785', 'xz');
INSERT INTO `cm_banker` VALUES ('47', '宁夏省农村信用社', '', '1', '1', '1649747799', '1649747799', 'nx');
INSERT INTO `cm_banker` VALUES ('48', '新疆省农村信用社', '', '1', '1', '1649747821', '1649747821', 'xj');
INSERT INTO `cm_banker` VALUES ('49', '广发银行', '', '1', '1', '1649781066', '1649781066', 'gf');
INSERT INTO `cm_banker` VALUES ('50', '江苏银行', '', '1', '1', '1649916222', '1649916237', 'js');
INSERT INTO `cm_banker` VALUES ('51', '上海农村商业银行', '', '1', '1', '1650904706', '1650904706', 'SH');
INSERT INTO `cm_banker` VALUES ('52', '广州农村商业银行', '', '1', '1', '1651016002', '1651016002', 'GZNCYH');
INSERT INTO `cm_banker` VALUES ('53', '上海银行', '', '1', '1', '1651311322', '1651311322', 'SHYH');
INSERT INTO `cm_banker` VALUES ('54', '北京农商银行', '', '1', '1', '1652941556', '1652941556', 'BJ');
INSERT INTO `cm_banker` VALUES ('55', '常熟农商银行', '1', '1', '1', '1653234121', '1653234146', 'chsh');
INSERT INTO `cm_banker` VALUES ('56', '贵州银行', '', '1', '1', '1653368462', '1653368462', 'GZYH');
INSERT INTO `cm_banker` VALUES ('57', '浙江民泰商业银行', '1', '1', '1', '1653417166', '1653417166', 'as');
INSERT INTO `cm_banker` VALUES ('58', '无锡农村商业银行', '', '1', '1', '1653779866', '1653779866', 'wxncsyyh');
INSERT INTO `cm_banker` VALUES ('59', '哈尔滨银行', '', '0', '1', '1654786615', '1654786615', 'heb');
INSERT INTO `cm_banker` VALUES ('60', '温州银行', '', '1', '1', '1654997353', '1654997353', 'wzh');
INSERT INTO `cm_banker` VALUES ('61', '广西自治区农村信用社', '', '0', '1', '1658250089', '1658250089', 'gxzzq');
INSERT INTO `cm_banker` VALUES ('62', '重庆农村商业银行', '', '0', '1', '1658497181', '1659494557', 'cqncsyyh');
INSERT INTO `cm_banker` VALUES ('63', '重庆农村商业银行', '', '1', '1', '1658497320', '1659494547', 'cq');
INSERT INTO `cm_banker` VALUES ('64', '广发银行', '', '0', '1', '1658582124', '1658582124', 'gfyh');
INSERT INTO `cm_banker` VALUES ('65', '河北省农村信用社', '', '1', '1', '1658668837', '1658668873', 'hb1');
INSERT INTO `cm_banker` VALUES ('66', '广西农村信用社联合社', '', '1', '1', '1658836334', '1658836334', 'GXNX');
INSERT INTO `cm_banker` VALUES ('67', '渤海银行', '', '0', '1', '1659024770', '1659024770', 'BH');
INSERT INTO `cm_banker` VALUES ('68', '长沙银行', '', '0', '1', '1659153466', '1659153466', 'cs');
INSERT INTO `cm_banker` VALUES ('69', '中原银行', '', '1', '1', '1659439442', '1659439442', 'ZY');
INSERT INTO `cm_banker` VALUES ('70', '中原银行', '', '0', '1', '1659439502', '1659439502', 'zyyh');
INSERT INTO `cm_banker` VALUES ('71', '恒丰银行', '', '0', '1', '1659509748', '1659509748', 'HF');
INSERT INTO `cm_banker` VALUES ('72', '武汉农村商业银行', '', '1', '1', '1659858186', '1659858200', 'whncsyyh');
INSERT INTO `cm_banker` VALUES ('73', '南京银行', '', '1', '1', '1660008360', '1660008360', 'jnyh');
INSERT INTO `cm_banker` VALUES ('74', '贵阳银行', '', '1', '1', '1660056716', '1660056716', 'gy');
INSERT INTO `cm_banker` VALUES ('75', '湖北银行', '', '0', '1', '1660232869', '1660232869', 'hbyh');
INSERT INTO `cm_banker` VALUES ('76', '长沙银行', '', '1', '1', '1660418670', '1660418670', 'zhsh');
INSERT INTO `cm_banker` VALUES ('77', '河北银行', '', '1', '1', '1660551385', '1660551385', 'hbyh');
INSERT INTO `cm_banker` VALUES ('78', '东莞农村商业银行', '', '0', '1', '1660967148', '1660967148', 'dgncsyyh');
INSERT INTO `cm_banker` VALUES ('79', '浦发银行', '', '0', '1', '1661565589', '1661565589', 'pfyh');
INSERT INTO `cm_banker` VALUES ('81', '汇丰银行', '', '1', '1', '1661822767', '1661822789', 'hfyh');
INSERT INTO `cm_banker` VALUES ('83', '上饶银行', '', '1', '1', '1662199939', '1662199939', 'ss');
INSERT INTO `cm_banker` VALUES ('84', '广州银行', '', '1', '1', '1662283514', '1662283514', 'gzhh');
INSERT INTO `cm_banker` VALUES ('85', '微商银行', '', '1', '1', '1662357046', '1662357077', 'wsyh');
INSERT INTO `cm_banker` VALUES ('86', '河北银行', '', '1', '1', '1662867273', '1662867273', 'hbyh');
INSERT INTO `cm_banker` VALUES ('87', '晋商银行', '', '1', '1', '1663226846', '1663226846', 'JSYH');
INSERT INTO `cm_banker` VALUES ('88', '莱商银行', '', '1', '1', '1663239106', '1663239106', '111');
INSERT INTO `cm_banker` VALUES ('89', '宁夏银行', '', '1', '1', '1663321499', '1663321499', 'nxx');
INSERT INTO `cm_banker` VALUES ('90', '河北省农村信用社', '', '1', '1', '1663321548', '1663321548', 'qq');
INSERT INTO `cm_banker` VALUES ('91', '光大银行', '', '1', '1', '1663549033', '1663549033', 'qqqqq');
INSERT INTO `cm_banker` VALUES ('92', '鼎业村镇银行', '', '0', '1', '1664000381', '1664001018', 'dy');
INSERT INTO `cm_banker` VALUES ('93', '深圳龙岗鼎业村镇银行', '', '1', '1', '1664001008', '1664001008', 'shzh');
INSERT INTO `cm_banker` VALUES ('94', '东莞银行', '', '1', '1', '1664243296', '1664243296', 'ddd');
INSERT INTO `cm_banker` VALUES ('95', '九江银行', '', '1', '1', '1664284379', '1666969875', 'jiujiangyinhang');

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
INSERT INTO `cm_config` VALUES ('1121', 'thrid_url_uid', 'UID中转地址', '1', '6', '0', 'http://zhongzhuan.sxwzrj.cn/uid.php', '', 'UID中转地址', '1', '1378898976', '1378898976');

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
-- Records of cm_dafiu_account
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cm_daifu_orders
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='充值卡信息';

-- ----------------------------
-- Records of cm_deposite_card
-- ----------------------------

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
-- Records of cm_deposite_orders
-- ----------------------------

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
-- Records of cm_ewm_block_ip
-- ----------------------------
INSERT INTO `cm_ewm_block_ip` VALUES ('1', '0', '119.91.255.197', '1664105133', '1664105133');
INSERT INTO `cm_ewm_block_ip` VALUES ('2', '0', '117.143.127.58', '1664106792', '1664106792');

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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cm_ewm_order
-- ----------------------------
INSERT INTO `cm_ewm_order` VALUES ('9', '1666795407', '2210262243274370', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262243274370', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262243274370', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('10', '1666796066', '2210262254261027', '200.00', '0', '120', '', null, '1', '200.00', '测试', null, '2210262254261027', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796066', '2210262254261027', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('11', '1666796070', '2210262254302900', '200.00', '0', '120', '', null, '2', '200.00', '测试', null, '2210262254302900', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796070', '2210262254302900', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('12', '1666796071', '2210262254314805', '200.00', '0', '120', '', null, '1', '199.90', '测试', null, '2210262254314805', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796071', '2210262254314805', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('13', '1666796071', '2210262254313125', '200.00', '0', '120', '', null, '2', '199.90', '测试', null, '2210262254313125', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796071', '2210262254313125', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('14', '1666796072', '2210262254325399', '200.00', '0', '120', '', null, '1', '199.91', '测试', null, '2210262254325399', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796072', '2210262254325399', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('15', '1666796072', '2210262254328214', '200.00', '0', '120', '', null, '2', '199.91', '测试', null, '2210262254328214', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796072', '2210262254328214', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('16', '1666796130', '2210262255306776', '200.00', '0', '120', '', null, '1', '199.92', '测试', null, '2210262255306776', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796130', '2210262255306776', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('17', '1666796487', '2210262301278959', '200.00', '0', '120', '', null, '2', '200.00', '测试', null, '2210262301278959', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666796487', '2210262301278959', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('18', '1666797191', '2210262313119975', '200.00', '0', '120', '', null, '3', '200.00', '测试', null, '2210262313119975', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797191', '2210262313119975', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('19', '1666797192', '2210262313122278', '200.00', '0', '120', '', null, '1', '200.00', '测试', null, '2210262313122278', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797192', '2210262313122278', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('20', '1666797192', '2210262313124884', '200.00', '0', '120', '', null, '2', '200.00', '测试', null, '2210262313124884', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797192', '2210262313124884', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('21', '1666797414', '2210262316546601', '200.00', '0', '120', '', null, '3', '199.90', '测试', null, '2210262316546601', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797414', '2210262316546601', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('22', '1666797416', '2210262316551142', '200.00', '0', '120', '', null, '1', '199.90', '测试', null, '2210262316551142', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797416', '2210262316551142', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('23', '1666797428', '2210262317085483', '200.00', '0', '120', '', null, '2', '199.90', '测试', null, '2210262317085483', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797428', '2210262317085483', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('24', '1666797428', '2210262317089291', '200.00', '0', '120', '', null, '3', '199.91', '测试', null, '2210262317089291', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797428', '2210262317089291', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('25', '1666797429', '2210262317093883', '200.00', '0', '120', '', null, '1', '199.91', '测试', null, '2210262317093883', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797429', '2210262317093883', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('26', '1666797429', '2210262317096308', '200.00', '0', '120', '', null, '2', '199.91', '测试', null, '2210262317096308', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797429', '2210262317096308', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('27', '1666797429', '2210262317091013', '200.00', '0', '120', '', null, '3', '199.92', '测试', null, '2210262317091013', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797429', '2210262317091013', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('28', '1666797429', '2210262317091962', '200.00', '0', '120', '', null, '1', '199.92', '测试', null, '2210262317091962', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797429', '2210262317091962', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('29', '1666797429', '2210262317092905', '200.00', '0', '120', '', null, '2', '199.92', '测试', null, '2210262317092905', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797429', '2210262317092905', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('30', '1666797429', '2210262317099107', '200.00', '0', '120', '', null, '3', '199.93', '测试', null, '2210262317099107', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797429', '2210262317099107', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('31', '1666797430', '2210262317102042', '200.00', '0', '120', '', null, '1', '199.93', '测试', null, '2210262317102042', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797430', '2210262317102042', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('32', '1666797430', '2210262317105889', '200.00', '0', '120', '', null, '2', '199.93', '测试', null, '2210262317105889', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797430', '2210262317105889', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('33', '1666797430', '2210262317109116', '200.00', '0', '120', '', null, '3', '199.94', '测试', null, '2210262317109116', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797430', '2210262317109116', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('34', '1666797430', '2210262317101926', '200.00', '0', '120', '', null, '1', '199.94', '测试', null, '2210262317101926', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797430', '2210262317101926', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('35', '1666797430', '2210262317108472', '200.00', '0', '120', '', null, '2', '199.94', '测试', null, '2210262317108472', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797430', '2210262317108472', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('36', '1666797431', '2210262317105784', '200.00', '0', '120', '', null, '3', '199.95', '测试', null, '2210262317105784', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317105784', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('37', '1666797431', '2210262317117389', '200.00', '0', '120', '', null, '1', '199.95', '测试', null, '2210262317117389', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317117389', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('38', '1666797431', '2210262317113845', '200.00', '0', '120', '', null, '2', '199.95', '测试', null, '2210262317113845', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317113845', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('39', '1666797431', '2210262317116495', '200.00', '0', '120', '', null, '3', '199.96', '测试', null, '2210262317116495', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317116495', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('40', '1666797431', '2210262317119128', '200.00', '0', '120', '', null, '1', '199.96', '测试', null, '2210262317119128', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317119128', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('41', '1666797431', '2210262317111896', '200.00', '0', '120', '', null, '2', '199.96', '测试', null, '2210262317111896', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317111896', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('42', '1666797431', '2210262317117475', '200.00', '0', '120', '', null, '3', '199.97', '测试', null, '2210262317117475', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317117475', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('43', '1666797431', '2210262317117992', '200.00', '0', '120', '', null, '1', '199.97', '测试', null, '2210262317117992', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797431', '2210262317117992', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('44', '1666797432', '2210262317125881', '200.00', '0', '120', '', null, '2', '199.97', '测试', null, '2210262317125881', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797432', '2210262317125881', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('45', '1666797432', '2210262317125872', '200.00', '0', '120', '', null, '3', '199.98', '测试', null, '2210262317125872', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797432', '2210262317125872', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('46', '1666797432', '2210262317121966', '200.00', '0', '120', '', null, '1', '199.98', '测试', null, '2210262317121966', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797432', '2210262317121966', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('47', '1666797432', '2210262317129419', '200.00', '0', '120', '', null, '2', '199.98', '测试', null, '2210262317129419', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797432', '2210262317129419', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('48', '1666797432', '2210262317129557', '200.00', '0', '120', '', null, '3', '199.99', '测试', null, '2210262317129557', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797432', '2210262317129557', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('49', '1666797432', '2210262317125489', '200.00', '0', '120', '', null, '1', '199.99', '测试', null, '2210262317125489', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797432', '2210262317125489', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('50', '1666797433', '2210262317124092', '200.00', '0', '120', '', null, '2', '199.99', '测试', null, '2210262317124092', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797433', '2210262317124092', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('51', '1666797433', '2210262317133520', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317133520', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317133520', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('52', '1666797433', '2210262317139849', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317139849', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317139849', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('53', '1666797433', '2210262317135778', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317135778', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317135778', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('54', '1666797433', '2210262317134553', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317134553', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317134553', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('55', '1666797433', '2210262317132295', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317132295', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317132295', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('56', '1666797434', '2210262317148488', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317148488', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317148488', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('57', '1666797434', '2210262317145468', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317145468', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317145468', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('58', '1666797439', '2210262317193909', '200.00', '0', '0', '', null, '0', '200.00', '', '系统没有可用的支付二维码', '2210262317193909', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210262317193909', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('59', '1666797444', '2210262317245127', '100.00', '0', '120', '', null, '3', '100.00', '测试', null, '2210262317245127', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797444', '2210262317245127', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('60', '1666797962', '2210262326021694', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210262326021694', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797962', '2210262326021694', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('61', '1666797967', '2210262326074803', '100.00', '0', '120', '', null, '2', '100.00', '测试', null, '2210262326074803', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797967', '2210262326074803', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('62', '1666797997', '2210262326367121', '200.00', '0', '120', '', null, '3', '200.00', '测试', null, '2210262326367121', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797997', '2210262326367121', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('63', '1666797997', '2210262326376872', '200.00', '0', '120', '', null, '1', '200.00', '测试', null, '2210262326376872', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797997', '2210262326376872', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('64', '1666797998', '2210262326389519', '200.00', '0', '120', '', null, '2', '200.00', '测试', null, '2210262326389519', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797998', '2210262326389519', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('65', '1666797998', '2210262326381845', '200.00', '0', '120', '', null, '3', '199.90', '测试', null, '2210262326381845', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666797998', '2210262326381845', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('66', '1666798099', '2210262328193305', '200.00', '0', '120', '', null, '1', '199.90', '测试', null, '2210262328193305', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798099', '2210262328193305', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('67', '1666798263', '2210262331033994', '200.00', '0', '119', '', null, '4', '200.00', '掌握', null, '2210262331033994', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798263', '2210262331033994', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('68', '1666798264', '2210262331031147', '200.00', '0', '120', '', null, '2', '199.90', '测试', null, '2210262331031147', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798264', '2210262331031147', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('69', '1666798264', '2210262331042312', '200.00', '0', '119', '', null, '4', '199.90', '掌握', null, '2210262331042312', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798264', '2210262331042312', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('70', '1666798264', '2210262331048250', '200.00', '0', '120', '', null, '3', '199.91', '测试', null, '2210262331048250', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798264', '2210262331048250', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('71', '1666798264', '2210262331043720', '200.00', '0', '119', '', null, '4', '199.91', '掌握', null, '2210262331043720', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798264', '2210262331043720', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('72', '1666798279', '2210262331194259', '200.00', '0', '120', '', null, '1', '199.91', '测试', null, '2210262331194259', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798279', '2210262331194259', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('73', '1666798279', '2210262331193888', '200.00', '0', '120', '', null, '2', '199.91', '测试', null, '2210262331193888', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798279', '2210262331193888', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('74', '1666798280', '2210262331203236', '200.00', '0', '119', '', null, '4', '199.92', '掌握', null, '2210262331203236', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798280', '2210262331203236', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('75', '1666798280', '2210262331209076', '200.00', '0', '120', '', null, '3', '199.92', '测试', null, '2210262331209076', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798280', '2210262331209076', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('76', '1666798280', '2210262331202859', '200.00', '0', '120', '', null, '1', '199.92', '测试', null, '2210262331202859', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798280', '2210262331202859', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('77', '1666798280', '2210262331208861', '200.00', '0', '120', '', null, '2', '199.92', '测试', null, '2210262331208861', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798280', '2210262331208861', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('78', '1666798291', '2210262331314122', '200.00', '0', '119', '', null, '4', '199.93', '掌握', null, '2210262331314122', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798291', '2210262331314122', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('79', '1666798292', '2210262331324132', '200.00', '0', '120', '', null, '3', '199.93', '测试', null, '2210262331324132', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798292', '2210262331324132', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('80', '1666798292', '2210262331329807', '200.00', '0', '120', '', null, '1', '199.93', '测试', null, '2210262331329807', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798292', '2210262331329807', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('81', '1666798292', '2210262331321028', '200.00', '0', '120', '', null, '2', '199.93', '测试', null, '2210262331321028', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798292', '2210262331321028', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('82', '1666798292', '2210262331322635', '200.00', '0', '119', '', null, '4', '199.94', '掌握', null, '2210262331322635', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798292', '2210262331322635', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('83', '1666798292', '2210262331321884', '200.00', '0', '120', '', null, '3', '199.94', '测试', null, '2210262331321884', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798292', '2210262331321884', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('86', '1666798692', '2210262338121965', '200.00', '0', '120', '', null, '1', '200.00', '测试', null, '2210262338121965', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798692', '2210262338121965', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('87', '1666798694', '2210262338147583', '200.00', '0', '120', '', null, '2', '200.00', '测试', null, '2210262338147583', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798694', '2210262338147583', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('88', '1666798695', '2210262338156710', '200.00', '0', '120', '', null, '3', '200.00', '测试', null, '2210262338156710', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798695', '2210262338156710', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('89', '1666798695', '2210262338157667', '200.00', '0', '120', '', null, '1', '199.90', '测试', null, '2210262338157667', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798695', '2210262338157667', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('90', '1666798695', '2210262338157804', '200.00', '0', '120', '', null, '2', '199.90', '测试', null, '2210262338157804', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798695', '2210262338157804', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('91', '1666798695', '2210262338151022', '200.00', '0', '120', '', null, '3', '199.90', '测试', null, '2210262338151022', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798695', '2210262338151022', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('92', '1666798695', '2210262338155277', '200.00', '0', '120', '', null, '1', '199.91', '测试', null, '2210262338155277', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798695', '2210262338155277', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('93', '1666798696', '2210262338161367', '200.00', '0', '120', '', null, '2', '199.91', '测试', null, '2210262338161367', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798696', '2210262338161367', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('94', '1666798696', '2210262338165296', '200.00', '0', '120', '', null, '3', '199.91', '测试', null, '2210262338165296', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798696', '2210262338165296', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('95', '1666798696', '2210262338169225', '200.00', '0', '120', '', null, '1', '199.92', '测试', null, '2210262338169225', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798696', '2210262338169225', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('96', '1666798696', '2210262338167203', '200.00', '0', '120', '', null, '2', '199.92', '测试', null, '2210262338167203', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798696', '2210262338167203', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('97', '1666798696', '2210262338166051', '200.00', '0', '120', '', null, '3', '199.92', '测试', null, '2210262338166051', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798696', '2210262338166051', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('98', '1666798696', '2210262338166518', '200.00', '0', '120', '', null, '1', '199.93', '测试', null, '2210262338166518', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798696', '2210262338166518', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('99', '1666798759', '2210262339195605', '200.00', '0', '119', '', null, '4', '200.00', '掌握', null, '2210262339195605', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798759', '2210262339195605', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('100', '1666798760', '2210262339203565', '200.00', '0', '119', '', null, '4', '199.90', '掌握', null, '2210262339203565', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798760', '2210262339203565', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('101', '1666798760', '2210262339201464', '200.00', '0', '119', '', null, '4', '199.91', '掌握', null, '2210262339201464', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798760', '2210262339201464', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('102', '1666798761', '2210262339211944', '200.00', '0', '119', '', null, '4', '199.92', '掌握', null, '2210262339211944', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798761', '2210262339211944', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('103', '1666798763', '2210262339236825', '200.00', '0', '120', '', null, '2', '199.93', '测试', null, '2210262339236825', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798763', '2210262339236825', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('104', '1666798763', '2210262339239433', '200.00', '0', '119', '', null, '4', '199.93', '掌握', null, '2210262339239433', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798763', '2210262339239433', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('105', '1666798763', '2210262339233407', '200.00', '0', '120', '', null, '3', '199.93', '测试', null, '2210262339233407', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798763', '2210262339233407', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('106', '1666798764', '2210262339246050', '200.00', '0', '119', '', null, '4', '199.94', '掌握', null, '2210262339246050', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666798764', '2210262339246050', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('107', '1666800432', '2210270007123420', '1000.00', '0', '120', '', null, '1', '1000.00', '测试', null, '2210270007123420', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800432', '2210270007123420', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('108', '1666800434', '2210270007146541', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270007146541', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800434', '2210270007146541', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('109', '1666800466', '2210270007465768', '1000.00', '0', '120', '', null, '2', '1000.00', '测试', null, '2210270007465768', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800466', '2210270007465768', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('110', '1666800466', '2210270007469323', '1000.00', '0', '120', '', null, '3', '1000.00', '测试', null, '2210270007469323', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800466', '2210270007469323', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('111', '1666800466', '2210270007461588', '1000.00', '0', '119', '', null, '4', '999.90', '掌握', null, '2210270007461588', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800466', '2210270007461588', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('112', '1666800466', '2210270007469288', '1000.00', '0', '120', '', null, '1', '999.90', '测试', null, '2210270007469288', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800466', '2210270007469288', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('113', '1666800467', '2210270007465179', '1000.00', '0', '120', '', null, '2', '999.90', '测试', null, '2210270007465179', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800467', '2210270007465179', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('114', '1666800467', '2210270007478073', '1000.00', '0', '120', '', null, '3', '999.90', '测试', null, '2210270007478073', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800467', '2210270007478073', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('115', '1666800467', '2210270007477908', '1000.00', '0', '119', '', null, '4', '999.91', '掌握', null, '2210270007477908', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800467', '2210270007477908', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('116', '1666800467', '2210270007473741', '1000.00', '0', '120', '', null, '1', '999.91', '测试', null, '2210270007473741', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800467', '2210270007473741', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('117', '1666800467', '2210270007476783', '1000.00', '0', '120', '', null, '2', '999.91', '测试', null, '2210270007476783', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800467', '2210270007476783', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('118', '1666800467', '2210270007478569', '1000.00', '0', '120', '', null, '3', '999.91', '测试', null, '2210270007478569', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800467', '2210270007478569', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('119', '1666800468', '2210270007481070', '1000.00', '0', '119', '', null, '4', '999.92', '掌握', null, '2210270007481070', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800468', '2210270007481070', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('120', '1666800475', '2210270007554400', '1000.00', '0', '120', '', null, '1', '999.92', '测试', null, '2210270007554400', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800475', '2210270007554400', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('121', '1666800476', '2210270007569541', '1000.00', '0', '120', '', null, '2', '999.92', '测试', null, '2210270007569541', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800476', '2210270007569541', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('122', '1666800476', '2210270007565424', '1000.00', '0', '120', '', null, '3', '999.92', '测试', null, '2210270007565424', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800476', '2210270007565424', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('123', '1666800504', '2210270008245630', '1000.00', '0', '119', '', null, '4', '999.93', '掌握', null, '2210270008245630', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800504', '2210270008245630', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('124', '1666800504', '2210270008245753', '1000.00', '0', '119', '', null, '4', '999.94', '掌握', null, '2210270008245753', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800504', '2210270008245753', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('125', '1666800505', '2210270008254938', '1000.00', '0', '119', '', null, '4', '999.95', '掌握', null, '2210270008254938', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800505', '2210270008254938', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('126', '1666800505', '2210270008254486', '1000.00', '0', '119', '', null, '4', '999.96', '掌握', null, '2210270008254486', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800505', '2210270008254486', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('127', '1666800505', '2210270008255311', '1000.00', '0', '119', '', null, '4', '999.97', '掌握', null, '2210270008255311', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800505', '2210270008255311', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('128', '1666800516', '2210270008364093', '1000.00', '0', '119', '', null, '4', '999.98', '掌握', null, '2210270008364093', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800516', '2210270008364093', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('129', '1666800517', '2210270008375111', '1000.00', '0', '119', '', null, '4', '999.99', '掌握', null, '2210270008375111', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800517', '2210270008375111', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('130', '1666800517', '2210270008377124', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270008377124', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270008377124', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('131', '1666800518', '2210270008385844', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270008385844', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270008385844', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('132', '1666800518', '2210270008386845', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270008386845', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270008386845', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('133', '1666800518', '2210270008385620', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270008385620', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270008385620', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('134', '1666800539', '2210270008594504', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270008594504', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270008594504', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('135', '1666800540', '2210270009003366', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270009003366', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270009003366', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('136', '1666800540', '2210270009008176', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270009008176', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270009008176', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('137', '1666800540', '2210270009003140', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270009003140', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270009003140', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('138', '1666800580', '2210270009401269', '1000.00', '0', '0', '', null, '0', '1000.00', '', '系统没有可用的支付二维码', '2210270009401269', '3', '0.00', '0', '0', null, '0', '0', null, null, null, '2210270009401269', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('139', '1666800952', '2210270015528109', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270015528109', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666800952', '2210270015528109', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('140', '1666801204', '2210270020047229', '1000.00', '0', '119', '', null, '4', '999.90', '掌握', null, '2210270020047229', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801204', '2210270020047229', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('141', '1666801539', '2210270025387512', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025387512', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801539', '2210270025387512', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('142', '1666801541', '2210270025411242', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025411242', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801541', '2210270025411242', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('143', '1666801541', '2210270025417491', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025417491', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801541', '2210270025417491', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('144', '1666801542', '2210270025423032', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025423032', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801542', '2210270025423032', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('145', '1666801543', '2210270025426580', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025426580', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801543', '2210270025426580', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('146', '1666801543', '2210270025439223', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025439223', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801543', '2210270025439223', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('147', '1666801543', '2210270025435278', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025435278', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801543', '2210270025435278', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('148', '1666801543', '2210270025433112', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025433112', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801543', '2210270025433112', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('149', '1666801543', '2210270025432728', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025432728', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801543', '2210270025432728', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('150', '1666801543', '2210270025436790', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025436790', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801543', '2210270025436790', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('151', '1666801544', '2210270025446325', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025446325', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801544', '2210270025446325', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('152', '1666801544', '2210270025441336', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025441336', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801544', '2210270025441336', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('153', '1666801544', '2210270025445048', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025445048', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801544', '2210270025445048', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('154', '1666801544', '2210270025443860', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025443860', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801544', '2210270025443860', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('155', '1666801545', '2210270025444496', '1000.00', '0', '119', '', null, '4', '1000.00', '掌握', null, '2210270025444496', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801545', '2210270025444496', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('156', '1666801573', '2210270026138617', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210270026138617', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801573', '2210270026138617', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('157', '1666801574', '2210270026147105', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026147105', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801574', '2210270026147105', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('158', '1666801574', '2210270026147768', '100.00', '0', '120', '', null, '2', '100.00', '测试', null, '2210270026147768', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801574', '2210270026147768', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('159', '1666801574', '2210270026143848', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026143848', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801574', '2210270026143848', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('160', '1666801575', '2210270026153563', '100.00', '0', '120', '', null, '3', '100.00', '测试', null, '2210270026153563', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801575', '2210270026153563', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('161', '1666801575', '2210270026153908', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026153908', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801575', '2210270026153908', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('162', '1666801575', '2210270026152389', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210270026152389', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801575', '2210270026152389', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('163', '1666801575', '2210270026156630', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026156630', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801575', '2210270026156630', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('164', '1666801605', '2210270026458522', '100.00', '0', '120', '', null, '2', '100.00', '测试', null, '2210270026458522', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801605', '2210270026458522', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('165', '1666801606', '2210270026467889', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026467889', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801606', '2210270026467889', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('166', '1666801606', '2210270026463904', '100.00', '0', '120', '', null, '3', '100.00', '测试', null, '2210270026463904', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801606', '2210270026463904', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('167', '1666801607', '2210270026478756', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026478756', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801607', '2210270026478756', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('168', '1666801607', '2210270026473383', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210270026473383', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801607', '2210270026473383', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('169', '1666801607', '2210270026473831', '100.00', '0', '119', '', null, '4', '100.00', '掌握', null, '2210270026473831', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801607', '2210270026473831', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('170', '1666801607', '2210270026474946', '100.00', '0', '120', '', null, '2', '100.00', '测试', null, '2210270026474946', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801607', '2210270026474946', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('171', '1666801732', '2210270028521755', '100.00', '0', '120', '', null, '3', '100.00', '测试', null, '2210270028521755', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801732', '2210270028521755', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('172', '1666801733', '2210270028533452', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210270028533452', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801733', '2210270028533452', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('173', '1666801734', '2210270028549226', '100.00', '0', '120', '', null, '2', '100.00', '测试', null, '2210270028549226', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801734', '2210270028549226', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('174', '1666801734', '2210270028542182', '100.00', '0', '120', '', null, '3', '100.00', '测试', null, '2210270028542182', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801734', '2210270028542182', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('175', '1666801734', '2210270028547609', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210270028547609', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801734', '2210270028547609', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('176', '1666801734', '2210270028546370', '100.00', '0', '120', '', null, '2', '100.00', '测试', null, '2210270028546370', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801734', '2210270028546370', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('177', '1666801734', '2210270028544291', '100.00', '0', '120', '', null, '3', '100.00', '测试', null, '2210270028544291', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801734', '2210270028544291', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('178', '1666801735', '2210270028555840', '100.00', '0', '120', '', null, '1', '100.00', '测试', null, '2210270028555840', '3', '0.00', '0', '0', null, '0', '0', '97.74.89.67', null, '1666801735', '2210270028555840', null, '1', '1', null, null, 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('180', '1667656198', '2211052149581976', '100.00', '0', '126', '', null, '1715', '100.00', 'ms0002', null, '2211052149581976', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667656198', '2211052149581976', null, '1', '1', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('181', '1667656297', '2211052151375735', '100.00', '0', '126', '', null, '1715', '100.00', 'ms0002', null, '2211052151375735', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667656297', '2211052151375735', null, '1', '1', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('182', '1667656325', '2211052152058709', '100.00', '0', '126', '', null, '1715', '100.00', 'ms0002', null, '2211052152058709', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667656325', '2211052152058709', null, '1', '1', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('183', '1667656330', '2211052152105720', '100.00', '0', '126', '', null, '1715', '100.00', 'ms0002', null, '2211052152105720', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667656330', '2211052152105720', null, '1', '1', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('184', '1667656335', '2211052152151992', '200.00', '0', '126', '', null, '1715', '200.00', 'ms0002', null, '2211052152151992', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667656335', '2211052152151992', null, '1', '1', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('185', '1667723166', '2211061626061422', '200.00', '1', '126', '', '1667723302', '1715', '200.00', 'ms0002', '用户手动调单', '2211061626061422', '32', '0.00', '0', '0', null, '123.139.47.174', '0', '120.53.107.54', null, '1667723166', '2211061626061422', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '1', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('186', '1667723614', '2211061633346901', '500.00', '1', '126', '', '1667723628', '1715', '500.00', 'ms0002', '用户手动调单', '2211061633346901', '32', '0.00', '0', '0', null, '123.139.47.174', '0', '120.53.107.54', null, '1667723614', '2211061633346901', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '1', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('187', '1667723673', '2211061634338784', '10.00', '0', '126', '', null, '1715', '10.00', 'ms0002', null, '2211061634338784', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667723673', '2211061634338784', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('188', '1667726919', '2211061728396750', '60.00', '1', '126', '', '1667727137', '1715', '60.00', 'ms0002', '用户手动调单', '2211061728396750', '32', '0.00', '0', '0', null, '123.139.47.174', '0', '120.53.107.54', null, '1667726919', '2211061728396750', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '1', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('189', '1667728321', '2211061752012772', '60.00', '1', '126', '', '1667758443', '1716', '60.00', 'ms0002', '用户手动调单', '2211061752012772', '32', '0.00', '0', '0', null, '123.139.47.174', '0', '120.53.107.54', null, '1667728321', '2211061752012772', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '2', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('190', '1667728326', '2211061752066156', '30.00', '0', '126', '', null, '1715', '30.00', 'ms0002', null, '2211061752066156', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667728326', '2211061752066156', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('191', '1667728331', '2211061752103462', '30.00', '0', '126', '', null, '1716', '30.00', 'ms0002', null, '2211061752103462', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667728331', '2211061752103462', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');
INSERT INTO `cm_ewm_order` VALUES ('192', '1667728335', '2211061752149016', '5.00', '0', '126', '', null, '1715', '5.00', 'ms0002', null, '2211061752149016', '32', '0.00', '0', '0', null, '0', '0', '120.53.107.54', null, '1667728335', '2211061752149016', null, '1', '5', null, null, 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '0', '', 'addH', '0', '0', '0');

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
  `limit__total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1717 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='码商二维码表';

-- ----------------------------
-- Records of cm_ewm_pay_code
-- ----------------------------
INSERT INTO `cm_ewm_pay_code` VALUES ('1712', '124', '1', '雪糕', '15566669999', '2088512265874154', '1667642914', 'ms001', '5', '0', '1667642914', '0', '0', null, '0', '0', '32', '', '100000.00');
INSERT INTO `cm_ewm_pay_code` VALUES ('1713', '124', '1', '小弟的小弟', '火星银行', '2088512265874154', '1667651692', 'ms001', '5', '0', '1667651692', '0', '0', null, '0', '0', '30', '', '100000.00');
INSERT INTO `cm_ewm_pay_code` VALUES ('1714', '124', '1', '小弟的小弟', '火星银行', '454546512346514', '1667651853', 'ms001', '5', '0', '1667651853', '0', '0', null, '0', '0', '30', '', '100000.00');
INSERT INTO `cm_ewm_pay_code` VALUES ('1715', '126', '1', '雪糕', '15566669999', '2088512265878899', '1667655670', 'ms0002', '6', '0', '1667655670', '0', '0', null, '11', '0', '32', '', '100000.00');
INSERT INTO `cm_ewm_pay_code` VALUES ('1716', '126', '1', '皮皮', '16633221234', '2088512265875544', '1667728306', 'ms0002', '6', '0', '1667728306', '0', '0', null, '2', '0', '32', '', '100000.00');

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
-- Records of cm_gemapay_code
-- ----------------------------

-- ----------------------------
-- Table structure for cm_jobs
-- ----------------------------
DROP TABLE IF EXISTS `cm_jobs`;
CREATE TABLE `cm_jobs` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cm_jobs
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8 COMMENT='基本菜单表';

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
INSERT INTO `cm_menu` VALUES ('153', '0', '100', '支付宝UID', 'admin', 'alipayUid', '0', '', '1', '1667630811', '1667630719');
INSERT INTO `cm_menu` VALUES ('155', '153', '100', '支付宝UID列表', 'admin', 'Ms/uidList', '0', '', '1', '1667654347', '1667630938');
INSERT INTO `cm_menu` VALUES ('156', '153', '100', '支付宝UID订单', 'admin', 'Ms/uidOrder', '0', '', '1', '1667654226', '1667631244');
INSERT INTO `cm_menu` VALUES ('157', '117', '100', '添加码商', 'admin', 'Ms/add', '1', '', '1', '1667651170', '1667651170');
INSERT INTO `cm_menu` VALUES ('158', '156', '100', '获取支付宝UID订单', 'admin', 'Ms/getuidOrdersList', '1', '', '1', '1667654546', '1667654546');
INSERT INTO `cm_menu` VALUES ('159', '155', '100', '获取支付宝UID列表', 'admin', 'Ms/getuidLists', '1', '', '1', '1667654622', '1667654622');
INSERT INTO `cm_menu` VALUES ('160', '103', '100', '获取商户总统计', 'admin', 'User/calList', '1', '', '1', '1667657168', '1667657168');
INSERT INTO `cm_menu` VALUES ('166', '117', '100', '删除码商', 'admin', 'Ms/del', '1', '', '1', '1667755769', '1667755769');
INSERT INTO `cm_menu` VALUES ('167', '117', '100', '设置码商接单状态', 'admin', 'Ms/editMsJdStatus', '1', '', '1', '1667755991', '1667755991');
INSERT INTO `cm_menu` VALUES ('168', '117', '100', '码商费率设置', 'admin', 'Ms/assign_channels', '1', '', '1', '1667756073', '1667756073');
INSERT INTO `cm_menu` VALUES ('169', '117', '100', '码商流水页', 'admin', 'Ms/bills', '1', '', '1', '1667756148', '1667756148');
INSERT INTO `cm_menu` VALUES ('170', '117', '100', '设置码商权重', 'admin', 'Ms/editMsWeight', '1', '', '1', '1667756199', '1667756199');
INSERT INTO `cm_menu` VALUES ('171', '117', '100', '配置码商白名单', 'admin', 'Ms/changeWhiteIp', '1', '', '1', '1667756269', '1667756269');
INSERT INTO `cm_menu` VALUES ('172', '117', '100', '白名单校验口令', 'admin', 'api/checkOpCommand', '1', '', '1', '1667756515', '1667756515');
INSERT INTO `cm_menu` VALUES ('173', '61', '100', '标记商户异常', 'admin', 'User/mark_abnormal', '1', '', '1', '1667756669', '1667756669');
INSERT INTO `cm_menu` VALUES ('174', '61', '100', '商户通道管理', 'admin', 'User/codes', '1', '', '1', '1667756710', '1667756710');
INSERT INTO `cm_menu` VALUES ('175', '61', '100', '商户分润设置', 'admin', 'User/profit', '1', '', '1', '1667756760', '1667756760');
INSERT INTO `cm_menu` VALUES ('176', '61', '100', '商户代付分成设置', 'admin', 'User/daifuProfit', '1', '', '1', '1667756814', '1667756814');
INSERT INTO `cm_menu` VALUES ('177', '61', '100', '重置密钥', 'admin', 'Api/resetKey', '1', '', '1', '1667757548', '1667757548');
INSERT INTO `cm_menu` VALUES ('178', '117', '100', '删除码商收款账号', 'admin', 'Ms/delPayCode', '1', '', '1', '1667757757', '1667757757');
INSERT INTO `cm_menu` VALUES ('179', '117', '100', '拉黑码商订单ip', 'admin', 'Ms/blockIp', '1', '', '1', '1667757857', '1667757857');
INSERT INTO `cm_menu` VALUES ('180', '117', '100', '码商订单退款', 'admin', 'Ms/refundOrder', '1', '', '1', '1667757901', '1667757901');
INSERT INTO `cm_menu` VALUES ('181', '117', '100', '订单姓名不符', 'admin', 'Ms/abnormalOrderSave', '1', '', '1', '1667757955', '1667757955');

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
  `admin_id` int(11) NOT NULL COMMENT '所属管理员ID',
  PRIMARY KEY (`userid`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cm_ms
-- ----------------------------
INSERT INTO `cm_ms` VALUES ('124', '0', 'ms001', '', '', 'ms001', '55468e47920bf79297195b88cacc30e5', 'bGvQ', '0.00', '1667629624', '127.0.0.1', '1', '0', '1', '0', '0', '0.00', '0', '1', 'Xvkc', '63b7305b222451db2d89b666e8c15e40', '749a5503a9caaf77bbbae9fe89071c09', '0', null, '1', null, '0', null, '', null, '0.00', '0.00', '5.00', '0.00', '', 'c8ffe9a587b126f152ed3d89a146b445', '1', '1', '1');
INSERT INTO `cm_ms` VALUES ('125', '0', 'ms002', '', '', 'ms002', '05c1a3ce4e5fd10d1d0526cdb5acd15f', 'KlGP', '0.00', '1667651271', '127.0.0.1', '1', '0', '1', '0', '0', '0.00', '0', '1', '', '', 'bb86a0fc023af330fef52c7bc2418efa', '0', null, '1', null, '0', null, '', null, '0.00', '0.00', '5.00', '0.00', '', '3def184ad8f4755ff269862ea77393dd', '1', '1', '5');
INSERT INTO `cm_ms` VALUES ('126', '0', 'ms0002', '', '', 'ms0002', 'f3225d0fce2c15a8430fd2bf39837eb2', '9moK', '99180.00', '1667651434', '127.0.0.1', '1', '0', '1', '0', '0', '0.00', '0', '1', 'iUZp', '764fa8866afcf3b39d48ed6134baae10', '1802df7debcc082f30103f934b59b3da', '0', null, '1', null, '0', null, '', null, '0.00', '0.00', '6.00', '0.00', '', '069059b7ef840f0c74a814ec9237b6ec', '1', '1', '5');
INSERT INTO `cm_ms` VALUES ('127', '126', 'ms0002的小弟', '', '', 'ms0002的小弟', '597a703d7db3e00e5c9990b624d30000', '9RUI', '100.00', '1667753166', '123.139.47.174', '-1', '0', '1', '0', '0', '0.00', '0', '1', '', '', 'df25758d1ed5b00ead416e4dd2c6ff25', '0', null, '1', '1667756412', '0', null, '', null, '0.00', '0.00', '0.00', '0.00', '', 'ec5decca5ed3d6b8079e2e7e7bacc9f2', '5', '2', '5');

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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cm_ms_rate
-- ----------------------------
INSERT INTO `cm_ms_rate` VALUES ('1', '42', '33', '3.000', '1667114332', '1667114332');
INSERT INTO `cm_ms_rate` VALUES ('2', '127', '33', '5.000', '1667756394', '1667756394');

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='码商流水账单';

-- ----------------------------
-- Records of cm_ms_somebill
-- ----------------------------
INSERT INTO `cm_ms_somebill` VALUES ('11', '126', '8', '后台管理员账变', '1667654705', '+', '100000.00', '0.00', '100000.00');
INSERT INTO `cm_ms_somebill` VALUES ('15', '126', '3', '2211061626061422', '1667723302', '-', '200.00', '100000.00', '99800.00');
INSERT INTO `cm_ms_somebill` VALUES ('16', '126', '3', '2211061633346901', '1667723628', '-', '500.00', '99800.00', '99300.00');
INSERT INTO `cm_ms_somebill` VALUES ('19', '126', '3', '2211061728396750', '1667727137', '-', '60.00', '99300.00', '99240.00');
INSERT INTO `cm_ms_somebill` VALUES ('22', '127', '8', '后台管理员账变', '1667756581', '+', '100.00', '0.00', '100.00');
INSERT INTO `cm_ms_somebill` VALUES ('24', '126', '3', '2211061752012772', '1667758443', '-', '60.00', '99240.00', '99180.00');

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
-- Records of cm_ms_white_ip
-- ----------------------------

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
-- Records of cm_notice
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COMMENT='交易订单表';

-- ----------------------------
-- Records of cm_orders
-- ----------------------------
INSERT INTO `cm_orders` VALUES ('221', '0', '100284', '2211052132112373', '2211052132112373', '数码办公', 'addH', 'alipayUid', '0', '[]', '100.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655131', '1667655131', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('222', '0', '100284', '2211052132174359', '2211052132174359', '手机通讯', 'addH', 'alipayUid', '0', '[]', '500.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655137', '1667655137', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('223', '0', '100284', '2211052134058050', '2211052134058050', '服饰鞋包', 'addH', 'alipayUid', '0', '[]', '500.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655245', '1667655245', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('224', '0', '100284', '2211052136283283', '2211052136283283', '服饰鞋包', 'addH', 'alipayUid', '0', '[]', '500.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655388', '1667655388', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('225', '0', '100284', '2211052140119920', '2211052140119920', '汽车用品', 'addH', 'alipayUid', '0', '[]', '100.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655611', '1667655611', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('226', '0', '100284', '2211052141223264', '2211052141223264', '珠宝', 'addH', 'alipayUid', '0', '[]', '500.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655683', '1667655683', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('227', '0', '100284', '2211052141291070', '2211052141291070', '珠宝', 'addH', 'alipayUid', '0', '[]', '100.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655689', '1667655689', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('228', '0', '100284', '2211052142482850', '2211052142482850', '玩具乐器', 'addH', 'alipayUid', '0', '[]', '100.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655768', '1667655768', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('229', '0', '100284', '2211052144581467', '2211052144581467', '汽车用品', 'addH', 'alipayUid', '0', '[]', '100.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655898', '1667655898', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('230', '0', '100284', '2211052146347777', '2211052146347777', '化妆品', 'addH', 'alipayUid', '195', '[]', '100.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667655994', '1667655994', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('231', '0', '100284', '2211052149581976', '2211052149581976', '汽车用品', 'addH', 'alipayUid', '195', '[]', '100.000', '100.000', '100.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667656198', '1667721885', '码商126修改订单:2211052149581976状态', '0', '0.000', '', '', '0', '0.020', 'no');
INSERT INTO `cm_orders` VALUES ('232', '0', '100284', '2211052151375735', '2211052151375735', '食品饮料', 'addH', 'alipayUid', '195', '[]', '100.000', '100.000', '100.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667656297', '1667722218', '码商126修改订单:2211052151375735状态', '0', '0.000', '', '', '0', '0.020', 'no');
INSERT INTO `cm_orders` VALUES ('233', '0', '100284', '2211052152058709', '2211052152058709', '手表', 'addH', 'alipayUid', '195', '[]', '100.000', '100.000', '100.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667656325', '1667721436', '码商126修改订单:2211052152058709状态', '0', '0.000', '', '', '0', '0.026', 'no');
INSERT INTO `cm_orders` VALUES ('234', '0', '100284', '2211052152105720', '2211052152105720', '食品饮料', 'addH', 'alipayUid', '195', '[]', '100.000', '100.000', '100.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667656330', '1667721349', '', '0', '0.000', '', '', '0', '0.027', 'no');
INSERT INTO `cm_orders` VALUES ('235', '0', '100284', '2211052152151992', '2211052152151992', '手表', 'addH', 'alipayUid', '195', '[]', '200.000', '200.000', '200.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667656335', '1667718786', '1', '0', '0.000', '', '', '0', '0.023', 'no');
INSERT INTO `cm_orders` VALUES ('236', '0', '100284', '2211061623195026', '2211061623195026', '服饰鞋包', 'addH', 'alipayUid', '195', '[]', '200.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667722999', '1667722999', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('237', '0', '100284', '2211061624498970', '2211061624498970', '手机通讯', 'addH', 'alipayUid', '195', '[]', '200.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667723089', '1667723089', '', '0', '0.000', '', '', '0', '0.000', 'no');
INSERT INTO `cm_orders` VALUES ('238', '0', '100284', '2211061626061422', '2211061626061422', '手表', 'addH', 'alipayUid', '195', '[]', '200.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667723166', '1667723166', '码商确认收款通知支付系统单号2211061626061422', '0', '0.000', '', '', '0', '0.023', 'no');
INSERT INTO `cm_orders` VALUES ('239', '0', '100284', '2211061633346901', '2211061633346901', '电脑配件', 'addH', 'alipayUid', '195', '[]', '500.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667723614', '1667723614', '码商126确认收款通知支付系统单号2211061633346901', '0', '0.000', '', '', '0', '0.023', 'no');
INSERT INTO `cm_orders` VALUES ('240', '0', '100284', '2211061634338784', '2211061634338784', '电脑配件', 'addH', 'alipayUid', '195', '[]', '10.000', '10.000', '10.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667723673', '1667723692', '1', '0', '0.000', '', '', '0', '0.026', 'no');
INSERT INTO `cm_orders` VALUES ('241', '0', '100284', '2211061728396750', '2211061728396750', '化妆品', 'addH', 'alipayUid', '195', '[]', '60.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667726919', '1667727137', '码商126确认收款通知支付系统单号2211061728396750', '0', '0.000', '', '', '0', '0.021', 'no');
INSERT INTO `cm_orders` VALUES ('242', '0', '100284', '2211061752012772', '2211061752012772', '手机通讯', 'addH', 'alipayUid', '195', '[]', '60.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '2', '1667728321', '1667758443', '后台确认收款通知支付系统单号2211061752012772', '0', '0.000', '', '', '0', '0.022', 'no');
INSERT INTO `cm_orders` VALUES ('243', '0', '100284', '2211061752066156', '2211061752066156', '汽车用品', 'addH', 'alipayUid', '195', '[]', '30.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667728326', '1667728326', '', '0', '0.000', '', '', '0', '0.035', 'no');
INSERT INTO `cm_orders` VALUES ('244', '0', '100284', '2211061752103462', '2211061752103462', '化妆品', 'addH', 'alipayUid', '195', '[]', '30.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667728331', '1667728331', '', '0', '0.000', '', '', '0', '0.022', 'no');
INSERT INTO `cm_orders` VALUES ('245', '0', '100284', '2211061752149016', '2211061752149016', '汽车用品', 'addH', 'alipayUid', '195', '[]', '5.000', '0.000', '0.000', '0.000', '0.000', 'RMB', '192.168.0.1', 'ta.sxwzrj.cn/test/return.php', 'ta.sxwzrj.cn/test/notify.php', '1', '1667728335', '1667728335', '', '0', '0.000', '', '', '0', '0.022', 'no');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='交易订单通知表';

-- ----------------------------
-- Records of cm_orders_notify
-- ----------------------------
INSERT INTO `cm_orders_notify` VALUES ('1', '235', '404', '', '0', '1667718786', '1667718786');
INSERT INTO `cm_orders_notify` VALUES ('2', '234', '404', '', '0', '1667721349', '1667721349');
INSERT INTO `cm_orders_notify` VALUES ('3', '233', '404', '', '0', '1667721436', '1667721436');
INSERT INTO `cm_orders_notify` VALUES ('4', '231', '404', '', '0', '1667721885', '1667721885');
INSERT INTO `cm_orders_notify` VALUES ('5', '232', '404', '', '0', '1667722218', '1667722218');
INSERT INTO `cm_orders_notify` VALUES ('6', '238', '404', '', '0', '1667723302', '1667723302');
INSERT INTO `cm_orders_notify` VALUES ('7', '239', '404', '', '0', '1667723628', '1667723628');
INSERT INTO `cm_orders_notify` VALUES ('8', '240', '404', '', '0', '1667723692', '1667723692');
INSERT INTO `cm_orders_notify` VALUES ('9', '241', '404', '', '0', '1667727137', '1667727137');
INSERT INTO `cm_orders_notify` VALUES ('11', '242', '404', '', '0', '1667758443', '1667758443');

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
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道账户表';

-- ----------------------------
-- Records of cm_pay_account
-- ----------------------------
INSERT INTO `cm_pay_account` VALUES ('193', '33', '30', '卡转卡', '0.000', '1.000', '0.998', '10000.000', '10000.000', '{\"start\":\"00:00:00\",\"end\":\"23:59:59\"}', '{&quot;mch_id&quot;:&quot;商户支付号&quot;,&quot;mch_key&quot;:&quot;商户支付KEY&quot;,&quot;app_id&quot;:&quot;商户应用号&quot;,&quot;app_key&quot;:&quot;应用KEY&quot;}', '备注', '1', '1666212550', '1666212550', '10000.000', '0.000');
INSERT INTO `cm_pay_account` VALUES ('194', '33', '31', '支付宝UID', '0.000', '1.000', '0.998', '10000.000', '10000.000', '{\"start\":\"00:00:00\",\"end\":\"23:59:59\"}', '{&quot;mch_id&quot;:&quot;商户支付号&quot;,&quot;mch_key&quot;:&quot;商户支付KEY&quot;,&quot;app_id&quot;:&quot;商户应用号&quot;,&quot;app_key&quot;:&quot;应用KEY&quot;}', '备注', '1', '1667648386', '1667648386', '10000.000', '0.000');
INSERT INTO `cm_pay_account` VALUES ('195', '34', '31', '支付宝UID', '0.000', '1.000', '0.998', '10000.000', '10000.000', '{\"start\":\"00:00:00\",\"end\":\"23:59:59\"}', '{&quot;mch_id&quot;:&quot;商户支付号&quot;,&quot;mch_key&quot;:&quot;商户支付KEY&quot;,&quot;app_id&quot;:&quot;商户应用号&quot;,&quot;app_key&quot;:&quot;应用KEY&quot;}', '备注', '1', '1667655982', '1667655982', '10000.000', '0.000');

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道表';

-- ----------------------------
-- Records of cm_pay_channel
-- ----------------------------
INSERT INTO `cm_pay_channel` VALUES ('33', '卡转卡', 'GumaV2Pay', '1.000', '0.998', '{\"start\":\"00:00:00\",\"end\":\"23:59:59\"}', 'http://xxxx/api/notify/notify/channel/GumaV2Pay', 'http://xxxx//api/notify/notify/channel/GumaV2Pay', '1', '1', '1666212536', '1666212536', '127.0.0.1', '1', '0.000', '0.000', '', 'cf1276eccede652bddf81be87ce1fd9b', '');
INSERT INTO `cm_pay_channel` VALUES ('34', '支付宝UID', 'GumaV2Pay', '1.000', '0.998', '{\"start\":\"00:00:00\",\"end\":\"23:59:59\"}', 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', 'http://ta.sxwzrj.cn/api/notify/notify/channel/GumaV2Pay', '1', '1', '1667648360', '1667648360', '127.0.0.1', '1', '0.000', '0.000', '', '2f316ece078407b8d1a1245c9a91d6d6', '');

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
-- Records of cm_pay_channel_change
-- ----------------------------

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
-- Records of cm_pay_channel_price_weight
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='交易方式表';

-- ----------------------------
-- Records of cm_pay_code
-- ----------------------------
INSERT INTO `cm_pay_code` VALUES ('30', '33', '卡转卡', 'kzk', '卡转卡', '1', '1666212478', '1666790612', '');
INSERT INTO `cm_pay_code` VALUES ('31', '34', '支付宝UID', 'alipayUid', '支付宝UID', '1', '1667648335', '1667648392', '');

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
-- Records of cm_shop
-- ----------------------------

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
-- Records of cm_tg_query_order_records
-- ----------------------------

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
-- Records of cm_transaction
-- ----------------------------

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
  `admin_id` int(11) NOT NULL COMMENT '所属管理员ID',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_name_unique` (`account`,`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100285 DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';

-- ----------------------------
-- Records of cm_user
-- ----------------------------
INSERT INTO `cm_user` VALUES ('100281', '0', '666@qq.com', '雪糕来了', null, 'd31f4b567830340af5ec399e4e4da8d6', '', '', '0', '1', '0', '1', '1667634546', '1667634546', '0', '0', '', '0', '0', '0', '0', '', '0', '9fe6f4d1ef8fab724cc1779b732a042d', '', '0', '1');
INSERT INTO `cm_user` VALUES ('100283', '0', '9888@qq.com', '小米来了', null, 'd31f4b567830340af5ec399e4e4da8d6', '', '', '0', '1', '0', '1', '1667650925', '1667650925', '0', '0', '', '0', '0', '0', '0', '', '0', 'a636f784ea91e180aac9e1b229d1a7a9', '', '0', '4');
INSERT INTO `cm_user` VALUES ('100284', '0', '9999@qq.com', '皮皮来啦', null, 'd31f4b567830340af5ec399e4e4da8d6', '', '', '1', '1', '0', '1', '1667654770', '1667757369', '0', '0', '', '0', '0', '0', '0', '', '0', '2bb503e6dad62e38e09fc4a32a029bbc', '', '0', '5');

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='商户结算账户表';

-- ----------------------------
-- Records of cm_user_account
-- ----------------------------
INSERT INTO `cm_user_account` VALUES ('16', '100281', '1', '', '', '', '0', '0', '1667634546', '1667634546', '');
INSERT INTO `cm_user_account` VALUES ('18', '100283', '1', '', '', '', '0', '0', '1667650925', '1667650925', '');
INSERT INTO `cm_user_account` VALUES ('19', '100284', '1', '', '', '', '0', '0', '1667654770', '1667654770', '');

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
-- Records of cm_user_auth
-- ----------------------------

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
-- Records of cm_user_daifuprofit
-- ----------------------------

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
-- Records of cm_user_padmin
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='·æ¯ä»æ¸ éè¡¨å³èpay_code';

-- ----------------------------
-- Records of cm_user_pay_code
-- ----------------------------
INSERT INTO `cm_user_pay_code` VALUES ('8', '100283', '31', '1', '1667655356', '0');
INSERT INTO `cm_user_pay_code` VALUES ('9', '100281', '31', '1', '1667655356', '0');
INSERT INTO `cm_user_pay_code` VALUES ('10', '100284', '31', '1', '0', '0');
INSERT INTO `cm_user_pay_code` VALUES ('11', '100284', '30', '1', '0', '0');

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
-- Records of cm_user_pay_code_appoint
-- ----------------------------

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

-- ----------------------------
-- Records of cm_user_profit
-- ----------------------------
