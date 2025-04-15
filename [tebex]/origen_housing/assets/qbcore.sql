CREATE TABLE IF NOT EXISTS `origen_housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `data` text DEFAULT '[]',
  `settings` text DEFAULT '[]',
  `furniture` longtext DEFAULT '[]',
  `exterior` longtext DEFAULT '[]',
  `doors` longtext DEFAULT '[]',
  `construction` text DEFAULT '[]',
  `positions` longtext DEFAULT NULL,
  `holders` longtext DEFAULT '[]',
  `garage` longtext DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `players`
  ADD COLUMN `last_house` VARCHAR(255) NULL;