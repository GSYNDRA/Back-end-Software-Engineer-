/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `export_products`;
CREATE TABLE `export_products` (
  `product_id` int NOT NULL,
  `export_shelf_id` int NOT NULL,
  `export_product_quantity` int DEFAULT NULL,
  PRIMARY KEY (`product_id`,`export_shelf_id`),
  KEY `idx_export_product_id` (`product_id`),
  KEY `idx_export_shelf_id` (`export_shelf_id`),
  CONSTRAINT `export_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `export_products_ibfk_2` FOREIGN KEY (`export_shelf_id`) REFERENCES `export_shelfs` (`export_shelf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `export_shelfs`;
CREATE TABLE `export_shelfs` (
  `export_shelf_id` int NOT NULL AUTO_INCREMENT,
  `shelf_id` int DEFAULT NULL,
  `export_id` int DEFAULT NULL,
  `export_shelf_quantity` float DEFAULT NULL,
  PRIMARY KEY (`export_shelf_id`),
  KEY `shelf_id` (`shelf_id`),
  KEY `export_id` (`export_id`),
  CONSTRAINT `export_shelfs_ibfk_1` FOREIGN KEY (`shelf_id`) REFERENCES `shelves` (`shelf_id`),
  CONSTRAINT `export_shelfs_ibfk_2` FOREIGN KEY (`export_id`) REFERENCES `exports` (`export_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `exports`;
CREATE TABLE `exports` (
  `export_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int DEFAULT NULL,
  `export_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `export_quantity` int DEFAULT NULL,
  PRIMARY KEY (`export_id`),
  KEY `idx_export_warehouse_id` (`warehouse_id`),
  CONSTRAINT `exports_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imports`;
CREATE TABLE `imports` (
  `import_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `import_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`import_id`),
  KEY `idx_import_warehouse_id` (`warehouse_id`),
  KEY `idx_import_product_id` (`product_id`),
  KEY `idx_import_supplier_id` (`supplier_id`),
  CONSTRAINT `imports_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `imports_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `imports_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `order_product_quantity` float DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `idx_order_product_id` (`product_id`),
  KEY `idx_order_order_id` (`order_id`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` float DEFAULT NULL,
  `order_quantity` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `idx_order_user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `selling_price` float DEFAULT NULL,
  `import_price` float DEFAULT NULL,
  `product_condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `shelf_products`;
CREATE TABLE `shelf_products` (
  `shelf_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` float DEFAULT '0',
  PRIMARY KEY (`shelf_id`,`product_id`),
  KEY `idx_shelf_product_id` (`product_id`),
  KEY `idx_shelf_shelf_id` (`shelf_id`),
  CONSTRAINT `shelf_products_ibfk_1` FOREIGN KEY (`shelf_id`) REFERENCES `shelves` (`shelf_id`),
  CONSTRAINT `shelf_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `shelves`;
CREATE TABLE `shelves` (
  `shelf_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `date_on_shelf` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`shelf_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `shelves_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refresh_token` text COLLATE utf8mb4_unicode_ci,
  `lastLogin` datetime DEFAULT NULL,
  `verificationTokenExpiresAt` datetime DEFAULT NULL,
  `verificationToken` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isVerified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `warehouse_products`;
CREATE TABLE `warehouse_products` (
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` float DEFAULT '0',
  PRIMARY KEY (`warehouse_id`,`product_id`),
  KEY `idx_warehouse_product_id` (`product_id`),
  KEY `idx_warehouse_warehouse_id` (`warehouse_id`),
  CONSTRAINT `warehouse_products_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `warehouse_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `warehouses`;
CREATE TABLE `warehouses` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`category_id`, `category_name`, `category_img`, `category_description`) VALUES
(1, 'Mango', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg');
INSERT INTO `categories` (`category_id`, `category_name`, `category_img`, `category_description`) VALUES
(2, 'Banana', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg');
INSERT INTO `categories` (`category_id`, `category_name`, `category_img`, `category_description`) VALUES
(3, 'Papaya', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg');
INSERT INTO `categories` (`category_id`, `category_name`, `category_img`, `category_description`) VALUES
(4, 'Coconut', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg'),
(5, 'Blackberry', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg'),
(6, 'Blueberry', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg'),
(7, 'Rasberry', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg'),
(8, 'Durian', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg'),
(9, 'Strawberry', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg'),
(10, 'Pineapple', 'This is a good mango', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg');

INSERT INTO `export_products` (`product_id`, `export_shelf_id`, `export_product_quantity`) VALUES
(1, 19, 6);
INSERT INTO `export_products` (`product_id`, `export_shelf_id`, `export_product_quantity`) VALUES
(1, 53, 10);
INSERT INTO `export_products` (`product_id`, `export_shelf_id`, `export_product_quantity`) VALUES
(2, 69, 2);
INSERT INTO `export_products` (`product_id`, `export_shelf_id`, `export_product_quantity`) VALUES
(4, 28, 6),
(5, 57, 10),
(5, 77, 9),
(5, 83, 7),
(6, 9, 7),
(7, 37, 8),
(7, 67, 1),
(7, 91, 8),
(7, 95, 10),
(8, 14, 9),
(9, 20, 1),
(9, 32, 5),
(10, 13, 7),
(10, 83, 10),
(12, 70, 10),
(12, 94, 10),
(13, 51, 10),
(13, 93, 8),
(14, 33, 7),
(15, 45, 9),
(16, 29, 6),
(17, 32, 10),
(17, 57, 2),
(18, 3, 8),
(21, 53, 6),
(22, 21, 8),
(22, 78, 8),
(22, 82, 8),
(23, 62, 3),
(24, 10, 8),
(24, 96, 9),
(25, 59, 1),
(27, 70, 4),
(28, 30, 3),
(29, 28, 5),
(29, 42, 1),
(29, 43, 4),
(32, 18, 7),
(32, 44, 4),
(32, 95, 6),
(33, 73, 2),
(34, 66, 10),
(34, 82, 1),
(34, 97, 4),
(35, 76, 5),
(36, 28, 8),
(36, 80, 9),
(37, 8, 3),
(37, 72, 5),
(38, 32, 1),
(38, 67, 7),
(38, 99, 8),
(39, 37, 3),
(39, 49, 8),
(39, 74, 10),
(41, 87, 2),
(43, 11, 2),
(44, 26, 10),
(44, 68, 5),
(44, 86, 6),
(45, 35, 1),
(46, 18, 10),
(47, 11, 1),
(47, 27, 9),
(47, 43, 9),
(47, 56, 7),
(48, 20, 2),
(48, 60, 5),
(48, 98, 1),
(49, 74, 4),
(49, 76, 2),
(49, 96, 4),
(50, 44, 4),
(50, 48, 5),
(50, 79, 9),
(51, 11, 8),
(51, 38, 6),
(52, 89, 2),
(53, 98, 6),
(54, 80, 8),
(55, 24, 9),
(55, 47, 8),
(55, 57, 1),
(55, 65, 4),
(56, 38, 5),
(57, 22, 10),
(57, 99, 3),
(58, 56, 10),
(59, 56, 2),
(60, 22, 8),
(60, 25, 3),
(61, 59, 8),
(62, 23, 10),
(62, 87, 8),
(65, 99, 1),
(66, 16, 2),
(66, 21, 8);

INSERT INTO `export_shelfs` (`export_shelf_id`, `shelf_id`, `export_id`, `export_shelf_quantity`) VALUES
(1, 5, 8, 5);
INSERT INTO `export_shelfs` (`export_shelf_id`, `shelf_id`, `export_id`, `export_shelf_quantity`) VALUES
(2, 2, 7, 1);
INSERT INTO `export_shelfs` (`export_shelf_id`, `shelf_id`, `export_id`, `export_shelf_quantity`) VALUES
(3, 8, 2, 7);
INSERT INTO `export_shelfs` (`export_shelf_id`, `shelf_id`, `export_id`, `export_shelf_quantity`) VALUES
(4, 8, 4, 10),
(5, 8, 9, 2),
(6, 10, 7, 8),
(7, 6, 7, 1),
(8, 8, 10, 10),
(9, 4, 10, 1),
(10, 8, 3, 1),
(11, 1, 9, 1),
(12, 8, 1, 6),
(13, 2, 9, 2),
(14, 6, 5, 9),
(15, 1, 8, 7),
(16, 5, 4, 1),
(17, 7, 4, 9),
(18, 5, 9, 10),
(19, 7, 7, 8),
(20, 10, 9, 8),
(21, 6, 5, 8),
(22, 2, 3, 4),
(23, 8, 6, 2),
(24, 9, 5, 3),
(25, 4, 3, 9),
(26, 9, 2, 2),
(27, 7, 8, 2),
(28, 2, 7, 5),
(29, 1, 10, 5),
(30, 2, 2, 6),
(31, 4, 3, 10),
(32, 3, 5, 1),
(33, 1, 5, 5),
(34, 3, 6, 4),
(35, 8, 4, 3),
(36, 6, 5, 2),
(37, 7, 2, 5),
(38, 7, 6, 9),
(39, 8, 10, 9),
(40, 1, 2, 6),
(41, 9, 4, 1),
(42, 1, 3, 10),
(43, 7, 9, 3),
(44, 3, 5, 8),
(45, 1, 9, 9),
(46, 4, 6, 9),
(47, 1, 10, 10),
(48, 4, 1, 10),
(49, 10, 5, 1),
(50, 10, 8, 9),
(51, 8, 6, 5),
(52, 2, 7, 1),
(53, 10, 2, 4),
(54, 9, 10, 2),
(55, 3, 8, 8),
(56, 5, 1, 1),
(57, 3, 3, 8),
(58, 6, 3, 5),
(59, 9, 1, 7),
(60, 1, 5, 10),
(61, 5, 6, 2),
(62, 3, 9, 3),
(63, 9, 8, 9),
(64, 5, 9, 7),
(65, 4, 9, 3),
(66, 7, 1, 2),
(67, 6, 5, 4),
(68, 8, 10, 2),
(69, 5, 7, 7),
(70, 10, 8, 4),
(71, 5, 4, 10),
(72, 1, 9, 1),
(73, 8, 5, 9),
(74, 6, 1, 1),
(75, 8, 7, 4),
(76, 4, 9, 5),
(77, 10, 4, 8),
(78, 9, 2, 5),
(79, 2, 10, 1),
(80, 9, 7, 6),
(81, 8, 10, 2),
(82, 4, 6, 7),
(83, 6, 8, 2),
(84, 2, 4, 1),
(85, 2, 3, 5),
(86, 7, 9, 5),
(87, 8, 7, 4),
(88, 5, 10, 2),
(89, 9, 2, 9),
(90, 5, 1, 3),
(91, 6, 6, 9),
(92, 8, 8, 6),
(93, 9, 8, 3),
(94, 3, 3, 10),
(95, 2, 5, 5),
(96, 9, 10, 1),
(97, 6, 6, 2),
(98, 6, 9, 2),
(99, 7, 7, 4),
(100, 8, 1, 9);

INSERT INTO `exports` (`export_id`, `warehouse_id`, `export_date`, `export_quantity`) VALUES
(1, 1, '2025-01-27 00:00:00', 76);
INSERT INTO `exports` (`export_id`, `warehouse_id`, `export_date`, `export_quantity`) VALUES
(2, 1, '2025-02-06 00:00:00', 64);
INSERT INTO `exports` (`export_id`, `warehouse_id`, `export_date`, `export_quantity`) VALUES
(3, 1, '2025-02-14 00:00:00', 65);
INSERT INTO `exports` (`export_id`, `warehouse_id`, `export_date`, `export_quantity`) VALUES
(4, 1, '2025-01-03 00:00:00', 87),
(5, 1, '2025-01-10 00:00:00', 54),
(6, 1, '2025-03-04 00:00:00', 85),
(7, 1, '2025-01-09 00:00:00', 63),
(8, 1, '2025-01-21 00:00:00', 72),
(9, 1, '2025-03-02 00:00:00', 74),
(10, 1, '2025-01-14 00:00:00', 58);

INSERT INTO `imports` (`import_id`, `warehouse_id`, `supplier_id`, `product_id`, `quantity`, `import_date`) VALUES
(1, 1, 3, 47, 28, '2025-01-04 00:00:00');
INSERT INTO `imports` (`import_id`, `warehouse_id`, `supplier_id`, `product_id`, `quantity`, `import_date`) VALUES
(2, 1, 10, 17, 22, '2025-01-15 00:00:00');
INSERT INTO `imports` (`import_id`, `warehouse_id`, `supplier_id`, `product_id`, `quantity`, `import_date`) VALUES
(3, 1, 4, 16, 56, '2025-02-12 00:00:00');
INSERT INTO `imports` (`import_id`, `warehouse_id`, `supplier_id`, `product_id`, `quantity`, `import_date`) VALUES
(4, 1, 4, 42, 48, '2025-01-27 00:00:00'),
(5, 1, 2, 35, 57, '2025-02-27 00:00:00'),
(6, 1, 10, 50, 81, '2025-02-04 00:00:00'),
(7, 1, 3, 40, 86, '2025-02-01 00:00:00'),
(8, 1, 3, 25, 90, '2025-01-28 00:00:00'),
(9, 1, 9, 22, 60, '2025-01-29 00:00:00'),
(10, 1, 10, 53, 38, '2025-02-25 00:00:00'),
(11, 1, 7, 34, 47, '2025-02-08 00:00:00'),
(12, 1, 1, 26, 66, '2025-01-04 00:00:00'),
(13, 1, 8, 1, 77, '2025-01-22 00:00:00'),
(14, 1, 5, 22, 76, '2025-02-22 00:00:00'),
(15, 1, 8, 8, 47, '2025-01-05 00:00:00'),
(16, 1, 4, 12, 41, '2025-02-02 00:00:00'),
(17, 1, 10, 40, 89, '2025-01-06 00:00:00'),
(18, 1, 7, 7, 86, '2025-01-15 00:00:00'),
(19, 1, 10, 20, 11, '2025-03-04 00:00:00'),
(20, 1, 8, 18, 84, '2025-01-21 00:00:00'),
(21, 1, 10, 2, 99, '2025-03-06 00:00:00'),
(22, 1, 2, 35, 78, '2025-01-23 00:00:00'),
(23, 1, 6, 64, 32, '2025-01-24 00:00:00'),
(24, 1, 5, 30, 89, '2025-01-27 00:00:00'),
(25, 1, 2, 32, 80, '2025-01-19 00:00:00'),
(26, 1, 6, 42, 23, '2025-01-10 00:00:00'),
(27, 1, 1, 32, 68, '2025-01-27 00:00:00'),
(28, 1, 5, 48, 83, '2025-03-04 00:00:00'),
(29, 1, 7, 47, 35, '2025-01-08 00:00:00'),
(30, 1, 3, 10, 77, '2025-01-28 00:00:00'),
(31, 1, 10, 58, 53, '2025-02-08 00:00:00'),
(32, 1, 3, 14, 99, '2025-02-01 00:00:00'),
(33, 1, 9, 35, 90, '2025-01-27 00:00:00'),
(34, 1, 3, 52, 38, '2025-02-24 00:00:00'),
(35, 1, 5, 62, 41, '2025-01-13 00:00:00'),
(36, 1, 2, 1, 11, '2025-02-09 00:00:00'),
(37, 1, 9, 21, 36, '2025-02-27 00:00:00'),
(38, 1, 7, 65, 68, '2025-01-12 00:00:00'),
(39, 1, 3, 57, 44, '2025-03-05 00:00:00'),
(40, 1, 3, 11, 41, '2025-02-02 00:00:00'),
(41, 1, 2, 26, 71, '2025-01-01 00:00:00'),
(42, 1, 8, 35, 10, '2025-02-12 00:00:00'),
(43, 1, 2, 56, 77, '2025-01-04 00:00:00'),
(44, 1, 8, 9, 58, '2025-03-05 00:00:00'),
(45, 1, 10, 17, 50, '2025-02-07 00:00:00'),
(46, 1, 8, 40, 39, '2025-01-03 00:00:00'),
(47, 1, 10, 16, 87, '2025-02-18 00:00:00'),
(48, 1, 6, 49, 64, '2025-02-26 00:00:00'),
(49, 1, 9, 27, 42, '2025-03-03 00:00:00'),
(50, 1, 6, 8, 59, '2025-01-05 00:00:00'),
(51, 1, 5, 26, 45, '2025-02-01 00:00:00'),
(52, 1, 10, 57, 32, '2025-02-25 00:00:00'),
(53, 1, 2, 39, 10, '2025-01-23 00:00:00'),
(54, 1, 9, 52, 67, '2025-02-02 00:00:00'),
(55, 1, 2, 30, 67, '2025-02-19 00:00:00'),
(56, 1, 5, 12, 47, '2025-01-18 00:00:00'),
(57, 1, 4, 32, 51, '2025-01-11 00:00:00'),
(58, 1, 8, 22, 21, '2025-02-09 00:00:00'),
(59, 1, 4, 37, 79, '2025-01-20 00:00:00'),
(60, 1, 7, 12, 46, '2025-03-07 00:00:00'),
(61, 1, 5, 7, 90, '2025-01-12 00:00:00'),
(62, 1, 10, 43, 24, '2025-02-16 00:00:00'),
(63, 1, 1, 12, 92, '2025-02-23 00:00:00'),
(64, 1, 6, 11, 47, '2025-02-06 00:00:00'),
(65, 1, 10, 65, 41, '2025-02-08 00:00:00'),
(66, 1, 4, 12, 33, '2025-02-06 00:00:00'),
(67, 1, 6, 23, 96, '2025-03-03 00:00:00'),
(68, 1, 10, 59, 73, '2025-01-12 00:00:00'),
(69, 1, 10, 59, 59, '2025-03-05 00:00:00'),
(70, 1, 10, 47, 36, '2025-02-06 00:00:00'),
(71, 1, 2, 45, 37, '2025-02-27 00:00:00'),
(72, 1, 3, 49, 59, '2025-02-23 00:00:00'),
(73, 1, 7, 13, 40, '2025-02-04 00:00:00'),
(74, 1, 7, 52, 42, '2025-02-09 00:00:00'),
(75, 1, 6, 1, 10, '2025-01-11 00:00:00'),
(76, 1, 10, 26, 92, '2025-02-09 00:00:00'),
(77, 1, 2, 45, 70, '2025-03-06 00:00:00'),
(78, 1, 1, 18, 100, '2025-01-18 00:00:00'),
(79, 1, 1, 50, 68, '2025-01-29 00:00:00'),
(80, 1, 6, 1, 30, '2025-03-02 00:00:00'),
(81, 1, 3, 42, 87, '2025-01-03 00:00:00'),
(82, 1, 8, 52, 34, '2025-02-15 00:00:00'),
(83, 1, 7, 20, 49, '2025-02-07 00:00:00'),
(84, 1, 1, 11, 77, '2025-01-17 00:00:00'),
(85, 1, 7, 60, 17, '2025-03-03 00:00:00'),
(86, 1, 8, 49, 89, '2025-01-03 00:00:00'),
(87, 1, 10, 17, 46, '2025-02-27 00:00:00'),
(88, 1, 8, 41, 85, '2025-03-03 00:00:00'),
(89, 1, 1, 41, 87, '2025-01-24 00:00:00'),
(90, 1, 2, 62, 75, '2025-02-11 00:00:00'),
(91, 1, 6, 22, 29, '2025-01-14 00:00:00'),
(92, 1, 10, 26, 35, '2025-02-15 00:00:00'),
(93, 1, 2, 55, 70, '2025-01-09 00:00:00'),
(94, 1, 10, 62, 97, '2025-01-31 00:00:00'),
(95, 1, 6, 28, 69, '2025-03-06 00:00:00'),
(96, 1, 1, 30, 62, '2025-02-02 00:00:00'),
(97, 1, 9, 49, 11, '2025-01-30 00:00:00'),
(98, 1, 5, 65, 39, '2025-02-13 00:00:00'),
(99, 1, 10, 32, 52, '2025-01-31 00:00:00'),
(100, 1, 3, 37, 55, '2025-02-20 00:00:00');

INSERT INTO `order_products` (`order_id`, `product_id`, `order_product_quantity`) VALUES
(2, 30, 5);
INSERT INTO `order_products` (`order_id`, `product_id`, `order_product_quantity`) VALUES
(3, 48, 6);
INSERT INTO `order_products` (`order_id`, `product_id`, `order_product_quantity`) VALUES
(4, 51, 10);
INSERT INTO `order_products` (`order_id`, `product_id`, `order_product_quantity`) VALUES
(4, 63, 1),
(5, 48, 6),
(6, 1, 1),
(6, 18, 2),
(7, 17, 10),
(8, 15, 1),
(8, 28, 2),
(10, 17, 3),
(12, 34, 10),
(13, 9, 7),
(17, 16, 3),
(18, 5, 4),
(18, 28, 4),
(18, 64, 10),
(22, 59, 5),
(24, 31, 10),
(24, 61, 10),
(25, 15, 2),
(25, 58, 9),
(25, 62, 1),
(27, 41, 7),
(28, 12, 4),
(28, 49, 8),
(29, 66, 7),
(30, 53, 10),
(31, 42, 4),
(31, 54, 1),
(32, 27, 2),
(32, 53, 8),
(32, 54, 4),
(33, 24, 3),
(34, 53, 2),
(34, 66, 6),
(35, 48, 10),
(36, 18, 5),
(37, 35, 1),
(38, 20, 10),
(39, 13, 6),
(41, 28, 4),
(44, 2, 6),
(44, 52, 3),
(45, 22, 5),
(46, 7, 8),
(46, 54, 8),
(47, 2, 6),
(47, 4, 4),
(47, 57, 10),
(48, 6, 5),
(49, 40, 9),
(50, 3, 7),
(50, 39, 3),
(50, 60, 1),
(51, 12, 6),
(51, 21, 10),
(52, 50, 7),
(53, 6, 6),
(54, 61, 7),
(55, 27, 9),
(56, 8, 8),
(57, 64, 7),
(58, 39, 9),
(61, 3, 4),
(61, 41, 7),
(62, 49, 8),
(63, 30, 6),
(65, 34, 4),
(68, 28, 10),
(68, 55, 8),
(69, 5, 1),
(70, 39, 2),
(71, 37, 3),
(72, 23, 8),
(73, 50, 1),
(74, 1, 4),
(74, 2, 7),
(74, 17, 10),
(76, 46, 7),
(77, 45, 10),
(78, 49, 6),
(80, 8, 2),
(80, 42, 1),
(81, 49, 1),
(83, 16, 5),
(83, 52, 6),
(84, 53, 3),
(86, 17, 10),
(86, 36, 2),
(92, 5, 9),
(92, 52, 3),
(94, 44, 4),
(95, 1, 5),
(96, 56, 9),
(97, 14, 1),
(97, 31, 1),
(97, 32, 9),
(98, 10, 9),
(98, 47, 1),
(98, 50, 7);

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_price`, `order_quantity`) VALUES
(1, 1, '2025-03-05 00:00:00', 21.41, 0);
INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_price`, `order_quantity`) VALUES
(2, 4, '2025-03-07 00:00:00', 57.14, 5);
INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_price`, `order_quantity`) VALUES
(3, 3, '2025-03-06 00:00:00', 82.63, 6);
INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_price`, `order_quantity`) VALUES
(4, 8, '2025-03-07 00:00:00', 93.3, 11),
(5, 5, '2025-03-03 00:00:00', 41.09, 6),
(6, 10, '2025-03-06 00:00:00', 47.54, 3),
(7, 3, '2025-03-08 00:00:00', 23.12, 10),
(8, 4, '2025-03-07 00:00:00', 66.19, 3),
(9, 5, '2025-03-06 00:00:00', 43.03, 0),
(10, 9, '2025-03-06 00:00:00', 55.02, 3),
(11, 4, '2025-03-02 00:00:00', 81.44, 0),
(12, 7, '2025-03-02 00:00:00', 46.68, 10),
(13, 10, '2025-03-04 00:00:00', 70.73, 7),
(14, 7, '2025-03-07 00:00:00', 28.79, 0),
(15, 10, '2025-03-05 00:00:00', 71.23, 0),
(16, 2, '2025-03-06 00:00:00', 44.66, 0),
(17, 7, '2025-03-07 00:00:00', 77.55, 3),
(18, 4, '2025-03-05 00:00:00', 78.31, 18),
(19, 3, '2025-03-06 00:00:00', 76.44, 0),
(20, 10, '2025-03-08 00:00:00', 56.29, 0),
(21, 2, '2025-03-04 00:00:00', 87.15, 0),
(22, 1, '2025-03-05 00:00:00', 85.09, 5),
(23, 9, '2025-03-02 00:00:00', 68.75, 0),
(24, 7, '2025-03-03 00:00:00', 40.22, 20),
(25, 7, '2025-03-01 00:00:00', 98.36, 12),
(26, 10, '2025-03-04 00:00:00', 41.66, 0),
(27, 4, '2025-03-05 00:00:00', 65.14, 7),
(28, 8, '2025-03-04 00:00:00', 66.38, 12),
(29, 6, '2025-03-06 00:00:00', 82.64, 7),
(30, 4, '2025-03-04 00:00:00', 71.3, 10),
(31, 1, '2025-03-08 00:00:00', 94.39, 5),
(32, 5, '2025-03-03 00:00:00', 76.77, 14),
(33, 2, '2025-03-07 00:00:00', 25.7, 3),
(34, 4, '2025-03-05 00:00:00', 35.82, 8),
(35, 5, '2025-03-07 00:00:00', 82.99, 10),
(36, 10, '2025-03-08 00:00:00', 93.17, 5),
(37, 10, '2025-03-08 00:00:00', 52.16, 1),
(38, 9, '2025-03-08 00:00:00', 75.53, 10),
(39, 8, '2025-03-06 00:00:00', 80.1, 6),
(40, 3, '2025-03-02 00:00:00', 78.35, 0),
(41, 6, '2025-03-03 00:00:00', 60.3, 4),
(42, 2, '2025-03-05 00:00:00', 93.95, 0),
(43, 8, '2025-03-07 00:00:00', 46.35, 0),
(44, 9, '2025-03-02 00:00:00', 31.8, 9),
(45, 6, '2025-03-05 00:00:00', 85.11, 5),
(46, 9, '2025-03-07 00:00:00', 94.97, 16),
(47, 8, '2025-03-05 00:00:00', 36.59, 20),
(48, 5, '2025-03-05 00:00:00', 91.87, 5),
(49, 1, '2025-03-05 00:00:00', 63.2, 9),
(50, 8, '2025-03-06 00:00:00', 50.19, 11),
(51, 9, '2025-03-03 00:00:00', 59.26, 16),
(52, 10, '2025-03-07 00:00:00', 34.54, 7),
(53, 1, '2025-03-04 00:00:00', 21.02, 6),
(54, 7, '2025-03-05 00:00:00', 47.42, 7),
(55, 7, '2025-03-04 00:00:00', 82.89, 9),
(56, 4, '2025-03-05 00:00:00', 75.17, 8),
(57, 7, '2025-03-02 00:00:00', 33.08, 7),
(58, 9, '2025-03-06 00:00:00', 35.89, 9),
(59, 8, '2025-03-04 00:00:00', 44.46, 0),
(60, 5, '2025-03-02 00:00:00', 59.34, 0),
(61, 6, '2025-03-04 00:00:00', 87.8, 11),
(62, 2, '2025-03-05 00:00:00', 28.14, 8),
(63, 5, '2025-03-03 00:00:00', 72.24, 6),
(64, 10, '2025-03-07 00:00:00', 55.27, 0),
(65, 2, '2025-03-06 00:00:00', 23.85, 4),
(66, 7, '2025-03-06 00:00:00', 20.7, 0),
(67, 1, '2025-03-07 00:00:00', 59.63, 0),
(68, 2, '2025-03-02 00:00:00', 25.33, 18),
(69, 1, '2025-03-08 00:00:00', 97.89, 1),
(70, 1, '2025-03-05 00:00:00', 82.96, 2),
(71, 3, '2025-03-07 00:00:00', 35.76, 3),
(72, 10, '2025-03-03 00:00:00', 93.48, 8),
(73, 2, '2025-03-08 00:00:00', 46.18, 1),
(74, 9, '2025-03-01 00:00:00', 42.09, 21),
(75, 10, '2025-03-03 00:00:00', 39.31, 0),
(76, 2, '2025-03-02 00:00:00', 93.87, 7),
(77, 2, '2025-03-02 00:00:00', 47.7, 10),
(78, 9, '2025-03-06 00:00:00', 83.39, 6),
(79, 3, '2025-03-02 00:00:00', 95.06, 0),
(80, 2, '2025-03-03 00:00:00', 94.11, 3),
(81, 1, '2025-03-04 00:00:00', 38.96, 1),
(82, 10, '2025-03-07 00:00:00', 82.22, 0),
(83, 9, '2025-03-08 00:00:00', 42.53, 11),
(84, 3, '2025-03-07 00:00:00', 85.86, 3),
(85, 9, '2025-03-02 00:00:00', 40.17, 0),
(86, 9, '2025-03-06 00:00:00', 64.16, 12),
(87, 8, '2025-03-03 00:00:00', 61.85, 0),
(88, 7, '2025-03-08 00:00:00', 58.43, 0),
(89, 4, '2025-03-04 00:00:00', 39.86, 0),
(90, 7, '2025-03-02 00:00:00', 77.46, 0),
(91, 8, '2025-03-08 00:00:00', 65.86, 0),
(92, 7, '2025-03-07 00:00:00', 20.66, 12),
(93, 9, '2025-03-03 00:00:00', 39.94, 0),
(94, 10, '2025-03-02 00:00:00', 43.09, 4),
(95, 10, '2025-03-03 00:00:00', 74.79, 5),
(96, 1, '2025-03-07 00:00:00', 64.2, 9),
(97, 10, '2025-03-03 00:00:00', 98.71, 11),
(98, 5, '2025-03-06 00:00:00', 46.71, 17),
(99, 5, '2025-03-04 00:00:00', 27.45, 0),
(100, 4, '2025-03-04 00:00:00', 98.74, 0);

INSERT INTO `products` (`product_id`, `product_name`, `description`, `selling_price`, `import_price`, `product_condition`, `product_img`, `category_id`) VALUES
(1, 'Keit Mango', 'This is a good keit mango', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1);
INSERT INTO `products` (`product_id`, `product_name`, `description`, `selling_price`, `import_price`, `product_condition`, `product_img`, `category_id`) VALUES
(2, 'Honey Mango', 'This is a good honey mango', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1);
INSERT INTO `products` (`product_id`, `product_name`, `description`, `selling_price`, `import_price`, `product_condition`, `product_img`, `category_id`) VALUES
(3, 'Haden Mango', 'This is a good haden mango', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1);
INSERT INTO `products` (`product_id`, `product_name`, `description`, `selling_price`, `import_price`, `product_condition`, `product_img`, `category_id`) VALUES
(4, 'Keit Mango', 'This is a good keit mango', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1),
(5, 'Honey Mango', 'This is a good honey mango', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1),
(6, 'Haden Mango', 'This is a good haden mango', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1),
(7, 'Keit Mango', 'This is a good keit mango', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1),
(8, 'Honey Mango', 'This is a good honey mango', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1),
(9, 'Haden Mango', 'This is a good haden mango', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 1),
(10, 'Apple Banana', 'This is a good apple banana', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(11, 'Apple Banana', 'This is a good apple banana', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(12, 'Apple Banana', 'This is a good apple banana', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(13, 'Red Banana', 'This is a good red banana', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(14, 'Red Banana', 'This is a good red banana', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(15, 'Red Banana', 'This is a good red banana', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(16, 'Cavendish Banana', 'This is a good cavendish banana', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(17, 'Cavendish Banana', 'This is a good cavendish banana', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(18, 'Cavendish Banana', 'This is a good cavendish banana', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 2),
(19, 'Bettina Papaya', 'This is a good bettina papaya', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(20, 'Bettina Papaya', 'This is a good bettina papaya', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(21, 'Bettina Papaya', 'This is a good bettina papaya', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(22, 'Sunrise Papaya', 'This is a good sunrise papaya', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(23, 'Sunrise Papaya', 'This is a good sunrise papaya', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(24, 'Sunrise Papaya', 'This is a good sunrise papaya', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(25, 'Red/Yellow Papaya', 'This is a good red/yellow papaya', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(26, 'Red/Yellow Papaya', 'This is a good red/yellow papaya', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(27, 'Red/Yellow Papaya', 'This is a good red/yellow papaya', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 3),
(28, 'Pineapple Coconut', 'This is a good pineapple coconut', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(29, 'Pineapple Coconut', 'This is a good pineapple coconut', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(30, 'Pineapple Coconut', 'This is a good pineapple coconut', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(31, 'Strawberry Coconut', 'This is a good strawberry coconut', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(32, 'Strawberry Coconut', 'This is a good strawberry coconut', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(33, 'Strawberry Coconut', 'This is a good strawberry coconut', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(34, 'Green Siamese Coconut', 'This is a good green siamese coconut', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(35, 'Green Siamese Coconut', 'This is a good green siamese coconut', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(36, 'Green Siamese Coconut', 'This is a good green siamese coconut', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 4),
(37, 'Blackberry', 'This is a good blackberry', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 5),
(38, 'Blackberry', 'This is a good blackberry', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 5),
(39, 'Blackberry', 'This is a good blackberry', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 5),
(40, 'Blueberry', 'This is a good blueberry', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 6),
(41, 'Blueberry', 'This is a good blueberry', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 6),
(42, 'Blueberry', 'This is a good blueberry', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 6),
(43, 'Raspberry', 'This is a good raspberry', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 7),
(44, 'Raspberry', 'This is a good raspberry', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 7),
(45, 'Raspberry', 'This is a good raspberry', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 7),
(46, 'Golden Phoenix Durian', 'This is a good Golden Phoenix durian', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(47, 'Golden Phoenix Durian', 'This is a good Golden Phoenix durian', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(48, 'Golden Phoenix Durian', 'This is a good Golden Phoenix durian', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(49, 'Red Prawn Durian', 'This is a good Red Prawn durian', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(50, 'Red Prawn Durian', 'This is a good Red Prawn durian', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(51, 'Red Prawn Durian', 'This is a good Red Prawn durian', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(52, 'D24 Durian', 'This is a good D24 durian', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(53, 'D24 Durian', 'This is a good D24 durian', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(54, 'D24 Durian', 'This is a good D24 durian', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 8),
(55, 'Strawberries', 'This is a good strawberry', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 9),
(56, 'Strawberries', 'This is a good strawberry', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 9),
(57, 'Strawberries', 'This is a good strawberry', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 9),
(58, 'Red Spanish Pineapple', 'This is a good Red Spanish pineapple', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(59, 'Red Spanish Pineapple', 'This is a good Red Spanish pineapple', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(60, 'Red Spanish Pineapple', 'This is a good Red Spanish pineapple', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(61, 'Queen Pineapple', 'This is a good Queen pineapple', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(62, 'Queen Pineapple', 'This is a good Queen pineapple', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(63, 'Queen Pineapple', 'This is a good Queen pineapple', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(64, 'Abacaxi Pineapple', 'This is a good Abacaxi pineapple', 15, 10, 'unripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(65, 'Abacaxi Pineapple', 'This is a good Abacaxi pineapple', 15, 10, 'ripe', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10),
(66, 'Abacaxi Pineapple', 'This is a good Abacaxi pineapple', 15, 10, 'firm', 'https://product.hstatic.net/200000325223/product/z2448801590715_13b24f7c102a0157944e3358d8435576_51e47991308140389238830f068c0f34_master.jpg', 10);

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'admin');
INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(2, 'customer');
INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(3, 'manager');
INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(4, 'admin'),
(5, 'customer'),
(6, 'manager'),
(7, 'admin'),
(8, 'customer'),
(9, 'manager');

INSERT INTO `shelf_products` (`shelf_id`, `product_id`, `quantity`) VALUES
(1, 1, 9);
INSERT INTO `shelf_products` (`shelf_id`, `product_id`, `quantity`) VALUES
(1, 2, 5);
INSERT INTO `shelf_products` (`shelf_id`, `product_id`, `quantity`) VALUES
(1, 3, 7);
INSERT INTO `shelf_products` (`shelf_id`, `product_id`, `quantity`) VALUES
(1, 4, 9),
(1, 5, 6),
(1, 6, 7),
(1, 7, 9),
(1, 8, 3),
(1, 9, 9),
(2, 10, 3),
(2, 11, 3),
(2, 12, 6),
(2, 13, 3),
(2, 14, 7),
(2, 15, 2),
(2, 16, 4),
(2, 17, 3),
(2, 18, 8),
(3, 19, 3),
(3, 20, 8),
(3, 21, 2),
(3, 22, 1),
(3, 23, 5),
(3, 24, 4),
(3, 25, 4),
(3, 26, 2),
(3, 27, 4),
(4, 28, 3),
(4, 29, 5),
(4, 30, 4),
(4, 31, 1),
(4, 32, 1),
(4, 33, 1),
(4, 34, 3),
(4, 35, 4),
(4, 36, 2),
(5, 37, 10),
(5, 38, 5),
(5, 39, 8),
(6, 40, 10),
(6, 41, 4),
(6, 42, 5),
(7, 43, 7),
(7, 44, 1),
(7, 45, 7),
(8, 46, 5),
(8, 47, 8),
(8, 48, 5),
(8, 49, 1),
(8, 50, 4),
(8, 51, 5),
(8, 52, 4),
(8, 53, 4),
(8, 54, 10),
(9, 55, 8),
(9, 56, 5),
(9, 57, 3),
(10, 58, 1),
(10, 59, 9),
(10, 60, 8),
(10, 61, 1),
(10, 62, 4),
(10, 63, 9),
(10, 64, 6),
(10, 65, 5),
(10, 66, 7);

INSERT INTO `shelves` (`shelf_id`, `quantity`, `category_id`, `date_on_shelf`) VALUES
(1, 64, 1, '2024-05-22 00:00:00');
INSERT INTO `shelves` (`shelf_id`, `quantity`, `category_id`, `date_on_shelf`) VALUES
(2, 39, 2, '2024-05-23 00:00:00');
INSERT INTO `shelves` (`shelf_id`, `quantity`, `category_id`, `date_on_shelf`) VALUES
(3, 33, 3, '2024-05-24 00:00:00');
INSERT INTO `shelves` (`shelf_id`, `quantity`, `category_id`, `date_on_shelf`) VALUES
(4, 24, 4, '2024-05-25 00:00:00'),
(5, 23, 5, '2024-05-26 00:00:00'),
(6, 19, 6, '2024-05-27 00:00:00'),
(7, 15, 7, '2024-05-21 00:00:00'),
(8, 46, 8, '2024-05-20 00:00:00'),
(9, 16, 9, '2024-05-22 00:00:00'),
(10, 50, 10, '2024-05-23 00:00:00');

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`) VALUES
(1, 'Leblanc-Day');
INSERT INTO `suppliers` (`supplier_id`, `supplier_name`) VALUES
(2, 'Elliott, Lamb and Mckenzie');
INSERT INTO `suppliers` (`supplier_id`, `supplier_name`) VALUES
(3, 'Rodgers-Campbell');
INSERT INTO `suppliers` (`supplier_id`, `supplier_name`) VALUES
(4, 'Brooks, Huffman and Francis'),
(5, 'Bass Inc'),
(6, 'Parker, Campos and Carter'),
(7, 'Reyes-Perkins'),
(8, 'Juarez-Duran'),
(9, 'Ford PLC'),
(10, 'Watson-Ward'),
(11, 'Lowe, Schwartz and Wilcox'),
(12, 'Hernandez, Bauer and Macdonald'),
(13, 'Washington, Pace and Jackson'),
(14, 'Carroll, Freeman and Miller'),
(15, 'Johnson PLC'),
(16, 'Davis-May'),
(17, 'Davis, Rodriguez and Bailey'),
(18, 'Butler, Gross and Young'),
(19, 'Davis, Wright and Payne'),
(20, 'Walker Inc'),
(21, 'Shaffer PLC'),
(22, 'Dunlap, Hurley and Pierce'),
(23, 'Matthews, Lambert and Kennedy'),
(24, 'Jones-Nelson'),
(25, 'Lewis-Smith'),
(26, 'Mcdonald, Baker and Carpenter'),
(27, 'Graham-Martinez'),
(28, 'Mays, Lawson and Sweeney'),
(29, 'Gallagher-Davidson'),
(30, 'Williams Group');

INSERT INTO `User` (`user_id`, `user_name`, `password`, `role_id`, `full_name`, `email`, `phone`, `bank_account`, `refresh_token`, `lastLogin`, `verificationTokenExpiresAt`, `verificationToken`, `isVerified`) VALUES
(1, 'steven29', 'OT7~La%fu#', 3, 'Christopher Sanchez', 'steven29@gmail.com', '0166851035', 'MBBank-737955806992', NULL, NULL, NULL, NULL, 0);
INSERT INTO `User` (`user_id`, `user_name`, `password`, `role_id`, `full_name`, `email`, `phone`, `bank_account`, `refresh_token`, `lastLogin`, `verificationTokenExpiresAt`, `verificationToken`, `isVerified`) VALUES
(2, 'qenglish', 'k,{7Effh^k', 3, 'Randy Obrien', 'qenglish@gmail.com', '0811930084', 'Agribank-301607458596', NULL, NULL, NULL, NULL, 0);
INSERT INTO `User` (`user_id`, `user_name`, `password`, `role_id`, `full_name`, `email`, `phone`, `bank_account`, `refresh_token`, `lastLogin`, `verificationTokenExpiresAt`, `verificationToken`, `isVerified`) VALUES
(3, 'michellecurry', 'xcM)6]Xv.d', 2, 'Dana Hawkins', 'michellecurry@gmail.com', '0269019434', 'Sacombank-697525297207', NULL, NULL, NULL, NULL, 0);
INSERT INTO `User` (`user_id`, `user_name`, `password`, `role_id`, `full_name`, `email`, `phone`, `bank_account`, `refresh_token`, `lastLogin`, `verificationTokenExpiresAt`, `verificationToken`, `isVerified`) VALUES
(4, 'christinalane', 't\'7:O0k|U7', 1, 'Jonathan Meadows', 'christinalane@gmail.com', '0748800128', 'Sacombank-331136367968', NULL, NULL, NULL, NULL, 0),
(5, 'cunninghamkaren', 'GTt=A7l:Zq', 2, 'Shirley Smith', 'cunninghamkaren@gmail.com', '0133040516', 'Sacombank-696464398187', NULL, NULL, NULL, NULL, 0),
(6, 'katrinagarcia', ';k&^C%3+p9', 2, 'William Thompson', 'katrinagarcia@gmail.com', '0777128990', 'Techcombank-377011108493', NULL, NULL, NULL, NULL, 0),
(7, 'tonya67', '@\"sgaN5M:v', 3, 'Justin Melendez', 'tonya67@gmail.com', '0471102810', 'Vietcombank-841077546687', NULL, NULL, NULL, NULL, 0),
(8, 'zfleming', '*H>xU!D0*:', 3, 'Stephanie Brown', 'zfleming@gmail.com', '0234457048', 'VPBank-766576790362', NULL, NULL, NULL, NULL, 0),
(9, 'pamela81', 'RIQbH.B+7S', 1, 'Terry Hernandez', 'pamela81@gmail.com', '0083919197', 'VPBank-897831890327', NULL, NULL, NULL, NULL, 0),
(10, 'daniel97', ',YYr,1|LSd', 2, 'Emily West', 'daniel97@gmail.com', '0075922769', 'Sacombank-632431259655', NULL, NULL, NULL, NULL, 0),
(16, 'minhtest', '$2b$10$iJdC01Zn36PsyRdFd7DRheEkkkv18goGRgT5AL2twRim9CCoELTeW', 2, 'Doan Minh', 'hoangiang272003@gmail.com', '0708963061', 'VPBANK-123456789', NULL, '2025-03-13 14:15:08', '2025-03-13 14:17:03', '228852', 1);

INSERT INTO `warehouse_products` (`warehouse_id`, `product_id`, `quantity`) VALUES
(1, 1, 31);
INSERT INTO `warehouse_products` (`warehouse_id`, `product_id`, `quantity`) VALUES
(1, 2, 26);
INSERT INTO `warehouse_products` (`warehouse_id`, `product_id`, `quantity`) VALUES
(1, 3, 49);
INSERT INTO `warehouse_products` (`warehouse_id`, `product_id`, `quantity`) VALUES
(1, 4, 16),
(1, 5, 27),
(1, 6, 48),
(1, 7, 41),
(1, 8, 48),
(1, 9, 17),
(1, 10, 20),
(1, 11, 49),
(1, 12, 30),
(1, 13, 18),
(1, 14, 32),
(1, 15, 26),
(1, 16, 38),
(1, 17, 48),
(1, 18, 40),
(1, 19, 17),
(1, 20, 11),
(1, 21, 45),
(1, 22, 25),
(1, 23, 47),
(1, 24, 10),
(1, 25, 21),
(1, 26, 38),
(1, 27, 23),
(1, 28, 20),
(1, 29, 20),
(1, 30, 43),
(1, 31, 36),
(1, 32, 44),
(1, 33, 23),
(1, 34, 37),
(1, 35, 29),
(1, 36, 44),
(1, 37, 43),
(1, 38, 13),
(1, 39, 34),
(1, 40, 37),
(1, 41, 37),
(1, 42, 45),
(1, 43, 22),
(1, 44, 38),
(1, 45, 44),
(1, 46, 48),
(1, 47, 22),
(1, 48, 10),
(1, 49, 35),
(1, 50, 21),
(1, 51, 49),
(1, 52, 21),
(1, 53, 30),
(1, 54, 26),
(1, 55, 16),
(1, 56, 16),
(1, 57, 33),
(1, 58, 13),
(1, 59, 26),
(1, 60, 32),
(1, 61, 26),
(1, 62, 46),
(1, 63, 33),
(1, 64, 36),
(1, 65, 39),
(1, 66, 36);

INSERT INTO `warehouses` (`warehouse_id`, `quantity`) VALUES
(1, 2064);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;