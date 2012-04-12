-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.8-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2012-04-12 00:04:16
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for battlescripts_dev
CREATE DATABASE IF NOT EXISTS `battlescripts_dev` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `battlescripts_dev`;


-- Dumping structure for table battlescripts_dev.authorities
CREATE TABLE IF NOT EXISTS `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `authorities_idx_1` (`username`,`authority`),
  CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table battlescripts_dev.authorities: ~0 rows (approximately)
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` (`username`, `authority`) VALUES
	('admin', 'ROLE_ADMIN');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;


-- Dumping structure for table battlescripts_dev.script
CREATE TABLE IF NOT EXISTS `script` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user.id of this script.',
  `name` varchar(32) NOT NULL DEFAULT '0' COMMENT 'The name of the script.',
  `image` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The ship image of this script.',
  `decal` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The decal image of this script.',
  `content` longtext NOT NULL COMMENT 'The coffee script content of this script.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User generated scripts and their images.';

-- Dumping data for table battlescripts_dev.script: ~0 rows (approximately)
/*!40000 ALTER TABLE `script` DISABLE KEYS */;
/*!40000 ALTER TABLE `script` ENABLE KEYS */;


-- Dumping structure for table battlescripts_dev.users
CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table battlescripts_dev.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`username`, `password`, `enabled`) VALUES
	('admin', 'admin', 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
