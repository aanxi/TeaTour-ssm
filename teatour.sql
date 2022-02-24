-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.26 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 teatour 的数据库结构
CREATE DATABASE IF NOT EXISTS `teatour` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `teatour`;

-- 导出  表 teatour.category 结构
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '分类的名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.category 的数据：~16 rows (大约)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `name`) VALUES
	(1, '茶叶'),
	(2, '袋泡茶');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- 导出  表 teatour.order_ 结构
CREATE TABLE IF NOT EXISTS `order_` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `order_code` varchar(255) NOT NULL COMMENT '订单号',
  `address` varchar(255) NOT NULL COMMENT '收货地址',
  `post` varchar(255) NOT NULL COMMENT '邮编',
  `receiver` varchar(255) NOT NULL COMMENT '收货人姓名',
  `mobile` varchar(255) NOT NULL COMMENT '手机号码',
  `user_message` varchar(255) NOT NULL COMMENT '用户备注的信息',
  `create_date` datetime NOT NULL COMMENT '订单创建时间',
  `pay_date` datetime DEFAULT NULL COMMENT '订单支付时间',
  `delivery_date` datetime DEFAULT NULL COMMENT '发货日期',
  `confirm_date` datetime DEFAULT NULL COMMENT '确认收货日期',
  `user_id` int(11) DEFAULT NULL COMMENT '对应的用户id',
  `status` varchar(255) NOT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`),
  KEY `fk_order_user` (`user_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.order 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `order_` DISABLE KEYS */;
INSERT INTO `order_` (`id`, `order_code`, `address`, `post`, `receiver`, `mobile`, `user_message`, `create_date`, `pay_date`, `delivery_date`, `confirm_date`, `user_id`, `status`) VALUES
	(1, '123456', '地球村', '', '测试账号1', '', '', '2021-11-30 00:00:00', '2022-04-29 00:00:00', '2022-04-29 00:00:00', '2022-04-29 00:00:00', 1, 'delete'),
	(10, '20220210143826504', '123123', '测试账号1', '', '12345678910', '', '2022-02-06 00:00:00', '2022-02-06 00:00:00', NULL, NULL, 1, 'delete'),
	(11, '20220211092435428', '详细地址', '', '测试账号1', '12345678910', '卖家留言', '2022-02-07 00:00:00', '2022-02-07 00:00:00', NULL, NULL, 1, 'finish'),
	(12, '20220212180327444', '123', '', '测试账号1', '12345678910', '', '2022-02-07 00:00:00', '2022-02-07 00:00:00', '2022-02-07 00:00:00', '2022-02-07 00:00:00', 1, 'finish'),
	(13, '20220207205110309', '', '', '', '', '', '2022-02-07 00:00:00', '2022-02-07 20:51:56', NULL, NULL, 1, 'waitDelivery'),
	(14, '20220216093257383', '', '', '', '', '', '2022-02-16 00:00:00', '2022-02-16 09:32:59', NULL, NULL, 1, 'waitReview');
/*!40000 ALTER TABLE `order_` ENABLE KEYS */;


-- 导出  表 teatour.order_item 结构
CREATE TABLE IF NOT EXISTS `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `product_id` int(11) NOT NULL COMMENT '对应产品id',
  `order_id` int(11) DEFAULT NULL COMMENT '对应订单id',
  `user_id` int(11) NOT NULL COMMENT '对应用户id',
  `number` int(11) DEFAULT NULL COMMENT '对应产品购买的数量',
  PRIMARY KEY (`id`),
  KEY `fk_order_item_product` (`product_id`),
  KEY `fk_order_item_order` (`order_id`),
  KEY `fk_order_item_user` (`user_id`),
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `order_` (`id`),
  CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_order_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.order_item 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` (`id`, `product_id`, `order_id`, `user_id`, `number`) VALUES
	(14, 4, 11, 1, 1),
	(15, 6, 11, 1, 1),
	(16, 4, NULL, 1, 5),
	(17, 4, 12, 1, 1),
	(18, 6, 13, 1, 1),
	(19, 6, 14, 4, 1);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;

-- 导出  表 teatour.product 结构
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '产品的名称',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '小标题',
  `price` float DEFAULT NULL COMMENT '价格',
  `sale` int(11) DEFAULT NULL COMMENT '销量',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `category_id` int(11) DEFAULT NULL COMMENT '对应的分类id',
  PRIMARY KEY (`id`),
  KEY `fk_product_category` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.product 的数据：~17 rows (大约)
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `name`, `sub_title`, `price`, `sale`, `stock`, `category_id`) VALUES
	(4, '【约茶】灵感一周茶礼盒挂耳茶包袋泡茶伴手礼物7包/盒', ' ', 48, 107769, 9999, 2),
	(5, '【约茶】水果茶茶包多种口味果茶组合全家福冷泡茶泡茶茶花袋泡茶', ' ', 129, 1148, 9999, 2),
	(6, '龙井茶叶绿茶2021年新茶250g礼盒西湖龙井正宗雨前级浓香型散装', '浓香扑鼻', 325, 946, 9999, 1),
	(7, '单丛茶潮州凤凰鸭屎香茶凤凰单枞特级单从乌岽乌龙茶茶叶春大乌叶', ' ', 228, 9543, 9999, 1),
	(8, '正宗新会大红柑柑普茶生晒天马柑橘陈皮普洱茶熟茶叶500g', ' ', 238, 4909, 9999, 1),
	(9, '【约茶】花茶冷泡茶柠檬红茶莓果蜜桃茶组合便携装40包',  ' ', 89, 107769, 9999, 2),
	(10, '【约茶】袋泡绿茶/抹茶0脂肪0蔗糖茶包热冷泡15杯2盒装 ',  ' ', 79, 10203, 9999, 2),
	(11, '【约茶】葡萄乌龙茶茶包水果茶蜜桃乌龙茶冷泡茶白桃乌龙袋泡茶 ',  ' ', 59, 10203, 9998, 2),
	(12, '黄山毛峰2021新茶正宗特级茶绿茶茶叶500g安徽毛尖散装罐装礼盒装 ', '浓香扑鼻', 199, 946, 9999, 1),
	(13, '金骏眉红茶蜜香武夷山金俊眉散装罐装特级茶叶过节送礼盒装 ', '浓香扑鼻', 159, 946, 9999, 1),
	(14, '武夷山岩茶大红袍茶叶礼盒装特级正宗浓香型正岩肉桂茶500g散袋装 ', '浓香扑鼻', 189, 946, 9999, 1),
	(15, '蝴蝶白茶 福鼎白茶老树白牡丹茶饼整提装2310克7饼 ', '浓香扑鼻', 619, 946, 9999, 1),
	(16, '蒙顶甘露2021新茶老川茶四川雅安名山浓香茶叶纯手工甘露散装250g', '浓香扑鼻', 389, 946, 9999, 1),
	(17, '小户赛古树普洱熟茶小饼 春茶发酵醇厚饱满 ', '浓香扑鼻', 226, 946, 9999, 1),
	(18, '【约茶】养生三角茶袋29种原料组合花草便携装40包',  ' ', 89, 107769, 9999, 2),
	(19, '【约茶】柑橘柠檬冷泡茶组合便携装10包',  ' ', 89, 107769, 9999, 2),
	(20, '【约茶】多味莓果茉莉冷泡茶组合便携装20包',  ' ', 89, 107769, 9999, 2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 导出  表 teatour.product_image 结构
CREATE TABLE IF NOT EXISTS `product_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `product_id` int(11) DEFAULT NULL COMMENT '对应的产品id',
  PRIMARY KEY (`id`),
  KEY `fk_product_image_product` (`product_id`),
  CONSTRAINT `fk_product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.product_image 的数据：~80 rows (大约)
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` (`id`, `product_id`) VALUES
	(11, 4),
	(12, 4),
	(13, 4),
	(14, 4),
	(15, 4),
	(16, 5),
	(17, 5),
	(18, 5),
	(19, 5),
	(20, 5),
	(21, 6),
	(22, 6),
	(23, 6),
	(24, 6),
	(25, 6),
	(26, 7),
	(27, 7),
	(28, 7),
	(29, 7),
	(30, 7),
	(31, 8),
	(32, 8),
	(33, 8),
	(34, 8),
	(35, 8),
	(36, 9),
	(37, 9),
	(38, 9),
	(39, 9),
	(40, 9),
	(41, 10),
	(42, 10),
	(43, 10),
	(44, 10),
	(45, 10),
	(46, 11),
	(47, 11),
	(48, 11),
	(49, 11),
	(50, 11),
	(51, 12),
	(52, 12),
	(53, 12),
	(54, 12),
	(55, 12),
	(56, 13),
	(57, 13),
	(58, 13),
	(59, 13),
	(60, 13),
	(61, 14),
	(62, 14),
	(63, 14),
	(64, 14),
	(65, 14),
	(66, 15),
	(67, 15),
	(68, 15),
	(69, 15),
	(70, 15),
	(71, 16),
	(72, 16),
	(73, 16),
	(74, 16),
	(75, 16),
	(76, 17),
	(77, 17),
	(78, 17),
	(79, 17),
	(80, 17),
	(81, 18),
	(82, 18),
	(83, 18),
	(84, 18),
	(85, 18),
	(86, 19),
	(87, 19),
	(88, 19),
	(89, 19),
	(90, 19),
	(91, 20),
	(92, 20),
	(93, 20),
	(94, 20),
	(95, 20);
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;

-- 导出  表 teatour.property 结构
CREATE TABLE IF NOT EXISTS `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) DEFAULT NULL COMMENT '属性名称',
  `category_id` int(11) NOT NULL COMMENT '对应的分类id',
  PRIMARY KEY (`id`),
  KEY `fk_property_category` (`category_id`),
  CONSTRAINT `fk_property_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.property 的数据：~5 rows (大约)
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` (`id`, `name`, `category_id`) VALUES
	(1, '净含量', 4),
	(2, '口味', 1),
	(3, '品种', 2),
	(4, '净含量', 1),
	(5, '口味', 1),
	(6, '品种', 2);

/*!40000 ALTER TABLE `property` ENABLE KEYS */;

-- 导出  表 teatour.property_value 结构
CREATE TABLE IF NOT EXISTS `property_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `product_id` int(11) NOT NULL COMMENT '对应产品id',
  `property_id` int(11) NOT NULL COMMENT '对应属性id',
  `value` varchar(255) DEFAULT NULL COMMENT '具体的属性值',
  PRIMARY KEY (`id`),
  KEY `fk_property_value_property` (`property_id`),
  KEY `fk_property_value_product` (`product_id`),
  CONSTRAINT `fk_property_value_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_property_value_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.property_value 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `property_value` DISABLE KEYS */;
INSERT INTO `property_value` (`id`, `product_id`, `property_id`, `value`) VALUES
	(1, 4, 1, '10g*7'),
	(2, 4, 2, '白桃味'),
	(3, 4, 3, '加工茶'),
               (4, 6, 4, '100g'),
	(5, 6, 5, '浓香'),
	(6, 6, 6, '鸭屎香');
/*!40000 ALTER TABLE `property_value` ENABLE KEYS */;


-- 导出  表 teatour.review 结构
CREATE TABLE IF NOT EXISTS `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `content` varchar(4000) DEFAULT NULL COMMENT '评价内容',
  `user_id` int(11) NOT NULL COMMENT '对应的用户id',
  `product_id` int(11) NOT NULL COMMENT '对应的产品id',
  `createDate` datetime DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `fk_review_product` (`product_id`),
  KEY `fk_review_user` (`user_id`),
  CONSTRAINT `fk_review_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.review 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` (`id`, `content`, `user_id`, `product_id`, `createDate`) VALUES
	(2, '好评！！！！', 1, 4, '2022-02-10 10:24:02'),
	(3, '非常香', 1, 4, '2022-02-10 10:42:07'),
	(6, '口味很特别很好喝，让我喝水不再痛苦', 1, 4, '2022-02-10 10:49:09'),
	(7, '非常奇特的香味', 1, 6, '2022-02-10 11:01:06'),
	(8, '茶很好，用来送人的', 1, 6, '2022-02-10 18:05:09'),
	(9, '非常好，下次还会回购', 1, 8, '2022-02-10 20:59:49');

-- 导出  表 teatour.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '用户名称',
  `password` varchar(255) NOT NULL COMMENT '用户密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.user 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `name`, `password`) VALUES
	(1, '测试账号1', '123'),
	(2, '测试账号2', '123'),
	(3, '测试账号3', '123'),
	(4, '测试账号4', '123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- 导出  表 teatour.teaGardenCategory 结构
CREATE TABLE IF NOT EXISTS `teaGardenCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '分类的名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.teaGardenCategory 的数据：~16 rows (大约)
/*!40000 ALTER TABLE `teaGardenCategory` DISABLE KEYS */;
INSERT INTO `teaGardenCategory` (`id`, `name`) VALUES
	(1, '茶园');

/*!40000 ALTER TABLE `teaGardenCategory` ENABLE KEYS */;

-- 导出  表 teatour.appointment_ 结构
CREATE TABLE IF NOT EXISTS `appointment_` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `appointment_code` varchar(255) NOT NULL COMMENT '订单号',
  `address` varchar(255)  COMMENT '收货地址',
  `post` varchar(255) COMMENT '邮编',
  `receiver` varchar(255) NOT NULL COMMENT '收货人姓名',
  `mobile` varchar(255) NOT NULL COMMENT '手机号码',
  `user_message` varchar(255) COMMENT '用户备注的信息',
  `create_date` datetime COMMENT '订单创建时间',
  `pay_date` datetime DEFAULT NULL COMMENT '订单支付时间',
  `delivery_date` datetime DEFAULT NULL COMMENT '发货日期',
  `confirm_date` datetime DEFAULT NULL COMMENT '确认收货日期',
  `user_id` int(11) DEFAULT NULL COMMENT '对应的用户id',
  `status` varchar(255) NOT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`),
  KEY `fk_appointment_user` (`user_id`),
  CONSTRAINT `fk_appointment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.appointment 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `appointment_` DISABLE KEYS */;
INSERT INTO `appointment_` (`id`, `appointment_code`, `address`, `post`, `receiver`, `mobile`, `user_message`, `create_date`, `pay_date`, `delivery_date`, `confirm_date`, `user_id`, `status`) VALUES
	(1, '20220504143826508', '2022-05-04', '', '测试账号1', '', '', '2021-11-30 00:00:00', '2022-04-29 00:00:00', '2022-04-29 00:00:00', '2022-04-29 00:00:00', 1, 'delete'),
	(10, '20220210143826504', '2022-03-04', '测试账号1', '', '12345678910', '', '2022-02-06 00:00:00', '2022-02-06 00:00:00', NULL, NULL, 1, 'delete'),
	(11, '20220211092435428', '2022-03-04', '', '测试账号1', '12345678910', '留言', '2022-02-07 00:00:00', '2022-02-07 00:00:00', NULL, NULL, 1, 'finish'),
	(12, '20220212180327444', '2022-03-04', '', '测试账号1', '12345678910', '', '2022-02-07 00:00:00', '2022-02-07 00:00:00', '2022-02-07 00:00:00', '2022-02-07 00:00:00', 1, 'waitTeaGardenReview'),
	(13, '20220207205110309', '2022-03-04', '测试账号1', '', '', '', '2022-02-07 00:00:00', '2022-02-07 20:51:56', NULL, NULL, 1, 'waitDelivery'),
	(14, '20220216093257383', '2022-03-04', '测试账号4', '', '', '', '2022-02-16 00:00:00', '2022-02-16 09:32:59', NULL, NULL, 4, 'waitTeaGardenReview');
/*!40000 ALTER TABLE `appointment_` ENABLE KEYS */;


-- 导出  表 teatour.appointment_item 结构
CREATE TABLE IF NOT EXISTS `appointment_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `teaGarden_id` int(11) NOT NULL COMMENT '对应产品id',
  `appointment_id` int(11) DEFAULT NULL COMMENT '对应订单id',
  `user_id` int(11) NOT NULL COMMENT '对应用户id',
  `number` int(11) DEFAULT NULL COMMENT '对应产品购买的数量',
  PRIMARY KEY (`id`),
  KEY `fk_appointment_item_teaGarden` (`teaGarden_id`),
  KEY `fk_appointment_item_appointment` (`appointment_id`),
  KEY `fk_appointment_item_user` (`user_id`),
  CONSTRAINT `fk_appointment_item_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment_` (`id`),
  CONSTRAINT `fk_appointment_item_teaGarden` FOREIGN KEY (`teaGarden_id`) REFERENCES `teaGarden` (`id`),
  CONSTRAINT `fk_appointment_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.appointment_item 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `appointment_item` DISABLE KEYS */;
INSERT INTO `appointment_item` (`id`, `teaGarden_id`, `appointment_id`, `user_id`, `number`) VALUES
	(14, 4, 11, 1, 1),
	(15, 6, 11, 1, 1),
	(16, 4, NULL, 1, 5),
	(17, 4, 12, 1, 1),
	(18, 6, 13, 1, 1),
	(19, 6, 14, 4, 1);
/*!40000 ALTER TABLE `appointment_item` ENABLE KEYS */;

-- 导出  表 teatour.teaGarden 结构
CREATE TABLE IF NOT EXISTS `teaGarden` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '产品的名称',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '小标题',
  `price` float DEFAULT NULL COMMENT '价格',
  `sale` int(11) DEFAULT NULL COMMENT '销量',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `teaGardenCategory_id` int(11) DEFAULT NULL COMMENT '对应的分类id',
  PRIMARY KEY (`id`),
  KEY `fk_teaGarden_teaGardenCategory` (`teaGardenCategory_id`),
  CONSTRAINT `fk_teaGarden_teaGardenCategory` FOREIGN KEY (`teaGardenCategory_id`) REFERENCES `teaGardenCategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.teaGarden 的数据：~17 rows (大约)
/*!40000 ALTER TABLE `teaGarden` DISABLE KEYS */;
INSERT INTO `teaGarden` (`id`, `name`, `sub_title`, `price`, `sale`, `stock`, `teaGardenCategory_id`) VALUES
	(4, '武夷香江茗苑', ' ', 248, 107769, 9999, 1),
	(5, '英德积庆里茶园', ' ', 229, 1148, 9999, 1),
	(6, '贺开古茶园', '浓香扑鼻', 125, 946, 9999, 1),
	(7, '西茶谷主题公园', ' ', 228, 9543, 9999, 1),
	(8, '渠江源茶园', ' ', 238, 4909, 9999, 1);

/*!40000 ALTER TABLE `teaGarden` ENABLE KEYS */;

-- 导出  表 teatour.teaGarden_image 结构
CREATE TABLE IF NOT EXISTS `teaGarden_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `teaGarden_id` int(11) DEFAULT NULL COMMENT '对应的产品id',
  PRIMARY KEY (`id`),
  KEY `fk_teaGarden_image_teaGarden` (`teaGarden_id`),
  CONSTRAINT `fk_teaGarden_image_teaGarden` FOREIGN KEY (`teaGarden_id`) REFERENCES `teaGarden` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.teaGarden_image 的数据：~80 rows (大约)
/*!40000 ALTER TABLE `teaGarden_image` DISABLE KEYS */;
INSERT INTO `teaGarden_image` (`id`, `teaGarden_id`) VALUES
	(11, 4),
	(12, 4),
	(13, 4),
	(14, 4),
	(15, 4),
	(16, 5),
	(17, 5),
	(18, 5),
	(19, 5),
	(20, 5),
	(21, 6),
	(22, 6),
	(23, 6),
	(24, 6),
	(25, 6),
	(26, 7),
	(27, 7),
	(28, 7),
	(29, 7),
	(30, 7),
	(31, 8),
	(32, 8),
	(33, 8),
	(34, 8),
	(35, 8);
/*!40000 ALTER TABLE `teaGarden_image` ENABLE KEYS */;


-- 导出  表 teatour.teaGardenReview 结构
CREATE TABLE IF NOT EXISTS `teaGardenReview` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `content` varchar(4000) DEFAULT NULL COMMENT '评价内容',
  `user_id` int(11) NOT NULL COMMENT '对应的用户id',
  `teaGarden_id` int(11) NOT NULL COMMENT '对应的产品id',
  `createDate` datetime DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `fk_teaGardenReview_teaGarden` (`teaGarden_id`),
  KEY `fk_teaGardenReview_user` (`user_id`),
  CONSTRAINT `fk_teaGardenReview_teaGarden` FOREIGN KEY (`teaGarden_id`) REFERENCES `teaGarden` (`id`),
  CONSTRAINT `fk_teaGardenReview_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.teaGardenReview 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `teaGardenReview` DISABLE KEYS */;
INSERT INTO `teaGardenReview` (`id`, `content`, `user_id`, `teaGarden_id`, `createDate`) VALUES
	(2, '好评！！！！', 1, 4, '2022-02-10 10:24:02'),
	(3, '体验很好', 1, 4, '2022-02-10 10:42:07'),
	(6, '环境很棒', 1, 4, '2022-02-10 10:49:09'),
	(7, '非常适合和孩子一起来', 1, 6, '2022-02-10 11:01:06'),
	(8, '体验真的很棒', 1, 6, '2022-02-10 18:05:09'),
	(9, '非常好，下次有机会还会来', 1, 8, '2022-02-10 20:59:49');


-- 导出  表 teatour.newProdCate 结构
CREATE TABLE IF NOT EXISTS `newProdCate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '分类的名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.newProdCate 的数据：~16 rows (大约)
/*!40000 ALTER TABLE `newProdCate` DISABLE KEYS */;
INSERT INTO `newProdCate` (`id`, `name`) VALUES
	(1, '待投票'),
	(2, '已上线'),
	(3, '已上线');

-- 导出  表 teatour.newProd 结构
CREATE TABLE IF NOT EXISTS `newProd` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '产品的名称',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '小标题',
  `price` varchar(255) DEFAULT NULL COMMENT '价格',
  `newProdCate_id` int(11) DEFAULT NULL COMMENT '对应的分类id',
  PRIMARY KEY (`id`),
  KEY `fk_newProd_newProdCate` (`newProdCate_id`),
  CONSTRAINT `fk_newProd_newProdCate` FOREIGN KEY (`newProdCate_id`) REFERENCES `newProdCate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.newProd 的数据：~17 rows (大约)
/*!40000 ALTER TABLE `newProd` DISABLE KEYS */;
INSERT INTO `newProd` (`id`, `name`, `sub_title`, `price`, `newProdCate_id`) VALUES
	(3, '【约茶】蜜桃乌龙茶铁观音茶包花果花草水果茶冷泡茶袋泡茶', '给传统茶叶加入水果香气','150-200', 1),
	(4, '【约茶】灵感一周茶礼盒挂耳茶包袋泡茶伴手礼物7包/盒', '给传统茶包分为一周七天不同类型','80-100', 1),
	(5, '【约茶】水果茶茶包多种口味果茶组合全家福冷泡茶泡茶茶花袋泡茶', '给传统茶叶加入水果香气比如蜜桃','50-70', 2),
	(6, '【约茶】咖啡味冷泡茶泡茶茶花袋泡茶', '给传统茶叶加入咖啡香气','80-100', 2),
	(7, '【约茶】改良型小青柑', '将传统小青柑中的茶换成别的茶','50-100', 3),
	(8, '【约茶】袋泡茶盲盒', '每次打开前无法知道袋泡茶的味道','20-100', 3);
/*!40000 ALTER TABLE `newProd` ENABLE KEYS */;

-- 导出  表 teatour.newProd_image 结构
CREATE TABLE IF NOT EXISTS `newProd_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `newProd_id` int(11) DEFAULT NULL COMMENT '对应的产品id',
  PRIMARY KEY (`id`),
  KEY `fk_newProd_image_newProd` (`newProd_id`),
  CONSTRAINT `fk_newProd_image_newProd` FOREIGN KEY (`newProd_id`) REFERENCES `newProd` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.newProd_image 的数据：~80 rows (大约)
/*!40000 ALTER TABLE `newProd_image` DISABLE KEYS */;
INSERT INTO `newProd_image` (`id`, `newProd_id`) VALUES
	(6, 3),
	(7, 4),
	(8, 5),
	(9, 6),
	(10, 7),
	(11, 8);

-- 导出  表 teatour.newProdRev 结构
CREATE TABLE IF NOT EXISTS `newProdRev` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `content` varchar(4000) DEFAULT NULL COMMENT '评价内容',
  `user_id` int(11) NOT NULL COMMENT '对应的用户id',
  `newProd_id` int(11) NOT NULL COMMENT '对应的产品id',
  `createDate` datetime DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `fk_newProdRev_newProd` (`newProd_id`),
  KEY `fk_newProdRev_user` (`user_id`),
  CONSTRAINT `fk_newProdRev_newProd` FOREIGN KEY (`newProd_id`) REFERENCES `newProd` (`id`),
  CONSTRAINT `fk_newProdRev_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  teatour.newProdRev 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `newProdRev` DISABLE KEYS */;
INSERT INTO `newProdRev` (`id`, `content`, `user_id`, `newProd_id`, `createDate`) VALUES
	(2, '5星 应该会不错', 1, 3, '2022-02-10 10:24:02'),
	(3, '3.5星 感觉会很黑暗', 1, 4, '2022-02-10 10:42:07'),
	(6, '4.5星 这种产品我一定会买！', 3, 5, '2022-02-10 10:49:09'),
	(7, '2星 ！！会很不错', 1, 6, '2022-02-10 11:01:06'),
	(8, '1星 不会买', 1, 7, '2022-02-10 18:05:09'),
	(9, '4星 非常好的建议', 1, 8, '2022-02-10 20:59:49');
/*!40000 ALTER TABLE `newProdRev` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;



