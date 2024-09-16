-- -------------------------------------------------------------
-- TablePlus 6.1.2(568)
--
-- https://tableplus.com/
--
-- Database: db_capstone_express_orm
-- Generation Time: 2024-09-14 23:30:16.0850
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `binh_luan` (
  `binh_luan_id` int NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` int DEFAULT NULL,
  `hinh_id` int DEFAULT NULL,
  `ngay_binh_luan` datetime DEFAULT NULL,
  `noi_dung` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`binh_luan_id`),
  KEY `nguoi_dung_id` (`nguoi_dung_id`),
  KEY `hinh_id` (`hinh_id`),
  CONSTRAINT `binh_luan_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`),
  CONSTRAINT `binh_luan_ibfk_2` FOREIGN KEY (`hinh_id`) REFERENCES `hinh_anh` (`hinh_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hinh_anh` (
  `hinh_id` int NOT NULL AUTO_INCREMENT,
  `ten_hinh` varchar(255) DEFAULT NULL,
  `duong_dan` varchar(255) DEFAULT NULL,
  `mo_ta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nguoi_dung_id` int DEFAULT NULL,
  `ngay_tao` datetime DEFAULT NULL,
  PRIMARY KEY (`hinh_id`),
  KEY `nguoi_dung_id` (`nguoi_dung_id`),
  CONSTRAINT `hinh_anh_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `luu_anh` (
  `nguoi_dung_id` int NOT NULL,
  `hinh_id` int NOT NULL,
  `ngay_luu` datetime DEFAULT NULL,
  PRIMARY KEY (`nguoi_dung_id`,`hinh_id`),
  KEY `hinh_id` (`hinh_id`),
  CONSTRAINT `luu_anh_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`),
  CONSTRAINT `luu_anh_ibfk_2` FOREIGN KEY (`hinh_id`) REFERENCES `hinh_anh` (`hinh_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `nguoi_dung` (
  `nguoi_dung_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `mat_khau` varchar(255) DEFAULT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `tuoi` int DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nguoi_dung_id`),
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `binh_luan` (`binh_luan_id`, `nguoi_dung_id`, `hinh_id`, `ngay_binh_luan`, `noi_dung`) VALUES
(1, 1, 1, '2024-09-04 10:20:30', 'Bình luận về hình 1'),
(2, 2, 2, '2024-09-04 11:25:40', 'Bình luận về hình 2'),
(3, 3, 3, '2024-09-04 12:30:50', 'Bình luận về hình 3'),
(4, 4, 4, '2024-09-04 13:35:10', 'Bình luận về hình 4'),
(5, 5, 5, '2024-09-04 14:40:20', 'Bình luận về hình 5'),
(6, 6, 6, '2024-09-04 15:45:30', 'Bình luận về hình 6'),
(7, 7, 7, '2024-09-04 16:50:40', 'Bình luận về hình 7'),
(8, 8, 8, '2024-09-04 17:55:50', 'Bình luận về hình 8'),
(9, 9, 9, '2024-09-04 18:05:00', 'Bình luận về hình 9'),
(10, 10, 10, '2024-09-04 19:10:10', 'Bình luận về hình 10'),
(17, 15, 1, '2024-09-12 11:39:23', 'abc'),
(18, 15, 3, '2024-09-12 11:40:28', 'Good Job'),
(21, 1, 3, '2024-09-14 16:11:55', 'Good Job'),
(22, 16, 2, '2024-09-14 16:12:51', 'Chào bạn'),
(23, 1, 2, '2024-09-14 16:21:39', 'Chào bạn');

INSERT INTO `hinh_anh` (`hinh_id`, `ten_hinh`, `duong_dan`, `mo_ta`, `nguoi_dung_id`, `ngay_tao`) VALUES
(1, 'Hinh 1', 'http://example.com/image1.jpg', 'Mo ta cho hinh 1', 1, '2024-09-04 10:15:30'),
(2, 'Hinh 2', 'http://example.com/image2.jpg', 'Mo ta cho hinh 2', 2, '2024-09-04 11:20:45'),
(3, 'Hinh 3', 'http://example.com/image3.jpg', 'Mo ta cho hinh 3', 3, '2024-09-04 12:30:55'),
(4, 'Hinh 4', 'http://example.com/image4.jpg', 'Mo ta cho hinh 4', 4, '2024-09-04 13:45:15'),
(5, 'Hinh 5', 'http://example.com/image5.jpg', 'Mo ta cho hinh 5', 5, '2024-09-04 14:50:25'),
(6, 'Hinh 6', 'http://example.com/image6.jpg', 'Mo ta cho hinh 6', 6, '2024-09-04 15:05:35'),
(7, 'Hinh 7', 'http://example.com/image7.jpg', 'Mo ta cho hinh 7', 7, '2024-09-04 16:10:40'),
(8, 'Hinh 8', 'http://example.com/image8.jpg', 'Mo ta cho hinh 8', 8, '2024-09-04 17:25:50'),
(9, 'Hinh 9', 'http://example.com/image9.jpg', 'Mo ta cho hinh 9', 9, '2024-09-04 18:35:55'),
(10, 'Hinh 10', 'http://example.com/image10.jpg', 'Mo ta cho hinh 10', 10, '2024-09-04 19:45:05'),
(11, '11', '11', '11', 1, NULL),
(12, '12', '12', '12', 2, '2024-09-14 16:04:50'),
(13, '13', '13', '13', 3, '2024-09-14 16:20:06'),
(14, '14', '14', '14', 4, '2024-09-14 16:27:31'),
(31, '1726331273978_5ffd05c9aed01344047e3926597ee883.jpg', '/Users/lieuthanh/Desktop/Capstone_ExpressORM_ThanhNode43/public/imgs/1726331273978_5ffd05c9aed01344047e3926597ee883.jpg', 'Mô tả hình 1726331273978_5ffd05c9aed01344047e3926597ee883.jpg', 1, '2024-09-14 16:27:53');

INSERT INTO `luu_anh` (`nguoi_dung_id`, `hinh_id`, `ngay_luu`) VALUES
(1, 1, '2024-09-04 10:15:30'),
(2, 2, '2024-09-04 11:20:45'),
(3, 3, '2024-09-04 12:25:50'),
(4, 4, '2024-09-04 13:30:55'),
(5, 5, '2024-09-04 14:35:10'),
(6, 6, '2024-09-04 15:40:20'),
(7, 7, '2024-09-04 16:45:30'),
(8, 8, '2024-09-04 17:50:40'),
(9, 9, '2024-09-04 18:55:50'),
(10, 10, '2024-09-04 19:05:00');

INSERT INTO `nguoi_dung` (`nguoi_dung_id`, `email`, `mat_khau`, `ho_ten`, `tuoi`, `anh_dai_dien`, `refresh_token`) VALUES
(1, 'user1@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'ngu ho tuong', 13, 'http://example.com/avatar1.jpg', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJJZCI6MSwia2V5IjoxNzI2MzMwNzE0Nzc3fSwiaWF0IjoxNzI2MzMwNzE0LCJleHAiOjE3MjY5MzU1MTR9.MxpD1SYIq2phHQzkJrly5g4j24OkE-s9aMUm3tAAOsg'),
(2, 'user2@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Tran Thi B', 30, 'http://example.com/avatar2.jpg', NULL),
(3, 'user3@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Le Thi C', 22, 'http://example.com/avatar3.jpg', NULL),
(4, 'user4@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Pham Van D', 28, 'http://example.com/avatar4.jpg', NULL),
(5, 'user5@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Vo Van E', 32, 'http://example.com/avatar5.jpg', NULL),
(6, 'user6@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Hoang Thi F', 27, 'http://example.com/avatar6.jpg', NULL),
(7, 'user7@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Bui Van G', 29, 'http://example.com/avatar7.jpg', NULL),
(8, 'user8@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Do Thi H', 26, 'http://example.com/avatar8.jpg', NULL),
(9, 'user9@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Vo Thi I', 31, 'http://example.com/avatar9.jpg', NULL),
(10, 'user10@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'Ngo Van J', 24, 'http://example.com/avatar10.jpg', NULL),
(14, 'user11@example.com', 'ac', 'ac', 35, '', ''),
(15, 'user12@example.com', '$2b$10$auf1MgdbGHkByluiu00oPep6EwW.iQJ4wdu15368VilYkl7bRILs.', 'ac', 35, '', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJJZCI6MTUsImtleSI6MTcyNjE0MDc5NzIwMH0sImlhdCI6MTcyNjE0MDc5NywiZXhwIjoxNzI2NzQ1NTk3fQ.WsRNCbZ0e-l6kLiX358oIn6jAQfOODyDqiZqH9z0UeQ'),
(16, 'user13@example.com', '$2b$10$h8JTMjK./A6jf08mmEStM.Ftcb/EIz7jZWzoVUS3mD.pg4S0F7H/O', 'ngu ho tuong', 13, '', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJJZCI6MTYsImtleSI6MTcyNjMzMDE2MTg4OX0sImlhdCI6MTcyNjMzMDE2MSwiZXhwIjoxNzI2OTM0OTYxfQ._pvQFXMdkYugRj7ZVVkzBKY7bXqYfmbWU6ZMYMgYymQ');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;