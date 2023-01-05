alter table `cm_tg_trading_house_data` add column  `id` int(11) NOT NULL AUTO_INCREMENT;

alter table `cm_tg_statistics_group` add column `rk_rate` double(5,2) NOT NULL COMMENT '入款费率';

CREATE TABLE `cm_tg_inline_keyboards` (
                                          `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                          `group_id` int(11) NOT NULL,
                                          `text` varchar(255) DEFAULT NULL,
                                          `url` varchar(255) DEFAULT NULL,
                                          `status` tinyint(1) DEFAULT '1',
                                          `create_time` int(11) DEFAULT '1',
                                          `update_time` int(11) DEFAULT NULL,
                                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;