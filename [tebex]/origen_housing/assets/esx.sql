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

ALTER TABLE `users`
  ADD COLUMN `last_house` VARCHAR(255) NULL;

-- Only if you want to use real estate job and you have not created it.
INSERT INTO `jobs` (name, label, whitelisted) VALUES
  ('realestate', 'Realestate', 1);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('realestate', 0, 'agent', 'Agent', 250, '{}', '{}'),
  ('realestate', 1, 'manager', 'Manager', 400, '{}', '{}'),
  ('realestate', 2, 'boss', 'Boss', 600, '{}', '{}');