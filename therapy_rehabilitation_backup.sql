-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: therapy_rehabilitation
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.22.04.4

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
-- Temporary view structure for view `appointment_details`
--

DROP TABLE IF EXISTS `appointment_details`;
/*!50001 DROP VIEW IF EXISTS `appointment_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `appointment_details` AS SELECT 
 1 AS `appointment_id`,
 1 AS `patient_name`,
 1 AS `therapist_name`,
 1 AS `appointment_date`,
 1 AS `appointment_time`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `therapist_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` varchar(20) DEFAULT 'Scheduled',
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `fk_appointment_patient` (`patient_id`),
  KEY `fk_appointment_therapist` (`therapist_id`),
  CONSTRAINT `fk_appointment_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `fk_appointment_therapist` FOREIGN KEY (`therapist_id`) REFERENCES `therapists` (`therapist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,1,1,'2026-09-01','10:00:00','Completed','Post knee surgery rehabilitation'),(2,2,2,'2026-09-02','11:00:00','Completed','Stroke recovery rehabilitation'),(3,3,3,'2026-09-03','09:30:00','Completed','Sports injury rehabilitation'),(4,4,1,'2026-09-05','14:00:00','Completed','Knee pain and mobility improvement'),(5,5,4,'2026-09-07','15:30:00','Completed','Balance and mobility training'),(6,6,2,'2026-09-10','10:30:00','Completed','Neurological rehabilitation'),(7,7,3,'2026-09-12','16:00:00','Scheduled','Shoulder rehabilitation'),(8,8,4,'2026-09-15','11:30:00','Scheduled','Age-related mobility improvement'),(9,1,1,'2026-09-18','10:00:00','Completed','Follow-up rehabilitation session'),(10,3,3,'2026-09-20','09:30:00','Cancelled','Sports injury follow-up'),(11,4,1,'2026-09-22','14:00:00','Scheduled','Knee mobility assessment'),(12,6,2,'2026-09-25','10:30:00','Scheduled','Progress evaluation');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validate_appointment_status` BEFORE INSERT ON `appointments` FOR EACH ROW BEGIN
    IF NEW.status IS NOT NULL
       AND NEW.status NOT IN ('Scheduled', 'Completed', 'Cancelled') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid appointment status';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bill_items`
--

DROP TABLE IF EXISTS `bill_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_items` (
  `bill_item_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `session_id` int DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`bill_item_id`),
  KEY `fk_bill_item_bill` (`bill_id`),
  KEY `fk_bill_item_session` (`session_id`),
  CONSTRAINT `fk_bill_item_bill` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`),
  CONSTRAINT `fk_bill_item_session` FOREIGN KEY (`session_id`) REFERENCES `therapy_sessions` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_items`
--

LOCK TABLES `bill_items` WRITE;
/*!40000 ALTER TABLE `bill_items` DISABLE KEYS */;
INSERT INTO `bill_items` VALUES (1,1,1,'Physiotherapy session',1,800.00),(2,1,NULL,'Initial assessment',1,500.00),(3,2,2,'Neurological rehabilitation session',1,900.00),(4,2,NULL,'Clinical assessment',1,600.00),(5,3,3,'Sports rehabilitation session',1,850.00),(6,4,4,'Knee rehabilitation session',1,800.00),(7,4,NULL,'Treatment assessment',1,400.00),(8,5,5,'Geriatric physiotherapy session',1,750.00),(9,5,NULL,'Balance assessment',1,350.00),(10,6,7,'Follow-up physiotherapy session',1,800.00),(11,6,NULL,'Progress assessment',1,300.00);
/*!40000 ALTER TABLE `bill_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `bill_summary`
--

DROP TABLE IF EXISTS `bill_summary`;
/*!50001 DROP VIEW IF EXISTS `bill_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bill_summary` AS SELECT 
 1 AS `bill_id`,
 1 AS `patient_name`,
 1 AS `bill_date`,
 1 AS `status`,
 1 AS `payment_method`,
 1 AS `bill_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `bill_date` date NOT NULL,
  `status` varchar(20) DEFAULT 'Unpaid',
  `payment_method` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `fk_bill_patient` (`patient_id`),
  CONSTRAINT `fk_bill_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,1,'2026-09-01','Paid','UPI'),(2,2,'2026-09-02','Paid','Credit Card'),(3,3,'2026-09-03','Paid','Cash'),(4,4,'2026-09-05','Unpaid',NULL),(5,5,'2026-09-07','Paid','Debit Card'),(6,1,'2026-09-18','Unpaid',NULL);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercises` (
  `exercise_id` int NOT NULL AUTO_INCREMENT,
  `exercise_name` varchar(100) NOT NULL,
  `description` text,
  `category` varchar(50) DEFAULT NULL,
  `instructions` text,
  `difficulty_level` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`exercise_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercises`
--

LOCK TABLES `exercises` WRITE;
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` VALUES (1,'Knee Extension','Strengthens the quadriceps muscles.','Strength','Sit upright and slowly extend the knee until the leg is straight.','Moderate'),(2,'Straight Leg Raise','Improves quadriceps strength and knee stability.','Strength','Lie flat and raise the straight leg slowly.','Easy'),(3,'Hamstring Stretch','Improves flexibility of the hamstring muscles.','Flexibility','Extend the leg and gently lean forward until a stretch is felt.','Easy'),(4,'Shoulder Flexion','Improves shoulder range of motion.','Mobility','Raise the arm forward slowly while maintaining good posture.','Easy'),(5,'Wall Push-Up','Strengthens the upper body with reduced joint load.','Strength','Place hands against the wall and perform controlled push-ups.','Easy'),(6,'Ankle Pumps','Improves ankle mobility and circulation.','Mobility','Move the ankle upward and downward repeatedly.','Easy'),(7,'Heel Raises','Strengthens calf muscles and improves balance.','Strength','Rise onto the toes and slowly lower the heels.','Moderate'),(8,'Hip Abduction','Strengthens the muscles around the hip.','Strength','Move the leg sideways while keeping the body upright.','Moderate'),(9,'Balance Stand','Improves static balance and postural control.','Balance','Stand upright while maintaining balance for the prescribed duration.','Moderate'),(10,'Bridging','Strengthens gluteal and lower back muscles.','Strength','Lie on the back and lift the pelvis while keeping the knees bent.','Moderate'),(11,'Neck Rotation','Improves cervical mobility.','Mobility','Slowly rotate the head from side to side within a comfortable range.','Easy'),(12,'Stationary Cycling','Improves lower-limb endurance and cardiovascular fitness.','Endurance','Cycle at a controlled pace for the prescribed duration.','Moderate');
/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `medical_record_details`
--

DROP TABLE IF EXISTS `medical_record_details`;
/*!50001 DROP VIEW IF EXISTS `medical_record_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `medical_record_details` AS SELECT 
 1 AS `record_id`,
 1 AS `patient_id`,
 1 AS `patient_name`,
 1 AS `record_date`,
 1 AS `diagnosis`,
 1 AS `injury_type`,
 1 AS `treatment_history`,
 1 AS `allergies`,
 1 AS `notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `medical_records`
--

DROP TABLE IF EXISTS `medical_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_records` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `diagnosis` varchar(255) DEFAULT NULL,
  `injury_type` varchar(100) DEFAULT NULL,
  `treatment_history` text,
  `allergies` text,
  `notes` text,
  `record_date` date NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `fk_medical_record_patient` (`patient_id`),
  CONSTRAINT `fk_medical_record_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_records`
--

LOCK TABLES `medical_records` WRITE;
/*!40000 ALTER TABLE `medical_records` DISABLE KEYS */;
INSERT INTO `medical_records` VALUES (1,1,'Post-operative knee rehabilitation','Knee injury','ACL reconstruction followed by physiotherapy','No known allergies','Initial rehabilitation assessment completed.','2026-09-01'),(2,2,'Post-stroke mobility impairment','Neurological condition','Ongoing neurological rehabilitation','Penicillin allergy','Requires assistance during balance exercises.','2026-09-02'),(3,3,'Sports-related lower limb injury','Muscle strain','Rest, strengthening and progressive mobility exercises','No known allergies','Good response to strengthening program.','2026-09-03'),(4,4,'Chronic knee pain','Knee injury','Physiotherapy and strengthening exercises','Dust allergy','Pain increases after prolonged activity.','2026-09-05'),(5,5,'Age-related mobility impairment','Mobility disorder','Balance training and lower-limb strengthening','No known allergies','Fall-risk assessment recommended.','2026-09-07'),(6,6,'Neurological mobility impairment','Neurological condition','Neurological physiotherapy and coordination training','No known allergies','Gradual improvement in functional mobility.','2026-09-10');
/*!40000 ALTER TABLE `medical_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `patient_progress_history`
--

DROP TABLE IF EXISTS `patient_progress_history`;
/*!50001 DROP VIEW IF EXISTS `patient_progress_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_progress_history` AS SELECT 
 1 AS `progress_id`,
 1 AS `patient_name`,
 1 AS `session_id`,
 1 AS `session_date`,
 1 AS `progress_date`,
 1 AS `pain_level`,
 1 AS `range_of_motion`,
 1 AS `strength_score`,
 1 AS `notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `emergency_contact` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Rahul','Sharma','1998-04-12','Male','9876543210','rahul.sharma@example.com','Jaipur, Rajasthan','Suresh Sharma - 9876500001'),(2,'Ananya','Verma','2001-09-25','Female','9876543211','ananya.verma@example.com','Jaipur, Rajasthan','Priya Verma - 9876500002'),(3,'Arjun','Mehta','1995-02-18','Male','9876543212','arjun.mehta@example.com','Ajmer, Rajasthan','Rajesh Mehta - 9876500003'),(4,'Sneha','Patel','1999-11-03','Female','9876543213','sneha.patel@example.com','Kota, Rajasthan','Neha Patel - 9876500004'),(5,'Vikram','Singh','1988-07-29','Male','9876543214','vikram.singh@example.com','Jaipur, Rajasthan','Amit Singh - 9876500005'),(6,'Kavya','Joshi','2003-01-15','Female','9876543215','kavya.joshi@example.com','Udaipur, Rajasthan','Ritu Joshi - 9876500006'),(7,'Rohan','Gupta','1992-06-21','Male','9876543216','rohan.gupta@example.com','Jaipur, Rajasthan','Manoj Gupta - 9876500007'),(8,'Meera','Kapoor','1985-12-10','Female','9876543217','meera.kapoor@example.com','Jodhpur, Rajasthan','Sunita Kapoor - 9876500008');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progress_records`
--

DROP TABLE IF EXISTS `progress_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progress_records` (
  `progress_id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `progress_date` date NOT NULL,
  `pain_level` int DEFAULT NULL,
  `range_of_motion` varchar(100) DEFAULT NULL,
  `strength_score` decimal(5,2) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`progress_id`),
  KEY `fk_progress_session` (`session_id`),
  CONSTRAINT `fk_progress_session` FOREIGN KEY (`session_id`) REFERENCES `therapy_sessions` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progress_records`
--

LOCK TABLES `progress_records` WRITE;
/*!40000 ALTER TABLE `progress_records` DISABLE KEYS */;
INSERT INTO `progress_records` VALUES (1,1,'2026-09-01',6,'85 degrees knee flexion',5.50,'Initial session. Limited knee movement and moderate pain.'),(2,2,'2026-09-02',7,'Limited shoulder and lower-limb control',4.50,'Balance remains reduced. Patient requires supervision.'),(3,3,'2026-09-03',4,'110 degrees knee flexion',7.00,'Good tolerance to strengthening exercises.'),(4,4,'2026-09-05',5,'100 degrees knee flexion',6.50,'Mobility improving with reduced stiffness.'),(5,5,'2026-09-07',3,'Functional standing balance improved',7.00,'Patient able to maintain balance for longer duration.'),(6,6,'2026-09-10',5,'Improved functional mobility',6.00,'Coordination improving gradually.'),(7,7,'2026-09-18',3,'125 degrees knee flexion',8.00,'Significant improvement compared with initial session.');
/*!40000 ALTER TABLE `progress_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validate_pain_level` BEFORE INSERT ON `progress_records` FOR EACH ROW BEGIN
    IF NEW.pain_level IS NOT NULL
       AND (NEW.pain_level < 0 OR NEW.pain_level > 10) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pain level must be between 0 and 10';
    END IF;

    IF NEW.strength_score IS NOT NULL
       AND (NEW.strength_score < 0 OR NEW.strength_score > 10) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Strength score must be between 0 and 10';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `session_exercise_details`
--

DROP TABLE IF EXISTS `session_exercise_details`;
/*!50001 DROP VIEW IF EXISTS `session_exercise_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `session_exercise_details` AS SELECT 
 1 AS `session_exercise_id`,
 1 AS `patient_name`,
 1 AS `session_id`,
 1 AS `session_date`,
 1 AS `exercise_name`,
 1 AS `category`,
 1 AS `sets`,
 1 AS `repetitions`,
 1 AS `duration_minutes`,
 1 AS `notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `session_exercises`
--

DROP TABLE IF EXISTS `session_exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_exercises` (
  `session_exercise_id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `exercise_id` int NOT NULL,
  `sets` int DEFAULT NULL,
  `repetitions` int DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`session_exercise_id`),
  KEY `fk_session_exercise_session` (`session_id`),
  KEY `fk_session_exercise_exercise` (`exercise_id`),
  CONSTRAINT `fk_session_exercise_exercise` FOREIGN KEY (`exercise_id`) REFERENCES `exercises` (`exercise_id`),
  CONSTRAINT `fk_session_exercise_session` FOREIGN KEY (`session_id`) REFERENCES `therapy_sessions` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_exercises`
--

LOCK TABLES `session_exercises` WRITE;
/*!40000 ALTER TABLE `session_exercises` DISABLE KEYS */;
INSERT INTO `session_exercises` VALUES (1,1,1,3,12,NULL,'Controlled knee extension with gradual resistance'),(2,1,2,3,10,NULL,'Performed with minimal assistance'),(3,1,3,2,5,NULL,'Gentle stretch within comfortable range'),(4,2,9,3,NULL,5,'Balance training with therapist supervision'),(5,2,8,3,10,NULL,'Hip strengthening exercise'),(6,2,7,3,12,NULL,'Supported heel raises'),(7,3,7,4,12,NULL,'Calf strengthening for sports recovery'),(8,3,8,3,12,NULL,'Hip strengthening'),(9,3,10,3,15,NULL,'Gluteal strengthening'),(10,4,1,3,15,NULL,'Knee strengthening'),(11,4,2,3,12,NULL,'Quadriceps activation'),(12,4,3,3,5,NULL,'Hamstring flexibility'),(13,5,9,4,NULL,5,'Static balance training'),(14,5,7,3,10,NULL,'Lower-limb strengthening'),(15,5,6,3,20,NULL,'Ankle mobility'),(16,6,5,3,10,NULL,'Upper-body strengthening'),(17,6,11,3,8,NULL,'Controlled neck mobility'),(18,6,9,3,NULL,5,'Balance exercise with supervision'),(19,7,1,3,15,NULL,'Progressive knee strengthening'),(20,7,2,3,15,NULL,'Straight leg raises'),(21,7,3,3,5,NULL,'Improved flexibility compared with initial session');
/*!40000 ALTER TABLE `session_exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `therapists`
--

DROP TABLE IF EXISTS `therapists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapists` (
  `therapist_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `qualification` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`therapist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `therapists`
--

LOCK TABLES `therapists` WRITE;
/*!40000 ALTER TABLE `therapists` DISABLE KEYS */;
INSERT INTO `therapists` VALUES (1,'Amit','Kumar','Orthopedic Physiotherapy','MPT Orthopedics','9811111111','amit.kumar@example.com'),(2,'Neha','Sharma','Neurological Rehabilitation','MPT Neurology','9822222222','neha.sharma@example.com'),(3,'Ravi','Malhotra','Sports Rehabilitation','MPT Sports','9833333333','ravi.malhotra@example.com'),(4,'Pooja','Iyer','Geriatric Physiotherapy','MPT Geriatrics','9844444444','pooja.iyer@example.com');
/*!40000 ALTER TABLE `therapists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `therapy_plan_details`
--

DROP TABLE IF EXISTS `therapy_plan_details`;
/*!50001 DROP VIEW IF EXISTS `therapy_plan_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `therapy_plan_details` AS SELECT 
 1 AS `plan_id`,
 1 AS `patient_name`,
 1 AS `therapist_name`,
 1 AS `start_date`,
 1 AS `end_date`,
 1 AS `goals`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `therapy_plans`
--

DROP TABLE IF EXISTS `therapy_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapy_plans` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `therapist_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `goals` text,
  `status` varchar(20) DEFAULT 'Active',
  `notes` text,
  PRIMARY KEY (`plan_id`),
  KEY `fk_plan_patient` (`patient_id`),
  KEY `fk_plan_therapist` (`therapist_id`),
  CONSTRAINT `fk_plan_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `fk_plan_therapist` FOREIGN KEY (`therapist_id`) REFERENCES `therapists` (`therapist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `therapy_plans`
--

LOCK TABLES `therapy_plans` WRITE;
/*!40000 ALTER TABLE `therapy_plans` DISABLE KEYS */;
INSERT INTO `therapy_plans` VALUES (1,1,1,'2026-09-01','2026-10-15','Restore knee strength and mobility after surgery','Active','Focus on gradual strengthening and range of motion'),(2,2,2,'2026-09-02','2026-11-01','Improve balance, coordination and functional movement','Active','Neurological rehabilitation program'),(3,3,3,'2026-09-03','2026-10-03','Return to sports activity after lower-limb injury','Completed','Progressive strengthening and mobility exercises'),(4,4,1,'2026-09-05','2026-10-20','Reduce knee pain and improve functional mobility','Active','Monitor pain levels during strengthening exercises'),(5,5,4,'2026-09-07','2026-10-07','Improve balance and independence in daily activities','Completed','Balance and lower-limb strengthening program'),(6,6,2,'2026-09-10','2026-11-10','Improve mobility and functional strength','Active','Neurological rehabilitation with regular progress assessment');
/*!40000 ALTER TABLE `therapy_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `therapy_sessions`
--

DROP TABLE IF EXISTS `therapy_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapy_sessions` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  `plan_id` int NOT NULL,
  `session_date` date NOT NULL,
  `duration_minutes` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `uq_session_appointment` (`appointment_id`),
  KEY `fk_session_plan` (`plan_id`),
  CONSTRAINT `fk_session_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`),
  CONSTRAINT `fk_session_plan` FOREIGN KEY (`plan_id`) REFERENCES `therapy_plans` (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `therapy_sessions`
--

LOCK TABLES `therapy_sessions` WRITE;
/*!40000 ALTER TABLE `therapy_sessions` DISABLE KEYS */;
INSERT INTO `therapy_sessions` VALUES (1,1,1,'2026-09-01',60,'Initial post-surgery rehabilitation session. Mild pain observed.'),(2,2,2,'2026-09-02',55,'Balance and coordination exercises completed with assistance.'),(3,3,3,'2026-09-03',60,'Lower-limb strengthening exercises performed successfully.'),(4,4,4,'2026-09-05',50,'Knee mobility exercises completed. Pain reduced during session.'),(5,5,5,'2026-09-07',45,'Balance training and lower-limb strengthening completed.'),(6,6,6,'2026-09-10',55,'Mobility exercises completed. Patient showed improved coordination.'),(7,9,1,'2026-09-18',50,'Follow-up session. Improved knee mobility noted.');
/*!40000 ALTER TABLE `therapy_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'therapy_rehabilitation'
--

--
-- Dumping routines for database 'therapy_rehabilitation'
--
/*!50003 DROP FUNCTION IF EXISTS `CalculateBillTotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateBillTotal`(p_bill_id INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM bill_items
    WHERE bill_id = p_bill_id;

    RETURN v_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculatePatientBillingTotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculatePatientBillingTotal`(p_patient_id INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(bi.quantity * bi.unit_price), 0)
    INTO v_total
    FROM bills AS b
    LEFT JOIN bill_items AS bi
        ON b.bill_id = bi.bill_id
    WHERE b.patient_id = p_patient_id;

    RETURN v_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CountPatientProgressRecords` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CountPatientProgressRecords`(p_patient_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM progress_records AS pr
    JOIN therapy_sessions AS ts
        ON pr.session_id = ts.session_id
    JOIN appointments AS a
        ON ts.appointment_id = a.appointment_id
    WHERE a.patient_id = p_patient_id;

    RETURN v_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CountPatientSessions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CountPatientSessions`(p_patient_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM therapy_sessions AS ts
    JOIN appointments AS a
        ON ts.appointment_id = a.appointment_id
    WHERE a.patient_id = p_patient_id;

    RETURN v_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CountTherapistAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CountTherapistAppointments`(p_therapist_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM appointments
    WHERE therapist_id = p_therapist_id;

    RETURN v_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientAppointments`(IN p_patient_id INT)
BEGIN
    SELECT
        appointment_id,
        appointment_date,
        appointment_time,
        status,
        reason
    FROM appointments
    WHERE patient_id = p_patient_id
    ORDER BY appointment_date, appointment_time;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientBillingTotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientBillingTotal`(IN p_patient_id INT)
BEGIN
    SELECT
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        COALESCE(SUM(bi.quantity * bi.unit_price), 0) AS total_billed
    FROM patients AS p
    LEFT JOIN bills AS b
        ON p.patient_id = b.patient_id
    LEFT JOIN bill_items AS bi
        ON b.bill_id = bi.bill_id
    WHERE p.patient_id = p_patient_id
    GROUP BY p.patient_id, p.first_name, p.last_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientProgressHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientProgressHistory`(
    IN p_patient_id INT
)
BEGIN
    SELECT
        pr.progress_id,
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        ts.session_id,
        pr.progress_date,
        pr.pain_level,
        pr.range_of_motion,
        pr.strength_score,
        pr.notes
    FROM patients AS p
    JOIN appointments AS a
        ON p.patient_id = a.patient_id
    JOIN therapy_sessions AS ts
        ON a.appointment_id = ts.appointment_id
    JOIN progress_records AS pr
        ON ts.session_id = pr.session_id
    WHERE p.patient_id = p_patient_id
    ORDER BY pr.progress_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientTherapyPlans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientTherapyPlans`(IN p_patient_id INT)
BEGIN
    SELECT
        plan_id,
        start_date,
        end_date,
        goals,
        status,
        notes
    FROM therapy_plans
    WHERE patient_id = p_patient_id
    ORDER BY start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSessionExerciseDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSessionExerciseDetails`(
    IN p_session_id INT
)
BEGIN
    SELECT
        ts.session_id,
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        e.exercise_name,
        e.category,
        se.sets,
        se.repetitions,
        se.duration_minutes,
        se.notes
    FROM therapy_sessions AS ts
    JOIN appointments AS a
        ON ts.appointment_id = a.appointment_id
    JOIN patients AS p
        ON a.patient_id = p.patient_id
    JOIN session_exercises AS se
        ON ts.session_id = se.session_id
    JOIN exercises AS e
        ON se.exercise_id = e.exercise_id
    WHERE ts.session_id = p_session_id
    ORDER BY e.exercise_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTherapistAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTherapistAppointments`(IN p_therapist_id INT)
BEGIN
    SELECT
        a.appointment_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        a.appointment_date,
        a.appointment_time,
        a.status,
        a.reason
    FROM appointments AS a
    JOIN patients AS p
        ON a.patient_id = p.patient_id
    WHERE a.therapist_id = p_therapist_id
    ORDER BY a.appointment_date, a.appointment_time;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUnpaidBills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUnpaidBills`()
BEGIN
    SELECT
        b.bill_id,
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        b.bill_date,
        b.status,
        COALESCE(SUM(bi.quantity * bi.unit_price), 0) AS bill_total
    FROM bills AS b
    JOIN patients AS p
        ON b.patient_id = p.patient_id
    LEFT JOIN bill_items AS bi
        ON b.bill_id = bi.bill_id
    WHERE b.status = 'Unpaid'
    GROUP BY
        b.bill_id,
        p.patient_id,
        p.first_name,
        p.last_name,
        b.bill_date,
        b.status
    ORDER BY b.bill_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `appointment_details`
--

/*!50001 DROP VIEW IF EXISTS `appointment_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `appointment_details` AS select `a`.`appointment_id` AS `appointment_id`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `patient_name`,concat(`t`.`first_name`,' ',`t`.`last_name`) AS `therapist_name`,`a`.`appointment_date` AS `appointment_date`,`a`.`appointment_time` AS `appointment_time`,`a`.`status` AS `status` from ((`appointments` `a` join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) join `therapists` `t` on((`a`.`therapist_id` = `t`.`therapist_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bill_summary`
--

/*!50001 DROP VIEW IF EXISTS `bill_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bill_summary` AS select `b`.`bill_id` AS `bill_id`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `patient_name`,`b`.`bill_date` AS `bill_date`,`b`.`status` AS `status`,`b`.`payment_method` AS `payment_method`,coalesce(sum((`bi`.`quantity` * `bi`.`unit_price`)),0) AS `bill_total` from ((`bills` `b` join `patients` `p` on((`b`.`patient_id` = `p`.`patient_id`))) left join `bill_items` `bi` on((`b`.`bill_id` = `bi`.`bill_id`))) group by `b`.`bill_id`,`p`.`first_name`,`p`.`last_name`,`b`.`bill_date`,`b`.`status`,`b`.`payment_method` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `medical_record_details`
--

/*!50001 DROP VIEW IF EXISTS `medical_record_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `medical_record_details` AS select `mr`.`record_id` AS `record_id`,`p`.`patient_id` AS `patient_id`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `patient_name`,`mr`.`record_date` AS `record_date`,`mr`.`diagnosis` AS `diagnosis`,`mr`.`injury_type` AS `injury_type`,`mr`.`treatment_history` AS `treatment_history`,`mr`.`allergies` AS `allergies`,`mr`.`notes` AS `notes` from (`medical_records` `mr` join `patients` `p` on((`mr`.`patient_id` = `p`.`patient_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_progress_history`
--

/*!50001 DROP VIEW IF EXISTS `patient_progress_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_progress_history` AS select `pr`.`progress_id` AS `progress_id`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `patient_name`,`ts`.`session_id` AS `session_id`,`ts`.`session_date` AS `session_date`,`pr`.`progress_date` AS `progress_date`,`pr`.`pain_level` AS `pain_level`,`pr`.`range_of_motion` AS `range_of_motion`,`pr`.`strength_score` AS `strength_score`,`pr`.`notes` AS `notes` from (((`progress_records` `pr` join `therapy_sessions` `ts` on((`pr`.`session_id` = `ts`.`session_id`))) join `appointments` `a` on((`ts`.`appointment_id` = `a`.`appointment_id`))) join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `session_exercise_details`
--

/*!50001 DROP VIEW IF EXISTS `session_exercise_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `session_exercise_details` AS select `se`.`session_exercise_id` AS `session_exercise_id`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `patient_name`,`ts`.`session_id` AS `session_id`,`ts`.`session_date` AS `session_date`,`e`.`exercise_name` AS `exercise_name`,`e`.`category` AS `category`,`se`.`sets` AS `sets`,`se`.`repetitions` AS `repetitions`,`se`.`duration_minutes` AS `duration_minutes`,`se`.`notes` AS `notes` from ((((`session_exercises` `se` join `therapy_sessions` `ts` on((`se`.`session_id` = `ts`.`session_id`))) join `appointments` `a` on((`ts`.`appointment_id` = `a`.`appointment_id`))) join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) join `exercises` `e` on((`se`.`exercise_id` = `e`.`exercise_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `therapy_plan_details`
--

/*!50001 DROP VIEW IF EXISTS `therapy_plan_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `therapy_plan_details` AS select `tp`.`plan_id` AS `plan_id`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `patient_name`,concat(`t`.`first_name`,' ',`t`.`last_name`) AS `therapist_name`,`tp`.`start_date` AS `start_date`,`tp`.`end_date` AS `end_date`,`tp`.`goals` AS `goals`,`tp`.`status` AS `status` from ((`therapy_plans` `tp` join `patients` `p` on((`tp`.`patient_id` = `p`.`patient_id`))) join `therapists` `t` on((`tp`.`therapist_id` = `t`.`therapist_id`))) */;
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

-- Dump completed on 2026-10-15 23:45:48
