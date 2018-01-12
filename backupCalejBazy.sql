-- MySQL dump 10.16  Distrib 10.1.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: DanceSchool
-- ------------------------------------------------------
-- Server version	10.1.25-MariaDB-1~xenial

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
-- Table structure for table `MiastaP`
--

DROP TABLE IF EXISTS `MiastaP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MiastaP` (
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MiastaP`
--

LOCK TABLES `MiastaP` WRITE;
/*!40000 ALTER TABLE `MiastaP` DISABLE KEYS */;
INSERT INTO `MiastaP` VALUES ('Wroclaw'),('Brzeg Dolny'),('Opole'),('Bielany Wroclawskie'),('Wroclaw'),('Wroclaw'),('Wroclaw'),('Wroclaw'),('Wroclaw'),('Wroclaw');
/*!40000 ALTER TABLE `MiastaP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pemail`
--

DROP TABLE IF EXISTS `Pemail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pemail` (
  `domena` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pemail`
--

LOCK TABLES `Pemail` WRITE;
/*!40000 ALTER TABLE `Pemail` DISABLE KEYS */;
INSERT INTO `Pemail` VALUES ('tlen.pl'),('gmail.com'),('op.pl'),('wp.pl'),('example.com'),('mail.com');
/*!40000 ALTER TABLE `Pemail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UliceP`
--

DROP TABLE IF EXISTS `UliceP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UliceP` (
  `ulica` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UliceP`
--

LOCK TABLES `UliceP` WRITE;
/*!40000 ALTER TABLE `UliceP` DISABLE KEYS */;
INSERT INTO `UliceP` VALUES ('Pilsudskiego'),('Kosciuszki'),('Poprzeczna'),('Glowna'),('Osiedlowa'),('Bacciarellego'),('Wyspianskiego'),('Wroblewskiego'),('Olszewskiego'),('Kazimierza Wielkiego'),('Mikolaja'),('Krzywoustego'),('Kromera'),('Wittiga');
/*!40000 ALTER TABLE `UliceP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `max_participants` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `class_course_id_fk` (`course_id`),
  CONSTRAINT `class_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'Bachata Poczatkujacy','2018-02-01','2018-05-01',250.00,1,1,20),(2,'Bachata Sensual','2018-01-01','2018-04-01',200.00,2,1,16),(3,'Salsa cubana START','2017-12-26','2018-02-27',180.00,3,3,16),(4,'Salsa cubana OPEN','2018-01-23','2018-01-23',15.00,3,78,20),(5,'Kizomba','2018-01-31','2018-04-24',200.00,4,34,18),(6,'Taniec Towarzyski','2018-01-19','2018-04-20',150.00,5,9,26),(7,'Salsa NY','2018-01-26','2018-05-04',200.00,6,51,16);
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_student`
--

DROP TABLE IF EXISTS `class_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_in_class` (`class_id`,`student_id`),
  CONSTRAINT `class_student_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_student`
--

LOCK TABLES `class_student` WRITE;
/*!40000 ALTER TABLE `class_student` DISABLE KEYS */;
INSERT INTO `class_student` VALUES (50,1,2),(57,1,7),(45,1,11),(2,1,14),(4,1,27),(1,1,29),(61,2,3),(9,2,5),(23,2,10),(8,2,20),(15,2,27),(20,2,39),(11,2,44),(12,2,48),(13,2,53),(10,2,63),(21,2,68),(22,2,73),(17,2,79),(18,2,82),(46,2,83),(52,3,NULL),(53,4,NULL),(54,5,NULL),(55,6,NULL),(56,7,NULL),(62,7,3);
/*!40000 ALTER TABLE `class_student` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER always_below_max_participants
BEFORE INSERT ON class_student
FOR EACH ROW
BEGIN
  DECLARE curr_num_of_participants INT;
  DECLARE max_participants INT;

  SET curr_num_of_participants = (SELECT COUNT(*) FROM class_student WHERE class_id=NEW.class_id);
  SET max_participants = (SELECT class.max_participants FROM class WHERE id=NEW.class_id);

  IF curr_num_of_participants >= max_participants
  THEN
   SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Warning: you cant add more students';
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `class_weekday`
--

DROP TABLE IF EXISTS `class_weekday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_weekday` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `weekday_id` int(11) NOT NULL,
  `hours` varchar(20) NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `weekday_id` (`weekday_id`),
  CONSTRAINT `class_weekday_ibfk_1` FOREIGN KEY (`weekday_id`) REFERENCES `weekday` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_weekday`
--

LOCK TABLES `class_weekday` WRITE;
/*!40000 ALTER TABLE `class_weekday` DISABLE KEYS */;
INSERT INTO `class_weekday` VALUES (1,1,'15:00 - 16:00'),(2,1,'16:00 - 17:00'),(3,2,'9:30 - 10:30'),(4,2,'11:00 - 12:00'),(5,3,'19:00 - 20:00'),(6,5,'19:00 - 20:00'),(7,5,'20:00 - 21:30');
/*!40000 ALTER TABLE `class_weekday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `level` (`level`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`type`) REFERENCES `type` (`id`),
  CONSTRAINT `course_ibfk_2` FOREIGN KEY (`level`) REFERENCES `level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,1,1,NULL),(2,1,1,NULL),(3,2,1,NULL),(4,3,1,NULL),(5,4,1,NULL),(6,5,1,NULL),(7,6,1,NULL),(8,7,1,NULL),(9,8,1,NULL),(17,1,2,NULL),(18,2,2,NULL),(19,3,2,NULL),(20,4,2,NULL),(21,5,2,NULL),(22,6,2,NULL),(23,7,2,NULL),(24,8,2,NULL),(32,1,3,NULL),(33,2,3,NULL),(34,3,3,NULL),(35,4,3,NULL),(36,5,3,NULL),(37,6,3,NULL),(38,7,3,NULL),(39,8,3,NULL),(47,1,4,NULL),(48,2,4,NULL),(49,3,4,NULL),(50,4,4,NULL),(51,5,4,NULL),(52,6,4,NULL),(53,7,4,NULL),(54,8,4,NULL),(62,1,5,NULL),(63,2,5,NULL),(64,3,5,NULL),(65,4,5,NULL),(66,5,5,NULL),(67,6,5,NULL),(68,7,5,NULL),(69,8,5,NULL),(77,1,6,NULL),(78,2,6,NULL),(79,3,6,NULL),(80,4,6,NULL),(81,5,6,NULL),(82,6,6,NULL),(83,7,6,NULL),(84,8,6,NULL);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imieP`
--

DROP TABLE IF EXISTS `imieP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imieP` (
  `imie` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imieP`
--

LOCK TABLES `imieP` WRITE;
/*!40000 ALTER TABLE `imieP` DISABLE KEYS */;
INSERT INTO `imieP` VALUES ('Jan'),('Andrzej'),('Józef'),('Tadeusz'),('Jerzy'),('Zbigniew'),('Krzysztof'),('Henryk'),('Ryszard'),('Kazimierz'),('Marek'),('Marian'),('Piotr'),('Janusz'),('Wladyslaw'),('Adam'),('Wieslaw'),('Zdzislaw'),('Edward'),('Mieczyslaw'),('Roman'),('Miroslaw'),('Maria'),('Krystyna'),('Anna'),('Barbara'),('Elzbieta'),('Teresa'),('Janina'),('Jadwiga'),('Zofia'),('Danuta'),('Irena'),('Ewa'),('Malgorzata'),('Grazyna'),('Bozena'),('Stanislawa'),('Marianna');
/*!40000 ALTER TABLE `imieP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sign` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` VALUES (1,'P0'),(2,'P1'),(3,'P2'),(4,'P3'),(5,'S'),(6,'OPEN');
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nazwiskaP`
--

DROP TABLE IF EXISTS `nazwiskaP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nazwiskaP` (
  `nazwisko` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nazwiskaP`
--

LOCK TABLES `nazwiskaP` WRITE;
/*!40000 ALTER TABLE `nazwiskaP` DISABLE KEYS */;
INSERT INTO `nazwiskaP` VALUES ('Nowak'),('Kowalak'),('Kowalski'),('Wisnoiewski'),('Kowalczyk'),('Szymanski'),('Wozniak'),('Grabowski'),('Kaczmarek'),('Zajac'),('Krol'),('Wieczorek'),('Nowakowski'),('Jaworski'),('Stepien'),('Pawlak'),('Dudek'),('Walczak');
/*!40000 ALTER TABLE `nazwiskaP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `show_available_classes`
--

DROP TABLE IF EXISTS `show_available_classes`;
/*!50001 DROP VIEW IF EXISTS `show_available_classes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `show_available_classes` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `start_date` tinyint NOT NULL,
  `end_date` tinyint NOT NULL,
  `price` tinyint NOT NULL,
  `teacher_id` tinyint NOT NULL,
  `first_name` tinyint NOT NULL,
  `last_name` tinyint NOT NULL,
  `day` tinyint NOT NULL,
  `hours` tinyint NOT NULL,
  `level` tinyint NOT NULL,
  `n` tinyint NOT NULL,
  `max_participants` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `show_student_classes`
--

DROP TABLE IF EXISTS `show_student_classes`;
/*!50001 DROP VIEW IF EXISTS `show_student_classes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `show_student_classes` (
  `student_id` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `start_date` tinyint NOT NULL,
  `end_date` tinyint NOT NULL,
  `price` tinyint NOT NULL,
  `first_name` tinyint NOT NULL,
  `last_name` tinyint NOT NULL,
  `day` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `show_student_classes2`
--

DROP TABLE IF EXISTS `show_student_classes2`;
/*!50001 DROP VIEW IF EXISTS `show_student_classes2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `show_student_classes2` (
  `student_id` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `start_date` tinyint NOT NULL,
  `end_date` tinyint NOT NULL,
  `price` tinyint NOT NULL,
  `first_name` tinyint NOT NULL,
  `last_name` tinyint NOT NULL,
  `day` tinyint NOT NULL,
  `hours` tinyint NOT NULL,
  `max_participants` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `show_students_in_class`
--

DROP TABLE IF EXISTS `show_students_in_class`;
/*!50001 DROP VIEW IF EXISTS `show_students_in_class`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `show_students_in_class` (
  `class_id` tinyint NOT NULL,
  `student_id` tinyint NOT NULL,
  `first_name` tinyint NOT NULL,
  `last_name` tinyint NOT NULL,
  `phone` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Wroclaw','Wittiga','Sebastian','Nowak','Sebastian1Nowak@gmail.com','124567543'),(3,'Wroclaw','Olszewskiego 30','Bozena','Wozniak','Bozena85Wozniak@tlen.pl','499117423'),(4,'Wroclaw','Mikolaja 54','Edward','Stepien','Edward12Stepien@tlen.pl','255526748'),(5,'Brzeg Dolny','Krzywoustego 39','Kazimierz','Szymanski','Kazimierz65Szymanski@mail.com','163127581'),(6,'Opole','Wyspianskiego 9','Adam','Zajac','Adam56Zajac@example.com','243405072'),(7,'Wroclaw','Poprzeczna 99','Irena','Nowakowski','Irena38Nowakowski@tlen.pl','650984727'),(8,'Wroclaw','Olszewskiego 53','Irena','Walczak','Irena38Walczak@tlen.pl','664614662'),(9,'Brzeg Dolny','Wroblewskiego 5','Miroslaw','Nowakowski','Miroslaw65Nowakowski@mail.com','949678913'),(10,'Brzeg Dolny','Mikolaja 48','Maria','Szymanski','Maria29Szymanski@op.pl','568439120'),(11,'Brzeg Dolny','Olszewskiego 26','Ryszard','Zajac','Ryszard94Zajac@tlen.pl','488056575'),(12,'Bielany Wroclawskie','Wittiga 32','Adam','Walczak','Adam33Walczak@op.pl','118104915'),(13,'Wroclaw','Wittiga 74','Wieslaw','Pawlak','Wieslaw56Pawlak@example.com','903349381'),(14,'Opole','Mikolaja 83','Teresa','Kowalczyk','Teresa91Kowalczyk@gmail.com','238790093'),(15,'Wroclaw','Kromera 36','Stanislawa','Wozniak','Stanislawa76Wozniak@tlen.pl','483256216'),(16,'Brzeg Dolny','Pilsudskiego 83','Anna','Jaworski','Anna66Jaworski@wp.pl','585027903'),(17,'Bielany Wroclawskie','Wittiga 71','Edward','Pawlak','Edward66Pawlak@tlen.pl','820941605'),(18,'Wroclaw','Mikolaja 88','Barbara','Grabowski','Barbara75Grabowski@example.com','992757006'),(19,'Wroclaw','Wittiga 43','Adam','Kowalski','Adam79Kowalski@gmail.com','419287281'),(20,'Brzeg Dolny','Pilsudskiego 65','Marek','Zajac','Marek44Zajac@example.com','141623594'),(21,'Wroclaw','Wittiga 27','Stanislawa','Nowakowski','Stanislawa35Nowakowski@example.com','751156128'),(22,'Wroclaw','Bacciarellego 23','Wieslaw','Zajac','Wieslaw67Zajac@op.pl','472973147'),(23,'Wroclaw','Bacciarellego 27','Marek','Kaczmarek','Marek22Kaczmarek@mail.com','110356578'),(24,'Opole','Wyspianskiego 50','Józef','Nowak','Józef34Nowak@example.com','398153471'),(25,'Opole','Wyspianskiego 10','Teresa','Grabowski','Teresa94Grabowski@op.pl','331679428'),(26,'Wroclaw','Poprzeczna 85','Marek','Pawlak','Marek32Pawlak@mail.com','876197552'),(27,'Bielany Wroclawskie','Pilsudskiego 4','Adam','Stepien','Adam78Stepien@gmail.com','540838115'),(28,'Wroclaw','Poprzeczna 73','Grazyna','Kaczmarek','Grazyna100Kaczmarek@wp.pl','622597977'),(29,'Wroclaw','Wittiga 85','Barbara','Kaczmarek','Barbara19Kaczmarek@op.pl','828913160'),(30,'Wroclaw','Wittiga 81','Piotr','Kowalak','Piotr61Kowalak@wp.pl','760403596'),(31,'Wroclaw','Kazimierza Wielkiego 12','Janusz','Nowak','Janusz72Nowak@gmail.com','776568513'),(32,'Opole','Olszewskiego 54','Edward','Kowalski','Edward25Kowalski@gmail.com','655521787'),(33,'Bielany Wroclawskie','Osiedlowa 64','Marianna','Kowalski','Marianna3Kowalski@example.com','517750522'),(34,'Wroclaw','Glowna 18','Józef','Nowakowski','Józef42Nowakowski@op.pl','133500682'),(35,'Wroclaw','Wyspianskiego 37','Wladyslaw','Stepien','Wladyslaw2Stepien@mail.com','664168142'),(36,'Wroclaw','Pilsudskiego 98','Adam','Kowalski','Adam69Kowalski@gmail.com','755936904'),(37,'Wroclaw','Poprzeczna 2','Józef','Nowakowski','Józef11Nowakowski@example.com','158283740'),(38,'Wroclaw','Kromera 33','Zdzislaw','Grabowski','Zdzislaw92Grabowski@example.com','333961484'),(39,'Opole','Mikolaja 69','Wladyslaw','Szymanski','Wladyslaw99Szymanski@gmail.com','248873925'),(40,'Wroclaw','Wyspianskiego 86','Teresa','Wozniak','Teresa7Wozniak@gmail.com','596062612'),(41,'Brzeg Dolny','Olszewskiego 66','Grazyna','Zajac','Grazyna17Zajac@example.com','677487480'),(42,'Wroclaw','Krzywoustego 76','Józef','Kowalak','Józef4Kowalak@mail.com','162060696'),(43,'Brzeg Dolny','Krzywoustego 17','Wieslaw','Wozniak','Wieslaw41Wozniak@wp.pl','196075622'),(44,'Opole','Osiedlowa 71','Marianna','Nowakowski','Marianna19Nowakowski@example.com','244008758'),(45,'Wroclaw','Mikolaja 8','Wladyslaw','Zajac','Wladyslaw55Zajac@gmail.com','358354283'),(46,'Wroclaw','Osiedlowa 17','Wladyslaw','Walczak','Wladyslaw69Walczak@gmail.com','907924364'),(47,'Wroclaw','Osiedlowa 41','Krzysztof','Stepien','Krzysztof88Stepien@gmail.com','161329884'),(48,'Wroclaw','Kazimierza Wielkiego 3','Danuta','Krol','Danuta35Krol@wp.pl','159976383'),(49,'Wroclaw','Wroblewskiego 75','Marek','Dudek','Marek63Dudek@tlen.pl','143920337'),(50,'Wroclaw','Wittiga 46','Anna','Stepien','Anna90Stepien@wp.pl','283791599'),(51,'Brzeg Dolny','Mikolaja 55','Tadeusz','Jaworski','Tadeusz24Jaworski@op.pl','659894712'),(52,'Wroclaw','Osiedlowa 37','Janusz','Grabowski','Janusz60Grabowski@example.com','731527757'),(53,'Wroclaw','Mikolaja 95','Teresa','Stepien','Teresa16Stepien@op.pl','857306466'),(54,'Wroclaw','Mikolaja 97','Zbigniew','Stepien','Zbigniew20Stepien@gmail.com','313738638'),(55,'Bielany Wroclawskie','Kromera 6','Jadwiga','Kowalski','Jadwiga37Kowalski@gmail.com','369655112'),(56,'Wroclaw','Pilsudskiego 100','Henryk','Wozniak','Henryk1Wozniak@gmail.com','484604323'),(57,'Wroclaw','Bacciarellego 54','Zdzislaw','Krol','Zdzislaw23Krol@wp.pl','228914377'),(58,'Wroclaw','Bacciarellego 44','Bozena','Walczak','Bozena43Walczak@mail.com','106098914'),(59,'Wroclaw','Bacciarellego 10','Marek','Dudek','Marek1Dudek@example.com','143715209'),(60,'Brzeg Dolny','Osiedlowa 37','Jerzy','Pawlak','Jerzy16Pawlak@mail.com','749132060'),(61,'Wroclaw','Wyspianskiego 13','Irena','Nowak','Irena56Nowak@mail.com','471405307'),(62,'Wroclaw','Wittiga 37','Barbara','Nowakowski','Barbara85Nowakowski@gmail.com','975315263'),(63,'Wroclaw','Mikolaja 67','Andrzej','Jaworski','Andrzej66Jaworski@mail.com','327225763'),(64,'Wroclaw','Wyspianskiego 58','Mieczyslaw','Wieczorek','Mieczyslaw93Wieczorek@example.com','719770202'),(65,'Wroclaw','Glowna 45','Jerzy','Kaczmarek','Jerzy67Kaczmarek@mail.com','117278342'),(66,'Wroclaw','Krzywoustego 25','Wladyslaw','Kowalak','Wladyslaw88Kowalak@example.com','525203529'),(67,'Wroclaw','Kosciuszki 37','Zbigniew','Wisnoiewski','Zbigniew7Wisnoiewski@example.com','343988474'),(68,'Wroclaw','Osiedlowa 100','Józef','Grabowski','Józef82Grabowski@example.com','468529689'),(69,'Bielany Wroclawskie','Pilsudskiego 63','Marek','Dudek','Marek84Dudek@example.com','341863500'),(70,'Bielany Wroclawskie','Bacciarellego 95','Irena','Kaczmarek','Irena84Kaczmarek@tlen.pl','169649045'),(71,'Wroclaw','Bacciarellego 30','Piotr','Stepien','Piotr36Stepien@wp.pl','918188264'),(72,'Wroclaw','Kosciuszki 43','Zdzislaw','Nowakowski','Zdzislaw19Nowakowski@example.com','371481271'),(73,'Wroclaw','Wittiga 74','Jan','Dudek','Jan51Dudek@tlen.pl','709125502'),(74,'Wroclaw','Mikolaja 66','Janina','Pawlak','Janina95Pawlak@wp.pl','880497702'),(75,'Wroclaw','Kromera 14','Jadwiga','Nowakowski','Jadwiga92Nowakowski@op.pl','870593939'),(76,'Brzeg Dolny','Pilsudskiego 79','Janina','Kaczmarek','Janina88Kaczmarek@tlen.pl','806146370'),(77,'Brzeg Dolny','Wroblewskiego 40','Malgorzata','Stepien','Malgorzata10Stepien@gmail.com','747176035'),(78,'Wroclaw','Kazimierza Wielkiego 4','Jadwiga','Kowalczyk','Jadwiga49Kowalczyk@example.com','423684353'),(79,'Wroclaw','Wittiga 85','Teresa','Kaczmarek','Teresa100Kaczmarek@example.com','448737099'),(80,'Wroclaw','Wroblewskiego 98','Józef','Grabowski','Józef85Grabowski@example.com','512334279'),(81,'Wroclaw','Olszewskiego 42','Marek','Wisnoiewski','Marek26Wisnoiewski@tlen.pl','483565402'),(82,'Wroclaw','Poprzeczna 38','Krystyna','Nowak','Krystyna22Nowak@wp.pl','622572336'),(83,'Wroclaw','Pilsudskiego 58','Danuta','Walczak','Danuta68Walczak@tlen.pl','377061235'),(84,'Wroclaw','Pilsudskiego 67','Ewa','Krol','Ewa25Krol@wp.pl','262215418'),(85,'Wroclaw','Glowna 8','Irena','Wieczorek','Irena36Wieczorek@wp.pl','984938966'),(86,'Opole','Wittiga 2','Zbigniew','Dudek','Zbigniew88Dudek@op.pl','538373999'),(87,'Wroclaw','Osiedlowa 82','Tadeusz','Wozniak','Tadeusz78Wozniak@example.com','695272847'),(88,'Wroclaw','Glowna 26','Anna','Krol','Anna98Krol@wp.pl','318383159'),(89,'Wroclaw','Olszewskiego 4','Marianna','Kowalczyk','Marianna5Kowalczyk@wp.pl','861908915'),(90,'Wroclaw','Kazimierza Wielkiego 85','Mieczyslaw','Grabowski','Mieczyslaw11Grabowski@tlen.pl','703565952'),(91,'Wroclaw','Wyspianskiego 57','Janusz','Dudek','Janusz41Dudek@mail.com','883472316'),(92,'Brzeg Dolny','Krzywoustego 21','Adam','Walczak','Adam53Walczak@wp.pl','980141843'),(93,'Wroclaw','Kosciuszki 24','Miroslaw','Szymanski','Miroslaw75Szymanski@tlen.pl','202725209'),(94,'Wroclaw','Wroblewskiego 84','Anna','Wozniak','Anna75Wozniak@example.com','155121589'),(95,'Bielany Wroclawskie','Osiedlowa 29','Kazimierz','Pawlak','Kazimierz38Pawlak@op.pl','214088771'),(96,'Wroclaw','Kazimierza Wielkiego 92','Józef','Wisnoiewski','Józef34Wisnoiewski@op.pl','406541175'),(97,'Opole','Poprzeczna 38','Jan','Wieczorek','Jan2Wieczorek@op.pl','641493544'),(98,'Brzeg Dolny','Krzywoustego 35','Ewa','Nowakowski','Ewa35Nowakowski@example.com','514057294'),(99,'Opole','Krzywoustego 70','Janusz','Krol','Janusz94Krol@gmail.com','728758686'),(100,'Wroclaw','Bacciarellego 1','Grazyna','Dudek','Grazyna55Dudek@mail.com','724190840'),(101,'Opole','Wroblewskiego 28','Marianna','Grabowski','Marianna87Grabowski@op.pl','441603402'),(102,'Wroclaw','Mikolaja 60','Zbigniew','Pawlak','Zbigniew86Pawlak@example.com','373702585');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_account`
--

DROP TABLE IF EXISTS `student_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `login` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_account_student_id_fk` (`student_id`),
  CONSTRAINT `student_account_student_id_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_account`
--

LOCK TABLES `student_account` WRITE;
/*!40000 ALTER TABLE `student_account` DISABLE KEYS */;
INSERT INTO `student_account` VALUES (1,1,'nowak1','FB2FE71D592FAD516F05549409DA8E35'),(2,3,'wozniak1','8906E145A9CB65DC3C8754E9A38DE3AA'),(3,4,'stepien1','856515A9874FE7CC83AE97AA65B5A538'),(4,5,'szymanski1','079DE726A885B89F6224603CA0E1AD2C'),(5,6,'zajac1','E2CBE643FCBCD3776E75D9F12C5B66E4'),(6,7,'nowakowski1','288841397B967091350F5087F494C1F2'),(7,8,'walczak1','1D64F413C7FC6F68CC5FB0B5F3A1032C'),(8,9,'nowakowski2','288841397B967091350F5087F494C1F2');
/*!40000 ALTER TABLE `student_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'Sebastian','Anonim','SebastianAnonim@dance.com','123456789'),(2,'Antonio','Walker','AntonioWalker@dance.com','742625340'),(3,'Agnes','Walker','AgnesWalker@dance.com','111222333'),(4,'Ronald','Rivest','RonaldRivest@dance.com','437813750'),(5,'Thomas','Corman','ThomasCorman@dance.com','761192756'),(6,'Richard','Feynman','RichardFeynman@dance.com','592522559'),(7,'Charles','Leiserson','CharlesLeiserson@dance.com','579034555'),(8,'Robert','Hooke','RobertHooke@dance.com','117605128'),(9,'James','Watt','JamesWatt@dance.com','550922004'),(10,'Felix','Saavart','FelixSaavart@dance.com','501794664'),(11,'Sandra','Faber','SandraFaber@dance.com','756207335'),(12,'Rosalind','Fraklin','RosalindFraklin@dance.com','375652711'),(13,'Heady','Lamarr','HeadyLamarr@dance.com','409641577'),(14,'Lene','Lamarr','LeneLamarr@dance.com','821249781'),(15,'Grace','Hopper','GraceHopper@dance.com','977324203');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_account`
--

DROP TABLE IF EXISTS `teacher_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) NOT NULL,
  `login` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `teacher_account_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_account`
--

LOCK TABLES `teacher_account` WRITE;
/*!40000 ALTER TABLE `teacher_account` DISABLE KEYS */;
INSERT INTO `teacher_account` VALUES (1,1,'anonim1','69E74C0A6BF4DE0393742E137679624E'),(2,2,'walker1','770621A93818C6788EF8B8907D57BF1B'),(3,3,'walker2','770621A93818C6788EF8B8907D57BF1B'),(4,4,'rivest1','EB9EBFF34535B975EDE83429AAAAEFD7'),(5,5,'corman1','65DC3AF650130404D7E66E9E29BD1E15'),(6,6,'feynman1','CF5BA382828450B94970664B01471F72');
/*!40000 ALTER TABLE `teacher_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'Bachata'),(2,'Salsa cubana'),(3,'Kizomba'),(4,'Uzytkowy'),(5,'Salsa liniowa'),(6,'Tango'),(7,'Zouk'),(8,'Taniec towarzyski');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekday`
--

DROP TABLE IF EXISTS `weekday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekday`
--

LOCK TABLES `weekday` WRITE;
/*!40000 ALTER TABLE `weekday` DISABLE KEYS */;
INSERT INTO `weekday` VALUES (1,'Poniedzialek'),(2,'Wtorek'),(3,'Sroda'),(4,'Czwartek'),(5,'Piatek'),(6,'Sobota'),(7,'Niedziela');
/*!40000 ALTER TABLE `weekday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `show_available_classes`
--

/*!50001 DROP TABLE IF EXISTS `show_available_classes`*/;
/*!50001 DROP VIEW IF EXISTS `show_available_classes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_available_classes` AS select `c`.`id` AS `id`,`c`.`name` AS `name`,`c`.`start_date` AS `start_date`,`c`.`end_date` AS `end_date`,`c`.`price` AS `price`,`t`.`id` AS `teacher_id`,`t`.`first_name` AS `first_name`,`t`.`last_name` AS `last_name`,`w`.`name` AS `day`,`cw`.`hours` AS `hours`,`l`.`sign` AS `level`,count(`cs`.`student_id`) AS `n`,`c`.`max_participants` AS `max_participants` from ((((((`class` `c` join `class_student` `cs` on((`c`.`id` = `cs`.`class_id`))) join `teacher` `t` on((`c`.`teacher_id` = `t`.`id`))) join `class_weekday` `cw` on((`c`.`id` = `cw`.`class_id`))) join `weekday` `w` on((`cw`.`weekday_id` = `w`.`id`))) join `course` `c2` on((`c`.`course_id` = `c2`.`id`))) join `level` `l` on((`c2`.`level` = `l`.`id`))) group by `cs`.`class_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_student_classes`
--

/*!50001 DROP TABLE IF EXISTS `show_student_classes`*/;
/*!50001 DROP VIEW IF EXISTS `show_student_classes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_student_classes` AS select `cs`.`student_id` AS `student_id`,`c`.`id` AS `id`,`c`.`name` AS `name`,`c`.`start_date` AS `start_date`,`c`.`end_date` AS `end_date`,`c`.`price` AS `price`,`teacher`.`first_name` AS `first_name`,`teacher`.`last_name` AS `last_name`,`w`.`name` AS `day`,`cw`.`hours` AS `hours` from ((((`class_student` `cs` join `class` `c` on((`c`.`id` = `cs`.`class_id`))) join `teacher` on((`c`.`teacher_id` = `teacher`.`id`))) join `class_weekday` `cw` on((`c`.`id` = `cw`.`class_id`))) join `weekday` `w` on((`cw`.`weekday_id` = `w`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_student_classes2`
--

/*!50001 DROP TABLE IF EXISTS `show_student_classes2`*/;
/*!50001 DROP VIEW IF EXISTS `show_student_classes2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_student_classes2` AS select `cs`.`student_id` AS `student_id`,`c`.`id` AS `id`,`c`.`name` AS `name`,`c`.`start_date` AS `start_date`,`c`.`end_date` AS `end_date`,`c`.`price` AS `price`,`teacher`.`first_name` AS `first_name`,`teacher`.`last_name` AS `last_name`,`w`.`name` AS `day`,`cw`.`hours` AS `hours`,`c`.`max_participants` AS `max_participants` from ((((`class_student` `cs` join `class` `c` on((`c`.`id` = `cs`.`class_id`))) join `teacher` on((`c`.`teacher_id` = `teacher`.`id`))) join `class_weekday` `cw` on((`c`.`id` = `cw`.`class_id`))) join `weekday` `w` on((`cw`.`weekday_id` = `w`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_students_in_class`
--

/*!50001 DROP TABLE IF EXISTS `show_students_in_class`*/;
/*!50001 DROP VIEW IF EXISTS `show_students_in_class`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_students_in_class` AS select `class_student`.`class_id` AS `class_id`,`class_student`.`student_id` AS `student_id`,`s`.`first_name` AS `first_name`,`s`.`last_name` AS `last_name`,`s`.`phone` AS `phone` from (`class_student` join `student` `s` on((`class_student`.`student_id` = `s`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12 18:59:27
