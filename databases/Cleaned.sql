-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 27, 2026 at 10:04 AM
-- Server version: 10.11.14-MariaDB-0ubuntu0.24.04.1
-- PHP Version: 8.5.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s217_reyescity`
--

-- --------------------------------------------------------

--
-- Table structure for table `anticheat_settings`
--

CREATE TABLE `anticheat_settings` (
  `ac_code` int(2) NOT NULL,
  `ac_code_trigger_type` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `atms`
--

CREATE TABLE `atms` (
  `id` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_r` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `BankHis`
--

CREATE TABLE `BankHis` (
  `uid` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `log_message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `id` int(10) NOT NULL,
  `username` varchar(24) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `bannedby` varchar(24) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL,
  `permanent` tinyint(1) DEFAULT 0,
  `days` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bars`
--

CREATE TABLE `bars` (
  `id` int(4) NOT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `pos_r` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

CREATE TABLE `businesses` (
  `id` int(10) NOT NULL,
  `ownerid` int(10) DEFAULT 0,
  `owner` varchar(24) DEFAULT 'Nobody',
  `name` varchar(64) DEFAULT 'Business',
  `message` varchar(128) DEFAULT 'Welcome to the business!',
  `type` tinyint(2) DEFAULT 0,
  `price` int(10) DEFAULT 0,
  `entryfee` int(10) DEFAULT 0,
  `locked` tinyint(1) DEFAULT 0,
  `timestamp` int(10) DEFAULT 0,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `pos_a` float DEFAULT 0,
  `int_x` float DEFAULT 0,
  `int_y` float DEFAULT 0,
  `int_z` float DEFAULT 0,
  `int_a` float DEFAULT 0,
  `interior` tinyint(2) DEFAULT 0,
  `world` int(10) DEFAULT 0,
  `outsideint` tinyint(2) DEFAULT 0,
  `outsidevw` int(10) DEFAULT 0,
  `cash` int(10) DEFAULT 0,
  `products` int(10) DEFAULT 500,
  `robbed` int(11) NOT NULL DEFAULT 0,
  `robbing` int(11) NOT NULL DEFAULT 0,
  `prices0` int(11) NOT NULL DEFAULT 35000,
  `prices1` int(11) NOT NULL DEFAULT 35000,
  `prices2` int(11) NOT NULL DEFAULT 35000,
  `prices3` int(11) NOT NULL DEFAULT 35000,
  `prices4` int(11) NOT NULL DEFAULT 35000,
  `prices5` int(11) NOT NULL DEFAULT 35000,
  `prices6` int(11) NOT NULL DEFAULT 35000,
  `prices7` int(11) NOT NULL DEFAULT 35000,
  `prices8` int(11) NOT NULL DEFAULT 35000,
  `prices9` int(11) NOT NULL DEFAULT 35000,
  `prices10` int(11) NOT NULL DEFAULT 35000,
  `prices11` int(11) NOT NULL DEFAULT 35000,
  `prices12` int(11) NOT NULL DEFAULT 35000,
  `prices13` int(11) NOT NULL DEFAULT 35000,
  `prices14` int(11) NOT NULL DEFAULT 35000,
  `prices15` int(111) NOT NULL DEFAULT 35000,
  `prices16` int(11) NOT NULL DEFAULT 35000,
  `prices17` int(11) NOT NULL DEFAULT 35000,
  `prices18` int(11) NOT NULL DEFAULT 35000,
  `prices19` int(11) NOT NULL DEFAULT 35000,
  `prices20` int(11) NOT NULL DEFAULT 35000,
  `prices21` int(11) NOT NULL DEFAULT 35000,
  `prices22` int(11) NOT NULL DEFAULT 35000,
  `prices23` int(11) NOT NULL DEFAULT 35000,
  `prices24` int(11) NOT NULL DEFAULT 35000,
  `biz_desc` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `changes`
--

CREATE TABLE `changes` (
  `slot` tinyint(2) DEFAULT NULL,
  `text` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

CREATE TABLE `charges` (
  `id` int(10) NOT NULL,
  `uid` int(10) DEFAULT NULL,
  `chargedby` varchar(24) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clothing`
--

CREATE TABLE `clothing` (
  `id` int(10) NOT NULL,
  `uid` int(10) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `modelid` smallint(5) DEFAULT NULL,
  `boneid` tinyint(2) DEFAULT NULL,
  `attached` tinyint(1) DEFAULT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `rot_x` float DEFAULT NULL,
  `rot_y` float DEFAULT NULL,
  `rot_z` float DEFAULT NULL,
  `scale_x` float DEFAULT NULL,
  `scale_y` float DEFAULT NULL,
  `scale_z` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cocainefarm`
--

CREATE TABLE `cocainefarm` (
  `id` int(11) NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `posa` float NOT NULL,
  `world` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `water` float NOT NULL DEFAULT 80,
  `fertility` float NOT NULL DEFAULT 80,
  `growth` float NOT NULL DEFAULT 0,
  `quality` float NOT NULL DEFAULT 75
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cocainelocker`
--

CREATE TABLE `cocainelocker` (
  `id` int(11) NOT NULL,
  `turfid` int(11) NOT NULL,
  `gangid` int(11) NOT NULL DEFAULT -1,
  `seeds` int(11) NOT NULL DEFAULT 0,
  `nextspawn` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealerships`
--

CREATE TABLE `dealerships` (
  `id` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL DEFAULT 0,
  `owner` varchar(32) NOT NULL DEFAULT 'Nobody',
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `posa` float NOT NULL,
  `vehx` float NOT NULL,
  `vehy` float NOT NULL,
  `vehz` float NOT NULL,
  `veha` float NOT NULL,
  `camx` float NOT NULL,
  `camy` float NOT NULL,
  `camz` float NOT NULL,
  `lookx` float NOT NULL,
  `looky` float NOT NULL,
  `lookz` float NOT NULL,
  `world` int(11) NOT NULL DEFAULT 0,
  `vault` int(11) NOT NULL DEFAULT 0,
  `exists` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `divisions`
--

CREATE TABLE `divisions` (
  `id` tinyint(2) DEFAULT NULL,
  `divisionid` tinyint(2) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dropped`
--

CREATE TABLE `dropped` (
  `id` int(11) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `itemPlayer` varchar(255) NOT NULL,
  `itemModel` int(11) NOT NULL DEFAULT -1,
  `itemQuantity` int(11) NOT NULL DEFAULT -1,
  `itemWeapon` int(11) NOT NULL DEFAULT -1,
  `itemAmmo` int(11) NOT NULL DEFAULT -1,
  `itemX` float(10,4) NOT NULL DEFAULT 0.0000,
  `itemY` float(10,4) NOT NULL DEFAULT 0.0000,
  `itemZ` float(10,4) NOT NULL DEFAULT 0.0000,
  `itemInt` int(11) NOT NULL DEFAULT 0,
  `itemWorld` int(11) NOT NULL DEFAULT 0,
  `itemTime` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `entrances`
--

CREATE TABLE `entrances` (
  `id` int(10) NOT NULL,
  `ownerid` int(10) DEFAULT 0,
  `owner` varchar(24) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `iconid` smallint(5) DEFAULT 1239,
  `locked` tinyint(1) DEFAULT 0,
  `radius` float DEFAULT 3,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `pos_a` float DEFAULT 0,
  `int_x` float DEFAULT 0,
  `int_y` float DEFAULT 0,
  `int_z` float DEFAULT 0,
  `int_a` float DEFAULT 0,
  `interior` tinyint(2) DEFAULT 0,
  `world` int(10) DEFAULT 0,
  `outsideint` tinyint(2) DEFAULT 0,
  `outsidevw` int(10) DEFAULT 0,
  `adminlevel` tinyint(2) DEFAULT 0,
  `factiontype` tinyint(2) DEFAULT 0,
  `vip` tinyint(2) DEFAULT 0,
  `vehicles` tinyint(1) DEFAULT 0,
  `freeze` tinyint(1) DEFAULT 0,
  `password` varchar(64) DEFAULT 'None',
  `label` tinyint(1) DEFAULT 1,
  `mapicon` tinyint(3) NOT NULL DEFAULT 0,
  `gangtype` tinyint(2) DEFAULT 0,
  `color` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factiongarages`
--

CREATE TABLE `factiongarages` (
  `id` int(11) NOT NULL,
  `faction` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_a` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factionlockers`
--

CREATE TABLE `factionlockers` (
  `id` int(11) NOT NULL,
  `factionid` int(2) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `interior` int(11) NOT NULL,
  `world` int(11) NOT NULL,
  `iconid` int(11) NOT NULL DEFAULT 1239,
  `label` int(11) NOT NULL DEFAULT 1,
  `weapon_kevlar` int(1) NOT NULL DEFAULT 1,
  `weapon_medkit` int(1) NOT NULL DEFAULT 1,
  `weapon_nitestick` int(1) NOT NULL DEFAULT 0,
  `weapon_mace` int(1) NOT NULL DEFAULT 0,
  `weapon_deagle` int(1) NOT NULL DEFAULT 1,
  `weapon_shotgun` int(1) NOT NULL DEFAULT 1,
  `weapon_mp5` int(1) NOT NULL DEFAULT 1,
  `weapon_m4` int(1) NOT NULL DEFAULT 1,
  `weapon_spas12` int(1) NOT NULL DEFAULT 1,
  `weapon_sniper` int(1) NOT NULL DEFAULT 1,
  `weapon_camera` int(1) NOT NULL DEFAULT 0,
  `weapon_fire_extinguisher` int(1) NOT NULL DEFAULT 0,
  `weapon_painkillers` int(1) NOT NULL DEFAULT 0,
  `price_kevlar` int(10) NOT NULL DEFAULT 100,
  `price_medkit` int(10) NOT NULL DEFAULT 50,
  `price_nitestick` int(10) NOT NULL DEFAULT 0,
  `price_mace` int(10) NOT NULL DEFAULT 0,
  `price_deagle` int(10) NOT NULL DEFAULT 850,
  `price_shotgun` int(10) NOT NULL DEFAULT 1000,
  `price_mp5` int(10) NOT NULL DEFAULT 1500,
  `price_m4` int(10) NOT NULL DEFAULT 2500,
  `price_spas12` int(10) NOT NULL DEFAULT 3500,
  `price_sniper` int(10) NOT NULL DEFAULT 5000,
  `price_camera` int(10) NOT NULL DEFAULT 0,
  `price_fire_extinguisher` int(10) NOT NULL DEFAULT 0,
  `price_painkillers` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factionpay`
--

CREATE TABLE `factionpay` (
  `id` tinyint(2) DEFAULT NULL,
  `rank` tinyint(2) DEFAULT NULL,
  `amount` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factionranks`
--

CREATE TABLE `factionranks` (
  `id` tinyint(2) DEFAULT NULL,
  `rank` tinyint(2) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `id` tinyint(2) DEFAULT NULL,
  `name` varchar(48) DEFAULT NULL,
  `leader` varchar(24) DEFAULT 'No-one',
  `type` tinyint(2) DEFAULT 0,
  `color` int(10) DEFAULT -1,
  `rankcount` tinyint(2) DEFAULT 6,
  `lockerx` float DEFAULT 0,
  `lockery` float DEFAULT 0,
  `lockerz` float DEFAULT 0,
  `lockerinterior` tinyint(2) DEFAULT 0,
  `lockerworld` int(10) DEFAULT 0,
  `turftokens` int(11) DEFAULT 0,
  `shortname` varchar(64) DEFAULT NULL,
  `vote` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factionskins`
--

CREATE TABLE `factionskins` (
  `id` tinyint(2) DEFAULT NULL,
  `slot` tinyint(2) DEFAULT NULL,
  `skinid` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flags`
--

CREATE TABLE `flags` (
  `id` int(10) NOT NULL,
  `uid` int(10) DEFAULT NULL,
  `flaggedby` varchar(24) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuelstations`
--

CREATE TABLE `fuelstations` (
  `id` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL DEFAULT 0,
  `owner` varchar(32) NOT NULL DEFAULT 'Nobody',
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `posa` float NOT NULL DEFAULT 0,
  `world` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 9999999,
  `fuelprice` int(11) NOT NULL DEFAULT 200,
  `stock` int(11) NOT NULL DEFAULT 5000,
  `capacity` int(11) NOT NULL DEFAULT 5000,
  `vault` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `furniture`
--

CREATE TABLE `furniture` (
  `id` int(10) NOT NULL,
  `houseid` int(10) DEFAULT NULL,
  `modelid` smallint(5) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` int(10) DEFAULT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `rot_x` float DEFAULT NULL,
  `rot_y` float DEFAULT NULL,
  `rot_z` float DEFAULT NULL,
  `interior` tinyint(2) DEFAULT NULL,
  `world` int(10) DEFAULT NULL,
  `door_opened` tinyint(1) DEFAULT 0,
  `door_locked` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ganggarage`
--

CREATE TABLE `ganggarage` (
  `id` int(11) NOT NULL,
  `gangid` int(11) NOT NULL DEFAULT 0,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `pos_r` float NOT NULL DEFAULT 0,
  `area` float NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gangranks`
--

CREATE TABLE `gangranks` (
  `id` tinyint(2) DEFAULT NULL,
  `rank` tinyint(2) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gangs`
--

CREATE TABLE `gangs` (
  `id` tinyint(2) DEFAULT NULL,
  `name` varchar(32) DEFAULT 'None',
  `motd` varchar(128) DEFAULT 'None',
  `leader` varchar(24) DEFAULT 'No-one',
  `color` int(10) DEFAULT -256,
  `strikes` tinyint(1) DEFAULT 0,
  `level` tinyint(2) DEFAULT 1,
  `points` int(10) DEFAULT 0,
  `turftokens` int(10) DEFAULT 0,
  `stash_x` float DEFAULT 0,
  `stash_y` float DEFAULT 0,
  `stash_z` float DEFAULT 0,
  `stashinterior` tinyint(2) DEFAULT 0,
  `stashworld` int(10) DEFAULT 0,
  `cash` int(10) DEFAULT 0,
  `materials` int(10) DEFAULT 0,
  `pot` int(10) DEFAULT 0,
  `crack` int(10) DEFAULT 0,
  `meth` int(10) DEFAULT 0,
  `painkillers` int(10) DEFAULT 0,
  `pistolammo` int(10) DEFAULT 0,
  `shotgunammo` int(10) DEFAULT 0,
  `smgammo` int(10) DEFAULT 0,
  `arammo` int(10) DEFAULT 0,
  `rifleammo` int(10) DEFAULT 0,
  `hpammo` int(10) DEFAULT 0,
  `poisonammo` int(10) DEFAULT 0,
  `fmjammo` int(10) DEFAULT 0,
  `weapon_9mm` int(10) DEFAULT 0,
  `weapon_sdpistol` int(10) DEFAULT 0,
  `weapon_deagle` int(10) DEFAULT 0,
  `weapon_shotgun` int(10) DEFAULT 0,
  `weapon_spas12` int(10) DEFAULT 0,
  `weapon_sawnoff` int(10) DEFAULT 0,
  `weapon_tec9` int(10) DEFAULT 0,
  `weapon_uzi` int(10) DEFAULT 0,
  `weapon_mp5` int(10) DEFAULT 0,
  `weapon_ak47` int(10) DEFAULT 0,
  `weapon_m4` int(10) DEFAULT 0,
  `weapon_rifle` int(10) DEFAULT 0,
  `weapon_sniper` int(10) DEFAULT 0,
  `weapon_molotov` int(10) DEFAULT 0,
  `armsdealer` tinyint(1) DEFAULT 0,
  `drugdealer` tinyint(1) DEFAULT 0,
  `arms_x` float DEFAULT 0,
  `arms_y` float DEFAULT 0,
  `arms_z` float DEFAULT 0,
  `arms_a` float DEFAULT 0,
  `drug_x` float DEFAULT 0,
  `drug_y` float DEFAULT 0,
  `drug_z` float DEFAULT 0,
  `drug_a` float DEFAULT 0,
  `armsworld` int(10) DEFAULT 0,
  `drugworld` int(10) DEFAULT 0,
  `drugpot` int(10) DEFAULT 0,
  `drugcrack` int(10) DEFAULT 0,
  `drugmeth` int(10) DEFAULT 0,
  `armsmaterials` int(10) DEFAULT 0,
  `armsprice_1` int(10) DEFAULT 0,
  `armsprice_2` int(10) DEFAULT 0,
  `armsprice_3` int(10) DEFAULT 0,
  `armsprice_4` int(10) DEFAULT 0,
  `armsprice_5` int(10) DEFAULT 0,
  `armsprice_6` int(10) DEFAULT 0,
  `armsprice_7` int(10) DEFAULT 0,
  `armsprice_8` int(10) DEFAULT 0,
  `pot_price` int(10) DEFAULT 0,
  `crack_price` int(10) DEFAULT 0,
  `meth_price` int(10) DEFAULT 0,
  `armshpammo` int(10) DEFAULT 0,
  `armspoisonammo` int(10) DEFAULT 0,
  `armsfmjammo` int(10) DEFAULT 0,
  `alliance` int(10) NOT NULL DEFAULT -1,
  `armsprice_9` int(10) DEFAULT 0,
  `armsprice_10` int(10) DEFAULT 0,
  `armsprice_11` int(10) DEFAULT 0,
  `armsprice_12` int(10) DEFAULT 0,
  `shortname` varchar(64) DEFAULT NULL,
  `weapon_vest` int(10) DEFAULT 0,
  `dirtycash` int(10) DEFAULT 0,
  `theme` tinyint(4) DEFAULT NULL,
  `vip` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gangskins`
--

CREATE TABLE `gangskins` (
  `id` tinyint(2) DEFAULT NULL,
  `slot` tinyint(2) DEFAULT NULL,
  `skinid` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `garages`
--

CREATE TABLE `garages` (
  `id` int(10) NOT NULL,
  `ownerid` int(10) DEFAULT 0,
  `owner` varchar(24) DEFAULT NULL,
  `type` tinyint(1) DEFAULT 0,
  `price` int(10) DEFAULT 0,
  `locked` tinyint(1) DEFAULT 0,
  `timestamp` int(10) DEFAULT 0,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `pos_a` float DEFAULT 0,
  `exit_x` float DEFAULT 0,
  `exit_y` float DEFAULT 0,
  `exit_z` float DEFAULT 0,
  `exit_a` float DEFAULT 0,
  `world` int(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `gateID` int(12) NOT NULL,
  `gateModel` int(12) DEFAULT 980,
  `gateSpeed` float DEFAULT 0,
  `gateTime` int(12) DEFAULT 0,
  `gateX` float DEFAULT 0,
  `gateY` float DEFAULT 0,
  `gateZ` float DEFAULT 0,
  `gateRX` float DEFAULT 0,
  `gateRY` float DEFAULT 0,
  `gateRZ` float DEFAULT 0,
  `gateInterior` int(12) DEFAULT 0,
  `gateWorld` int(12) DEFAULT 0,
  `gateMoveX` float DEFAULT 0,
  `gateMoveY` float DEFAULT 0,
  `gateMoveZ` float DEFAULT 0,
  `gateMoveRX` float DEFAULT 0,
  `gateMoveRY` float DEFAULT 0,
  `gateMoveRZ` float DEFAULT 0,
  `gateLinkID` int(12) DEFAULT 0,
  `gateFaction` int(12) DEFAULT 0,
  `gategangid` int(12) DEFAULT 0,
  `gatePass` varchar(32) DEFAULT NULL,
  `gateRadius` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `graffiti`
--

CREATE TABLE `graffiti` (
  `graffitiID` int(12) NOT NULL,
  `graffitiX` float DEFAULT 0,
  `graffitiY` float DEFAULT 0,
  `graffitiZ` float DEFAULT 0,
  `graffitiAngle` float DEFAULT 0,
  `graffitiColor` int(12) DEFAULT 0,
  `graffitiText` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `greenzone`
--

CREATE TABLE `greenzone` (
  `id` tinyint(4) DEFAULT NULL,
  `min_x` float DEFAULT 0,
  `min_y` float DEFAULT 0,
  `max_x` float DEFAULT 0,
  `max_y` float DEFAULT 0,
  `height` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(10) NOT NULL,
  `ownerid` int(10) DEFAULT 0,
  `owner` varchar(24) DEFAULT 'Nobody',
  `type` tinyint(2) DEFAULT 0,
  `price` int(10) DEFAULT 0,
  `rentprice` int(10) DEFAULT 0,
  `level` tinyint(2) DEFAULT 0,
  `locked` tinyint(1) DEFAULT 0,
  `timestamp` int(10) DEFAULT 0,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `pos_a` float DEFAULT 0,
  `int_x` float DEFAULT 0,
  `int_y` float DEFAULT 0,
  `int_z` float DEFAULT 0,
  `int_a` float DEFAULT 0,
  `interior` tinyint(2) DEFAULT 0,
  `world` int(10) DEFAULT 0,
  `outsideint` int(10) DEFAULT 0,
  `outsidevw` int(10) DEFAULT 0,
  `cash` int(10) DEFAULT 0,
  `materials` int(10) DEFAULT 0,
  `pot` int(10) DEFAULT 0,
  `crack` int(10) DEFAULT 0,
  `meth` int(10) DEFAULT 0,
  `painkillers` int(10) DEFAULT 0,
  `weapon_1` tinyint(2) DEFAULT 0,
  `weapon_2` tinyint(2) DEFAULT 0,
  `weapon_3` tinyint(2) DEFAULT 0,
  `weapon_4` tinyint(2) DEFAULT 0,
  `weapon_5` tinyint(2) DEFAULT 0,
  `weapon_6` tinyint(2) DEFAULT 0,
  `weapon_7` tinyint(2) DEFAULT 0,
  `weapon_8` tinyint(2) DEFAULT 0,
  `weapon_9` tinyint(2) DEFAULT 0,
  `weapon_10` tinyint(2) DEFAULT 0,
  `ammo_1` smallint(5) DEFAULT 0,
  `ammo_2` smallint(5) DEFAULT 0,
  `ammo_3` smallint(5) DEFAULT 0,
  `ammo_4` smallint(5) DEFAULT 0,
  `ammo_5` smallint(5) DEFAULT 0,
  `ammo_6` tinyint(2) DEFAULT 0,
  `ammo_7` tinyint(2) DEFAULT 0,
  `ammo_8` tinyint(2) DEFAULT 0,
  `ammo_9` tinyint(2) DEFAULT 0,
  `ammo_10` tinyint(2) DEFAULT 0,
  `pistolammo` smallint(5) DEFAULT 0,
  `shotgunammo` smallint(5) DEFAULT 0,
  `smgammo` smallint(5) DEFAULT 0,
  `arammo` smallint(5) DEFAULT 0,
  `rifleammo` smallint(5) DEFAULT 0,
  `hpammo` smallint(5) DEFAULT 0,
  `poisonammo` smallint(5) DEFAULT 0,
  `fmjammo` smallint(5) DEFAULT 0,
  `robbed` int(11) NOT NULL DEFAULT 0,
  `robbing` int(11) NOT NULL DEFAULT 0,
  `lights` int(1) DEFAULT 0,
  `house_desc` varchar(128) NOT NULL DEFAULT 'A house',
  `dcash` int(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kills`
--

CREATE TABLE `kills` (
  `id` int(10) NOT NULL,
  `killer_uid` int(10) DEFAULT NULL,
  `target_uid` int(10) DEFAULT NULL,
  `killer` varchar(24) DEFAULT NULL,
  `target` varchar(24) DEFAULT NULL,
  `reason` varchar(24) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `landobjects`
--

CREATE TABLE `landobjects` (
  `id` int(10) NOT NULL,
  `landid` int(10) DEFAULT NULL,
  `modelid` smallint(5) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` int(10) DEFAULT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `rot_x` float DEFAULT NULL,
  `rot_y` float DEFAULT NULL,
  `rot_z` float DEFAULT NULL,
  `door_opened` tinyint(1) DEFAULT 0,
  `door_locked` tinyint(1) DEFAULT 0,
  `move_x` float DEFAULT 0,
  `move_y` float DEFAULT 0,
  `move_z` float DEFAULT 0,
  `move_rx` float DEFAULT 0,
  `move_ry` float DEFAULT 0,
  `move_rz` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lands`
--

CREATE TABLE `lands` (
  `id` int(10) NOT NULL,
  `ownerid` int(10) DEFAULT 0,
  `owner` varchar(24) DEFAULT 'Nobody',
  `price` int(10) DEFAULT 0,
  `min_x` float DEFAULT 0,
  `min_y` float DEFAULT 0,
  `max_x` float DEFAULT 0,
  `max_y` float DEFAULT 0,
  `height` float DEFAULT 0,
  `lx` float NOT NULL,
  `ly` float NOT NULL,
  `lz` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_faction`
--

CREATE TABLE `log_faction` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `log` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mdc`
--

CREATE TABLE `mdc` (
  `id` int(11) NOT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `pos_a` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mushroomfarm`
--

CREATE TABLE `mushroomfarm` (
  `id` int(11) NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `posa` float NOT NULL,
  `world` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `water` float NOT NULL DEFAULT 80,
  `fertility` float NOT NULL DEFAULT 80,
  `growth` float NOT NULL DEFAULT 0,
  `quality` float NOT NULL DEFAULT 75
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mushroomlocker`
--

CREATE TABLE `mushroomlocker` (
  `id` int(11) NOT NULL,
  `turfid` int(11) NOT NULL,
  `gangid` int(11) NOT NULL DEFAULT -1,
  `seeds` int(11) NOT NULL DEFAULT 0,
  `nextspawn` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `object`
--

CREATE TABLE `object` (
  `mobjID` int(11) NOT NULL,
  `mobjModel` int(11) NOT NULL DEFAULT 980,
  `mobjInterior` int(11) NOT NULL DEFAULT 0,
  `mobjWorld` int(11) NOT NULL DEFAULT 0,
  `mobjX` float NOT NULL DEFAULT 0,
  `mobjY` float NOT NULL DEFAULT 0,
  `mobjZ` float NOT NULL DEFAULT 0,
  `mobjRX` float NOT NULL DEFAULT 0,
  `mobjRY` float NOT NULL DEFAULT 0,
  `mobjRZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payphones`
--

CREATE TABLE `payphones` (
  `phID` int(10) NOT NULL,
  `phNumber` int(20) NOT NULL,
  `phX` float NOT NULL,
  `phY` float NOT NULL,
  `phZ` float NOT NULL,
  `phA` float NOT NULL,
  `phInterior` int(11) NOT NULL,
  `phWorld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phonebook`
--

CREATE TABLE `phonebook` (
  `name` varchar(24) DEFAULT NULL,
  `number` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phones`
--

CREATE TABLE `phones` (
  `phoneid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `phonenumber` varchar(15) NOT NULL,
  `basecolor` varchar(7) NOT NULL DEFAULT '#000000',
  `box1color` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `box2color` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `wallpaper` varchar(255) DEFAULT 'default',
  `zomatoinstalled` tinyint(1) DEFAULT 0,
  `btcinstalled` tinyint(1) DEFAULT 0,
  `taxiinstalled` tinyint(1) DEFAULT 0,
  `amazoninstalled` tinyint(1) DEFAULT 0,
  `mapsinstalled` tinyint(1) DEFAULT 0,
  `gpayinstalled` tinyint(1) DEFAULT 0,
  `instainstalled` tinyint(1) DEFAULT 0,
  `valleyinstalled` tinyint(1) DEFAULT 0,
  `createdat` timestamp NULL DEFAULT current_timestamp(),
  `updatedat` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_contacts`
--

CREATE TABLE `phone_contacts` (
  `contact_id` int(11) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `contact_name` varchar(24) NOT NULL,
  `contact_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `points`
--

CREATE TABLE `points` (
  `id` tinyint(2) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `capturedby` varchar(24) DEFAULT 'No-one',
  `capturedgang` tinyint(2) DEFAULT -1,
  `type` tinyint(2) DEFAULT 0,
  `profits` int(10) DEFAULT 0,
  `time` tinyint(2) DEFAULT 10,
  `point_x` float DEFAULT 0,
  `point_y` float DEFAULT 0,
  `point_z` float DEFAULT 0,
  `pointinterior` tinyint(2) DEFAULT 0,
  `pointworld` int(10) DEFAULT 0,
  `min_x` float DEFAULT NULL,
  `min_y` float DEFAULT NULL,
  `max_x` float DEFAULT NULL,
  `max_y` float DEFAULT NULL,
  `height` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publicganggarage`
--

CREATE TABLE `publicganggarage` (
  `id` int(11) NOT NULL,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `pos_r` float NOT NULL DEFAULT 0,
  `area` float NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publicgarage`
--

CREATE TABLE `publicgarage` (
  `id` int(11) NOT NULL,
  `min_x` float NOT NULL,
  `min_y` float NOT NULL,
  `max_x` float NOT NULL,
  `max_y` float NOT NULL,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publiclocker`
--

CREATE TABLE `publiclocker` (
  `uid` int(11) NOT NULL,
  `expiredate` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `repairstation`
--

CREATE TABLE `repairstation` (
  `id` int(11) NOT NULL,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `pos_r` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shots`
--

CREATE TABLE `shots` (
  `id` int(10) NOT NULL,
  `playerid` smallint(3) DEFAULT NULL,
  `weaponid` tinyint(2) DEFAULT NULL,
  `hittype` tinyint(2) DEFAULT NULL,
  `hitid` int(10) DEFAULT NULL,
  `hitplayer` varchar(24) DEFAULT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `timestamp` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `speedcameras`
--

CREATE TABLE `speedcameras` (
  `speedID` int(11) NOT NULL,
  `speedRange` float DEFAULT 0,
  `speedLimit` float DEFAULT 0,
  `speedX` float DEFAULT 0,
  `speedY` float DEFAULT 0,
  `speedZ` float DEFAULT 0,
  `speedAngle` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sticky_messages`
--

CREATE TABLE `sticky_messages` (
  `channel_id` varchar(30) NOT NULL,
  `message` text NOT NULL,
  `last_msg_id` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `surgery`
--

CREATE TABLE `surgery` (
  `id` int(4) NOT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `pos_r` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `texts`
--

CREATE TABLE `texts` (
  `id` int(10) NOT NULL,
  `sender_number` int(10) DEFAULT NULL,
  `recipient_number` int(10) DEFAULT NULL,
  `sender` varchar(24) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `turfs`
--

CREATE TABLE `turfs` (
  `id` tinyint(2) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `capturedby` varchar(24) DEFAULT 'No-one',
  `capturedgang` tinyint(2) DEFAULT -1,
  `type` tinyint(2) DEFAULT 0,
  `time` tinyint(2) DEFAULT 12,
  `min_x` float DEFAULT 0,
  `min_y` float DEFAULT 0,
  `max_x` float DEFAULT 0,
  `max_y` float DEFAULT 0,
  `height` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uid` int(10) NOT NULL,
  `username` varchar(24) NOT NULL,
  `password` varchar(129) NOT NULL,
  `regdate` datetime DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `ip` varchar(16) NOT NULL DEFAULT '0.0.0.0',
  `setup` int(11) DEFAULT 1,
  `gender` int(11) DEFAULT 1,
  `age` int(11) DEFAULT 18,
  `skin` int(11) DEFAULT 299,
  `camera_x` float DEFAULT 0,
  `camera_y` float DEFAULT 0,
  `camera_z` float DEFAULT 0,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `pos_a` float DEFAULT 0,
  `interior` int(11) DEFAULT 0,
  `world` int(10) DEFAULT 0,
  `cash` int(10) DEFAULT 20000,
  `bank` int(11) NOT NULL DEFAULT 500,
  `paycheck` int(10) DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `exp` int(10) DEFAULT 0,
  `minutes` int(11) DEFAULT 0,
  `hours` int(10) DEFAULT 0,
  `adminlevel` int(10) DEFAULT 0,
  `adminname` varchar(24) DEFAULT 'None',
  `helperlevel` int(11) DEFAULT 0,
  `health` float DEFAULT 100,
  `armor` float DEFAULT 0,
  `warnings` int(11) DEFAULT 0,
  `injured` int(11) DEFAULT 0,
  `hospital` int(11) DEFAULT 0,
  `spawnhealth` float DEFAULT 50,
  `spawnarmor` float DEFAULT 0,
  `jailtype` int(11) DEFAULT 0,
  `jailtime` int(10) DEFAULT 0,
  `newbiemuted` int(11) DEFAULT 0,
  `helpmuted` int(11) DEFAULT 0,
  `admuted` int(11) DEFAULT 0,
  `livemuted` int(11) DEFAULT 0,
  `globalmuted` int(11) DEFAULT 0,
  `reportmuted` int(2) DEFAULT 0,
  `reportwarns` int(2) DEFAULT 0,
  `fightstyle` int(2) DEFAULT 4,
  `locked` int(11) DEFAULT 0,
  `accent` varchar(16) DEFAULT 'None',
  `cookies` int(10) DEFAULT 0,
  `phone` int(10) DEFAULT 0,
  `job` int(10) DEFAULT -1,
  `secondjob` int(2) DEFAULT -1,
  `crimes` int(10) DEFAULT 0,
  `arrested` int(10) DEFAULT 0,
  `wantedlevel` int(2) DEFAULT 0,
  `materials` int(10) DEFAULT 0,
  `pot` int(10) DEFAULT 0,
  `crack` int(10) DEFAULT 0,
  `meth` int(10) DEFAULT 0,
  `painkillers` int(10) DEFAULT 0,
  `seeds` int(10) DEFAULT 0,
  `ephedrine` int(10) DEFAULT 0,
  `muriaticacid` int(10) DEFAULT 0,
  `bakingsoda` int(10) DEFAULT 0,
  `cigars` int(10) DEFAULT 0,
  `walkietalkie` int(11) DEFAULT 1,
  `channel` int(10) DEFAULT 0,
  `rentinghouse` int(10) DEFAULT 0,
  `spraycans` int(10) DEFAULT 0,
  `boombox` tinyint(1) DEFAULT 0,
  `mp3player` tinyint(1) DEFAULT 0,
  `phonebook` tinyint(1) DEFAULT 0,
  `fishingrod` tinyint(1) DEFAULT 0,
  `fishingbait` int(10) DEFAULT 0,
  `fishweight` int(10) DEFAULT 0,
  `components` int(10) DEFAULT 0,
  `courierskill` int(10) DEFAULT 0,
  `fishingskill` int(10) DEFAULT 0,
  `guardskill` int(10) DEFAULT 0,
  `weaponskill` int(10) DEFAULT 0,
  `mechanicskill` int(10) DEFAULT 0,
  `lawyerskill` int(10) DEFAULT 0,
  `smugglerskill` int(10) DEFAULT 0,
  `toggleooc` int(1) DEFAULT 0,
  `togglephone` int(1) DEFAULT 0,
  `toggleadmin` int(1) DEFAULT 0,
  `togglehelper` int(1) DEFAULT 0,
  `togglenewbie` int(1) DEFAULT 0,
  `togglewt` int(1) DEFAULT 0,
  `toggleradio` int(1) DEFAULT 0,
  `togglevip` int(1) DEFAULT 0,
  `togglemusic` int(1) DEFAULT 0,
  `togglefaction` int(1) DEFAULT 0,
  `togglegang` int(1) DEFAULT 0,
  `togglenews` int(1) DEFAULT 0,
  `toggleglobal` int(1) DEFAULT 0,
  `togglecam` int(1) DEFAULT 0,
  `carlicense` int(1) DEFAULT 0,
  `vippackage` tinyint(2) NOT NULL DEFAULT 0,
  `viptime` int(10) DEFAULT 0,
  `vipcooldown` int(10) DEFAULT 0,
  `weapon_0` tinyint(2) DEFAULT 0,
  `weapon_1` tinyint(2) DEFAULT 0,
  `weapon_2` tinyint(2) DEFAULT 0,
  `weapon_3` tinyint(2) DEFAULT 0,
  `weapon_4` tinyint(2) DEFAULT 0,
  `weapon_5` tinyint(2) DEFAULT 0,
  `weapon_6` tinyint(2) DEFAULT 0,
  `weapon_7` tinyint(2) DEFAULT 0,
  `weapon_8` tinyint(2) DEFAULT 0,
  `weapon_9` tinyint(2) DEFAULT 0,
  `weapon_10` tinyint(2) DEFAULT 0,
  `weapon_11` tinyint(2) DEFAULT 0,
  `weapon_12` tinyint(2) DEFAULT 0,
  `faction` tinyint(2) DEFAULT -1,
  `gang` tinyint(2) DEFAULT -1,
  `factionrank` tinyint(2) DEFAULT 0,
  `gangrank` tinyint(2) DEFAULT 0,
  `division` tinyint(2) DEFAULT -1,
  `contracted` int(10) DEFAULT 0,
  `contractby` varchar(24) DEFAULT 'Nobody',
  `bombs` int(10) DEFAULT 0,
  `completedhits` int(10) DEFAULT 0,
  `failedhits` int(10) DEFAULT 0,
  `reports` int(10) DEFAULT 0,
  `helprequests` int(10) DEFAULT 0,
  `speedometer` int(11) DEFAULT 1,
  `factionmod` int(11) DEFAULT 0,
  `gangmod` int(11) DEFAULT 0,
  `banappealer` int(11) DEFAULT 0,
  `potplanted` int(11) DEFAULT 0,
  `pottime` int(10) DEFAULT 0,
  `potgrams` int(10) DEFAULT 0,
  `pot_x` float DEFAULT 0,
  `pot_y` float DEFAULT 0,
  `pot_z` float DEFAULT 0,
  `pot_a` float DEFAULT 0,
  `inventoryupgrade` int(10) DEFAULT 0,
  `addictupgrade` int(10) DEFAULT 0,
  `traderupgrade` int(10) DEFAULT 0,
  `assetupgrade` int(10) DEFAULT 0,
  `dmwarnings` tinyint(2) DEFAULT 0,
  `weaponrestricted` int(10) DEFAULT 0,
  `newbieweaponseconds` int(11) NOT NULL DEFAULT -1,
  `referral_uid` int(10) DEFAULT 0,
  `refercount` int(10) DEFAULT 0,
  `watch` tinyint(1) DEFAULT 0,
  `gps` tinyint(1) DEFAULT 0,
  `prisonedby` varchar(24) DEFAULT 'No-one',
  `prisonreason` varchar(128) DEFAULT 'None',
  `togglehud` tinyint(1) DEFAULT 1,
  `clothes` smallint(3) DEFAULT -1,
  `showturfs` tinyint(1) DEFAULT 0,
  `showlands` tinyint(1) DEFAULT 0,
  `watchon` tinyint(1) DEFAULT 0,
  `gpson` tinyint(1) DEFAULT 0,
  `doublexp` int(10) DEFAULT 0,
  `couriercooldown` int(10) DEFAULT 0,
  `pizzacooldown` int(10) DEFAULT 0,
  `detectivecooldown` int(10) DEFAULT 0,
  `duty` int(10) DEFAULT 0,
  `bandana` int(10) NOT NULL DEFAULT 0,
  `detectiveskill` int(11) DEFAULT 0,
  `gascan` int(11) DEFAULT 0,
  `refunded` int(11) DEFAULT 0,
  `backpack` int(11) DEFAULT 0,
  `bpcash` int(11) DEFAULT 0,
  `bpmaterials` int(11) DEFAULT 0,
  `bppot` int(11) DEFAULT 0,
  `bpcrack` int(11) DEFAULT 0,
  `bpmeth` int(11) DEFAULT 0,
  `bppainkillers` int(11) DEFAULT 0,
  `bpweapon_0` int(11) DEFAULT 0,
  `bpweapon_1` int(11) DEFAULT 0,
  `bpweapon_2` int(11) DEFAULT 0,
  `bpweapon_3` int(11) DEFAULT 0,
  `bpweapon_4` int(11) DEFAULT 0,
  `bpweapon_5` int(11) DEFAULT 0,
  `bpweapon_6` int(11) DEFAULT 0,
  `bpweapon_7` int(11) DEFAULT 0,
  `bpweapon_8` int(11) DEFAULT 0,
  `bpweapon_9` int(11) DEFAULT 0,
  `bpweapon_10` int(11) DEFAULT 0,
  `bpweapon_11` int(11) DEFAULT 0,
  `bpweapon_12` int(11) DEFAULT 0,
  `bpweapon_13` int(11) DEFAULT 0,
  `bpweapon_14` int(11) DEFAULT 0,
  `formeradmin` int(2) NOT NULL DEFAULT 0,
  `deathcooldown` int(10) NOT NULL DEFAULT 0,
  `totalpatients` int(10) NOT NULL DEFAULT 0,
  `totalfires` int(10) NOT NULL DEFAULT 0,
  `rarecooldown` int(10) NOT NULL DEFAULT 0,
  `customtitle` varchar(64) NOT NULL DEFAULT '0',
  `customcolor` varchar(16) NOT NULL DEFAULT '0',
  `mask` int(10) NOT NULL DEFAULT 0,
  `blindfold` int(10) NOT NULL DEFAULT 0,
  `rope` int(10) NOT NULL DEFAULT 0,
  `insurance` int(10) NOT NULL DEFAULT 0,
  `passport` int(10) NOT NULL DEFAULT 0,
  `passportname` varchar(64) DEFAULT NULL,
  `passportlevel` int(10) NOT NULL DEFAULT 0,
  `passportskin` int(10) NOT NULL DEFAULT 0,
  `passportphone` int(10) NOT NULL DEFAULT 0,
  `marriedto` int(10) NOT NULL DEFAULT -1,
  `newbies` int(10) NOT NULL DEFAULT 0,
  `chatanim` int(2) NOT NULL DEFAULT 1,
  `money_earned` bigint(20) NOT NULL DEFAULT 0,
  `money_spent` bigint(20) NOT NULL DEFAULT 0,
  `hunger` int(10) NOT NULL DEFAULT 100,
  `thirst` int(11) NOT NULL DEFAULT 100,
  `hungertimer` int(11) NOT NULL DEFAULT 0,
  `thirsttimer` int(11) NOT NULL DEFAULT 0,
  `dynamicadmin` int(1) NOT NULL DEFAULT 0,
  `login_date` date DEFAULT NULL,
  `amuted` int(1) NOT NULL DEFAULT 0,
  `amcount` int(10) NOT NULL DEFAULT 0,
  `dirtycash` int(10) DEFAULT 0,
  `Phonep` int(2) NOT NULL DEFAULT 0,
  `lottery` int(2) NOT NULL DEFAULT 0,
  `brokenleg` int(1) NOT NULL DEFAULT 0,
  `gunlicense` tinyint(2) NOT NULL DEFAULT 0,
  `comserv` int(10) DEFAULT 0,
  `stress` int(11) NOT NULL DEFAULT 0,
  `stresstimer` int(11) NOT NULL DEFAULT 0,
  `shopeecooldown` int(10) DEFAULT 0,
  `WepSerial` int(10) DEFAULT 0,
  `crew` int(2) DEFAULT -1,
  `youtuber` int(1) NOT NULL DEFAULT 0,
  `upgradepoints` int(10) DEFAULT 0,
  `flashlight` int(2) NOT NULL DEFAULT 0,
  `ammo_0` int(5) DEFAULT 0,
  `ammo_1` int(5) DEFAULT 0,
  `ammo_2` int(5) DEFAULT 0,
  `ammo_3` int(5) DEFAULT 0,
  `ammo_4` int(5) DEFAULT 0,
  `ammo_5` int(5) DEFAULT 0,
  `ammo_6` int(5) DEFAULT 0,
  `ammo_7` int(5) DEFAULT 0,
  `ammo_8` int(5) DEFAULT 0,
  `ammo_9` int(5) DEFAULT 0,
  `ammo_10` int(5) DEFAULT 0,
  `ammo_11` int(5) DEFAULT 0,
  `ammo_12` int(5) DEFAULT 0,
  `pistolammo` int(5) DEFAULT 0,
  `shotgunammo` int(5) DEFAULT 0,
  `smgammo` int(5) DEFAULT 0,
  `arammo` int(5) DEFAULT 0,
  `rifleammo` int(5) DEFAULT 0,
  `hpammo` int(5) DEFAULT 0,
  `poisonammo` int(5) DEFAULT 0,
  `fmjammo` int(5) DEFAULT 0,
  `ammotype` tinyint(2) DEFAULT 0,
  `ammoweapon` tinyint(2) DEFAULT 0,
  `eventmod` int(1) DEFAULT 0,
  `toggletextdraws` tinyint(1) DEFAULT 0,
  `contentcreator` int(1) NOT NULL DEFAULT 0,
  `bphpammo` int(11) DEFAULT 0,
  `bppoisonammo` int(11) DEFAULT 0,
  `bpfmjammo` int(11) DEFAULT 0,
  `repairkit` int(10) DEFAULT 0,
  `chatstyle` int(11) NOT NULL DEFAULT 1,
  `togglebug` int(1) DEFAULT 0,
  `bugged` int(1) DEFAULT 0,
  `toggletweet` int(1) DEFAULT 0,
  `tweetmuted` int(1) DEFAULT 0,
  `bitcoincooldown` int(10) NOT NULL DEFAULT 0,
  `bitcoin` int(10) DEFAULT 0,
  `phonecredit` int(10) DEFAULT 0,
  `bpammo_0` int(10) NOT NULL DEFAULT 0,
  `bpammo_1` int(10) NOT NULL DEFAULT 0,
  `bpammo_2` int(10) NOT NULL DEFAULT 0,
  `bpammo_3` int(10) NOT NULL DEFAULT 0,
  `bpammo_4` int(10) NOT NULL DEFAULT 0,
  `bpammo_5` int(10) NOT NULL DEFAULT 0,
  `bpammo_6` int(10) NOT NULL DEFAULT 0,
  `bpammo_7` int(10) NOT NULL DEFAULT 0,
  `bpammo_8` int(10) NOT NULL DEFAULT 0,
  `bpammo_9` int(10) NOT NULL DEFAULT 0,
  `bpammo_10` int(10) NOT NULL DEFAULT 0,
  `bpammo_11` int(10) NOT NULL DEFAULT 0,
  `bpammo_12` int(10) NOT NULL DEFAULT 0,
  `bpammo_13` int(10) NOT NULL DEFAULT 0,
  `bpammo_14` int(10) NOT NULL DEFAULT 0,
  `weaponclip` int(10) DEFAULT 0,
  `vest` int(10) DEFAULT 0,
  `bandage` int(10) DEFAULT 0,
  `medkit` int(10) DEFAULT 0,
  `walkstyle` int(11) NOT NULL DEFAULT 1,
  `food` int(10) DEFAULT 0,
  `drink` int(10) DEFAULT 0,
  `diamonds` int(11) NOT NULL DEFAULT 0,
  `voicechat` int(11) DEFAULT NULL,
  `discordtag` int(11) DEFAULT NULL,
  `discordname` int(11) DEFAULT NULL,
  `rollerskates` int(1) NOT NULL DEFAULT 0,
  `parts` int(10) DEFAULT 0,
  `firework` int(10) DEFAULT 2,
  `crowbar` tinyint(1) NOT NULL DEFAULT 0,
  `pendrive` int(11) NOT NULL DEFAULT 0,
  `adminpersonnel` int(1) DEFAULT 0,
  `approved` int(1) NOT NULL DEFAULT 0,
  `application_reason` varchar(128) DEFAULT NULL,
  `application_answer1` varchar(128) DEFAULT NULL,
  `application_answer2` varchar(128) DEFAULT NULL,
  `application_answer3` varchar(128) DEFAULT NULL,
  `application_answer4` varchar(128) DEFAULT NULL,
  `application_answer5` varchar(128) DEFAULT NULL,
  `application_answer6` varchar(128) DEFAULT NULL,
  `application_answer7` varchar(128) DEFAULT NULL,
  `application_answer8` varchar(128) DEFAULT NULL,
  `application_answer9` varchar(128) DEFAULT NULL,
  `firstspawn` int(1) NOT NULL DEFAULT 1,
  `spawntype` int(1) NOT NULL DEFAULT 0,
  `spawnid` int(5) NOT NULL DEFAULT -1,
  `helmet` int(10) DEFAULT 0,
  `bedtype` int(11) DEFAULT 0,
  `bedtime` int(10) DEFAULT 0,
  `dryflower` int(10) DEFAULT 0,
  `flower` int(10) DEFAULT 0,
  `helmetp` int(10) DEFAULT 0,
  `laptop` int(10) DEFAULT 0,
  `toolkit` int(10) DEFAULT 0,
  `LotteryB` int(10) DEFAULT 0,
  `loginurl` varchar(128) DEFAULT 'https://stream.zeno.fm/9sfpn7udkfwuv',
  `psdeagle` int(11) DEFAULT 0,
  `psm4` int(11) DEFAULT 0,
  `psmp5` int(11) DEFAULT 0,
  `helmetpro` int(11) DEFAULT 0,
  `helmethide` int(11) DEFAULT 0,
  `energydrink` int(2) DEFAULT 0,
  `energyroll` int(2) DEFAULT 0,
  `apple` int(2) DEFAULT 0,
  `ore` int(11) DEFAULT 0,
  `metals` int(11) DEFAULT 0,
  `copper` int(11) DEFAULT 0,
  `gold` int(11) DEFAULT 0,
  `iorn` int(11) DEFAULT 0,
  `pscash` int(11) DEFAULT 0,
  `MobileMethLab` int(11) DEFAULT 0,
  `batteries` int(11) DEFAULT 0,
  `acetone` int(11) DEFAULT 0,
  `psdcash` int(11) DEFAULT 0,
  `pspot` int(11) DEFAULT 0,
  `psmeth` int(11) DEFAULT 0,
  `pscrack` int(11) DEFAULT 0,
  `psuzi` int(11) DEFAULT 0,
  `ps9mm` int(11) DEFAULT 0,
  `psak` int(11) DEFAULT 0,
  `lasttime` int(11) DEFAULT 0,
  `family` int(11) DEFAULT 0,
  `familyrank` int(11) DEFAULT 0,
  `voted` int(11) DEFAULT 0,
  `donateweapon` int(11) DEFAULT 0,
  `buygun` int(11) DEFAULT 0,
  `bgtime` datetime DEFAULT NULL,
  `factionban` int(11) DEFAULT 0,
  `gangban` int(11) DEFAULT 0,
  `laborupgrade` int(11) DEFAULT 0,
  `Amount` decimal(10,2) DEFAULT 0.00,
  `vipdlcooldown` datetime DEFAULT NULL,
  `load` int(11) NOT NULL DEFAULT 0,
  `loadtime` int(11) DEFAULT 0,
  `sim` tinyint(4) DEFAULT 0,
  `lockpick` tinyint(4) DEFAULT NULL,
  `Select` tinyint(4) DEFAULT NULL,
  `verify` tinyint(1) NOT NULL DEFAULT 0,
  `code` tinyint(4) DEFAULT NULL,
  `pepperspray` int(11) DEFAULT 0,
  `pepperammo` int(11) DEFAULT 0,
  `psjoint` int(11) DEFAULT 0,
  `milkshake` int(11) DEFAULT 0,
  `height` int(11) NOT NULL DEFAULT 170,
  `radio` int(11) NOT NULL DEFAULT 0,
  `birth_day` int(11) NOT NULL DEFAULT 1,
  `birth_month` int(11) NOT NULL DEFAULT 1,
  `birth_year` int(11) NOT NULL DEFAULT 2000,
  `date_of_birth` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(64) NOT NULL DEFAULT '',
  `discord_id` varchar(50) NOT NULL DEFAULT '',
  `idcard` varchar(9) NOT NULL DEFAULT '',
  `idcard_date` varchar(32) NOT NULL DEFAULT '',
  `pIDCard1` int(1) NOT NULL DEFAULT 0,
  `gunframe` int(11) NOT NULL DEFAULT 0,
  `pistolframe` int(11) NOT NULL DEFAULT 0,
  `rifleframe` int(11) NOT NULL DEFAULT 0,
  `metalparts` int(11) NOT NULL DEFAULT 0,
  `gunpowder` int(11) NOT NULL DEFAULT 0,
  `weaponkits` int(11) NOT NULL DEFAULT 0,
  `farmwater` int(11) NOT NULL DEFAULT 0,
  `farmfertilization` int(11) NOT NULL DEFAULT 0,
  `mushroomseed` int(11) NOT NULL DEFAULT 0,
  `mushroom` int(11) NOT NULL DEFAULT 0,
  `cocowplant` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(10) NOT NULL,
  `ownerid` int(10) DEFAULT 0,
  `owner` varchar(24) DEFAULT 'Nobody',
  `modelid` smallint(3) DEFAULT 0,
  `price` int(10) DEFAULT 0,
  `tickets` int(10) DEFAULT 0,
  `locked` tinyint(1) DEFAULT 0,
  `plate` varchar(32) DEFAULT 'None',
  `fuel` float DEFAULT 100,
  `health` float DEFAULT 1000,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `pos_a` float DEFAULT 0,
  `color1` smallint(3) DEFAULT 0,
  `color2` smallint(3) DEFAULT 0,
  `paintjob` tinyint(2) DEFAULT -1,
  `interior` tinyint(2) DEFAULT 0,
  `world` int(10) DEFAULT 0,
  `neon` smallint(5) DEFAULT 0,
  `neonenabled` tinyint(1) DEFAULT 0,
  `trunk` tinyint(1) DEFAULT 0,
  `mod_1` smallint(4) DEFAULT 0,
  `mod_2` smallint(4) DEFAULT 0,
  `mod_3` smallint(4) DEFAULT 0,
  `mod_4` smallint(4) DEFAULT 0,
  `mod_5` smallint(4) DEFAULT 0,
  `mod_6` smallint(4) DEFAULT 0,
  `mod_7` smallint(4) DEFAULT 0,
  `mod_8` smallint(4) DEFAULT 0,
  `mod_9` smallint(4) DEFAULT 0,
  `mod_10` smallint(4) DEFAULT 0,
  `mod_11` smallint(4) DEFAULT 0,
  `mod_12` smallint(4) DEFAULT 0,
  `mod_13` smallint(4) DEFAULT 0,
  `mod_14` smallint(4) DEFAULT 0,
  `cash` int(10) DEFAULT 0,
  `materials` int(10) DEFAULT 0,
  `pot` int(10) DEFAULT 0,
  `crack` int(10) DEFAULT 0,
  `meth` int(10) DEFAULT 0,
  `painkillers` int(10) DEFAULT 0,
  `weapon_1` tinyint(2) DEFAULT 0,
  `weapon_2` tinyint(2) DEFAULT 0,
  `weapon_3` tinyint(2) DEFAULT 0,
  `weapon_4` tinyint(2) DEFAULT 0,
  `weapon_5` tinyint(2) DEFAULT 0,
  `gangid` tinyint(2) DEFAULT -1,
  `ammo_1` int(10) NOT NULL DEFAULT 0,
  `ammo_2` int(10) NOT NULL DEFAULT 0,
  `ammo_3` int(10) NOT NULL DEFAULT 0,
  `factiontype` tinyint(2) DEFAULT 0,
  `job` tinyint(2) DEFAULT -1,
  `respawndelay` int(10) DEFAULT 0,
  `impounded` tinyint(1) NOT NULL DEFAULT 0,
  `forsaleprice` int(11) NOT NULL DEFAULT 0,
  `forsale` int(11) NOT NULL DEFAULT 0,
  `vippackage` tinyint(2) NOT NULL DEFAULT 0,
  `pistolammo` smallint(5) DEFAULT 0,
  `shotgunammo` smallint(5) DEFAULT 0,
  `smgammo` smallint(5) DEFAULT 0,
  `arammo` smallint(5) DEFAULT 0,
  `rifleammo` smallint(5) DEFAULT 0,
  `hpammo` smallint(5) DEFAULT 0,
  `poisonammo` smallint(5) DEFAULT 0,
  `fmjammo` smallint(5) DEFAULT 0,
  `registered` tinyint(11) DEFAULT 0,
  `vest` int(10) DEFAULT 0,
  `broken` tinyint(1) NOT NULL DEFAULT 0,
  `costom` int(11) DEFAULT 0,
  `milliage` float NOT NULL DEFAULT 0,
  `rent` tinyint(4) DEFAULT 0,
  `renttime` int(11) DEFAULT 0,
  `hydro` tinyint(4) NOT NULL DEFAULT 0,
  `vip` tinyint(4) NOT NULL DEFAULT 0,
  `ore` int(11) DEFAULT 0,
  `metals` int(11) DEFAULT 0,
  `copper` int(11) DEFAULT 0,
  `iorn` int(11) DEFAULT 0,
  `gold` int(11) DEFAULT 0,
  `diamond` int(11) DEFAULT 0,
  `ogowner` int(11) DEFAULT 0,
  `cartype` int(11) DEFAULT 0,
  `carname` varchar(128) NOT NULL DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `vendorID` int(12) NOT NULL,
  `vendorModel` int(12) DEFAULT 980,
  `vendorPosX` float DEFAULT 0,
  `vendorPosY` float DEFAULT 0,
  `vendorPosZ` float DEFAULT 0,
  `vendorInterior` int(12) DEFAULT 0,
  `vendorWorld` int(12) DEFAULT 0,
  `vendorAngle` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weapons`
--

CREATE TABLE `weapons` (
  `uid` int(10) NOT NULL,
  `weaponid` tinyint(2) DEFAULT NULL,
  `ammo` int(5) DEFAULT NULL,
  `slot` tinyint(2) DEFAULT NULL,
  `ownername` varchar(124) DEFAULT NULL,
  `ownerid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weapon_factories`
--

CREATE TABLE `weapon_factories` (
  `id` int(11) NOT NULL,
  `gang_id` int(11) NOT NULL DEFAULT 0,
  `owner_name` varchar(32) NOT NULL DEFAULT 'None',
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_a` float NOT NULL,
  `locker_x` float NOT NULL DEFAULT 0,
  `locker_y` float NOT NULL DEFAULT 0,
  `locker_z` float NOT NULL DEFAULT 0,
  `has_locker` tinyint(4) NOT NULL DEFAULT 0,
  `slot1_x` float NOT NULL DEFAULT 0,
  `slot1_y` float NOT NULL DEFAULT 0,
  `slot1_z` float NOT NULL DEFAULT 0,
  `slot2_x` float NOT NULL DEFAULT 0,
  `slot2_y` float NOT NULL DEFAULT 0,
  `slot2_z` float NOT NULL DEFAULT 0,
  `slot3_x` float NOT NULL DEFAULT 0,
  `slot3_y` float NOT NULL DEFAULT 0,
  `slot3_z` float NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 100,
  `status` int(11) NOT NULL DEFAULT 0,
  `cooldown_end` int(11) NOT NULL DEFAULT 0,
  `locker_m4` int(11) NOT NULL DEFAULT 0,
  `locker_deagle` int(11) NOT NULL DEFAULT 0,
  `total_m4` int(11) NOT NULL DEFAULT 0,
  `total_deagle` int(11) NOT NULL DEFAULT 0,
  `crates_spawned` int(11) NOT NULL DEFAULT 0,
  `crates_lost` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_logs`
--

CREATE TABLE `wf_logs` (
  `id` int(11) NOT NULL,
  `factory_sql_id` int(11) NOT NULL,
  `player_name` varchar(32) NOT NULL DEFAULT 'System',
  `action` varchar(32) NOT NULL,
  `details` varchar(144) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_productions`
--

CREATE TABLE `wf_productions` (
  `factory_sql_id` int(11) NOT NULL,
  `weapon_type` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `progress` int(11) NOT NULL DEFAULT 0,
  `start_time` int(11) NOT NULL,
  `last_crate` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atms`
--
ALTER TABLE `atms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `BankHis`
--
ALTER TABLE `BankHis`
  ADD PRIMARY KEY (`log_date`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_bans_username` (`username`),
  ADD KEY `idx_bans_ip` (`ip`);

--
-- Indexes for table `bars`
--
ALTER TABLE `bars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `changes`
--
ALTER TABLE `changes`
  ADD UNIQUE KEY `slot` (`slot`);

--
-- Indexes for table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_charges_uid` (`uid`);

--
-- Indexes for table `clothing`
--
ALTER TABLE `clothing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clothing_uid` (`uid`);

--
-- Indexes for table `cocainefarm`
--
ALTER TABLE `cocainefarm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cocainelocker`
--
ALTER TABLE `cocainelocker`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `turfid` (`turfid`);

--
-- Indexes for table `dealerships`
--
ALTER TABLE `dealerships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dealerships_exists_id` (`exists`,`id`);

--
-- Indexes for table `divisions`
--
ALTER TABLE `divisions`
  ADD UNIQUE KEY `id` (`id`,`divisionid`);

--
-- Indexes for table `dropped`
--
ALTER TABLE `dropped`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entrances`
--
ALTER TABLE `entrances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factiongarages`
--
ALTER TABLE `factiongarages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factionlockers`
--
ALTER TABLE `factionlockers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factionpay`
--
ALTER TABLE `factionpay`
  ADD UNIQUE KEY `id` (`id`,`rank`);

--
-- Indexes for table `factionranks`
--
ALTER TABLE `factionranks`
  ADD UNIQUE KEY `id` (`id`,`rank`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `idx_factions_type_id` (`type`,`id`);

--
-- Indexes for table `factionskins`
--
ALTER TABLE `factionskins`
  ADD UNIQUE KEY `id` (`id`,`slot`);

--
-- Indexes for table `flags`
--
ALTER TABLE `flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_flags_uid_date` (`uid`,`date`);

--
-- Indexes for table `fuelstations`
--
ALTER TABLE `fuelstations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `furniture`
--
ALTER TABLE `furniture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_furniture_houseid_id` (`houseid`,`id`);

--
-- Indexes for table `ganggarage`
--
ALTER TABLE `ganggarage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ganggarage_gangid` (`gangid`);

--
-- Indexes for table `gangranks`
--
ALTER TABLE `gangranks`
  ADD UNIQUE KEY `id` (`id`,`rank`);

--
-- Indexes for table `gangs`
--
ALTER TABLE `gangs`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `gangskins`
--
ALTER TABLE `gangskins`
  ADD UNIQUE KEY `id` (`id`,`slot`);

--
-- Indexes for table `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`gateID`);

--
-- Indexes for table `graffiti`
--
ALTER TABLE `graffiti`
  ADD PRIMARY KEY (`graffitiID`);

--
-- Indexes for table `greenzone`
--
ALTER TABLE `greenzone`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kills`
--
ALTER TABLE `kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_kills_killer_date` (`killer_uid`,`date`),
  ADD KEY `idx_kills_target_date` (`target_uid`,`date`);

--
-- Indexes for table `landobjects`
--
ALTER TABLE `landobjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_landobjects_landid_id` (`landid`,`id`);

--
-- Indexes for table `lands`
--
ALTER TABLE `lands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_faction`
--
ALTER TABLE `log_faction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdc`
--
ALTER TABLE `mdc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mushroomfarm`
--
ALTER TABLE `mushroomfarm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mushroomlocker`
--
ALTER TABLE `mushroomlocker`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `turfid` (`turfid`);

--
-- Indexes for table `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`mobjID`);

--
-- Indexes for table `payphones`
--
ALTER TABLE `payphones`
  ADD PRIMARY KEY (`phID`);

--
-- Indexes for table `phonebook`
--
ALTER TABLE `phonebook`
  ADD UNIQUE KEY `number` (`number`),
  ADD KEY `idx_phonebook_name` (`name`);

--
-- Indexes for table `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`phoneid`),
  ADD UNIQUE KEY `phonenumber` (`phonenumber`);

--
-- Indexes for table `phone_contacts`
--
ALTER TABLE `phone_contacts`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `idx_phone_contacts_number` (`phone_number`);

--
-- Indexes for table `points`
--
ALTER TABLE `points`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `publicganggarage`
--
ALTER TABLE `publicganggarage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `publicgarage`
--
ALTER TABLE `publicgarage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `publiclocker`
--
ALTER TABLE `publiclocker`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `repairstation`
--
ALTER TABLE `repairstation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shots`
--
ALTER TABLE `shots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_shots_player_id` (`playerid`,`id`),
  ADD KEY `idx_shots_hit_id` (`hitid`,`hittype`,`id`);

--
-- Indexes for table `speedcameras`
--
ALTER TABLE `speedcameras`
  ADD PRIMARY KEY (`speedID`);

--
-- Indexes for table `sticky_messages`
--
ALTER TABLE `sticky_messages`
  ADD PRIMARY KEY (`channel_id`);

--
-- Indexes for table `surgery`
--
ALTER TABLE `surgery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `texts`
--
ALTER TABLE `texts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_texts_recipient_date` (`recipient_number`,`date`);

--
-- Indexes for table `turfs`
--
ALTER TABLE `turfs`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `idx_users_username` (`username`),
  ADD KEY `idx_users_phone` (`phone`),
  ADD KEY `idx_users_bank` (`bank`),
  ADD KEY `idx_users_crimes` (`crimes`),
  ADD KEY `idx_users_hours` (`hours`),
  ADD KEY `idx_users_verify_username` (`verify`,`username`),
  ADD KEY `idx_users_ip_lastlogin` (`ip`,`lastlogin`),
  ADD KEY `idx_users_gang_rank` (`gang`,`gangrank`),
  ADD KEY `idx_users_faction_rank` (`faction`,`factionrank`),
  ADD KEY `idx_users_rentinghouse_login` (`rentinghouse`,`lastlogin`),
  ADD KEY `idx_users_admin_login` (`adminlevel`,`lastlogin`),
  ADD KEY `idx_users_helper_login` (`helperlevel`,`lastlogin`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vehicles_ownerid` (`ownerid`),
  ADD KEY `idx_vehicles_gangid` (`gangid`),
  ADD KEY `idx_vehicles_owner_impounded` (`ownerid`,`impounded`),
  ADD KEY `idx_vehicles_owner_rent` (`ownerid`,`rent`),
  ADD KEY `idx_vehicles_rent` (`rent`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`vendorID`);

--
-- Indexes for table `weapons`
--
ALTER TABLE `weapons`
  ADD PRIMARY KEY (`uid`) USING BTREE;

--
-- Indexes for table `weapon_factories`
--
ALTER TABLE `weapon_factories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wf_logs`
--
ALTER TABLE `wf_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wf_logs_factory_created` (`factory_sql_id`,`created_at`);

--
-- Indexes for table `wf_productions`
--
ALTER TABLE `wf_productions`
  ADD PRIMARY KEY (`factory_sql_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `atms`
--
ALTER TABLE `atms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bars`
--
ALTER TABLE `bars`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clothing`
--
ALTER TABLE `clothing`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cocainefarm`
--
ALTER TABLE `cocainefarm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cocainelocker`
--
ALTER TABLE `cocainelocker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealerships`
--
ALTER TABLE `dealerships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dropped`
--
ALTER TABLE `dropped`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `entrances`
--
ALTER TABLE `entrances`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factiongarages`
--
ALTER TABLE `factiongarages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factionlockers`
--
ALTER TABLE `factionlockers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flags`
--
ALTER TABLE `flags`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuelstations`
--
ALTER TABLE `fuelstations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `furniture`
--
ALTER TABLE `furniture`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ganggarage`
--
ALTER TABLE `ganggarage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `garages`
--
ALTER TABLE `garages`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gates`
--
ALTER TABLE `gates`
  MODIFY `gateID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `graffiti`
--
ALTER TABLE `graffiti`
  MODIFY `graffitiID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kills`
--
ALTER TABLE `kills`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `landobjects`
--
ALTER TABLE `landobjects`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lands`
--
ALTER TABLE `lands`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_faction`
--
ALTER TABLE `log_faction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdc`
--
ALTER TABLE `mdc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mushroomfarm`
--
ALTER TABLE `mushroomfarm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mushroomlocker`
--
ALTER TABLE `mushroomlocker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `object`
--
ALTER TABLE `object`
  MODIFY `mobjID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payphones`
--
ALTER TABLE `payphones`
  MODIFY `phID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phones`
--
ALTER TABLE `phones`
  MODIFY `phoneid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_contacts`
--
ALTER TABLE `phone_contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publicganggarage`
--
ALTER TABLE `publicganggarage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `repairstation`
--
ALTER TABLE `repairstation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shots`
--
ALTER TABLE `shots`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `speedcameras`
--
ALTER TABLE `speedcameras`
  MODIFY `speedID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `surgery`
--
ALTER TABLE `surgery`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `texts`
--
ALTER TABLE `texts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `vendorID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weapons`
--
ALTER TABLE `weapons`
  MODIFY `uid` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weapon_factories`
--
ALTER TABLE `weapon_factories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wf_logs`
--
ALTER TABLE `wf_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
