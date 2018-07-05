-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: central_ledger
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
  `name` varchar(50) NOT NULL,
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
  PRIMARY KEY (`currencyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES ('AED','UAE dirham',1,'2018-07-03 21:12:01'),('AFA','Afghanistan afghani',1,'2018-07-03 21:12:01'),('ALL','Albanian lek',1,'2018-07-03 21:12:01'),('AMD','Armenian dram',1,'2018-07-03 21:12:01'),('ANG','Netherlands Antillian guilder',1,'2018-07-03 21:12:01'),('AOR','Angolan kwanza reajustado',1,'2018-07-03 21:12:01'),('ARS','Argentine peso',1,'2018-07-03 21:12:01'),('AUD','Australian dollar',1,'2018-07-03 21:12:01'),('AWG','Aruban guilder',1,'2018-07-03 21:12:01'),('AZN','Azerbaijanian new manat',1,'2018-07-03 21:12:01'),('BBD','Barbados dollar',1,'2018-07-03 21:12:01'),('BDT','Bangladeshi taka',1,'2018-07-03 21:12:01'),('BGN','Bulgarian lev',1,'2018-07-03 21:12:01'),('BHD','Bahraini dinar',1,'2018-07-03 21:12:01'),('BIF','Burundi franc',1,'2018-07-03 21:12:01'),('BMD','Bermudian dollar',1,'2018-07-03 21:12:01'),('BND','Brunei dollar',1,'2018-07-03 21:12:01'),('BOB','Bolivian boliviano',1,'2018-07-03 21:12:01'),('BRL','Brazilian real',1,'2018-07-03 21:12:01'),('BSD','Bahamian dollar',1,'2018-07-03 21:12:01'),('BTN','Bhutan ngultrum',1,'2018-07-03 21:12:01'),('BWP','Botswana pula',1,'2018-07-03 21:12:01'),('BYN','Belarusian ruble',1,'2018-07-03 21:12:01'),('BZD','Belize dollar',1,'2018-07-03 21:12:01'),('CAD','Canadian dollar',1,'2018-07-03 21:12:01'),('CDF','Congolese franc',1,'2018-07-03 21:12:01'),('CHF','Swiss franc',1,'2018-07-03 21:12:01'),('CLP','Chilean peso',1,'2018-07-03 21:12:01'),('CNY','Chinese yuan renminbi',1,'2018-07-03 21:12:01'),('COP','Colombian peso',1,'2018-07-03 21:12:01'),('CRC','Costa Rican colon',1,'2018-07-03 21:12:01'),('CUP','Cuban peso',1,'2018-07-03 21:12:01'),('CVE','Cape Verde escudo',1,'2018-07-03 21:12:01'),('CZK','Czech koruna',1,'2018-07-03 21:12:01'),('DJF','Djibouti franc',1,'2018-07-03 21:12:01'),('DKK','Danish krone',1,'2018-07-03 21:12:01'),('DOP','Dominican peso',1,'2018-07-03 21:12:01'),('DZD','Algerian dinar',1,'2018-07-03 21:12:01'),('EEK','Estonian kroon',1,'2018-07-03 21:12:01'),('EGP','Egyptian pound',1,'2018-07-03 21:12:01'),('ERN','Eritrean nakfa',1,'2018-07-03 21:12:01'),('ETB','Ethiopian birr',1,'2018-07-03 21:12:01'),('EUR','EU euro',1,'2018-07-03 21:12:01'),('FJD','Fiji dollar',1,'2018-07-03 21:12:01'),('FKP','Falkland Islands pound',1,'2018-07-03 21:12:01'),('GBP','British pound',1,'2018-07-03 21:12:01'),('GEL','Georgian lari',1,'2018-07-03 21:12:01'),('GHS','Ghanaian new cedi',1,'2018-07-03 21:12:01'),('GIP','Gibraltar pound',1,'2018-07-03 21:12:01'),('GMD','Gambian dalasi',1,'2018-07-03 21:12:01'),('GNF','Guinean franc',1,'2018-07-03 21:12:01'),('GTQ','Guatemalan quetzal',1,'2018-07-03 21:12:01'),('GYD','Guyana dollar',1,'2018-07-03 21:12:01'),('HKD','Hong Kong SAR dollar',1,'2018-07-03 21:12:01'),('HNL','Honduran lempira',1,'2018-07-03 21:12:01'),('HRK','Croatian kuna',1,'2018-07-03 21:12:01'),('HTG','Haitian gourde',1,'2018-07-03 21:12:01'),('HUF','Hungarian forint',1,'2018-07-03 21:12:01'),('IDR','Indonesian rupiah',1,'2018-07-03 21:12:01'),('ILS','Israeli new shekel',1,'2018-07-03 21:12:01'),('INR','Indian rupee',1,'2018-07-03 21:12:01'),('IQD','Iraqi dinar',1,'2018-07-03 21:12:01'),('IRR','Iranian rial',1,'2018-07-03 21:12:01'),('ISK','Icelandic krona',1,'2018-07-03 21:12:01'),('JMD','Jamaican dollar',1,'2018-07-03 21:12:01'),('JOD','Jordanian dinar',1,'2018-07-03 21:12:01'),('JPY','Japanese yen',1,'2018-07-03 21:12:01'),('KES','Kenyan shilling',1,'2018-07-03 21:12:01'),('KGS','Kyrgyz som',1,'2018-07-03 21:12:01'),('KHR','Cambodian riel',1,'2018-07-03 21:12:01'),('KMF','Comoros franc',1,'2018-07-03 21:12:01'),('KPW','North Korean won',1,'2018-07-03 21:12:01'),('KRW','South Korean won',1,'2018-07-03 21:12:01'),('KWD','Kuwaiti dinar',1,'2018-07-03 21:12:01'),('KYD','Cayman Islands dollar',1,'2018-07-03 21:12:01'),('KZT','Kazakh tenge',1,'2018-07-03 21:12:01'),('LAK','Lao kip',1,'2018-07-03 21:12:01'),('LBP','Lebanese pound',1,'2018-07-03 21:12:01'),('LKR','Sri Lanka rupee',1,'2018-07-03 21:12:01'),('LRD','Liberian dollar',1,'2018-07-03 21:12:01'),('LSL','Lesotho loti',1,'2018-07-03 21:12:01'),('LTL','Lithuanian litas',1,'2018-07-03 21:12:01'),('LVL','Latvian lats',1,'2018-07-03 21:12:01'),('LYD','Libyan dinar',1,'2018-07-03 21:12:01'),('MAD','Moroccan dirham',1,'2018-07-03 21:12:01'),('MDL','Moldovan leu',1,'2018-07-03 21:12:01'),('MGA','Malagasy ariary',1,'2018-07-03 21:12:01'),('MKD','Macedonian denar',1,'2018-07-03 21:12:01'),('MMK','Myanmar kyat',1,'2018-07-03 21:12:01'),('MNT','Mongolian tugrik',1,'2018-07-03 21:12:01'),('MOP','Macao SAR pataca',1,'2018-07-03 21:12:01'),('MRO','Mauritanian ouguiya',1,'2018-07-03 21:12:01'),('MUR','Mauritius rupee',1,'2018-07-03 21:12:01'),('MVR','Maldivian rufiyaa',1,'2018-07-03 21:12:01'),('MWK','Malawi kwacha',1,'2018-07-03 21:12:01'),('MXN','Mexican peso',1,'2018-07-03 21:12:01'),('MYR','Malaysian ringgit',1,'2018-07-03 21:12:01'),('MZN','Mozambique new metical',1,'2018-07-03 21:12:01'),('NAD','Namibian dollar',1,'2018-07-03 21:12:01'),('NGN','Nigerian naira',1,'2018-07-03 21:12:01'),('NIO','Nicaraguan cordoba oro',1,'2018-07-03 21:12:01'),('NOK','Norwegian krone',1,'2018-07-03 21:12:01'),('NPR','Nepalese rupee',1,'2018-07-03 21:12:01'),('NZD','New Zealand dollar',1,'2018-07-03 21:12:01'),('OMR','Omani rial',1,'2018-07-03 21:12:01'),('PAB','Panamanian balboa',1,'2018-07-03 21:12:01'),('PEN','Peruvian nuevo sol',1,'2018-07-03 21:12:01'),('PGK','Papua New Guinea kina',1,'2018-07-03 21:12:01'),('PHP','Philippine peso',1,'2018-07-03 21:12:01'),('PKR','Pakistani rupee',1,'2018-07-03 21:12:01'),('PLN','Polish zloty',1,'2018-07-03 21:12:01'),('PYG','Paraguayan guarani',1,'2018-07-03 21:12:01'),('QAR','Qatari rial',1,'2018-07-03 21:12:01'),('RON','Romanian new leu',1,'2018-07-03 21:12:01'),('RSD','Serbian dinar',1,'2018-07-03 21:12:01'),('RUB','Russian ruble',1,'2018-07-03 21:12:01'),('RWF','Rwandan franc',1,'2018-07-03 21:12:01'),('SAR','Saudi riyal',1,'2018-07-03 21:12:01'),('SBD','Solomon Islands dollar',1,'2018-07-03 21:12:01'),('SCR','Seychelles rupee',1,'2018-07-03 21:12:01'),('SDG','Sudanese pound',1,'2018-07-03 21:12:01'),('SEK','Swedish krona',1,'2018-07-03 21:12:01'),('SGD','Singapore dollar',1,'2018-07-03 21:12:01'),('SHP','Saint Helena pound',1,'2018-07-03 21:12:01'),('SLL','Sierra Leone leone',1,'2018-07-03 21:12:01'),('SOS','Somali shilling',1,'2018-07-03 21:12:01'),('SRD','Suriname dollar',1,'2018-07-03 21:12:01'),('STD','Sao Tome and Principe dobra',1,'2018-07-03 21:12:01'),('SVC','El Salvador colon',1,'2018-07-03 21:12:01'),('SYP','Syrian pound',1,'2018-07-03 21:12:01'),('SZL','Swaziland lilangeni',1,'2018-07-03 21:12:01'),('THB','Thai baht',1,'2018-07-03 21:12:01'),('TJS','Tajik somoni',1,'2018-07-03 21:12:01'),('TMT','Turkmen new manat',1,'2018-07-03 21:12:01'),('TND','Tunisian dinar',1,'2018-07-03 21:12:01'),('TOP','Tongan pa\'anga',1,'2018-07-03 21:12:01'),('TRY','Turkish lira',1,'2018-07-03 21:12:01'),('TTD','Trinidad and Tobago dollar',1,'2018-07-03 21:12:01'),('TWD','Taiwan New dollar',1,'2018-07-03 21:12:01'),('TZS','Tanzanian shilling',1,'2018-07-03 21:12:01'),('UAH','Ukrainian hryvnia',1,'2018-07-03 21:12:01'),('UGX','Uganda new shilling',1,'2018-07-03 21:12:01'),('USD','US dollar',1,'2018-07-03 21:12:01'),('UYU','Uruguayan peso uruguayo',1,'2018-07-03 21:12:01'),('UZS','Uzbekistani sum',1,'2018-07-03 21:12:01'),('VEF','Venezuelan bolivar fuerte',1,'2018-07-03 21:12:01'),('VND','Vietnamese dong',1,'2018-07-03 21:12:01'),('VUV','Vanuatu vatu',1,'2018-07-03 21:12:01'),('WST','Samoan tala',1,'2018-07-03 21:12:01'),('XAF','CFA franc BEAC',1,'2018-07-03 21:12:01'),('XAG','Silver (ounce)',1,'2018-07-03 21:12:01'),('XAU','Gold (ounce)',1,'2018-07-03 21:12:01'),('XCD','East Caribbean dollar',1,'2018-07-03 21:12:01'),('XDR','IMF special drawing right',1,'2018-07-03 21:12:01'),('XFO','Gold franc',1,'2018-07-03 21:12:01'),('XFU','UIC franc',1,'2018-07-03 21:12:01'),('XOF','CFA franc BCEAO',1,'2018-07-03 21:12:01'),('XPD','Palladium (ounce)',1,'2018-07-03 21:12:01'),('XPF','CFP franc',1,'2018-07-03 21:12:01'),('XPT','Platinum (ounce)',1,'2018-07-03 21:12:01'),('YER','Yemeni rial',1,'2018-07-03 21:12:01'),('ZAR','South African rand',1,'2018-07-03 21:12:01'),('ZMK','Zambian kwacha',1,'2018-07-03 21:12:01'),('ZWL','Zimbabwe dollar',1,'2018-07-03 21:12:01');
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
  UNIQUE KEY `endpointtype_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `eventId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
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
  `value` text NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferId`),
  CONSTRAINT `ilppacket_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
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
  `name` varchar(50) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ledgerEntryTypeId`),
  UNIQUE KEY `ledgerentrytype_name_unique` (`name`)
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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES (1,'100100_event.js',1,'2018-07-04 00:11:50'),(2,'110100_contactType.js',1,'2018-07-04 00:11:50'),(3,'110101_contactType-indexes.js',1,'2018-07-04 00:11:50'),(4,'110200_currency.js',1,'2018-07-04 00:11:50'),(5,'110300_endpointType.js',1,'2018-07-04 00:11:50'),(6,'110301_endpointType-indexes.js',1,'2018-07-04 00:11:50'),(7,'110400_ledgerEntryType.js',1,'2018-07-04 00:11:50'),(8,'110401_ledgerEntryType-indexes.js',1,'2018-07-04 00:11:50'),(9,'110500_participantLimitType.js',1,'2018-07-04 00:11:50'),(10,'110501_participantLimitType-indexes.js',1,'2018-07-04 00:11:50'),(11,'110600_transferParticipantRoleType.js',1,'2018-07-04 00:11:50'),(12,'110601_transferParticipantRoleType-indexes.js',1,'2018-07-04 00:11:50'),(13,'110700_transferState.js',1,'2018-07-04 00:11:50'),(14,'110701_transferState-indexes.js',1,'2018-07-04 00:11:50'),(15,'200100_participant.js',1,'2018-07-04 00:11:50'),(16,'200101_participant-indexes.js',1,'2018-07-04 00:11:50'),(17,'200200_participantContact.js',1,'2018-07-04 00:11:50'),(18,'200201_participantContact-indexes.js',1,'2018-07-04 00:11:50'),(19,'200300_participantEndpoint.js',1,'2018-07-04 00:11:50'),(20,'200301_participantEndpoint-indexes.js',1,'2018-07-04 00:11:50'),(21,'200400_participantParty.js',1,'2018-07-04 00:11:50'),(22,'200401_participantParty-indexes.js',1,'2018-07-04 00:11:50'),(23,'200500_participantSettlement.js',1,'2018-07-04 00:11:50'),(24,'200501_participantSettlement-indexes.js',1,'2018-07-04 00:11:50'),(25,'200600_token.js',1,'2018-07-04 00:11:51'),(26,'200601_token-indexes.js',1,'2018-07-04 00:11:51'),(27,'300100_transfer.js',1,'2018-07-04 00:11:51'),(28,'300101_transfer-indexes.js',1,'2018-07-04 00:11:51'),(29,'300200_ilpPacket.js',1,'2018-07-04 00:11:51'),(30,'300300_transferDuplicateCheck.js',1,'2018-07-04 00:11:51'),(31,'300400_transferStateChange.js',1,'2018-07-04 00:11:51'),(32,'300401_transferStateChange-indexes.js',1,'2018-07-04 00:11:51'),(33,'310100_participantCurrency.js',1,'2018-07-04 00:11:51'),(34,'310101_participantCurrency-indexes.js',1,'2018-07-04 00:11:51'),(35,'310200_transferParticipant.js',1,'2018-07-04 00:11:51'),(36,'310201_transferParticipant-indexes.js',1,'2018-07-04 00:11:51'),(37,'310300_participantPosition.js',1,'2018-07-04 00:11:51'),(38,'310301_participantPosition-indexes.js',1,'2018-07-04 00:11:51'),(39,'310400_participantPositionChange.js',1,'2018-07-04 00:11:51'),(40,'310401_participantPositionChange-indexes.js',1,'2018-07-04 00:11:51'),(41,'310500_participantLimit.js',1,'2018-07-04 00:11:51'),(42,'310501_participantLimit-indexes.js',1,'2018-07-04 00:11:51'),(43,'400100_settlementWindow.js',1,'2018-07-04 00:11:51'),(44,'400200_settlement.js',1,'2018-07-04 00:11:52'),(45,'400201_settlement-indexes.js',1,'2018-07-04 00:11:52'),(46,'400500_settledFee.js',1,'2018-07-04 00:11:52'),(47,'400501_settledFee-indexes.js',1,'2018-07-04 00:11:52'),(48,'410100_transferFulfilmentDuplicateCheck.js',1,'2018-07-04 00:11:52'),(49,'410101_transferFulfilmentDuplicateCheck-indexes.js',1,'2018-07-04 00:11:52'),(50,'410200_transferFulfilment.js',1,'2018-07-04 00:11:52'),(51,'410201_transferFulfilment-indexes.js',1,'2018-07-04 00:11:52'),(52,'410300_transferExtension.js',1,'2018-07-04 00:11:52'),(53,'410301_transferExtension-indexes.js',1,'2018-07-04 00:11:52');
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
INSERT INTO `migration_lock` VALUES (0);
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
  UNIQUE KEY `participant_name_unique` (`name`)
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
  UNIQUE KEY `participantcurrency_participantid_currencyid_unique` (`participantId`,`currencyId`),
  KEY `participantcurrency_participantid_index` (`participantId`),
  KEY `participantcurrency_currencyid_index` (`currencyId`),
  CONSTRAINT `participantcurrency_currencyid_foreign` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`currencyId`),
  CONSTRAINT `participantcurrency_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
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
  KEY `participantendpoint_participantid_index` (`participantId`),
  KEY `participantendpoint_endpointtypeid_index` (`endpointTypeId`),
  CONSTRAINT `participantendpoint_endpointtypeid_foreign` FOREIGN KEY (`endpointTypeId`) REFERENCES `endpointType` (`endpointTypeId`),
  CONSTRAINT `participantendpoint_participantid_foreign` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `startAfterParticipantPositionChangeId` bigint(20) unsigned DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` varchar(128) NOT NULL,
  PRIMARY KEY (`participantLimitId`),
  KEY `participantlimit_participantcurrencyid_index` (`participantCurrencyId`),
  KEY `participantlimit_participantlimittypeid_index` (`participantLimitTypeId`),
  KEY `participantlimit_startafterparticipantpositionchangeid_index` (`startAfterParticipantPositionChangeId`),
  CONSTRAINT `participantlimit_participantcurrencyid_foreign` FOREIGN KEY (`participantCurrencyId`) REFERENCES `participantCurrency` (`participantCurrencyId`),
  CONSTRAINT `participantlimit_participantlimittypeid_foreign` FOREIGN KEY (`participantLimitTypeId`) REFERENCES `participantLimitType` (`participantLimitTypeId`),
  CONSTRAINT `participantlimit_startafterparticipantpositionchangeid_foreign` FOREIGN KEY (`startAfterParticipantPositionChangeId`) REFERENCES `participantPositionChange` (`participantPositionChangeId`)
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
  `name` varchar(50) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participantLimitTypeId`),
  UNIQUE KEY `participantlimittype_name_unique` (`name`)
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
  KEY `participantposition_participantcurrencyid_index` (`participantCurrencyId`),
  CONSTRAINT `participantposition_participantcurrencyid_foreign` FOREIGN KEY (`participantCurrencyId`) REFERENCES `participantCurrency` (`participantCurrencyId`)
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
  `participantPositionChangeId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `participantPositionId` bigint(20) unsigned NOT NULL,
  `transferStateChangeId` bigint(20) unsigned NOT NULL,
  `value` decimal(18,2) NOT NULL,
  `reservedValue` decimal(18,2) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participantPositionChangeId`),
  KEY `participantpositionchange_participantpositionid_index` (`participantPositionId`),
  KEY `participantpositionchange_transferstatechangeid_index` (`transferStateChangeId`),
  CONSTRAINT `participantpositionchange_participantpositionid_foreign` FOREIGN KEY (`participantPositionId`) REFERENCES `participantPosition` (`participantPositionId`),
  CONSTRAINT `participantpositionchange_transferstatechangeid_foreign` FOREIGN KEY (`transferStateChangeId`) REFERENCES `transferStateChange` (`transferStateChangeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `feeId` bigint(20) unsigned DEFAULT NULL,
  `settlementId` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`settledFeeId`),
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
  KEY `settlement_settlementwindowid_index` (`settlementWindowId`),
  CONSTRAINT `settlement_settlementwindowid_foreign` FOREIGN KEY (`settlementWindowId`) REFERENCES `settlementWindow` (`settlementWindowId`)
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
  `currencyId` varchar(3) NOT NULL,
  `ilpCondition` varchar(256) NOT NULL,
  `expirationDate` datetime NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferId`),
  KEY `transfer_currencyid_index` (`currencyId`),
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
  `value` text,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferExtentionId`),
  KEY `transferextension_transferid_index` (`transferId`),
  KEY `transferextension_transferfulfilmentid_index` (`transferFulfilmentId`),
  CONSTRAINT `transferextension_transferfulfilmentid_foreign` FOREIGN KEY (`transferFulfilmentId`) REFERENCES `transferFulfilment` (`transferFulfilmentId`),
  CONSTRAINT `transferextension_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
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
  `isValid` tinyint(1) DEFAULT NULL,
  `settlementWindowId` bigint(20) unsigned DEFAULT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferFulfilmentId`),
  UNIQUE KEY `transferfulfilment_transferid_ilpfulfilment_unique` (`transferId`,`ilpFulfilment`),
  KEY `transferfulfilment_transferid_index` (`transferId`),
  KEY `transferfulfilment_settlementwindowid_index` (`settlementWindowId`),
  CONSTRAINT `transferfulfilment_settlementwindowid_foreign` FOREIGN KEY (`settlementWindowId`) REFERENCES `settlementWindow` (`settlementWindowId`),
  CONSTRAINT `transferfulfilment_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
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
  KEY `transferfulfilmentduplicatecheck_transferid_index` (`transferId`),
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
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferParticipantId`),
  KEY `transferparticipant_transferid_index` (`transferId`),
  KEY `transferparticipant_participantcurrencyid_index` (`participantCurrencyId`),
  KEY `transferparticipant_transferparticipantroletypeid_index` (`transferParticipantRoleTypeId`),
  KEY `transferparticipant_ledgerentrytypeid_index` (`ledgerEntryTypeId`),
  CONSTRAINT `transferparticipant_ledgerentrytypeid_foreign` FOREIGN KEY (`ledgerEntryTypeId`) REFERENCES `ledgerEntryType` (`ledgerEntryTypeId`),
  CONSTRAINT `transferparticipant_participantcurrencyid_foreign` FOREIGN KEY (`participantCurrencyId`) REFERENCES `participantCurrency` (`participantCurrencyId`),
  CONSTRAINT `transferparticipant_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`),
  CONSTRAINT `transferparticipant_transferparticipantroletypeid_foreign` FOREIGN KEY (`transferParticipantRoleTypeId`) REFERENCES `transferParticipantRoleType` (`transferParticipantRoleTypeId`)
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
  `name` varchar(50) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferParticipantRoleTypeId`),
  UNIQUE KEY `transferparticipantroletype_name_unique` (`name`)
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
  `description` varchar(512) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferStateId`),
  UNIQUE KEY `transferstate_enumeration_unique` (`enumeration`)
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

-- Dump completed on 2018-07-04  0:15:00
