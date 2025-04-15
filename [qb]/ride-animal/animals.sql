CREATE TABLE IF NOT EXISTS `pug_animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `animal` varchar(50) DEFAULT NULL,
  `totalmissions` varchar(50) DEFAULT NULL,
  `day` varchar(50) DEFAULT NULL,
  `horsemissions` varchar(50) DEFAULT NULL,
  `cowmissions` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;