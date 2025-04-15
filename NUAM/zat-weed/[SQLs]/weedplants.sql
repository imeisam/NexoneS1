-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2024 at 12:17 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qbcoreframework_de8c00`
--

-- --------------------------------------------------------

--
-- Table structure for table `weedplants`
--

CREATE TABLE `weedplants` (
  `id` int(11) NOT NULL,
  `coords` longtext NOT NULL CHECK (json_valid(`coords`)),
  `time` int(255) NOT NULL,
  `fertilizer` longtext NOT NULL CHECK (json_valid(`fertilizer`)),
  `water` longtext NOT NULL CHECK (json_valid(`water`)),
  `genetics` varchar(45) NOT NULL,
  `light` int(255) NOT NULL,
  `planter` int(11) NOT NULL,
  `watersetup` longtext NOT NULL,
  `lightsetup` longtext NOT NULL,
  `bucket` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `weedplants`
--
ALTER TABLE `weedplants`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `weedplants`
--
ALTER TABLE `weedplants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
