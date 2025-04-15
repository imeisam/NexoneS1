CREATE TABLE IF NOT EXISTS `drx_mdt_academy` (
  `identifier` varchar(46) NOT NULL,
  `intro_course` tinyint(1) DEFAULT 0,
  `mdt_access` tinyint(1) DEFAULT 0,
  `driving` tinyint(1) DEFAULT 0,
  `shooting_training` tinyint(1) DEFAULT 0,
  `writing` tinyint(1) DEFAULT 0,
  `rights` tinyint(1) DEFAULT 0,
  `theory_test` tinyint(1) DEFAULT 0,
  `practical_test` tinyint(1) DEFAULT 0,
  `notes` text DEFAULT '',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_announcements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `author` varchar(225) NOT NULL,
  `expireDate` bigint(20) unsigned NOT NULL DEFAULT 0,
  `creationDate` bigint(20) unsigned NOT NULL DEFAULT 0,
  `department` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_bolos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `creationDate` bigint(20) unsigned NOT NULL,
  `date` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `author` varchar(255) NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_cameras` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `online` tinyint(1) unsigned NOT NULL,
  `location` varchar(255) NOT NULL,
  `rotation` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `coords` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `color` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_charges` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `fine` int(11) unsigned NOT NULL DEFAULT 0,
  `jail` int(11) unsigned NOT NULL DEFAULT 0,
  `points` int(11) unsigned NOT NULL DEFAULT 0,
  `category` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_drx_mdt_charges_drx_mdt_categories` (`category`),
  CONSTRAINT `FK_drx_mdt_charges_drx_mdt_categories` FOREIGN KEY (`category`) REFERENCES `drx_mdt_categories` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_database` (
  `identifier` varchar(46) NOT NULL,
  `date_of_infaction` int(11) DEFAULT 0,
  `description_of_infaction` text DEFAULT '',
  `disciplinary_action_taken` text DEFAULT '',
  `status` int(11) DEFAULT 0,
  `severity_level` int(11) DEFAULT 0,
  `supervisor` text DEFAULT '',
  `date_of_resolution` int(11) DEFAULT 0,
  `notes` text DEFAULT '',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_evidence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `author` varchar(255) NOT NULL DEFAULT '',
  `date` bigint(20) unsigned NOT NULL DEFAULT 0,
  `department` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `tags` longtext NOT NULL DEFAULT '[]',
  `gallery` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_evidence_link` (
  `id` int(11) unsigned NOT NULL,
  `type` enum('officer','report','incident','vehicle','citizen','evidence') NOT NULL,
  `identifier` varchar(46) NOT NULL,
  PRIMARY KEY (`type`,`identifier`,`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `FK_drx_mdt_evidence_link_drx_mdt_evidence` FOREIGN KEY (`id`) REFERENCES `drx_mdt_evidence` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_incident` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `location` char(255) NOT NULL DEFAULT '',
  `author` varchar(255) DEFAULT '',
  `date` bigint(20) unsigned DEFAULT 0,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `department` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_incident_criminals` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `identifier` varchar(46) NOT NULL,
  `hold` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `fine` int(11) unsigned NOT NULL DEFAULT 0,
  `chosenReduction` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `jail` int(11) unsigned NOT NULL DEFAULT 0,
  `percent` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `pleaded` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `points` int(11) unsigned NOT NULL DEFAULT 0,
  `processed` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `trial` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `warrant` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `warrantData` longtext NOT NULL,
  `charges` mediumtext NOT NULL,
  `customSentence` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `sentenceExecuted` tinyint(4) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`identifier`) USING BTREE,
  KEY `incident` (`id`) USING BTREE,
  CONSTRAINT `FK_drx_mdt_incident_criminals_drx_mdt_incidents` FOREIGN KEY (`id`) REFERENCES `drx_mdt_incident` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_incident_link` (
  `id` int(11) unsigned NOT NULL,
  `type` enum('officer','report','incident','vehicle','citizen','evidence') NOT NULL,
  `identifier` varchar(46) NOT NULL,
  PRIMARY KEY (`type`,`identifier`,`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `FK_drx_mdt_incident_link_drx_mdt_incidents` FOREIGN KEY (`id`) REFERENCES `drx_mdt_incident` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_legislations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `date` bigint(20) unsigned NOT NULL DEFAULT 0,
  `category` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_officers` (
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) NOT NULL DEFAULT '',
  `callsign` varchar(255) NOT NULL DEFAULT '',
  `badgenumber` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `image` text DEFAULT '',
  `department` int(11) unsigned NOT NULL DEFAULT 0,
  `rank` int(11) unsigned NOT NULL DEFAULT 0,
  `lastSeen` bigint(20) unsigned NOT NULL DEFAULT 0,
  `activity` bigint(20) unsigned NOT NULL DEFAULT 0,
  `activity_data` longtext NOT NULL DEFAULT '[]',
  `suspended` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `suspended_date` bigint(20) unsigned NOT NULL DEFAULT 0,
  `roles` text DEFAULT NULL,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_player_link` (
  `identifier` varchar(225) NOT NULL,
  `stateid` varchar(225) NOT NULL,
  `image` longtext DEFAULT '',
  `notes` longtext NOT NULL DEFAULT '',
  `tags` longtext NOT NULL DEFAULT '[]',
  `gallery` longtext NOT NULL DEFAULT '[]',
  `points` int(11) unsigned NOT NULL DEFAULT 0,
  `wanted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `location` char(255) NOT NULL DEFAULT '',
  `author` varchar(255) DEFAULT '',
  `date` bigint(20) unsigned DEFAULT 0,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `department` tinyint(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_report_link` (
  `id` int(11) unsigned NOT NULL,
  `type` enum('officer','report','incident','vehicle','citizen','evidence') NOT NULL,
  `identifier` varchar(46) NOT NULL,
  PRIMARY KEY (`type`,`identifier`,`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `FK_drx_mdt_report_link_drx_mdt_reports` FOREIGN KEY (`id`) REFERENCES `drx_mdt_report` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL,
  `indexes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_roster` (
  `identifier` varchar(50) NOT NULL,
  `apu` tinyint(1) DEFAULT 0,
  `air` tinyint(1) DEFAULT 0,
  `mc` tinyint(1) DEFAULT 0,
  `k9` tinyint(1) DEFAULT 0,
  `fto` tinyint(1) DEFAULT 0,
  `strikes` int(11) DEFAULT 0,
  `responsibilities` text DEFAULT 'Default Text',
  `status` int(11) DEFAULT 0,
  `notes` text DEFAULT '',
  PRIMARY KEY (`identifier`),
  CONSTRAINT `FK_drx_mdt_roster_drx_mdt_officers` FOREIGN KEY (`identifier`) REFERENCES `drx_mdt_officers` (`identifier`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_sops` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `date` bigint(20) unsigned NOT NULL DEFAULT 0,
  `category` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` text NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '',
  `identifier` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_vehicle_link` (
  `identifier` varchar(46) NOT NULL,
  `image` mediumtext NOT NULL DEFAULT '',
  `notes` longtext NOT NULL DEFAULT '',
  `tags` mediumtext NOT NULL DEFAULT '[]',
  `gallery` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_warrants` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `creationDate` bigint(20) unsigned NOT NULL DEFAULT 0,
  `date` bigint(20) unsigned NOT NULL DEFAULT 0,
  `clothes` text NOT NULL,
  `reason` text NOT NULL,
  `author` varchar(255) NOT NULL DEFAULT '',
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tags`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_weapons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner` varchar(46) DEFAULT NULL,
  `serial` varchar(225) NOT NULL,
  `weapon` varchar(225) NOT NULL DEFAULT '',
  `label` varchar(225) NOT NULL DEFAULT '',
  `content` longtext NOT NULL DEFAULT '',
  `evidence` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `drx_mdt_weapon_link` (
  `id` int(11) unsigned NOT NULL,
  `type` enum('evidence') NOT NULL,
  `identifier` varchar(46) NOT NULL,
  PRIMARY KEY (`type`,`identifier`,`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER drx_mdt_officers_delete
AFTER DELETE
ON drx_mdt_officers FOR EACH ROW
BEGIN
  DELETE FROM drx_mdt_roster WHERE identifier = OLD.identifier;
  DELETE FROM drx_mdt_academy WHERE identifier = OLD.identifier;
  DELETE FROM drx_mdt_database WHERE identifier = OLD.identifier;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER drx_mdt_officers_insert
AFTER INSERT
ON drx_mdt_officers FOR EACH ROW
BEGIN
  INSERT INTO drx_mdt_roster (identifier)
  VALUES (NEW.identifier);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;