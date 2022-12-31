alter table `cm_tg_trading_house_data` add column  `id` int(11) NOT NULL AUTO_INCREMENT;

alter table `cm_tg_statistics_group` add column `rk_rate` double(5,2) NOT NULL COMMENT '入款费率';
