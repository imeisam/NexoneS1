CREATE TABLE `selldrugs_players` (
  `player` varchar(255) DEFAULT NULL,
  `respect` int(11) NOT NULL DEFAULT 0,
  `sale_skill` int(11) NOT NULL DEFAULT 0,
  `mole` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `selldrugs_phone` (
  `player` varchar(255) NOT NULL,
  `settings` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;