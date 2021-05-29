-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 29, 2021 at 07:08 PM
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

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_feed_exist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_feed_exist` (IN `guid` TEXT)  NO SQL
SELECT 
	ns_feed_guid
FROM 
	tbl_ns_feed 
WHERE 
	ns_feed_guid = guid$$

DROP PROCEDURE IF EXISTS `sp_get_all_feeds_post_date`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_feeds_post_date` (IN `lastCreatedAt` DATETIME)  NO SQL
SELECT
    ns_feed_guid AS guid,
	ns_feed_title AS title, 
	ns_feed_description AS description, 
	ns_feed_image AS image, 
	ns_feed_link AS link, 
	ns_feed_original_pub_date AS pubDate,
    ns_feed_tone AS tone,
	ns_feed_source AS source,
	ns_feed_twitter_handle AS twitterHandle,
	ns_feed_keywords AS keywords,
	ns_feed_created_at AS createdAt
FROM 
    tbl_ns_feed
WHERE 
    ns_feed_created_at <= lastCreatedAt
ORDER BY
	ns_feed_created_at DESC
LIMIT 10$$

DROP PROCEDURE IF EXISTS `sp_get_sot_for_date`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_sot_for_date` (IN `date` DATE)  NO SQL
SELECT
    ns_sot_time AS time,
	ns_sot_tone AS tone
FROM 
    tbl_ns_sentiment_over_time
WHERE 
    ns_sot_date = date$$

DROP PROCEDURE IF EXISTS `sp_get_tones_in_between_date_time`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_tones_in_between_date_time` (IN `dateIst` VARCHAR(200), IN `fromTimeIst` VARCHAR(200), IN `toTimeIst` VARCHAR(200))  NO SQL
SELECT
    tbl_ns_feed.ns_feed_guid AS guid,
	tbl_ns_feed.ns_feed_tone AS tone,
    tbl_ns_feed.ns_feed_time_ist AS timeIst,
    tbl_ns_feed.ns_feed_date_ist AS dateIst
FROM 
    tbl_ns_feed
WHERE
	tbl_ns_feed.ns_feed_time_ist >= fromTimeIst
AND 
	tbl_ns_feed.ns_feed_time_ist <= toTimeIst
AND
	ns_feed_date_ist = dateIst$$

DROP PROCEDURE IF EXISTS `sp_get_unique_date`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_unique_date` ()  NO SQL
SELECT
    DISTINCT ns_feed_date_ist AS dateIst
FROM 
    tbl_ns_feed$$

DROP PROCEDURE IF EXISTS `sp_insert_new_feed`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_new_feed` (IN `guid` TEXT, IN `title` TEXT, IN `description` TEXT, IN `image` VARCHAR(1000), IN `link` VARCHAR(1000), IN `originalPubDate` VARCHAR(200), IN `dateIst` VARCHAR(200), IN `timeIst` VARCHAR(200), IN `tone` VARCHAR(200), IN `source` VARCHAR(200), IN `twitterHandle` VARCHAR(200), IN `keywords` VARCHAR(2000))  NO SQL
INSERT INTO 
tbl_ns_feed 
(
	ns_feed_guid,
	ns_feed_title, 
	ns_feed_description, 
	ns_feed_image, 
	ns_feed_link, 
	ns_feed_original_pub_date,
    ns_feed_date_ist,
    ns_feed_time_ist,
    ns_feed_tone,
	ns_feed_source,
	ns_feed_twitter_handle,
	ns_feed_keywords,
	ns_feed_created_at
) 
values 
(
	guid,
	title,
	description,
	image,
	link,
	originalPubDate,
    dateIst,
    timeIst,
    tone,
	source,
	twitterHandle,
	keywords,
	now()
)$$

DROP PROCEDURE IF EXISTS `sp_insert_new_sot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_new_sot` (IN `date` DATE, IN `time` VARCHAR(200), IN `tone` VARCHAR(200))  NO SQL
REPLACE INTO 
tbl_ns_sentiment_over_time 
(
	ns_sot_date,
	ns_sot_time, 
	ns_sot_tone
) 
values 
(
	date,
	time, 
	tone
)$$

DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
