CREATE TABLE IF NOT EXISTS `0r_unlockedslots` (
  `license` longtext DEFAULT NULL,
  `slots` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `auth_codes` (
  `transaction` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
