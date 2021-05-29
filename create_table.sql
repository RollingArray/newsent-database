-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 29, 2021 at 07:05 PM
-- Server version: 5.7.23-23
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rolli3oh_newsent`
--
USE `newsent`;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ns_feed`
--

DROP TABLE IF EXISTS `tbl_ns_feed`;
CREATE TABLE IF NOT EXISTS `tbl_ns_feed` (
  `ns_feed_guid` text NOT NULL,
  `ns_feed_title` text NOT NULL,
  `ns_feed_description` text NOT NULL,
  `ns_feed_image` varchar(1000) NOT NULL DEFAULT '',
  `ns_feed_link` varchar(1000) NOT NULL,
  `ns_feed_original_pub_date` varchar(200) NOT NULL DEFAULT '',
  `ns_feed_source` varchar(200) NOT NULL,
  `ns_feed_twitter_handle` varchar(200) NOT NULL,
  `ns_feed_keywords` varchar(2000) NOT NULL DEFAULT '',
  `ns_feed_date_ist` date NOT NULL,
  `ns_feed_time_ist` time NOT NULL,
  `ns_feed_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ns_feed_tone` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ns_sentiment_over_time`
--

DROP TABLE IF EXISTS `tbl_ns_sentiment_over_time`;
CREATE TABLE IF NOT EXISTS `tbl_ns_sentiment_over_time` (
  `ns_sot_date` date NOT NULL,
  `ns_sot_time` varchar(200) NOT NULL DEFAULT '',
  `ns_sot_tone` varchar(200) NOT NULL DEFAULT '',
  UNIQUE KEY `unique_index` (`ns_sot_date`,`ns_sot_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
