/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.1.0 : Database - db_ai_shop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_ai_shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_ai_shop`;

/*Table structure for table `t_address` */

DROP TABLE IF EXISTS `t_address`;

CREATE TABLE `t_address` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `name` varchar(50) NOT NULL COMMENT '收货人',
  `phone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(255) NOT NULL COMMENT '详细地址',
  `is_default` tinyint DEFAULT '0' COMMENT '是否默认:1是0否',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收货地址表';

/*Data for the table `t_address` */

insert  into `t_address`(`id`,`user_id`,`name`,`phone`,`address`,`is_default`,`create_time`,`update_time`) values 
(1,1,'张三','14412512412','江苏省南京市xxxx路',1,'2026-06-29 08:52:22','2026-06-29 08:52:22'),
(2,1,'李四','14412412411','测试地址',0,'2026-06-29 08:52:44','2026-06-29 08:52:44');

/*Table structure for table `t_admin` */

DROP TABLE IF EXISTS `t_admin`;

CREATE TABLE `t_admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码(MD5)',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `status` tinyint DEFAULT '1' COMMENT '状态:1正常0禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员表';

/*Data for the table `t_admin` */

insert  into `t_admin`(`id`,`username`,`password`,`nickname`,`avatar`,`status`,`create_time`,`update_time`) values 
(1,'admin','25d55ad283aa400af464c76d713c07ad','超级管理员','/uploads/avatar/35cccdc8e6a744a5927e31e160c696f0.png',1,'2026-06-28 20:35:11','2026-06-29 08:32:38');

/*Table structure for table `t_banner` */

DROP TABLE IF EXISTS `t_banner`;

CREATE TABLE `t_banner` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `image` varchar(255) NOT NULL COMMENT '图片地址',
  `link_type` tinyint DEFAULT '0' COMMENT '链接类型:0无1商品2分类',
  `link_id` int DEFAULT '0' COMMENT '链接ID',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '状态:1启用0禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='轮播图表';

/*Data for the table `t_banner` */

insert  into `t_banner`(`id`,`title`,`image`,`link_type`,`link_id`,`sort`,`status`,`create_time`,`update_time`) values 
(1,'新品上市','/uploads/banner/1cf442462b9e451e9f66c419b274da33.png',1,1,1,1,'2026-06-28 20:35:11','2026-06-29 07:56:40'),
(2,'限时特惠','/uploads/banner/fdaa3bb830314faf9e5e559660428534.png',1,6,2,1,'2026-06-28 20:35:11','2026-06-29 07:58:08'),
(3,'品质生活','/uploads/banner/1dc5aaf85dfd4886a0bbdd9e41a5f745.png',0,0,3,1,'2026-06-28 20:35:11','2026-06-29 07:59:53');

/*Table structure for table `t_cart` */

DROP TABLE IF EXISTS `t_cart`;

CREATE TABLE `t_cart` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `quantity` int DEFAULT '1' COMMENT '数量',
  `checked` tinyint DEFAULT '1' COMMENT '是否选中:1是0否',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='购物车表';

/*Data for the table `t_cart` */

insert  into `t_cart`(`id`,`user_id`,`product_id`,`quantity`,`checked`,`create_time`,`update_time`) values 
(1,1,1,2,1,'2026-06-28 20:35:11','2026-06-29 08:46:42'),
(2,1,3,1,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(3,2,6,3,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(4,1,23,1,1,'2026-06-29 08:46:23','2026-06-29 08:46:23'),
(5,1,22,2,1,'2026-06-29 08:46:31','2026-06-29 08:46:39');

/*Table structure for table `t_category` */

DROP TABLE IF EXISTS `t_category`;

CREATE TABLE `t_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '状态:1启用0禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品分类表';

/*Data for the table `t_category` */

insert  into `t_category`(`id`,`name`,`sort`,`status`,`create_time`,`update_time`) values 
(1,'数码电子',1,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(2,'服装鞋帽',2,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(3,'食品饮料',3,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(4,'家居生活',4,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(5,'图书文具',5,1,'2026-06-28 20:35:11','2026-06-28 20:35:11');

/*Table structure for table `t_chat_message` */

DROP TABLE IF EXISTS `t_chat_message`;

CREATE TABLE `t_chat_message` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `session_id` varchar(64) NOT NULL COMMENT '会话ID',
  `role` varchar(20) NOT NULL COMMENT '角色:user/assistant',
  `content` text NOT NULL COMMENT '消息内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_session` (`user_id`,`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI聊天消息表';

/*Data for the table `t_chat_message` */

insert  into `t_chat_message`(`id`,`user_id`,`session_id`,`role`,`content`,`create_time`) values 
(1,1,'session_001','user','请问你们的退换货政策是什么？','2026-06-10 09:00:00'),
(2,1,'session_001','assistant','您好！我们支持7天无理由退换货，商品需保持原包装完好。如有质量问题，可在15天内申请退换。','2026-06-10 09:00:05'),
(3,1,'session_001','user','运费谁承担？','2026-06-10 09:01:00'),
(4,1,'session_001','assistant','非质量问题退换货，运费由买家承担；质量问题退换货，运费由我们承担。','2026-06-10 09:01:05'),
(5,1,'session_ddf85aa1be7f','user','你好，怎么退货？','2026-06-29 08:25:39'),
(6,1,'session_ddf85aa1be7f','assistant','您好！感谢您的咨询。关于退货流程，一般操作如下：\n1️⃣ 进入小程序「我的」-「我的订单」，找到需退货的订单；\n2️⃣ 点击「申请售后/退货」，选择原因并按提示提交；\n3️⃣ 审核通过后，将商品寄回并填写物流单号；\n4️⃣ 商家签收确认无误后，退款将原路退回。\n\n? 温馨提示：退货商品需保持完好、配件齐全，且通常需在签收后7天内申请。\n\n由于当前暂无具体订单信息，如操作中遇到问题或订单状态特殊，建议您直接点击小程序内的「联系人工客服」，我们将为您快速核实并一对一处理。祝您生活愉快！','2026-06-29 08:25:59'),
(7,1,'session_ce51cbfc0a30','user','关于商品与页面描述不符','2026-06-29 09:00:22'),
(8,1,'session_ce51cbfc0a30','assistant','亲，感谢您的反馈！经核实，您指出的差异确实存在，这是我们页面编辑上的失误，非常抱歉给您造成了误解。您可以直接申请退货退款，来回运费将由我们全额承担。我们会尽快修正页面描述，感谢您的监督！如需协助操作或有其他问题，请随时告诉我哦~','2026-06-29 09:00:38'),
(9,1,'session_ce51cbfc0a30','user','购买后商品降价了，怎么回事','2026-06-29 09:01:26'),
(10,1,'session_ce51cbfc0a30','assistant','亲，很抱歉没能让您在最优惠的时候下单。平台商品价格会随市场促销活动和库存情况动态调整哦。\n\n? **为您提供的解决方案：**\n- **购买7天内**：我们可以为您申请**价格保护**，核实后直接退还差价。\n- **购买超过7天**：建议您按当前优惠价重新下单，同时将原订单申请退货退款（符合平台退换货规则即可）。\n\n您可以提供一下**订单号**，我马上为您查询具体购买时间并协助办理价保或退换流程，您看可以吗？','2026-06-29 09:01:39');

/*Table structure for table `t_knowledge_file` */

DROP TABLE IF EXISTS `t_knowledge_file`;

CREATE TABLE `t_knowledge_file` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '知识库文件ID',
  `file_name` varchar(255) NOT NULL COMMENT '文件名',
  `file_type` varchar(20) NOT NULL COMMENT '文件类型:txt/doc/pdf/markdown',
  `file_path` varchar(500) NOT NULL COMMENT '文件路径',
  `file_size` int DEFAULT '0' COMMENT '文件大小(字节)',
  `chunk_count` int DEFAULT '0' COMMENT '分块数量',
  `status` tinyint DEFAULT '0' COMMENT '状态:0待处理1已向量化2失败',
  `error_msg` varchar(500) DEFAULT NULL COMMENT '错误信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识库文件表';

/*Data for the table `t_knowledge_file` */

insert  into `t_knowledge_file`(`id`,`file_name`,`file_type`,`file_path`,`file_size`,`chunk_count`,`status`,`error_msg`,`create_time`,`update_time`) values 
(4,'常见商品问题.md','markdown','uploads14/knowledge/5d2c51896a424d25879b91569cb467f0.md',4445,4,1,NULL,'2026-06-29 08:27:00','2026-06-29 08:27:01'),
(5,'常见售后问题.docx','doc','uploads14/knowledge/0f2caba5851948d4ab9c929f788bead2.docx',15111,6,1,NULL,'2026-06-29 08:27:22','2026-06-29 08:27:22'),
(6,'常见物流问题.txt','txt','uploads14/knowledge/3d6d8bd179824740914928ae72d85434.txt',3207,3,1,NULL,'2026-06-29 08:27:26','2026-06-29 08:27:27'),
(7,'其他问题.pdf','pdf','uploads14/knowledge/d9b6195096ca41338190be2333104105.pdf',473663,6,1,NULL,'2026-06-29 08:27:30','2026-06-29 08:27:30');

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `user_id` int NOT NULL COMMENT '用户ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `pay_amount` decimal(10,2) NOT NULL COMMENT '实付金额',
  `status` tinyint DEFAULT '0' COMMENT '状态:0待支付1已支付2已发货3已完成4已取消',
  `receiver_name` varchar(50) DEFAULT NULL COMMENT '收货人',
  `receiver_phone` varchar(20) DEFAULT NULL COMMENT '收货电话',
  `receiver_address` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单表';

/*Data for the table `t_order` */

insert  into `t_order`(`id`,`order_no`,`user_id`,`total_amount`,`pay_amount`,`status`,`receiver_name`,`receiver_phone`,`receiver_address`,`remark`,`pay_time`,`create_time`,`update_time`) values 
(1,'202606010001',1,727.00,727.00,3,'张三','13800000001','北京市朝阳区建国路88号',NULL,'2026-06-23 10:30:00','2026-06-23 10:25:17','2026-06-29 08:21:16'),
(2,'202606020001',1,299.00,299.00,1,'张三','13800000001','北京市朝阳区建国路88号',NULL,'2026-06-24 14:20:00','2026-06-24 14:15:30','2026-06-29 08:21:16'),
(3,'202606030001',2,237.00,237.00,3,'李四','13800000002','上海市浦东新区陆家嘴100号',NULL,'2026-06-25 09:10:00','2026-06-25 09:05:22','2026-06-29 08:21:16'),
(4,'202606040001',3,899.00,899.00,2,'王五','13800000003','广州市天河区体育西路200号',NULL,'2026-06-27 16:45:00','2026-06-27 16:40:11','2026-06-29 08:21:16'),
(5,'202606050001',1,128.00,128.00,0,'张三','13800000001','北京市朝阳区建国路88号',NULL,NULL,'2026-06-29 11:20:00','2026-06-29 08:21:16'),
(6,'TREND001',2,459.00,459.00,1,'李四','13800000002','上海市浦东新区陆家嘴100号',NULL,'2026-06-26 11:30:00','2026-06-26 11:25:17','2026-06-29 08:21:16'),
(7,'TREND002',3,89.00,89.00,1,'王五','13800000003','广州市天河区体育西路200号',NULL,'2026-06-27 09:15:00','2026-06-27 09:10:22','2026-06-29 08:21:16'),
(8,'TREND003',1,359.00,359.00,3,'张三','13800000001','北京市朝阳区建国路88号',NULL,'2026-06-28 15:40:00','2026-06-28 15:35:17','2026-06-29 08:21:16'),
(9,'TREND004',2,268.00,268.00,3,'李四','13800000002','上海市浦东新区陆家嘴100号',NULL,'2026-06-29 08:20:00','2026-06-29 08:15:30','2026-06-29 08:21:16'),
(10,'TREND005',3,899.00,899.00,3,'王五','13800000003','广州市天河区体育西路200号',NULL,'2026-06-25 18:10:00','2026-06-25 18:05:11','2026-06-29 08:21:16'),
(11,'202606290853019607',1,826.00,826.00,3,'李四','14412412411','测试地址','放门卫','2026-06-29 08:53:02','2026-06-29 08:53:01','2026-06-29 08:59:23');

/*Table structure for table `t_order_item` */

DROP TABLE IF EXISTS `t_order_item`;

CREATE TABLE `t_order_item` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单明细ID',
  `order_id` int NOT NULL COMMENT '订单ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `product_name` varchar(100) NOT NULL COMMENT '商品名称',
  `product_image` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `quantity` int NOT NULL COMMENT '数量',
  `total_price` decimal(10,2) NOT NULL COMMENT '小计',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单明细表';

/*Data for the table `t_order_item` */

insert  into `t_order_item`(`id`,`order_id`,`product_id`,`product_name`,`product_image`,`price`,`quantity`,`total_price`,`create_time`) values 
(1,1,1,'无线蓝牙耳机','/uploads/product/earphone.jpg',299.00,2,598.00,'2026-06-28 20:35:11'),
(2,1,3,'便携充电宝','/uploads/product/powerbank.jpg',129.00,1,129.00,'2026-06-28 20:35:11'),
(3,2,1,'无线蓝牙耳机','/uploads/product/earphone.jpg',299.00,1,299.00,'2026-06-28 20:35:11'),
(4,3,6,'休闲T恤','/uploads/product/tshirt.jpg',79.00,3,237.00,'2026-06-28 20:35:11'),
(5,4,2,'智能手表','/uploads/product/watch.jpg',899.00,1,899.00,'2026-06-28 20:35:11'),
(6,5,11,'有机坚果礼盒','/uploads/product/nuts.jpg',128.00,1,128.00,'2026-06-28 20:35:11'),
(7,6,4,'机械键盘','/uploads/product/keyboard.jpg',459.00,1,459.00,'2026-06-29 08:21:16'),
(8,7,5,'无线鼠标','/uploads/product/mouse.jpg',89.00,1,89.00,'2026-06-29 08:21:16'),
(9,8,7,'运动跑鞋','/uploads/product/shoes.jpg',359.00,1,359.00,'2026-06-29 08:21:16'),
(10,9,12,'进口红酒','/uploads/product/wine.jpg',268.00,1,268.00,'2026-06-29 08:21:16'),
(11,10,2,'智能手表','/uploads/product/watch.jpg',899.00,1,899.00,'2026-06-29 08:21:16'),
(12,11,22,'笔记本套装','/uploads/product/2ab3264651f7477c9dc39a4b90a5ca1b.png',35.00,2,70.00,'2026-06-29 08:53:02'),
(13,11,23,'签字笔套装','/uploads/product/62d879da7c754a4090486a97a3c865bd.png',29.00,1,29.00,'2026-06-29 08:53:02'),
(14,11,3,'便携充电宝','/uploads/product/6155dcbf97144586ad4d5a6e36375125.png',129.00,1,129.00,'2026-06-29 08:53:02'),
(15,11,1,'无线蓝牙耳机','/uploads/product/4cf50c521f2848f7887e07189c69f952.png',299.00,2,598.00,'2026-06-29 08:53:02');

/*Table structure for table `t_product` */

DROP TABLE IF EXISTS `t_product`;

CREATE TABLE `t_product` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `category_id` int NOT NULL COMMENT '分类ID',
  `name` varchar(100) NOT NULL COMMENT '商品名称',
  `description` text COMMENT '商品描述',
  `price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `stock` int DEFAULT '0' COMMENT '库存',
  `image` varchar(255) DEFAULT NULL COMMENT '商品主图',
  `images` text COMMENT '商品图片(JSON数组)',
  `sales` int DEFAULT '0' COMMENT '销量',
  `status` tinyint DEFAULT '1' COMMENT '状态:1上架0下架',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品表';

/*Data for the table `t_product` */

insert  into `t_product`(`id`,`category_id`,`name`,`description`,`price`,`stock`,`image`,`images`,`sales`,`status`,`create_time`,`update_time`) values 
(1,1,'无线蓝牙耳机','高品质降噪蓝牙耳机，续航24小时',299.00,498,'/uploads/product/4cf50c521f2848f7887e07189c69f952.png',NULL,122,1,'2026-06-28 20:35:11','2026-06-29 08:53:02'),
(2,1,'智能手表','多功能运动健康监测智能手表',899.00,200,'/uploads/product/5d26b0899fe7414da89f830f2b21e6e9.png',NULL,85,1,'2026-06-28 20:35:11','2026-06-29 07:50:12'),
(3,1,'便携充电宝','20000mAh大容量快充移动电源',129.00,799,'/uploads/product/6155dcbf97144586ad4d5a6e36375125.png',NULL,231,1,'2026-06-28 20:35:11','2026-06-29 08:53:02'),
(4,1,'机械键盘','青轴RGB背光游戏机械键盘',459.00,150,'/uploads/product/377ebba773c34e7aaecbcf416cee8695.png',NULL,67,1,'2026-06-28 20:35:11','2026-06-29 07:49:13'),
(5,1,'无线鼠标','人体工学设计静音无线鼠标',89.00,600,'/uploads/product/a21fa5c85e934dee807ef5166c493de5.png',NULL,310,1,'2026-06-28 20:35:11','2026-06-29 07:48:51'),
(6,2,'休闲T恤','100%纯棉透气舒适休闲T恤',79.00,1000,'/uploads/product/998a79f9fd134f4db09ebe6161d3d7cb.png',NULL,450,1,'2026-06-28 20:35:11','2026-06-29 07:48:31'),
(7,2,'运动跑鞋','轻便透气专业跑步运动鞋',359.00,300,'/uploads/product/75430aa7ea5a417ca75337efa9afebba.png',NULL,180,1,'2026-06-28 20:35:11','2026-06-29 07:48:09'),
(8,2,'牛仔外套','经典款修身牛仔夹克外套',259.00,200,'/uploads/product/c0e38e80895c4a21afe4579edf5da151.png',NULL,95,1,'2026-06-28 20:35:11','2026-06-29 07:47:44'),
(9,2,'休闲裤','弹力修身商务休闲长裤',149.00,400,'/uploads/product/3d86497565f84b408f7eccf3ba48e329.png',NULL,210,1,'2026-06-28 20:35:11','2026-06-29 07:47:28'),
(10,2,'棒球帽','时尚百搭遮阳棒球帽',59.00,500,'/uploads/product/4d345d4a8e3d415e9bc6f61f687bba43.png',NULL,320,1,'2026-06-28 20:35:11','2026-06-29 07:46:59'),
(11,3,'有机坚果礼盒','混合坚果每日坚果大礼包',128.00,300,'/uploads/product/6f72a9dc20394f56b42a80f713e3964a.png',NULL,156,1,'2026-06-28 20:35:11','2026-06-29 07:46:41'),
(12,3,'进口红酒','法国波尔多AOC级干红葡萄酒',268.00,100,'/uploads/product/2dce40ae43494aa2a662a64078277fd9.png',NULL,45,1,'2026-06-28 20:35:11','2026-06-29 07:46:25'),
(13,3,'速溶咖啡','精品阿拉比卡三合一速溶咖啡',68.00,800,'/uploads/product/4418398dcde14358afe67ff2fcebe59a.png',NULL,520,1,'2026-06-28 20:35:11','2026-06-29 07:46:19'),
(14,3,'手工曲奇','黄油手工烘焙曲奇饼干礼盒',88.00,400,'/uploads/product/6d10a54ba2b14e5795094531e576ce8e.png',NULL,280,1,'2026-06-28 20:35:11','2026-06-29 07:44:48'),
(15,3,'绿茶礼盒','明前特级龙井绿茶礼盒装',198.00,150,'/uploads/product/84ad08a275d0482b9b4f5a054c25a979.png',NULL,78,1,'2026-06-28 20:35:11','2026-06-29 07:44:38'),
(16,4,'记忆棉枕头','慢回弹护颈记忆棉枕芯',168.00,250,'/uploads/product/8ee3ab23766247038189984e2c5d967f.png',NULL,134,1,'2026-06-28 20:35:11','2026-06-29 07:44:29'),
(17,4,'四件套床品','全棉亲肤四件套床上用品',399.00,100,'/uploads/product/89d99e55c6e94dc492590a46b7dd2117.png',NULL,56,1,'2026-06-28 20:35:11','2026-06-29 07:44:20'),
(18,4,'收纳箱','大容量可折叠衣物收纳箱',49.00,600,'/uploads/product/21be86a176554a59a94a2bcb10f9dad4.png',NULL,410,1,'2026-06-28 20:35:11','2026-06-29 07:44:13'),
(19,4,'香薰机','超声波静音加湿器香薰机',199.00,180,'/uploads/product/ae33809d995b45e090adff2f210786fe.png',NULL,92,1,'2026-06-28 20:35:11','2026-06-29 07:44:06'),
(20,4,'懒人沙发','可折叠多功能懒人豆袋沙发',299.00,80,'/uploads/product/6c226377ab074c32bad675ed264afc1c.png',NULL,38,1,'2026-06-28 20:35:11','2026-06-29 07:43:55'),
(21,5,'Python编程','Python从入门到精通实战教程',79.00,500,'/uploads/product/effe12f88532474696235c2a93a1fd7b.png',NULL,680,1,'2026-06-28 20:35:11','2026-06-29 07:43:48'),
(22,5,'笔记本套装','A5商务办公笔记本套装',35.00,998,'/uploads/product/2ab3264651f7477c9dc39a4b90a5ca1b.png',NULL,892,1,'2026-06-28 20:35:11','2026-06-29 08:53:02'),
(23,5,'签字笔套装','中性笔签字笔礼盒套装',29.00,799,'/uploads/product/62d879da7c754a4090486a97a3c865bd.png',NULL,761,1,'2026-06-28 20:35:11','2026-06-29 08:53:02');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码(MD5)',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `status` tinyint DEFAULT '1' COMMENT '状态:1正常0禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`username`,`password`,`phone`,`nickname`,`avatar`,`status`,`create_time`,`update_time`) values 
(1,'user001','e10adc3949ba59abbe56e057f20f883e','13800000001','张三','/uploads/avatar/33737e5abb584c928f6a8cefe96b5a63.jpg',1,'2026-06-28 20:35:11','2026-06-29 08:43:38'),
(2,'user002','e10adc3949ba59abbe56e057f20f883e','13800000002','李四',NULL,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(3,'user003','e10adc3949ba59abbe56e057f20f883e','13800000003','王五',NULL,1,'2026-06-28 20:35:11','2026-06-28 20:35:11'),
(4,'cc','e10adc3949ba59abbe56e057f20f883e',NULL,'cc',NULL,1,'2026-06-29 08:32:58','2026-06-29 08:32:58'),
(5,'jack','25d55ad283aa400af464c76d713c07ad','15541214122','杰克2','/uploads/avatar/ea6f59026ceb43e1a6147d87eee0d9b0.jpg',1,'2026-06-29 08:39:00','2026-06-29 08:42:49');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
