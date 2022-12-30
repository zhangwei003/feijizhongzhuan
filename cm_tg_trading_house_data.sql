/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : statistical_bot

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2022-12-30 18:52:46
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cm_tg_trading_house_data
-- ----------------------------
INSERT INTO `cm_tg_trading_house_data` VALUES ('1', '闽A诚信商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('2', '天府之国币行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('3', '龙华商贸', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('4', '无忧国际币商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('5', '靠谱商家', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('6', '信誉币铺', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('7', '五年老商家安全', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('8', '蓝海资本', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('9', '隐藏的大佬', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('10', '老字号商行拒黑', '6.86', '银行卡');
