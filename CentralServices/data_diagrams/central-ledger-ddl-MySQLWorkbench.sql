-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: central_ledger
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `charge`
--

DROP TABLE IF EXISTS `charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge` (
  `chargeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chargeType` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `payerParticipantId` int(10) unsigned NOT NULL,
  `payeeParticipantId` int(10) unsigned NOT NULL,
  `rate` decimal(18,2) NOT NULL DEFAULT '0.00',
  `rateType` varchar(256) NOT NULL,
  `minimum` decimal(18,2) DEFAULT NULL,
  `maximum` decimal(18,2) DEFAULT NULL,
  `code` varchar(256) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '0',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chargeId`),
  UNIQUE KEY `charge_name_unique` (`name`),
  KEY `charge_payerparticipantid_index` (`payerParticipantId`),
  KEY `charge_payeeparticipantid_index` (`payeeParticipantId`),
  CONSTRAINT `charge_payeeparticipantid_foreign` FOREIGN KEY (`payeeParticipantId`) REFERENCES `participant` (`participantId`),
  CONSTRAINT `charge_payerparticipantid_foreign` FOREIGN KEY (`payerParticipantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contactType`
--

DROP TABLE IF EXISTS `contactType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactType` (
  `contactTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`contactTypeId`),
  UNIQUE KEY `contacttype_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `currencyId` varchar(3) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`currencyId`),
  UNIQUE KEY `currency_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eventName`
--

DROP TABLE IF EXISTS `eventName`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventName` (
  `eventNameId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`eventNameId`),
  UNIQUE KEY `eventname_value_unique` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extension`
--

DROP TABLE IF EXISTS `extension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extension` (
  `extensionId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `key` varchar(128) NOT NULL,
  `value` text NOT NULL,
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changedBy` varchar(128) NOT NULL,
  PRIMARY KEY (`extensionId`),
  KEY `extension_transferid_index` (`transferId`),
  CONSTRAINT `extension_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fee`
--

DROP TABLE IF EXISTS `fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fee` (
  `feeId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `payerParticipantId` int(10) unsigned NOT NULL,
  `payeeParticipantId` int(10) unsigned NOT NULL,
  `chargeId` int(10) unsigned NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feeId`),
  KEY `fee_transferid_index` (`transferId`),
  KEY `fee_payerparticipantid_index` (`payerParticipantId`),
  KEY `fee_payeeparticipantid_index` (`payeeParticipantId`),
  KEY `fee_chargeid_index` (`chargeId`),
  CONSTRAINT `fee_chargeid_foreign` FOREIGN KEY (`chargeId`) REFERENCES `charge` (`chargeId`),
  CONSTRAINT `fee_payeeparticipantid_foreign` FOREIGN KEY (`payeeParticipantId`) REFERENCES `participant` (`participantId`),
  CONSTRAINT `fee_payerparticipantid_foreign` FOREIGN KEY (`payerParticipantId`) REFERENCES `participant` (`participantId`),
  CONSTRAINT `fee_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ilp`
--

DROP TABLE IF EXISTS `ilp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ilp` (
  `ilpId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `packet` text NOT NULL COMMENT 'ilpPacket',
  `condition` varchar(256) NOT NULL,
  `fulfilment` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ilpId`),
  KEY `ilp_transferid_index` (`transferId`),
  CONSTRAINT `ilp_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `participant`
--

DROP TABLE IF EXISTS `participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participant` (
  `participantId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currencyId` varchar(3) NOT NULL,
  `name` varchar(256) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDisabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`participantId`),
  UNIQUE KEY `participant_currencyid_name_unique` (`currencyId`,`name`),
  KEY `participant_currencyid_index` (`currencyId`),
  CONSTRAINT `participant_currencyid_foreign` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`currencyId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  PRIMARY KEY (`participantContactId`),
  KEY `participantcontact_participantid_index` (`participantId`),
  KEY `participantcontact_contacttypeid_index` (`contactTypeId`),
  CONSTRAINT `participantcontact_contacttypeid_foreign` FOREIGN KEY (`contactTypeId`) REFERENCES `contactType` (`contactTypeId`),
  CONSTRAINT `participantcontact_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `participantLimit`
--

DROP TABLE IF EXISTS `participantLimit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantLimit` (
  `participantLimitId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `partyRoleId` bigint(20) unsigned NOT NULL,
  `netDebitCap` decimal(18,2) NOT NULL DEFAULT '0.00',
  `thresholdAlarmPercent` decimal(5,2) NOT NULL DEFAULT '10.00',
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participantLimitId`),
  KEY `participantlimit_participantid_index` (`participantId`),
  KEY `participantlimit_partyroleid_index` (`partyRoleId`),
  CONSTRAINT `participantlimit_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`),
  CONSTRAINT `participantlimit_partyroleid_foreign` FOREIGN KEY (`partyRoleId`) REFERENCES `partyRole` (`partyRoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  KEY `participantparty_partyid_index` (`partyId`),
  CONSTRAINT `participantparty_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`),
  CONSTRAINT `participantparty_partyid_foreign` FOREIGN KEY (`partyId`) REFERENCES `party` (`partyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `participantPosition`
--

DROP TABLE IF EXISTS `participantPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participantPosition` (
  `participantPositionId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `participantId` int(10) unsigned NOT NULL,
  `value` decimal(18,2) NOT NULL,
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changedBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantPositionId`),
  KEY `participantposition_participantid_index` (`participantId`),
  CONSTRAINT `participantposition_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party` (
  `partyId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `partyTypeId` int(10) unsigned DEFAULT NULL,
  `typeValue` varchar(256) DEFAULT NULL,
  `key` varchar(256) NOT NULL,
  `firstName` varchar(128) NOT NULL,
  `middleName` varchar(128) DEFAULT NULL,
  `lastName` varchar(128) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `password` varchar(256) DEFAULT NULL,
  `partyIdentifierTypeId` int(10) unsigned DEFAULT NULL,
  `identifierOther` varchar(50) DEFAULT NULL,
  `identifierValue` varchar(50) DEFAULT NULL,
  `dateOfBirth` datetime DEFAULT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`partyId`),
  UNIQUE KEY `party_key_unique` (`key`),
  KEY `party_partytypeid_index` (`partyTypeId`),
  KEY `party_partyidentifiertypeid_index` (`partyIdentifierTypeId`),
  CONSTRAINT `party_partyidentifiertypeid_foreign` FOREIGN KEY (`partyIdentifierTypeId`) REFERENCES `partyIdentifierType` (`partyIdentifierTypeId`),
  CONSTRAINT `party_partytypeid_foreign` FOREIGN KEY (`partyTypeId`) REFERENCES `partyType` (`partyTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partyIdentifierType`
--

DROP TABLE IF EXISTS `partyIdentifierType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partyIdentifierType` (
  `partyIdentifierTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`partyIdentifierTypeId`),
  UNIQUE KEY `partyidentifiertype_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partyRole`
--

DROP TABLE IF EXISTS `partyRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partyRole` (
  `partyRoleId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `partyId` bigint(20) unsigned NOT NULL,
  `roleId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`partyRoleId`),
  UNIQUE KEY `partyrole_partyid_roleid_unique` (`partyId`,`roleId`),
  KEY `partyrole_partyid_index` (`partyId`),
  KEY `partyrole_roleid_index` (`roleId`),
  CONSTRAINT `partyrole_partyid_foreign` FOREIGN KEY (`partyId`) REFERENCES `party` (`partyId`),
  CONSTRAINT `partyrole_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partyType`
--

DROP TABLE IF EXISTS `partyType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partyType` (
  `partyTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`partyTypeId`),
  UNIQUE KEY `partytype_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `roleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `permissions` text NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `role_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  CONSTRAINT `settledfee_feeid_foreign` FOREIGN KEY (`feeId`) REFERENCES `fee` (`feeId`),
  CONSTRAINT `settledfee_settlementid_foreign` FOREIGN KEY (`settlementId`) REFERENCES `settlement` (`settlementId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settlement`
--

DROP TABLE IF EXISTS `settlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlement` (
  `settlementId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferSettlementBatchId` bigint(20) unsigned NOT NULL,
  `settlementType` varchar(16) NOT NULL,
  `settledDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`settlementId`),
  KEY `settlement_transfersettlementbatchid_index` (`transferSettlementBatchId`),
  CONSTRAINT `settlement_transfersettlementbatchid_foreign` FOREIGN KEY (`transferSettlementBatchId`) REFERENCES `transferSettlementBatch` (`transferSettlementBatchId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfer` (
  `transferId` varchar(36) NOT NULL,
  `payeeParticipantId` int(10) unsigned NOT NULL COMMENT 'payeeFsp',
  `payerParticipantId` int(10) unsigned NOT NULL COMMENT 'payerFsp',
  `amount` decimal(18,2) NOT NULL,
  `currencyId` varchar(3) NOT NULL COMMENT 'currency',
  `expirationDate` datetime DEFAULT NULL COMMENT 'expiration ilp condition',
  `transferSettlementBatchId` bigint(20) unsigned DEFAULT '0',
  PRIMARY KEY (`transferId`),
  KEY `transfer_currencyid_foreign` (`currencyId`),
  KEY `transfer_transferid_index` (`transferId`),
  KEY `transfer_transfersettlementbatchid_index` (`transferSettlementBatchId`),
  KEY `transfer_payerparticipantid_index` (`payerParticipantId`),
  KEY `transfer_payeeparticipantid_index` (`payeeParticipantId`),
  CONSTRAINT `transfer_currencyid_foreign` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`currencyId`),
  CONSTRAINT `transfer_payeeparticipantid_foreign` FOREIGN KEY (`payeeParticipantId`) REFERENCES `participant` (`participantId`),
  CONSTRAINT `transfer_payerparticipantid_foreign` FOREIGN KEY (`payerParticipantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transferEventIndex`
--

DROP TABLE IF EXISTS `transferEventIndex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferEventIndex` (
  `transferEventIndexId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `eventNameId` bigint(20) unsigned NOT NULL,
  `transferId` varchar(36) NOT NULL,
  `value` bigint(20) unsigned NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferEventIndexId`),
  KEY `transfereventindex_eventnameid_index` (`eventNameId`),
  KEY `transfereventindex_transferid_index` (`transferId`),
  CONSTRAINT `transfereventindex_eventnameid_foreign` FOREIGN KEY (`eventNameId`) REFERENCES `eventName` (`eventNameId`),
  CONSTRAINT `transfereventindex_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transferPosition`
--

DROP TABLE IF EXISTS `transferPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferPosition` (
  `transferPositionId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `value` decimal(18,2) NOT NULL,
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changedBy` varchar(128) NOT NULL,
  PRIMARY KEY (`transferPositionId`),
  KEY `transferposition_transferid_index` (`transferId`),
  CONSTRAINT `transferposition_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transferSettlementBatch`
--

DROP TABLE IF EXISTS `transferSettlementBatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferSettlementBatch` (
  `transferSettlementBatchId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`transferSettlementBatchId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferStateChangeId`),
  KEY `transferstatechange_transferid_index` (`transferId`),
  KEY `transferstatechange_transferstateid_index` (`transferStateId`),
  CONSTRAINT `transferstatechange_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`),
  CONSTRAINT `transferstatechange_transferstateid_foreign` FOREIGN KEY (`transferStateId`) REFERENCES `transferState` (`transferStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-06 11:42:08
