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
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `Room_ID` varchar(10) NOT NULL,
  `Point` int DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `Mismatch` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES ('D217',1,28.5253922,77.5760115,3.74,0),('D217',2,28.5254502,77.5762321,3.74,0),('D217',3,28.5254546,77.576243,3.74,0),('D217',4,28.5254496,77.5762368,3.74,0);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
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
INSERT INTO `student` VALUES (100,'Dummy','Dummy','2000-01-01',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0\0\n\Z!.&+\'8&+/1555$;@;3?.4514$!+11641114444444444144444444444444441444414441444414ÿÀ\0\0¨,\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0<\0\0\0\0\0\0!1A\"Qaq2¡±ÁB\ðRb\Ñr\á\ñ$3Sc\Âÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0#\0\0\0\0\0\0\0\0\0!1A\"Q2aÿ\Ú\0\0\0?\0\ßÀ!Q\Æ# \0B`#@, F,`#@,`#(\ÃhÀE¬\ê\Î\ä*¢bv\nÉ	6\0jI\Ø	\Í9£\ÚA§U\è\à\Ñ\ë¸%Kuy\ß\Æ`ùÇªb\ÕÒ\ìè£s\ßq¯¼~°<b.\ê-Ý°¿R.I¸by\×\\Ù«:h)7J\ÜJ¥_~­Jh3»\ëm¦5±\ô¦#6buý\Ú¨ $\\t)¹>»W­Ü:°\Ìú\Ûýdz\ÅH%\÷\í©,4¼­«2®Rmb@\Í\ë}gµ~\óf»lº[_;B³\ñX¢kZ¡J(´\Ð5F\ZX\ïiÁsN:1uJ²l\ê¾Wk\Þk(Õû\Ëo;·¿%Apúi¥ºü¾\ß\ï	Ã£\ð_iÎ©@\êM¥0/\õXhD\ê8<M:\ÔÒ­7W¦\êM\Ã)\ØÏÀmo¾Ö%sunE\'¦1BM\é\æ#1O\í\ë¥\çh\n\Å\Âb­4¨C£\r¤¶Ò¢¢±\n\ËÈVIiam²\")a	yX¥daHQr\ËHiEG@#(\0F!\00Z0\0`! \0#\0@\Ð\ç¾\Ö8È§er¯Pp\r®:S7üUqN\ÔkDg nB\é>i\æ~5S^¦!®.\Ý\Õ\ß*~%XÇµK^\Û¨\×s+\Ãáµw\Êºnmµª£\â\Ípu±i\é,UjÊ¶RJ\âo\'¦Rs\àil\Ý\ì¡vUQv>&ú[y`\0­\ïÙ´#ª\ò\Ü}g¯Âª0Ê	;\ßPY\ên\\¨\Ìm¶³\Ô\Ìg:Z¿\ê*x\é­úþú\Ï@¨®¶\È5\ê\0\ÓA­ÿ\0}g\ð­kAß¬\õ\r\\£(¿ \ï#¾\'eyA\0\èu#Kp<wNr­+\Þ\ß\ô©\ß\ï)«\Ã\ëssmüu\Û\ác*L%M{¬NºK\ÝÊ½\êR,\r\ÃQ³¢ß½\å®Á+ °&\Ç	«q·¡|\×­¬@\ëû\Ò;¢v\×A\öy\Î\Ä&³³\ák¶Ze\Í\nt±þRt·K\Î\Ù>YL@´\Ù¤©¹3\é\îZ\ôiVBjSGD\Ê0±} \"= \"TTDR%¤E\"dE\"XD@¨*\")\Ò \"$E´´¶8À@ÀHa \0F@#\Ð\Ú@!\08%¡´6\Ð5þz©cZ\öÿ\0q]?3\ç*4À\0\\û£}I;i¸\õûÚ¥`&½\Å\ó½$ù¸?\ÆyRj 7\Öa½q9g\÷^n\É\ÉQ\0ª\Ì_rF!6~\Êxji!mnK\ñ>¢z\ð½\é3s¬\à\ßSZú\ôs\ç\Ô>Ó¦¥5Q\à\0Cº©\õYAg­RL\ÎX\ê°\õ8§¿B\×ù\ôS\à´\0(\Ó\0\rDiºg\ÃU×\rø=úIÿ\0¨\Z\ÜJH?\ñgtJ\Ô\æ½f\Æ\Ìë¥\àTJ^¶\Ði41\Ê\ã+\ä0¹FuJ\é1¸\Ì876gw7\Ãf³58®\ô\È\Ô\Ü6=w£\Ø\ç50u0\ìI8j\Ë\ßþ[Ü\ð!§4\æ,\'gRº`X²|&\ï\ìJù±þZ_v·\ß\é=k+\Î\Þ{o¯hh-3kVDR%¤D\"@E\"9(KE\"XDR VDR%\ÑÈ\Ð Ä¢\à@#	 	ZPDp\"`A$\"4}í\Â\ô:J\ã\ÇÞ·\Ör\ÞR{X±µ¾\ó¬{c¥¹µ\òb(1\ò­ù{T³³~¿¯\Õ\Õþ-\Ý\ä\éX\Öf(\î\×\ð´\Øp\èHÏ¯EÃ°\Ò{c0À\ÉQ\Úl\ÃN\×,\"\ÓsAe§ \æ«1×¦X\ö\ðU\Z\Ï\"d^\Þb\ñ¦×\õ\Õã{cr5\n-á®m\ÆRÏ\ð\ËG\çÞ;\Ñe¨µ?K\\\æ-¤\Ú}¹51¢ú¥\é|\Íø\Ý\ã=yùWX´h-7¹\ÊDB%)+\"G\")ÀB\",\" VD[G0@8#A\"C\"I\â( 0\Z§\í>n\ÙQ½,\êo8·+\éM¿\ÎgG\æ^lj¿\â¦¹UjS\ÐÙ\åÑØ´\ç\éS\ÉÈuf¥o\Ænu9úÜ°8kcQª\îL\ÌR\æl:XjBÀþf©Q\ß\"¡4\Îu×­C\ç-¥Á\Ë{ø¦¹±¾_9£¶On®\í_QÒ°\rSj¨=X\Ì\ÅR0î²B\ãX¾\\¨\éWW=C{ü\ó`1X¼#×µ\õ\×H\â|©Æ¾\ÇuL@\ÕÇÒ¸\'5B\æ7?Y\â¸\ãMo\å\ó\÷¯ú\å¬\õLr\Þe\0oskLv\'°j\ô\î:¹ù	\Ìx¾>½{¢_SrI6\ð¼\ó\ð®\0	5k³\Ø\ëN?·´\ÊY}Ô¸\ã\Ôo¾w\Ã.úh¤}L­ø\Å:\Â\èJt\Û\èFMøl2`µ©>@5¥?\ÃvnBuBI|7\êf²Ç8p\î%¾¢f=\Ò9\ñµ5±\Ð~z\Ìo9PÍ,º\è\ßY\åJ\õ8ve\Õ\ë\ÑWK\ê³\0:yÍ¸\Ô\Î|´o§­\ë\ë\ÐLg.c¾\ZJ lÁ¬,4b&Rt\æ\ó9r\ÙÅ²Àc¦T!\Æ1H)1(R 1 EÄ D0\Â0#H@!F#ønL}GQl\êþ$±¯-%·vûN©\Ï\Ü?´4w*\ê~\Z\Ì\ç3\Ù3¡\Ü\Ô\Ì~*\'&¼[¹ü³+É¢T\ó:\Ê0Q\ê§DU¨O¿UID·\íù\óu3´¦t¾Â=F,\ôdÑ\Ã:[»W\Z\Æ1jON\òEþM&\ê\÷úL\à\éT\Ý2Ì{}i?\Ë\÷>IHqO;3*\Ï\ãp/}wú}¥C¢\'\\\Ù\Ç\Ä\ë\ËZÍ\ç:\Í\ð\Õ9[Q1©¦\öþ·s6\ô\ÆQ­½e&þ(¹\ÔØA\Òl\\Jd±\ÛI«e¬µ®5#c¸5U*A/k\æ`)¢l\ïÔvÅ¡\Äp\Õ\r:uY\Û! \ÔÒº\Ì\Z\ë{\ÞÇ¤\èØ%M\ï1\å±¡¼Á\"\ö\ñ´\Ï:øj]z¼5UjPF«Q1\"¥\ËÓ¬ 6\\\Ç)mqckuþ,\ÈWM½¬Í¿z¤fP¾\'v\Ì\Ò\Ö\é0Ö¹\õIÅ¼´¾g\Â\ß	U¤	¡)S{\ÖKA²\ØyK¸\å\Ê\èvpW\ç=\Ü/vKe##)`:$¼\Ù\"\Î%µµ\ðz9(\"ù\ó3\Û+\Â-\ô¯\Ú[=\Î3#\Ì\Õ\çV\Å1S2bXc±\Å1\â\nb\Ç\"@E1Ä¬G@!\Z!\"D \ÈG\"»¸qR\×\ì\Üm\ì{§\ï9 \ÛÀ\èJò\á{ji\õt _\Æ\ÚN%ZX\n¾©°;\'?S>yt\ôuø\ñÿ\0[\÷pP)ÿ\0G\ÝDÖ¹z¸*>nÃ¸´\æÏ^­\ó\Óá»\Ú\Þ%b¸\Å3QJb\Ã\Öe©\Ä\ð×[¯,o$\Õ-\ä&É¤\Åp/f<n34Ú¬¹,:\ò\ÂT\×,\õ\ö \ôF¥ó¤\÷\Óm$\å7~Â­:J\ë%¬\óÉ«¡\\p\Ç2\Ú\Õxûrv\ÒþUØ¢\0PI\Ô)\ë\õ\×«\ÛÅ}f\ÍÀ¸pj\ÊIT\nX\ô¸\Z,\Ïu·Z\ÖÞÀ\00Á;\ÞaLS\Ä0aÀSÀ`,2B`P%b8!D)\"(B\"\Ãx Àpc\ÊÁ\Ä\Ò=¤pGqA\0«M\î4%	µ\Æn\Âb¹£\Û`±4\ìjLEüF ü¼s^+pv]/7|4¼\å8\n\ÅXn,lA\Ü¸3p¥4\é\'EPO\Æpo\ÅzX½\ÙoZû¦\ó\ÄQuz\"ë£­^\ãmº\ÏN)AmF\Äøxü¢\âqA\Ïx]	\Ô\õQc¯¥þ\ñ9ú¾\'¦½Á¹ý\é°Ð&\×;)\òo\ï6j¼ùK)\È3±\Z(\êfÀ)¹k¡\èI\0}\"\ð\î\áRÍº¡¾·9\ñÏ¸±8\Þ?QVa^\îk)\ñ7°úÎ6E[ªs¾¬×°\ØSNÁW(Ôk\Ø\rÿ\0{Ë2\Ü{ ©\÷\ÞcMy\ð\ÌÖ«cc1|G`D\ñW\âeA:øÿ\0¡ù\Ê8£\é\ëù­\ò\Ï2pÃ»\n(\â\ê\õPm\Å\î~u\ÊU*(UEP\0U\âTT®eB\ìA\ò\Z\ëv\ôs\Æ\\=}s®d1L\ÜÐ\Å2`2 À`)\Â`¦I(HÀÊD 0(0\Þ\Ò^-\á¼!\"D*Àa¼A\Z\ÈÀAØ¤U \àü\á\Ã\Î]mdv\í\ÂÍ¯\Þeyzºb¥:°\ñf=±a²\ÃV\n3\öz\ÊO\âs~juµ\Í\ô3«}:ú\âye\ñ<;E³\\ÁN£6ú\Þ]æ¢¹	Uªu$_¯»{\Ìþ\Zµ¬Ik7R5ýü¥8¬(VÌEüEÕªj}t\Ìþ\Ò\ç*\Ì(\öcù\ZMG©´\ôv\rl´²7\ê*Ä-4ú\ÏW\âÝ¬\ô\ë\ô\×\ç2\ð\ö\ß]½Æ¸6\Ûi\ílþ\Ñ\ÌX\ö\0\ÒÂ³¡¿Q©J¸\î!9B\õ\æb\Ã\Ï(\ß\ç3u8­klá¹*(»^\ç©ü)µÇÁ`8MDe5^ú\ôý\å\\{Z\ãK\ì|\ön3²\ã\Æh¥¿\ÅÓ¥«vÀ\\¥\Æk[\Êa\÷i\õÛý\ìÇ\Úcu~\å6=Wbm\ægENZi\Ñ@i¢¨\Û\÷©ß\Ä\á\æ\ê\óy*Á0 &\00LSA!`C&,\nDo3$81 \È\Å\rxb\Â¢\Äq+\Ä)\Ä\"(3Ä¹\r½E$iM\Ú\ðpÖ½­¥\ð<±ü4\â\õI¦\×±`O\æ\Ór\æf«®\È{´RÌ\Ð1\Ò\äø\Úk\Ì>`Gú\×\Zt\ã7µ\å\î\"¤dcnnw¿µeg\îÊÑ¯}w\ñ8\â6P\äThN þ­5u3\ö7\ô·\ò²U¸UDWpl¡IÔ\0\\A¨P\Äibt\ßO>³y8\êd\\\Ükk­\ì.m\ã\ñ*i\ì\Z\ÃO|¼×\Ûg%\á\Ü	\ò«3\ØimG\Ê6Q­®\'q\ÄE¦wø4$\éû\ë<<cM\í{¾\ï[ù\Ég>l79q\0(Ýý5ÿ\0\ÇrF®+Q7®o\Ð\Ò\Ó±u{G¹U²D\Øø{­\Z´\\û´\êSco\0\Â\ólü|5\Ü\÷s§h \ñ\ïi°úS¢\õ\î¬^Q\ö¸ÚN¥>Èwº\ëµ\ç\\¼¸;4\ß\â/É¦1d\0Å\Å0!C\Ê	0I0H°(¼`dT0$\ÆI 0I$@7,g¡D\õ\ã\ô©¹HgÓ¸ÿ\05Ô¬¥(\Ý\é{\ÇûMC-¡7\'RI\Ö\òI\r\ó2F>ª\Æ\ÝX\Ë\r;¤q\ï\Û~v}.&,³£f\é´2KMzd\ð¼\ÃQT/ý\ï\ñýù[_P¥)!\ï`/\ôIl&«\Ïþ8\ä®\à\õ¹h\ô0\õk]©:H\õI5\âx\\y¾[fB°\á.Ä­\õI£\ëªzz\Æj%Ci\ÔO¦\êCå½·xI$\Ïü{{\Øu$n;jRUW\ï¾\ð³kÀq\Zu\Ó53\ê§p|\äw8ºQdF$PS$d/?ÿ\Ù','dd100','dummy2000');
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

-- Dump completed on 2023-09-01 20:33:44
