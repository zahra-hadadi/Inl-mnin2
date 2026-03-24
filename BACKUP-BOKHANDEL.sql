-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: bokhandel
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'f1bd2ff8-bf9c-11f0-ac15-005056c00001:1-609';

--
-- Table structure for table `bestallningar`
--

DROP TABLE IF EXISTS `bestallningar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallningar` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Datum` date NOT NULL,
  `Totalbelopp` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `bestallningar_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallningar`
--

LOCK TABLES `bestallningar` WRITE;
/*!40000 ALTER TABLE `bestallningar` DISABLE KEYS */;
INSERT INTO `bestallningar` VALUES (1,1,'2025-10-22',648.00),(2,1,'2025-11-20',459.00),(3,2,'2025-11-22',379.00),(4,3,'2025-11-21',708.00),(5,5,'2025-11-23',399.00),(6,1,'2025-11-25',658.00),(7,4,'2025-11-26',NULL);
/*!40000 ALTER TABLE `bestallningar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bocker`
--

DROP TABLE IF EXISTS `bocker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bocker` (
  `ISBN` varchar(30) NOT NULL,
  `Titel` varchar(200) NOT NULL,
  `Forfattare` varchar(100) NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  `Lagerstatus` int NOT NULL,
  PRIMARY KEY (`ISBN`),
  CONSTRAINT `bocker_chk_1` CHECK ((`Pris` > 0)),
  CONSTRAINT `check_pris` CHECK ((`Pris` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bocker`
--

LOCK TABLES `bocker` WRITE;
/*!40000 ALTER TABLE `bocker` DISABLE KEYS */;
INSERT INTO `bocker` VALUES ('9779123456789','SQL och Databaser','Maria Svensson',249.00,7),('9789144131234','Databasteknik','Sofia Andersson',399.00,10),('9789149129871','Datastrukturer','Emma Petersson',459.00,4),('9789171799691','Nätverksteknik','Lars Johansson',379.00,9),('9789334501235','Programmering med Python','Karl Andersson',329.00,12);
/*!40000 ALTER TABLE `bocker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunder`
--

DROP TABLE IF EXISTS `kunder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunder` (
  `KundID` int NOT NULL AUTO_INCREMENT,
  `Namn` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telefon` varchar(30) NOT NULL,
  `Adress` varchar(200) NOT NULL,
  PRIMARY KEY (`KundID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `idx_email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunder`
--

LOCK TABLES `kunder` WRITE;
/*!40000 ALTER TABLE `kunder` DISABLE KEYS */;
INSERT INTO `kunder` VALUES (1,'Zahra Hadadi','zahra.ny@gmail.com','0761547560','Kalmar'),(2,'Sara Gustafsson','sara@gmail.com','0729856543','Helsingborg'),(3,'Emil Eriksson','Emil@gmail.com','0768547520','Stockholm'),(4,'Nicklas Petersson','Nicklas@gmail.com','0719856543','Göteborg'),(5,'Markus Arko','Markus@gmail.com','0731544521','Malmö'),(6,'Sigrid Persson','Sigrid@gmail.com','0749856541','Linköping'),(7,'Adam Abrahamsson','Adam@gmail.com','0768547590','Kalmar');
/*!40000 ALTER TABLE `kunder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `LoggID` int NOT NULL AUTO_INCREMENT,
  `KundID` int DEFAULT NULL,
  `Datum` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LoggID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,7,'2026-03-24 08:52:00');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrader`
--

DROP TABLE IF EXISTS `orderrader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderrader` (
  `OrderradID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `ISBN` varchar(30) NOT NULL,
  `Antal` int NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderradID`),
  KEY `ISBN` (`ISBN`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `orderrader_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `bocker` (`ISBN`),
  CONSTRAINT `orderrader_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `bestallningar` (`OrderID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrader`
--

LOCK TABLES `orderrader` WRITE;
/*!40000 ALTER TABLE `orderrader` DISABLE KEYS */;
INSERT INTO `orderrader` VALUES (1,1,'9789144131234',1,399.00),(2,1,'9779123456789',1,249.00),(3,2,'9789149129871',1,459.00),(4,3,'9789171799691',1,379.00),(5,4,'9789334501235',1,329.00),(6,4,'9789171799691',1,379.00),(7,5,'9789144131234',1,399.00),(8,6,'9789334501235',2,329.00),(9,5,'9789149129871',1,459.00);
/*!40000 ALTER TABLE `orderrader` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-24  9:53:19
