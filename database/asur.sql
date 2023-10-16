-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: asur
-- ------------------------------------------------------
-- Server version	8.0.29
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!50503 SET NAMES utf8 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Table structure for table `attendance_details`
--

DROP TABLE IF EXISTS `attendance_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `attendance_details` (
  `Roll_No` int NOT NULL,
  `Subject_ID` varchar(10) NOT NULL,
  `Date` date NOT NULL,
  `PorA` varchar(5) DEFAULT NULL,
  `Percentage` double DEFAULT '0',
  PRIMARY KEY (`Roll_No`, `Subject_ID`, `Date`),
  KEY `index_date` (`Date`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `attendance_details`
--

LOCK TABLES `attendance_details` WRITE;
/*!40000 ALTER TABLE `attendance_details` DISABLE KEYS */
;
INSERT INTO `attendance_details`
VALUES (100, 'CCC708', '2023-09-11', 'A', 0),
(100, 'CSD101', '2023-09-10', 'P', 0),
(100, 'CSD101', '2023-09-11', 'A', 0),
(100, 'CSD101', '2023-09-14', 'A', 0),
(100, 'CSD102', '2023-09-11', 'P', 0),
(100, 'CSD311', '2023-08-11', 'A', 0),
(100, 'CSD311', '2023-08-12', 'P', 0),
(100, 'MAT376', '2023-08-12', 'P', 0),
(101, 'CSD101', '2023-09-10', 'P', 0),
(101, 'CSD101', '2023-09-11', 'P', 0),
(102, 'CSD101', '2023-09-10', 'P', 0),
(103, 'CSD101', '2023-09-10', 'A', 0),
(105, 'CSD101', '2023-09-10', 'A', 0);
/*!40000 ALTER TABLE `attendance_details` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `classroom` (
  `Room_ID` varchar(10) NOT NULL,
  `centerX` double DEFAULT NULL,
  `centerY` double DEFAULT NULL,
  `Semi_Major_Axis` double DEFAULT NULL,
  `Semi_Minor_Axis` double DEFAULT NULL,
  `Altitude` double DEFAULT NULL,
  `Error` double DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  PRIMARY KEY (`Room_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */
;
INSERT INTO `classroom`
VALUES ('D007', 28.5254083, 77.5755172, 6.05, 4, 0, 0, 80);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `student` (
  `Roll_No` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Picture_URL` varchar(255) DEFAULT NULL,
  `Net_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Roll_No`)
) ENGINE = InnoDB AUTO_INCREMENT = 118 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */
;
INSERT INTO `student`
VALUES (
    100,
    'Rahul',
    'Kohli',
    '2002-11-05',
    'www.google.com',
    'rk123'
  ),
(
    101,
    'Rahul',
    'Kohli',
    '2002-11-05',
    'www.google.com',
    'rk123'
  ),
(102, 'Rahul', 'Gupta', '2002-11-05', NULL, 'rk123'),
(
    103,
    'Aayush',
    'Arora',
    '2003-02-11',
    NULL,
    'undefined'
  ),
(
    104,
    'Aayush',
    'Arora',
    '2003-02-11',
    NULL,
    'undefined'
  ),
(105, 'Aayush', 'Arora', '2003-02-11', NULL, 'aa373'),
(106, 'Aayush', 'Gupta', '2004-02-11', NULL, 'aa921'),
(107, 'Aayush', 'Gupta', '2004-02-11', NULL, 'aa921'),
(108, 'Punyam', 'Gupta', '2004-11-11', NULL, 'pg987'),
(117, 'Arnav', 'Verma', '2001-12-11', NULL, 'av234');
/*!40000 ALTER TABLE `student` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `studenttosubject`
--

DROP TABLE IF EXISTS `studenttosubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `studenttosubject` (
  `Roll_No` int NOT NULL,
  `Subject_id` varchar(10) NOT NULL,
  PRIMARY KEY (`Roll_No`, `Subject_id`),
  KEY `Subject_id` (`Subject_id`),
  CONSTRAINT `studenttosubject_ibfk_1` FOREIGN KEY (`Roll_No`) REFERENCES `student` (`Roll_No`),
  CONSTRAINT `studenttosubject_ibfk_2` FOREIGN KEY (`Subject_id`) REFERENCES `subject` (`Subject_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `studenttosubject`
--

LOCK TABLES `studenttosubject` WRITE;
/*!40000 ALTER TABLE `studenttosubject` DISABLE KEYS */
;
INSERT INTO `studenttosubject`
VALUES (108, 'CCC708'),
(117, 'CCC708'),
(108, 'CSD101'),
(117, 'CSD101'),
(108, 'CSD102'),
(117, 'CSD102'),
(108, 'CSD311'),
(117, 'CSD311'),
(108, 'MAT376'),
(117, 'MAT376');
/*!40000 ALTER TABLE `studenttosubject` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `subject` (
  `Subject_ID` varchar(10) NOT NULL,
  `Subject_Name` varchar(50) NOT NULL,
  `Classroom_ID` varchar(10) NOT NULL,
  `Teacher_ID` varchar(10) NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Seats` int DEFAULT NULL,
  `LIVE` enum('L', 'NL') DEFAULT 'NL',
  `TeacherName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Subject_ID`),
  KEY `index_start_time` (`Start_Time`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */
;
INSERT INTO `subject`
VALUES (
    'CCC708',
    'Genetic Engineering',
    'B012',
    'zJS104',
    '16:00:00',
    '17:00:00',
    60,
    'NL',
    'Deepak Sehgal'
  ),
(
    'CSD101',
    'Intro to C',
    'D007',
    'zAS100',
    '09:00:00',
    '10:30:00',
    130,
    'NL',
    'Snehasis Mukherjee'
  ),
(
    'CSD102',
    'Data Structures & Algo.',
    'C309',
    'zPT101',
    '10:30:00',
    '12:00:00',
    140,
    'NL',
    'Saurabh Shigwan'
  ),
(
    'CSD311',
    'Artifical Intelligence',
    'B315',
    'zBL102',
    '14:00:00',
    '15:00:00',
    150,
    'NL',
    'Snehasis Mukherjee'
  ),
(
    'MAT376',
    'Machine Learning - Hands on',
    'D313',
    'zRM103',
    '15:00:00',
    '16:00:00',
    60,
    'L',
    'Snehasis Mukherjee'
  );
/*!40000 ALTER TABLE `subject` ENABLE KEYS */
;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2023-10-16 23:43:36