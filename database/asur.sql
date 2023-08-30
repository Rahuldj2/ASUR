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
  `Picture` blob,
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
INSERT INTO `student` VALUES (100,'Dummy','Dummy','2000-01-01',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0�\0\n\Z!.&+\'8&+/1555$;@;3?.4514$!+11641114444444444144444444444444441444414441444414��\0\0�,\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0<\0\0\0\0\0\0!1A\"Qaq2�����B\�Rb\�r\�\�$3Sc��\��\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0#\0\0\0\0\0\0\0\0\0!1A\"Q2�a�\�\0\0\0?\0\���!Q\�# \0B`#@�, F��,`#@�,`#(�\�h�E�\�\�\�*��bv\nɀ�	6\0jI\�	\�9�\�A�U\�\����\�\�%Ku�y\�\�`�ǝ�b\�ґ\�裟s\�q��~��<b.\�-ݰ�R.I����by\�\\٫:h)��7�J\�J�_~�J�h3��\�m�5��\���#6bu�\���$\\�t)�>�W�ܛ:�\���\��dz�\�H%�\�\��,4����2�Rmb@\�\�}g��~\�f�l�[_;B�\�X���kZ�J(�\�5F�\ZX\�i��sN:��1uJ��l\�Wk\�k(՜�\�o;���%Ap�i����\�\�	ã\�_iΎ��@\�M��0/\�XhD\�8<M:\�ҭ7W�\�M\�)\�Ϙ�mo�֛%sunE\'��1BM\�\�#1O�\�\���\�h\n\�\�b�4��C�\r����Ң��\n\�ȊVIiam�\"���)a	yX�d��aH�Qr\�H�iE�G@#�(\0F!\00Z0\0`! \0#�\0@�\�\�\�8ȧ�er�P�p\r��:S7�UqN�\�k�Dg nB�\�>i\�~5S^�!�.\�\�\�*~�%XǵK^\��\�s+\�ᕵw\���nm����\�\�pu�i\�,UjʶRJ\�o\'�Rs\�il\�\�vUQv>&�[y`\0�\�ٴ#��\�\�}g�ª0ʈ	;\�PY\�n\\�\�m����\�\�g:Z�\��*�x\����\�@���\�5\�\0\�A��\0}g�\��kA߬\�\r\\�(��\�#�\'ey�A\0\�u#K�p<w��Nr��+\�\�\��\�\�)�\�\�ssm�u\�\�c*L%M{�N�K\�ʽ\�R,\r��\�Q��߽\���+��&\�	���q������|\���@\��\�;�v\�A\�y\��\�&��\�k�Ze�\�\n�t��Rt�K\�\�>YL@��\����3\�\��Z\�iVBjSG�D\�0�}�\"=�\"TTDR%�E\"dE\"XD@���*\")\� \"$E�����8��@��Ha \0F@#\�\�@!�\0�8%��6�\�5�z���cZ\��\0�q]?3\�*4�\0\\��}I;i�\���ڥ`�&�\�\�$��?�\�yR�j���7\�a�q9g�\�^n\�\�Q\0�\�_rF�!6~\�xji�!mnK�\�>�z\��\�3s�\�\�SZ�\�s�\�\�>�Ӧ�5Q\�\0��C��\�YAg�RL\�X\�\�8��B�\��\�S\�\0(\�\0\r���D�i�g\�Uז\r�=�I�\0��\Z\��JH?\�gt�J\�\�f\�\�떥�\�T�J�^�\�i4�1\�\�+\�0�FuJ\�1�\�876�gw7\�f�58�\�\�\�\�6=w��\�\�50u0\�I8j�\�\��[܁\�!�4\�,\'gR�`X��|&\�\�J����Z_v�\�\�=k�+\�\�{o�h�h-3kVDR%�D\"@�E\"9(KE\"XDR VDR%����\�Ȓ\�� Ģ\�@#	 �	�ZPDp\"�`�A$\"4}협\�\�:J\�\�޷\�r\�R{X���\�{c�����\�b(1\����{�T��~����\�\��-\�\�\�X\�f(\�\�\��\�p\�HϯE�ð\�{�c0���\�Q\�l\�N\�,\"�\�sAe���\�1צX\�\�U\Z\�\"d^�\�b\�ל\�\�㜕{cr5\n-ᮆm\�Rύ\�\�G\�ޚ�;\�e��?K\\\�-�\�}��51���\�|\���\�\�=y�WX��h-7�\�DB%�)+\"G\")���B\"�,\" VD[G0@�8�#�A�\"C\"�I��\�(� 0�\Z�\�>�n�\�Q�,\�o8�+\�M�\�gG\�^lj�\���UjS\�ي\�с؝��\�\�S\�Țuf�o\�nu9�ܰ8�kcQ��\�L\�R\�l:XjB���f���Q\�\"�4\�u׭�C\�-��\�{������_9��On�\�_QҰ�\rSj�=X\�\�R0B\�X�\\�\�WW=C{�\�`1X�#�׵\�\�H\�|�ƾ\�uL@�\�ǌҸ\'5B\�7?Y�\�\�Mo\�\�\���\�\�Lr\�e\0oskLv\'���j\�\�:��	\�x�>�{�_SrI6\�\�\�\0�	5k�\�\�N��?��\�Y}Ը\�\�o��w\�.���h�}L��\�:\�\�J�t\�\�F�M�l2�`��>@5�?\�vn�BuBI|7�\�f��ǟ��8p\�%��f=�\�9\�5�\��~z\�o9P̈́,�\�\�Y�\�J\�8ve\�\�\�WK\��\0:y͸\�\�|�o��\�\�\�Lg.c�\Z�J�l��,4b&Rt\�\�9r\�Ų��c�T!�\�1H�)�1�(R 1����EĠ�D0��\�0�#H�@!F�#���nL}GQl\��$����-%���v�N�\�\�?�4�w*\�~\Z�\�\�3\�3�\�\�\�~*\'&�[���+ɋ�T�\�:\�0Q\��DU�O�UID��\��\�u3��t���=F,�\�dф\�:�[�W�\Z�\�1jON�\�E�M&\�\���L�\��\�T\�2�̙��{}i�?\�\��>IHqO;��3*�\�\�p/}w��}�C��\'\\\�\�\�\��\�Z͞�\�:�\�\�\�9[Q1���\����s6\�\�Q���e&��(�\�؏A\�l\\J�d�\�I��e���5#�c�5U*�A/k\�`)��l\�ԍvŏ�\�p\�\r:uY�\�!�\�Ҙ��\�\Z\�{\�Ǥ\�،�%�M\�1\����\"\�\�\�:��j]z�5UjPF�Q1\"�\�Ӭ�6\\\�)mqcku���,\�WM����Ϳz�fP�\'v�\�\�\�\�0ֹ\�I�ż��g\�\�	U��	���)S{�\�K�A�\�yK�\�\�\�vpW\�=\�/�vKe##)`:�$�\�\"\�%��\�z9(\"�\�3\�+\�-�\��\�[=\�3#\�\�\�V�\�1�S2bXc���\�1\�\nb\�\"@E1ĬG��@!\Z!\"D� \�G\"���qR\�\�\�m\�{�\�9� \��\�J�򝏊\�{ji\�t _\�\�N%�Z�X\n�����;�\'?S>yt\�u�\��\0[\�pP)��\0G\�Dֹz�*>nø�\�ϗ^���\�\�ሻ���\�\�%�b�\�3QJb\�\�e�\�\�׍[�,o$\�-\�&Ɋ�\�p�/f<n34ڬ��,:�\�\�T\�,\�\� \��F��󏏤\�\�m$�\�7~­:J\�%�\�ɋ���\\p\�2\�\�x��rv\�����Uآ\0PI\�)\�\��\���\�Ŕ}f\���pj�\�IT\nX\��\Z,�\�u��Z��\�ނ�\00�;\�aLS\�0�a��S��`,2B`�P�%b8�!D)�\"(�B\"\�x� �pc\����\�\�=�p�GqA\0�M�\�4%	��\�n\�b��\�`�4\�jLE�F����s^+�pv]/7|4�\�8\n\�Xn,lA\��3p��4\�\'EPO\�po\�zX�\�oZ��\�\�Quz\"딣��^\�m�\�N�)AmF\��x��\�qA\�x]	\�\�Qc���\�9��\'�����\�Ѕ&\�;)\�o\�6j��K)\�3�\Z(\�f�)�k�\�I\0�}\"\�\��\�R�ͺ����9�\�ϸ�8\�?QV��a�^\�k)\�7��΁�6E[���s���װ\�SN�W(ԝk\�\r�\0{˗�2\�{��\���\�cMy\�\�֫cc1|G`D\�W\�e�A:���\0��\�8�\�\����\�\�2pû\n��(\�\�\�Pm\�\�~�u\�U*(UEP\0����U\�TT�eB\�A\�\Z�\�v\�s\�\\=}s�d1L\�Є\�2`2 ��`)�\�`��I�(�H�ʋ�D�0�(0\�\�^-\�!��\"D*�a�A\Z�\��A؂�U� \��\�\�\�]mdv\�\�ͯ\�eyz�b�:��\�f=�a�\�V\n3\���z�\�O\�s~�ju��\�\�3���}:�\�ye\�<;E��\\�N�6�\�]�敢�	U�u$_��{\��\Z���Ik7R5���8�(V̙E�EՇ���j}t\���\�\�*�\�(\�c�\Z�MG��\�v\rl��7\�*�ğ-4�\�W\�ݖ��\�\�\�\�\�2�\�\�\�]�Ƹ6\�i�\�l��\�\�X\�\0\�³��Q��J�\�!�9B�\�\�b\�\�(\�\�3u8��k�lṞ�*(�^\��)���ǈ�`8MDe5^�\��\�\\{Z\�K\�|�\��n3���\�\�h���\�ӥ�v���\\��\�k[\�a�\�i�\�ۖ�\�ǆ�\�cu~\�6=Wbm\�gE�N�Zi\�@i��\�\���ߙ\�\�\�\�\�y�*�0 &\00LSA!�`C&,\nD�o3$81�� \�\�\rxb�\���\�q+\�)\�\"(3Ĺ�\r��E$i�M\�\�pֽ��\�<��4\�\�I�\��`O\�\�r\�f���\�{�R̉\�1\�\��\�k�\�>`G���\�\Zt\�7��\�\�\"�dcn�nw����eg\�ʕ���ѯ}w\��8\�6P\�ThN���5u3\�7\��\�U�UDWpl�IԞ�\0�\\A��P\�ibt\�O>�y8\�d\\�\�kk�\�.m\��\�*i�\�\Z\�O�|�ך\�g%\�\�	\�3�\�imG�\�6Q��\'�q\�E�w���4$\��\�<<c����M\�{�\�[�\�g>�l79q\0�(݅�5�\0�\�rF�+Q�7��o\�\�\���u{G�U��D\��{�\Z�\\��\�Sco\0\�\�l�|5\�\�s�h���\�\�i��S�\��\�^Q\���ڍN�>ȋw��\�\�\\��;4\�\�/Ɋ�1�d\0ń\�0!�C\�	0I0�H�(�`d�T0�$�\�I 0�I$�@7�,g�D\�\�\����Hg�Ӹ�\05Ԭ�(\�\�{\��MC-�7\'RI\�\�I\r\�2F>��\�\�X\�\r;���q\�\�~�v}.&,��f\�2K�Mzd\�\�QT�/�\�\���[_��P��)!��\�`/\��I�l&�\��8\��\�\��h\�0\�k�]��:��H\��I5\�x\\y�[fB��\�.ĭ�\��I�\�zz\�j%�Ci\�O��\�C彷xI$\��{{\�u$n;�jRUW\��\��k�q\Zu\�53\�p|\�w8���Q�d�F��$�PS$��d��/�?�\�','dd100','dummy2000');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subject`
--

DROP TABLE IF EXISTS `Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subject` (
  `Subject_ID` varchar(10) NOT NULL,
  `Subject_Name` varchar(50) NOT NULL,
  `Classroom_ID` varchar(10) NOT NULL,
  `Teacher_ID` varchar(10) NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Seats` int DEFAULT NULL,
  PRIMARY KEY (`Subject_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subject`
--

LOCK TABLES `Subject` WRITE;
/*!40000 ALTER TABLE `Subject` DISABLE KEYS */;
INSERT INTO `Subject` VALUES ('CSD101','Intro to C','D217','zAS100','09:00:00','10:30:00',120);
/*!40000 ALTER TABLE `Subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-30 11:30:21
