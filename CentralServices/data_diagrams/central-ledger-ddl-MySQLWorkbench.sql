-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: central_ledger_
-- ------------------------------------------------------
-- Server version	5.7.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contactType`
--

DROP TABLE IF EXISTS `contactType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactType` (
  `contactTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`contactTypeId`),
  UNIQUE KEY `contacttype_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactType`
--

LOCK TABLES `contactType` WRITE;
/*!40000 ALTER TABLE `contactType` DISABLE KEYS */;
/*!40000 ALTER TABLE `contactType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `currencyId` varchar(3) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`currencyId`),
  UNIQUE KEY `currency_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endpointType`
--

DROP TABLE IF EXISTS `endpointType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endpointType` (
  `endpointTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`endpointTypeId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endpointType`
--

LOCK TABLES `endpointType` WRITE;
/*!40000 ALTER TABLE `endpointType` DISABLE KEYS */;
/*!40000 ALTER TABLE `endpointType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `eventId` varchar(36) NOT NULL,
  `name` varchar(128) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`eventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ilpPacket`
--

DROP TABLE IF EXISTS `ilpPacket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ilpPacket` (
  `transferId` varchar(36) NOT NULL,
  `value` text NOT NULL COMMENT 'ilpPacket',
  PRIMARY KEY (`transferId`),
  KEY `ilp_transferid_index` (`transferId`),
  CONSTRAINT `ilp_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ilpPacket`
--

LOCK TABLES `ilpPacket` WRITE;
/*!40000 ALTER TABLE `ilpPacket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ilpPacket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ledgerEntryType`
--

DROP TABLE IF EXISTS `ledgerEntryType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ledgerEntryType` (
  `ledgerEntryTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ledgerEntryTypeId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ledgerEntryType`
--

LOCK TABLES `ledgerEntryType` WRITE;
/*!40000 ALTER TABLE `ledgerEntryType` DISABLE KEYS */;
/*!40000 ALTER TABLE `ledgerEntryType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `batch` int(11) DEFAULT NULL,
  `migration_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_lock`
--

DROP TABLE IF EXISTS `migration_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration_lock` (
  `is_locked` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_lock`
--

LOCK TABLES `migration_lock` WRITE;
/*!40000 ALTER TABLE `migration_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `migration_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participant`
--

DROP TABLE IF EXISTS `participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participant` (
  `participantId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantId`),
  UNIQUE KEY `participant_currencyid_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participant`
--

LOCK TABLES `participant` WRITE;
/*!40000 ALTER TABLE `participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantContact`
--

DROP TABLE IF EXISTS `participantContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantContact` (
  `participantContactId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `contactTypeId` int(10) unsigned NOT NULL,
  `value` varchar(256) NOT NULL,
  `priorityPreference` int(11) NOT NULL DEFAULT '9',
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantContactId`),
  KEY `participantcontact_participantid_index` (`participantId`),
  KEY `participantcontact_contacttypeid_index` (`contactTypeId`),
  CONSTRAINT `participantcontact_contacttypeid_foreign` FOREIGN KEY (`contactTypeId`) REFERENCES `contactType` (`contactTypeId`),
  CONSTRAINT `participantcontact_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantContact`
--

LOCK TABLES `participantContact` WRITE;
/*!40000 ALTER TABLE `participantContact` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantContact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantCurrency`
--

DROP TABLE IF EXISTS `participantCurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantCurrency` (
  `participantCurrencyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `currencyId` varchar(3) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantCurrencyId`),
  KEY `participantcurrency_participantid_foreign_idx` (`participantId`),
  KEY `participantcurrency_currencyid_foreign_idx` (`currencyId`),
  CONSTRAINT `participantcurrency_currencyid_foreign` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`currencyId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `participantcurrency_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantCurrency`
--

LOCK TABLES `participantCurrency` WRITE;
/*!40000 ALTER TABLE `participantCurrency` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantCurrency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantEndpoint`
--

DROP TABLE IF EXISTS `participantEndpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantEndpoint` (
  `participantEndpointId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `endpointTypeId` int(10) unsigned NOT NULL,
  `value` varchar(512) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantEndpointId`),
  KEY `participantendpoint_participantid_foreign_idx` (`participantId`),
  KEY `participantendpoint_endpointtype_foreign_idx` (`endpointTypeId`),
  CONSTRAINT `participantendpoint_endpointtype_foreign` FOREIGN KEY (`endpointTypeId`) REFERENCES `endpointType` (`endpointTypeId`),
  CONSTRAINT `participantendpoint_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantEndpoint`
--

LOCK TABLES `participantEndpoint` WRITE;
/*!40000 ALTER TABLE `participantEndpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantEndpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantLimit`
--

DROP TABLE IF EXISTS `participantLimit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantLimit` (
  `participantLimitId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participantCurrencyId` int(10) unsigned NOT NULL,
  `participantLimitTypeId` int(10) unsigned NOT NULL,
  `value` decimal(18,2) NOT NULL DEFAULT '0.00',
  `thresholdAlarmPercentage` decimal(5,2) NOT NULL DEFAULT '10.00',
  `startAfterParticipantPositionLogId` bigint(20) unsigned DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantLimitId`),
  KEY `participantlimit_participantid_index` (`participantCurrencyId`),
  KEY `participantlimit_participantlimittypeid_foreign_idx` (`participantLimitTypeId`),
  KEY `participantlimit_startafterparticipantpositionid_foreign_idx` (`startAfterParticipantPositionLogId`),
  CONSTRAINT `participantlimit_participantcurrencyid_foreign` FOREIGN KEY (`participantCurrencyId`) REFERENCES `participantCurrency` (`participantCurrencyId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `participantlimit_participantlimittypeid_foreign` FOREIGN KEY (`participantLimitTypeId`) REFERENCES `participantLimitType` (`participantLimitTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `participantlimit_startafterparticipantpositionid_foreign` FOREIGN KEY (`startAfterParticipantPositionLogId`) REFERENCES `participantPositionChange` (`participantPositionChangeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantLimit`
--

LOCK TABLES `participantLimit` WRITE;
/*!40000 ALTER TABLE `participantLimit` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantLimit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantLimitType`
--

DROP TABLE IF EXISTS `participantLimitType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantLimitType` (
  `participantLimitTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participantLimitTypeId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantLimitType`
--

LOCK TABLES `participantLimitType` WRITE;
/*!40000 ALTER TABLE `participantLimitType` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantLimitType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantParty`
--

DROP TABLE IF EXISTS `participantParty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantParty` (
  `participantPartyId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `partyId` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`participantPartyId`),
  UNIQUE KEY `participantparty_participantid_partyid_unique` (`participantId`,`partyId`),
  KEY `participantparty_participantid_index` (`participantId`),
  CONSTRAINT `participantparty_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantParty`
--

LOCK TABLES `participantParty` WRITE;
/*!40000 ALTER TABLE `participantParty` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantParty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantPosition`
--

DROP TABLE IF EXISTS `participantPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantPosition` (
  `participantPositionId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `participantCurrencyId` int(10) unsigned NOT NULL,
  `value` decimal(18,2) NOT NULL,
  `reservedValue` decimal(18,2) NOT NULL,
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participantPositionId`),
  KEY `participantposition_participantid_index` (`participantCurrencyId`),
  CONSTRAINT `participantposition_participantcurrencyid_foreign` FOREIGN KEY (`participantCurrencyId`) REFERENCES `participantCurrency` (`participantCurrencyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantPosition`
--

LOCK TABLES `participantPosition` WRITE;
/*!40000 ALTER TABLE `participantPosition` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantPosition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantPositionChange`
--

DROP TABLE IF EXISTS `participantPositionChange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantPositionChange` (
  `participantPositionChangeId` bigint(20) unsigned NOT NULL,
  `participantPositionId` bigint(10) unsigned NOT NULL,
  `transferStateChangeId` bigint(20) unsigned NOT NULL,
  `value` decimal(18,2) NOT NULL,
  `reservedValue` decimal(18,2) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participantPositionChangeId`),
  KEY `participantPositionLog_participantPositionId_foreign_idx` (`participantPositionId`),
  KEY `participantPositionLog_transferStateChangeId_foreign_idx` (`transferStateChangeId`),
  CONSTRAINT `participantpositionlog_participantpositionId_foreign` FOREIGN KEY (`participantPositionId`) REFERENCES `participantPosition` (`participantPositionId`),
  CONSTRAINT `participantpositionlog_transferstatechangeId_foreign` FOREIGN KEY (`transferStateChangeId`) REFERENCES `transferStateChange` (`transferStateChangeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantPositionChange`
--

LOCK TABLES `participantPositionChange` WRITE;
/*!40000 ALTER TABLE `participantPositionChange` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantPositionChange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantSettlement`
--

DROP TABLE IF EXISTS `participantSettlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantSettlement` (
  `participantSettlementId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `participantNumber` varchar(16) NOT NULL,
  `routingNumber` varchar(16) NOT NULL,
  PRIMARY KEY (`participantSettlementId`),
  UNIQUE KEY `participantsettlement_participantid_unique` (`participantId`),
  KEY `participantsettlement_participantid_index` (`participantId`),
  CONSTRAINT `participantsettlement_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participantSettlement`
--

LOCK TABLES `participantSettlement` WRITE;
/*!40000 ALTER TABLE `participantSettlement` DISABLE KEYS */;
/*!40000 ALTER TABLE `participantSettlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settledFee`
--

DROP TABLE IF EXISTS `settledFee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settledFee` (
  `settledFeeId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feeId` bigint(20) unsigned NOT NULL,
  `settlementId` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`settledFeeId`),
  UNIQUE KEY `settledfee_feeid_settlementid_unique` (`feeId`,`settlementId`),
  KEY `settledfee_feeid_index` (`feeId`),
  KEY `settledfee_settlementid_index` (`settlementId`),
  CONSTRAINT `settledfee_settlementid_foreign` FOREIGN KEY (`settlementId`) REFERENCES `settlement` (`settlementId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settledFee`
--

LOCK TABLES `settledFee` WRITE;
/*!40000 ALTER TABLE `settledFee` DISABLE KEYS */;
/*!40000 ALTER TABLE `settledFee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlement`
--

DROP TABLE IF EXISTS `settlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlement` (
  `settlementId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `settlementWindowId` bigint(20) unsigned NOT NULL,
  `settlementType` varchar(16) NOT NULL,
  `settledDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`settlementId`),
  KEY `settlement_transfersettlementbatchid_index` (`settlementWindowId`),
  CONSTRAINT `settlement_transfersettlementbatchid_foreign` FOREIGN KEY (`settlementWindowId`) REFERENCES `settlementWindow` (`settlementWindowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlement`
--

LOCK TABLES `settlement` WRITE;
/*!40000 ALTER TABLE `settlement` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlementWindow`
--

DROP TABLE IF EXISTS `settlementWindow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlementWindow` (
  `settlementWindowId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(50) DEFAULT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`settlementWindowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlementWindow`
--

LOCK TABLES `settlementWindow` WRITE;
/*!40000 ALTER TABLE `settlementWindow` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlementWindow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `tokenId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `value` varchar(256) NOT NULL,
  `expiration` bigint(20) DEFAULT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tokenId`),
  UNIQUE KEY `token_value_unique` (`value`),
  KEY `token_participantid_index` (`participantId`),
  CONSTRAINT `token_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfer` (
  `transferId` varchar(36) NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `currencyId` varchar(3) NOT NULL COMMENT 'currency',
  `ilpCondition` varchar(256) NOT NULL,
  `expirationDate` datetime NOT NULL COMMENT 'expiration ilp condition',
  PRIMARY KEY (`transferId`),
  KEY `transfer_currencyid_foreign` (`currencyId`),
  KEY `transfer_transferid_index` (`transferId`),
  CONSTRAINT `transfer_currencyid_foreign` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`currencyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferDuplicateCheck`
--

DROP TABLE IF EXISTS `transferDuplicateCheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferDuplicateCheck` (
  `transferId` varchar(36) NOT NULL,
  `hash` varchar(256) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferId`),
  KEY `transferduplicatecheck_transferid_foreign_idx` (`transferId`),
  CONSTRAINT `transferduplicatecheck_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferDuplicateCheck`
--

LOCK TABLES `transferDuplicateCheck` WRITE;
/*!40000 ALTER TABLE `transferDuplicateCheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferDuplicateCheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferExtension`
--

DROP TABLE IF EXISTS `transferExtension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferExtension` (
  `transferExtentionId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `transferFulfilmentId` varchar(36) DEFAULT NULL,
  `key` varchar(128) NOT NULL,
  `value` text NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferExtentionId`),
  KEY `transferextention_transferid_foreign_idx` (`transferId`),
  KEY `transferextention_transferfulfilmentid_foreign_idx` (`transferFulfilmentId`),
  CONSTRAINT `transferextention_transferfulfilmentid_foreign` FOREIGN KEY (`transferFulfilmentId`) REFERENCES `transferFulfilment` (`transferFulfilmentId`),
  CONSTRAINT `transferextention_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferExtension`
--

LOCK TABLES `transferExtension` WRITE;
/*!40000 ALTER TABLE `transferExtension` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferExtension` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferFulfilment`
--

DROP TABLE IF EXISTS `transferFulfilment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferFulfilment` (
  `transferFulfilmentId` varchar(36) NOT NULL,
  `transferId` varchar(36) NOT NULL,
  `ilpFulfilment` varchar(256) NOT NULL,
  `completedDate` datetime NOT NULL,
  `isValid` tinyint(1) NOT NULL DEFAULT '0',
  `settlementWindowId` bigint(20) unsigned DEFAULT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferFulfilmentId`),
  KEY `transferfulfilment_transferid_foreign_idx` (`transferId`),
  KEY `transferfulfilment_settlementwindowid_foreign_idx` (`settlementWindowId`),
  CONSTRAINT `transferfulfilment_settlementwindowid_foreign` FOREIGN KEY (`settlementWindowId`) REFERENCES `settlementWindow` (`settlementWindowId`) ON DELETE NO ACTION,
  CONSTRAINT `transferfulfilment_transferfulfilmentid_foreign` FOREIGN KEY (`transferFulfilmentId`) REFERENCES `transferFulfilmentDuplicateCheck` (`transferFulfilmentId`) ON DELETE NO ACTION,
  CONSTRAINT `transferfulfilment_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferFulfilment`
--

LOCK TABLES `transferFulfilment` WRITE;
/*!40000 ALTER TABLE `transferFulfilment` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferFulfilment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferFulfilmentDuplicateCheck`
--

DROP TABLE IF EXISTS `transferFulfilmentDuplicateCheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferFulfilmentDuplicateCheck` (
  `transferFulfilmentId` varchar(36) NOT NULL,
  `transferId` varchar(36) NOT NULL,
  `hash` varchar(256) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferFulfilmentId`),
  KEY `transferfulfilmentduplicatecheck_transferid_foreign_idx` (`transferId`),
  CONSTRAINT `transferfulfilmentduplicatecheck_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferFulfilmentDuplicateCheck`
--

LOCK TABLES `transferFulfilmentDuplicateCheck` WRITE;
/*!40000 ALTER TABLE `transferFulfilmentDuplicateCheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferFulfilmentDuplicateCheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferParticipant`
--

DROP TABLE IF EXISTS `transferParticipant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferParticipant` (
  `transferParticipantId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `participantCurrencyId` int(10) unsigned NOT NULL,
  `transferParticipantRoleTypeId` int(10) unsigned NOT NULL,
  `ledgerEntryTypeId` int(10) unsigned NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferParticipantId`),
  KEY `transferparticipant_transferid_index` (`transferId`),
  KEY `transferparticipant_transferparticipantroleid_foreign` (`transferParticipantRoleTypeId`),
  KEY `transferparticipant_ledgerentryid_foreign` (`ledgerEntryTypeId`),
  KEY `transferparticipant_participancurrencytid_foreign_idx` (`participantCurrencyId`),
  CONSTRAINT `transferparticipant_ledgerentryid_foreign` FOREIGN KEY (`ledgerEntryTypeId`) REFERENCES `ledgerEntryType` (`ledgerEntryTypeId`),
  CONSTRAINT `transferparticipant_participancurrencytid_foreign` FOREIGN KEY (`participantCurrencyId`) REFERENCES `participantCurrency` (`participantCurrencyId`),
  CONSTRAINT `transferparticipant_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`),
  CONSTRAINT `transferparticipant_transferparticipantroleid_foreign` FOREIGN KEY (`transferParticipantRoleTypeId`) REFERENCES `transferParticipantRoleType` (`transferParticipantRoleTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferParticipant`
--

LOCK TABLES `transferParticipant` WRITE;
/*!40000 ALTER TABLE `transferParticipant` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferParticipant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferParticipantRoleType`
--

DROP TABLE IF EXISTS `transferParticipantRoleType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferParticipantRoleType` (
  `transferParticipantRoleTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferParticipantRoleTypeId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferParticipantRoleType`
--

LOCK TABLES `transferParticipantRoleType` WRITE;
/*!40000 ALTER TABLE `transferParticipantRoleType` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferParticipantRoleType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferState`
--

DROP TABLE IF EXISTS `transferState`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferState` (
  `transferStateId` varchar(50) NOT NULL,
  `enumeration` varchar(50) NOT NULL COMMENT 'transferState associated to the Mojaloop API',
  `description` varchar(256) NOT NULL,
  PRIMARY KEY (`transferStateId`),
  UNIQUE KEY `transferstate_transferstateid_unique` (`transferStateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferState`
--

LOCK TABLES `transferState` WRITE;
/*!40000 ALTER TABLE `transferState` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferState` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferStateChange`
--

DROP TABLE IF EXISTS `transferStateChange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferStateChange` (
  `transferStateChangeId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `transferStateId` varchar(50) NOT NULL,
  `reason` text,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferStateChangeId`),
  KEY `transferstatechange_transferid_index` (`transferId`),
  KEY `transferstatechange_transferstateid_index` (`transferStateId`),
  CONSTRAINT `transferstatechange_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`),
  CONSTRAINT `transferstatechange_transferstateid_foreign` FOREIGN KEY (`transferStateId`) REFERENCES `transferState` (`transferStateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferStateChange`
--

LOCK TABLES `transferStateChange` WRITE;
/*!40000 ALTER TABLE `transferStateChange` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferStateChange` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-02 18:13:19
