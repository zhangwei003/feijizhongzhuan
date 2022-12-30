/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : statistical_bot

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2022-12-29 21:08:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cm_tg_trading_house_data
-- ----------------------------
DROP TABLE IF EXISTS `cm_tg_trading_house_data`;
CREATE TABLE `cm_tg_trading_house_data` (
  `merchant_name` varchar(255) NOT NULL,
  `price_buy` decimal(10,2) NOT NULL,
  `pay_method` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cm_tg_trading_house_data
-- ----------------------------
INSERT INTO `cm_tg_trading_house_data` VALUES ('大白商行', '6.85', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('币圈梧桐引君来', '6.85', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('权威商贸', '6.85', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('买我币暴富商行', '6.85', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('小万达大卖部', '6.85', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('万润商贸', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('永胜币商', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('星际资本', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('手机1号都在线', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('宇航商贸壹号', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('鼎立商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('飞卓商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('鼎道帝白资商', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('华源资本', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('平凡的人', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('小黑哥查流水', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('白资交易机构', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('信誉币铺', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('隐藏的大佬', '6.86', '银行卡,支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('夏天', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('斯文商行', '6.86', '银行卡,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('Super瑶瑶', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('买我币必发财', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('南峰商贸', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('煎饼没果子', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('少珩商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('风神安全有保障', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('家家商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('华信商城', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('合约客户', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('无敌小宇宙', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('和我交易必發财', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('支持花呗信用卡', '6.86', '银行卡,支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('意气风发', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('A尚好商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('牛牛信誉商行', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('信誉资本商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('九州华城', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('吉利商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('宁顺商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('老商家只做安全', '6.86', '银行卡,支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('买我必赚', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('U商丸子', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('拒黑秒放商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('恒发升隆', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('伟骏商行', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('小米粒商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('马斯克诚信币行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('小金宝', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('青河尚易', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('旺旺币币行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('币圈老掌柜', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('信泰商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('老兵商家', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('嚣张胖星人', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('贷款理财老商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('玖富商行', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('自信商人', '6.86', '银行卡,支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('大哥大商行', '6.86', '银行卡,支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('币圈好多多', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('伯爵商行', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('徽皖商行', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('明日之星.商行', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('向日葵', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('思瑞商', '6.86', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('努力搬砖', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('买我币暴富商行', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('黄掌柜', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('郝旺商行', '6.86', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('非零传说', '6.86', '银行卡,支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('可爱女人', '6.86', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('金福币通商行', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('拒黑…秒放', '6.86', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('大帝国行', '6.87', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('妮儿商行', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('小小诚信币商', '6.87', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('浩瀚', '6.87', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('永胜币商', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('長远商行', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('无敌大鲤鱼', '6.87', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('哈啰商行888', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('张记商贸', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('老汤姆诚信商行', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('手机1号都在线', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('安全重于泰山', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('東耀商行', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('实名安全商行', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('迈巴赫币商', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('盛源资本', '6.87', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('宇航商贸壹号', '6.87', '银行卡');
INSERT INTO `cm_tg_trading_house_data` VALUES ('日日兴商行', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('静待繁花', '6.87', '支付宝');
INSERT INTO `cm_tg_trading_house_data` VALUES ('九运开元商行', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('恒鑫商行', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('飞扬商行', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('大炮币庄', '6.87', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('大伟商行秒放', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('春意盎然商家', '6.87', '微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('财富用心服务', '6.87', '支付宝,微信支付');
INSERT INTO `cm_tg_trading_house_data` VALUES ('诚速商家', '6.87', '银行卡');
