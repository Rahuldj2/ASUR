-- MySQL dump 10.13  Distrib 8.1.0, for macos13 (x86_64)
--
-- Host: localhost    Database: asur
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `D217`
--

DROP TABLE IF EXISTS `D217`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `D217` (
  `Point` int DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `Mismatch` double DEFAULT NULL,
  `Major_axis` double DEFAULT NULL,
  `Minor_axis` double DEFAULT NULL,
  `Error` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `D217`
--

LOCK TABLES `D217` WRITE;
/*!40000 ALTER TABLE `D217` DISABLE KEYS */;
INSERT INTO `D217` VALUES (1,28.5253922,77.5760115,3.74,0,0,0),(2,28.5254502,77.5762321,3.74,0,0,0),(3,28.5254546,77.576243,3.74,0,0,0),(4,28.5254496,77.5762368,3.74,0,0,0);
/*!40000 ALTER TABLE `D217` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_classroom`
--

DROP TABLE IF EXISTS `master_classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_classroom` (
  `Room_ID` varchar(10) NOT NULL,
  `Table_Name` varchar(10) DEFAULT NULL,
  `Subject_ID` varchar(10) DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  `Altitude` double DEFAULT NULL,
  PRIMARY KEY (`Room_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_classroom`
--

LOCK TABLES `master_classroom` WRITE;
/*!40000 ALTER TABLE `master_classroom` DISABLE KEYS */;
INSERT INTO `master_classroom` VALUES ('D217','D217','CSD101',150,3.74);
/*!40000 ALTER TABLE `master_classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `Roll_No` int NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Picture_URL` varchar(255) DEFAULT NULL,
  `Net_ID` varchar(10) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`Roll_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (100,'Dummy','Dummy','2000-01-01','www.google.com','dd100','dummy2000');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `Subject_ID` varchar(10) NOT NULL,
  `Subject_Name` varchar(50) NOT NULL,
  `Classroom_ID` varchar(10) NOT NULL,
  `Teacher_ID` varchar(10) NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Seats` int DEFAULT NULL,
  `LIVE` enum('L','NL') DEFAULT 'NL',
  PRIMARY KEY (`Subject_ID`),
  KEY `index_start_time` (`Start_Time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES ('CCC708','Genetic Engineering','B012','zJS104','16:00:00','17:00:00',60,'NL'),('CSD101','Intro to C','D217','zAS100','09:00:00','10:30:00',130,'NL'),('CSD102','Data Structures & Algo.','C309','zPT101','10:30:00','12:00:00',140,'NL'),('CSD311','Artifical Intelligence','B315','zBL102','14:00:00','15:00:00',150,'NL'),('MAT376','Machine Learning - Hands on','D313','zRM103','15:00:00','16:00:00',60,'L');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-07 15:21:00