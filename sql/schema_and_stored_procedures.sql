-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: transactions
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Current Database: `transactions`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `transactions` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `transactions`;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `acct_num` varchar(30) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT '0',
  `locked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `acct_num` (`acct_num`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_cards`
--

DROP TABLE IF EXISTS `credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_cards` (
  `card_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `cc_num` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`card_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `credit_cards_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_addresses`
--

DROP TABLE IF EXISTS `customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `customer_id` (`customer_id`),
  KEY `zip` (`zip`),
  CONSTRAINT `customer_addresses_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `customer_addresses_ibfk_2` FOREIGN KEY (`zip`) REFERENCES `zip_codes` (`zip`)
) ENGINE=InnoDB AUTO_INCREMENT=2401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_behavior_daily`
--

DROP TABLE IF EXISTS `customer_behavior_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_behavior_daily` (
  `customer_id` int NOT NULL,
  `trans_date` date NOT NULL,
  `customer_num_trans_1_day` int DEFAULT NULL,
  `customer_avg_amount_1_day` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`trans_date`),
  CONSTRAINT `customer_behavior_daily_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_behavior_monthly`
--

DROP TABLE IF EXISTS `customer_behavior_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_behavior_monthly` (
  `customer_id` int NOT NULL,
  `month_start_date` date NOT NULL,
  `customer_num_trans_30_day` int DEFAULT NULL,
  `customer_avg_amount_30_day` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`month_start_date`),
  CONSTRAINT `customer_behavior_monthly_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_behavior_weekly`
--

DROP TABLE IF EXISTS `customer_behavior_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_behavior_weekly` (
  `customer_id` int NOT NULL,
  `week_start_date` date NOT NULL,
  `customer_num_trans_7_day` int DEFAULT NULL,
  `customer_avg_amount_7_day` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`week_start_date`),
  KEY `idx_cbw_customer_week` (`customer_id`,`week_start_date`),
  CONSTRAINT `customer_behavior_weekly_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_jobs`
--

DROP TABLE IF EXISTS `customer_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_jobs` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_jobs_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `ssn` varchar(15) DEFAULT NULL,
  `first` varchar(50) DEFAULT NULL,
  `last` varchar(50) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profile` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `ssn` (`ssn`)
) ENGINE=InnoDB AUTO_INCREMENT=2403 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fraud_investigations`
--

DROP TABLE IF EXISTS `fraud_investigations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fraud_investigations` (
  `investigation_id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `merchant_id` int DEFAULT NULL,
  `status` enum('pending','under review','closed - fraud confirmed','closed - not fraud') NOT NULL DEFAULT 'pending',
  `created_at` datetime DEFAULT NULL,
  `investigation_start_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `investigation_end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`investigation_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `fraud_investigations_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_behavior_daily`
--

DROP TABLE IF EXISTS `merchant_behavior_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_behavior_daily` (
  `merchant_id` int NOT NULL,
  `trans_date` date NOT NULL,
  `merchant_num_trans_1_day` decimal(15,2) DEFAULT NULL,
  `merchant_risk_1_day` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`merchant_id`,`trans_date`),
  CONSTRAINT `merchant_behavior_daily_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_behavior_monthly`
--

DROP TABLE IF EXISTS `merchant_behavior_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_behavior_monthly` (
  `merchant_id` int NOT NULL,
  `month_start_date` date NOT NULL,
  `merchant_num_trans_30_day` decimal(15,2) DEFAULT NULL,
  `merchant_risk_30_day` decimal(15,4) DEFAULT NULL,
  `merchant_risk_90_day` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`merchant_id`,`month_start_date`),
  CONSTRAINT `merchant_behavior_monthly_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_behavior_weekly`
--

DROP TABLE IF EXISTS `merchant_behavior_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_behavior_weekly` (
  `merchant_id` int NOT NULL,
  `week_start_date` date NOT NULL,
  `merchant_num_trans_7_day` decimal(15,2) DEFAULT NULL,
  `merchant_risk_7_day` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`merchant_id`,`week_start_date`),
  CONSTRAINT `merchant_behavior_weekly_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchants`
--

DROP TABLE IF EXISTS `merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchants` (
  `merchant_id` int NOT NULL AUTO_INCREMENT,
  `merchant` varchar(100) DEFAULT NULL,
  `merch_lat` decimal(10,6) DEFAULT NULL,
  `merch_long` decimal(10,6) DEFAULT NULL,
  `location` point NOT NULL /*!80003 SRID 4326 */,
  PRIMARY KEY (`merchant_id`),
  UNIQUE KEY `merchant` (`merchant`),
  SPATIAL KEY `idx_location` (`location`)
) ENGINE=InnoDB AUTO_INCREMENT=694 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `suspicious_transactions_by_customer`
--

DROP TABLE IF EXISTS `suspicious_transactions_by_customer`;
/*!50001 DROP VIEW IF EXISTS `suspicious_transactions_by_customer`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `suspicious_transactions_by_customer` AS SELECT 
 1 AS `customer_id`,
 1 AS `first`,
 1 AS `last`,
 1 AS `transaction_id`,
 1 AS `trans_date`,
 1 AS `trans_time`,
 1 AS `amt`,
 1 AS `suspicious_reason`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `suspicious_transactions_by_merchant`
--

DROP TABLE IF EXISTS `suspicious_transactions_by_merchant`;
/*!50001 DROP VIEW IF EXISTS `suspicious_transactions_by_merchant`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `suspicious_transactions_by_merchant` AS SELECT 
 1 AS `merchant_id`,
 1 AS `merchant_name`,
 1 AS `transaction_id`,
 1 AS `trans_date`,
 1 AS `trans_time`,
 1 AS `amt`,
 1 AS `suspicious_reason`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transaction_logs`
--

DROP TABLE IF EXISTS `transaction_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `action_type` varchar(50) DEFAULT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `performed_by` varchar(100) DEFAULT NULL,
  `action_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`log_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `transaction_logs_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_time_features`
--

DROP TABLE IF EXISTS `transaction_time_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_time_features` (
  `transaction_id` int NOT NULL,
  `trans_date` date NOT NULL,
  `trans_time_secs` int DEFAULT NULL,
  `trans_time_hrs` tinyint DEFAULT NULL,
  `trans_time_is_night` tinyint(1) DEFAULT NULL,
  `trans_time_day` varchar(15) DEFAULT NULL,
  `trans_date_is_weekend` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`,`trans_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY RANGE (((year(`trans_date`) * 100) + month(`trans_date`)))
(PARTITION p202201 VALUES LESS THAN (202202) ENGINE = InnoDB,
 PARTITION p202202 VALUES LESS THAN (202203) ENGINE = InnoDB,
 PARTITION p202203 VALUES LESS THAN (202204) ENGINE = InnoDB,
 PARTITION p202204 VALUES LESS THAN (202205) ENGINE = InnoDB,
 PARTITION p202205 VALUES LESS THAN (202206) ENGINE = InnoDB,
 PARTITION p202206 VALUES LESS THAN (202207) ENGINE = InnoDB,
 PARTITION p202207 VALUES LESS THAN (202208) ENGINE = InnoDB,
 PARTITION p202208 VALUES LESS THAN (202209) ENGINE = InnoDB,
 PARTITION p202209 VALUES LESS THAN (202210) ENGINE = InnoDB,
 PARTITION p202210 VALUES LESS THAN (202211) ENGINE = InnoDB,
 PARTITION p202211 VALUES LESS THAN (202212) ENGINE = InnoDB,
 PARTITION p202212 VALUES LESS THAN (202213) ENGINE = InnoDB,
 PARTITION p202301 VALUES LESS THAN (202302) ENGINE = InnoDB,
 PARTITION p202302 VALUES LESS THAN (202303) ENGINE = InnoDB,
 PARTITION p202303 VALUES LESS THAN (202304) ENGINE = InnoDB,
 PARTITION p202304 VALUES LESS THAN (202305) ENGINE = InnoDB,
 PARTITION p202305 VALUES LESS THAN (202306) ENGINE = InnoDB,
 PARTITION p202306 VALUES LESS THAN (202307) ENGINE = InnoDB,
 PARTITION p202307 VALUES LESS THAN (202308) ENGINE = InnoDB,
 PARTITION p202308 VALUES LESS THAN (202309) ENGINE = InnoDB,
 PARTITION p202309 VALUES LESS THAN (202310) ENGINE = InnoDB,
 PARTITION p202310 VALUES LESS THAN (202311) ENGINE = InnoDB,
 PARTITION p202311 VALUES LESS THAN (202312) ENGINE = InnoDB,
 PARTITION p202312 VALUES LESS THAN (202313) ENGINE = InnoDB,
 PARTITION pfuture VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_time_features_backup`
--

DROP TABLE IF EXISTS `transaction_time_features_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_time_features_backup` (
  `transaction_id` int NOT NULL,
  `trans_time_secs` int DEFAULT NULL,
  `trans_time_hrs` tinyint DEFAULT NULL,
  `trans_time_is_night` tinyint(1) DEFAULT NULL,
  `trans_time_day` varchar(15) DEFAULT NULL,
  `trans_date_is_weekend` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `trans_num` varchar(50) DEFAULT NULL,
  `trans_date` date DEFAULT NULL,
  `trans_time` time DEFAULT NULL,
  `unix_time` bigint DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `amt` decimal(15,2) DEFAULT NULL,
  `is_fraud` tinyint(1) DEFAULT NULL,
  `merchant_id` int DEFAULT NULL,
  `is_suspicious` tinyint(1) DEFAULT '0',
  `suspicious_reason` text,
  `confirmed_at` datetime DEFAULT NULL,
  `status` enum('normal','suspicious','confirmed','fraud') DEFAULT NULL,
  `processing_status` enum('pending','processing','completed','failed') DEFAULT 'pending',
  `processed_at` datetime DEFAULT NULL,
  `suspicious_at` datetime DEFAULT NULL,
  `fraud_resolved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `trans_num` (`trans_num`),
  KEY `account_id` (`account_id`),
  KEY `merchant_id` (`merchant_id`),
  KEY `idx_transactions_acc_merch` (`account_id`,`merchant_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2067286 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_log_transaction_status_update` AFTER UPDATE ON `transactions` FOR EACH ROW BEGIN
    IF NOT (OLD.status <=> NEW.status) THEN
        INSERT INTO transaction_logs (
            transaction_id,
            account_id,
            action_type,
            old_status,
            new_status,
            performed_by,
            notes
        )
        VALUES (
            NEW.transaction_id,
            NEW.account_id,
            'status-update',
            OLD.status,
            NEW.status,
            'system',
            CONCAT('Status changed from ', OLD.status, ' to ', NEW.status)
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zip_codes`
--

DROP TABLE IF EXISTS `zip_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zip_codes` (
  `zip` varchar(10) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `city_pop` int DEFAULT NULL,
  `lat` decimal(10,6) DEFAULT NULL,
  `long` decimal(10,6) DEFAULT NULL,
  `location` point NOT NULL /*!80003 SRID 4326 */,
  `population` int DEFAULT NULL,
  PRIMARY KEY (`zip`),
  SPATIAL KEY `idx_location` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'transactions'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `auto_block_event` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `auto_block_event` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-05-18 07:39:08' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    CALL auto_block_transactions();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `auto_block_unconfirmed_transactions` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `auto_block_unconfirmed_transactions` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-05-17 00:08:25' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Khai báo biến để lưu trữ thời điểm hiện tại
    DECLARE now DATETIME;
    SET now = NOW();

    -- Đánh dấu giao dịch là gian lận nếu quá 3 phút không xác nhận
    UPDATE transactions t
    SET
        t.is_fraud = 1,
        t.status = 'fraud',
        t.processed_at = now,
        t.processing_status = 'auto-blocked'
    WHERE
        t.is_suspicious = 1
        AND t.confirmed_at IS NULL
        AND TIMESTAMPDIFF(MINUTE, t.suspicious_at, now) >= 3;

    -- Chèn các bản ghi điều tra gian lận mới
    INSERT INTO fraud_investigations (transaction_id, account_id, merchant_id, status, created_at)
    SELECT
        t.transaction_id, t.account_id, t.merchant_id, 'pending', now
    FROM transactions t
    WHERE
        t.is_suspicious = 1
        AND t.confirmed_at IS NULL
        AND TIMESTAMPDIFF(MINUTE, t.suspicious_at, now) >= 3
        AND NOT EXISTS (
            SELECT 1
            FROM fraud_investigations fi
            WHERE fi.transaction_id = t.transaction_id
        );

    -- Ghi log giao dịch
    INSERT INTO transaction_logs (
        transaction_id, account_id, action_type, old_status,
        new_status, performed_by, notes, action_time
    )
    SELECT
        t.transaction_id, t.account_id, 'auto-block', 'suspicious',
        'fraud', 'system', 'Auto-blocked after 3 minutes without confirmation', now
    FROM transactions t
    WHERE
        t.is_suspicious = 1
        AND t.confirmed_at IS NULL
        AND TIMESTAMPDIFF(MINUTE, t.suspicious_at, now) >= 3;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `daily_update_customer_behavior` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `daily_update_customer_behavior` ON SCHEDULE EVERY 1 DAY STARTS '2025-05-18 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL update_customer_behavior() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'transactions'
--
/*!50003 DROP FUNCTION IF EXISTS `haversine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `haversine`(lat1 DOUBLE, lon1 DOUBLE, lat2 DOUBLE, lon2 DOUBLE) RETURNS double
    DETERMINISTIC
BEGIN
    DECLARE r INT DEFAULT 6371; -- bán kính trái đất km
    DECLARE dlat DOUBLE;
    DECLARE dlon DOUBLE;
    DECLARE a DOUBLE;
    DECLARE c DOUBLE;
    SET dlat = RADIANS(lat2 - lat1);
    SET dlon = RADIANS(lon2 - lon1);
    SET a = SIN(dlat/2) * SIN(dlat/2) + COS(RADIANS(lat1)) * COS(RADIANS(lat2)) * SIN(dlon/2) * SIN(dlon/2);
    SET c = 2 * ATAN2(SQRT(a), SQRT(1-a));
    RETURN r * c;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `haversine_km` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `haversine_km`(
    lat1 DOUBLE, lon1 DOUBLE,
    lat2 DOUBLE, lon2 DOUBLE
) RETURNS double
    DETERMINISTIC
BEGIN
    DECLARE r DOUBLE DEFAULT 6371; -- Bán kính Trái Đất (km)
    DECLARE dlat DOUBLE;
    DECLARE dlon DOUBLE;
    DECLARE a DOUBLE;

    SET dlat = RADIANS(lat2 - lat1);
    SET dlon = RADIANS(lon2 - lon1);

    SET a = SIN(dlat/2) * SIN(dlat/2) +
            COS(RADIANS(lat1)) * COS(RADIANS(lat2)) *
            SIN(dlon/2) * SIN(dlon/2);

    RETURN r * 2 * ATAN2(SQRT(a), SQRT(1 - a));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transaction_with_check` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_transaction_with_check`(
    IN in_customer_id INT, IN in_acct_num VARCHAR(30), IN in_merchant_id INT,
    IN in_trans_num VARCHAR(50), IN in_trans_date DATE, IN in_trans_time TIME,
    IN in_unix_time BIGINT, IN in_category VARCHAR(50), IN in_amt DECIMAL(15,2)
)
BEGIN
    DECLARE v_account_id INT;
    DECLARE v_customer_exists BOOL;
    DECLARE v_merchant_exists BOOL;
    DECLARE v_transaction_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Kiểm tra khách hàng
    SELECT EXISTS (
        SELECT 1 FROM customers WHERE customer_id = in_customer_id
    ) INTO v_customer_exists;
    IF NOT v_customer_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist. Transaction canceled.';
    END IF;

    -- Kiểm tra tài khoản
    SELECT account_id INTO v_account_id
    FROM accounts
    WHERE acct_num = in_acct_num AND customer_id = in_customer_id
    LIMIT 1
    FOR UPDATE;
    IF v_account_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account does not exist or does not belong to customer. Transaction canceled.';
    END IF;

    -- Kiểm tra merchant
    SELECT EXISTS (
        SELECT 1 FROM merchants WHERE merchant_id = in_merchant_id
    ) INTO v_merchant_exists;
    IF NOT v_merchant_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Merchant does not exist. Transaction canceled.';
    END IF;

    -- Thêm giao dịch
    INSERT INTO transactions (
        account_id, trans_num, trans_date, trans_time, unix_time,
        category, amt, is_fraud, merchant_id,
        status, processing_status, processed_at
    )
    VALUES (
        v_account_id, in_trans_num, in_trans_date, in_trans_time, in_unix_time,
        in_category, in_amt, NULL, in_merchant_id,
        'normal', 'pending', NULL
    );
    
    SET v_transaction_id = LAST_INSERT_ID();
    -- Gọi procedure cập nhật transaction_time_features
    CALL autoinsert_transaction_time_features(v_transaction_id);
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `autoinsert_transaction_time_features` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autoinsert_transaction_time_features`(
    IN in_transaction_id INT
)
BEGIN
    DECLARE v_trans_time TIME;
    DECLARE v_trans_date DATE;
    DECLARE is_night BOOLEAN;
    DECLARE is_weekend BOOLEAN;
    DECLARE trans_time_secs INT;
    DECLARE trans_time_hrs TINYINT;
    DECLARE trans_time_day VARCHAR(15);

    -- Lấy trans_time và trans_date từ bảng transactions
    SELECT trans_time, trans_date
    INTO v_trans_time, v_trans_date
    FROM transactions
    WHERE transaction_id = in_transaction_id;

    -- Tính toán đặc trưng thời gian
    SET is_night = (v_trans_time >= '22:00:00' OR v_trans_time < '06:00:00');
    SET is_weekend = (DAYOFWEEK(v_trans_date) = 1 OR DAYOFWEEK(v_trans_date) = 7);
    SET trans_time_secs = TIME_TO_SEC(v_trans_time);
    SET trans_time_hrs = HOUR(v_trans_time);
    SET trans_time_day = DAYNAME(v_trans_date);

    -- Insert hoặc update bảng transaction_time_features
    INSERT INTO transaction_time_features (
        transaction_id, trans_date, trans_time_secs, trans_time_hrs,
        trans_time_is_night, trans_time_day, trans_date_is_weekend
    )
    VALUES (
        in_transaction_id, v_trans_date, trans_time_secs, trans_time_hrs,
        is_night, trans_time_day, is_weekend
    )
    ON DUPLICATE KEY UPDATE
        trans_time_secs = VALUES(trans_time_secs),
        trans_time_hrs = VALUES(trans_time_hrs),
        trans_time_is_night = VALUES(trans_time_is_night),
        trans_time_day = VALUES(trans_time_day),
        trans_date_is_weekend = VALUES(trans_date_is_weekend);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `auto_block_transactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `auto_block_transactions`(IN p_transaction_id INT)
BEGIN
    DECLARE v_now DATETIME;
    DECLARE v_account_id INT;
    DECLARE v_merchant_id INT;
    DECLARE v_status VARCHAR(50);
    DECLARE v_suspicious_at DATETIME;
    DECLARE v_confirmed_at DATETIME;
    DECLARE v_is_suspicious BOOLEAN;
    DECLARE v_is_locked BOOLEAN;

    -- Exit handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    SET v_now = NOW();

    -- Lấy thông tin giao dịch
    SELECT account_id, merchant_id, suspicious_at, confirmed_at, is_suspicious
    INTO v_account_id, v_merchant_id, v_suspicious_at, v_confirmed_at, v_is_suspicious
    FROM transactions
    WHERE transaction_id = p_transaction_id;

    -- Chỉ xử lý nếu is_suspicious = 1, chưa xác nhận, và quá 3 phút
    IF v_is_suspicious = 1 AND v_confirmed_at IS NULL AND TIMESTAMPDIFF(MINUTE, v_suspicious_at, v_now) >= 3 THEN
        START TRANSACTION;

        -- Đánh dấu giao dịch là fraud
        UPDATE transactions
        SET
            is_fraud = 1,
            status = 'fraud',
            processed_at = v_now,
            processing_status = 'failed'
        WHERE transaction_id = p_transaction_id;

        -- Ghi log auto-block nếu chưa có
        INSERT INTO transaction_logs (
            transaction_id,
            account_id,
            action_type,
            old_status,
            new_status,
            performed_by,
            action_time,
            notes
        )
        SELECT
            p_transaction_id,
            v_account_id,
            'auto-block',
            status,
            'fraud',
            'system',
            v_now,
            'Auto-blocked after 3 minutes without confirmation'
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT 1 FROM transaction_logs
            WHERE transaction_id = p_transaction_id
              AND action_type = 'auto-block'
        );

        -- Thêm điều tra nếu chưa có
        INSERT INTO fraud_investigations (
            transaction_id,
            account_id,
            merchant_id,
            status,
            created_at
        )
        SELECT
            p_transaction_id,
            v_account_id,
            v_merchant_id,
            'pending',
            v_now
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT 1 FROM fraud_investigations
            WHERE transaction_id = p_transaction_id
        );

        -- Nếu account chưa bị khóa, khóa lại và ghi log
        SELECT is_locked INTO v_is_locked
        FROM accounts WHERE account_id = v_account_id;

        IF v_is_locked = 0 THEN
            UPDATE accounts
            SET is_locked = 1
            WHERE account_id = v_account_id;

            INSERT INTO transaction_logs (
                transaction_id,
                account_id,
                action_type,
                old_status,
                new_status,
                performed_by,
                action_time,
                notes
            ) VALUES (
                NULL,
                v_account_id,
                'lock-account',
                NULL,
                NULL,
                'system',
                v_now,
                'Account locked due to suspicious unconfirmed transaction'
            );
        END IF;

        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `confirm_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `confirm_transaction`(
    IN p_transaction_id INT, 
    IN p_new_status VARCHAR(50),
    IN p_performed_by VARCHAR(100), 
    IN p_notes TEXT
)
BEGIN
    DECLARE v_old_status VARCHAR(50);
    DECLARE v_account_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction confirmation failed.';
    END;

    START TRANSACTION;

    -- Lock bản ghi tránh race condition
    SELECT status, account_id
    INTO v_old_status, v_account_id
    FROM transactions
    WHERE transaction_id = p_transaction_id
    FOR UPDATE;

    -- Kiểm tra trạng thái hợp lệ
    IF p_new_status NOT IN ('confirmed', 'fraud') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid status. Must be "confirmed" or "fraud".';
    END IF;

    IF v_old_status = 'fraud' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot confirm a fraud transaction.';
    END IF;

    -- Cập nhật giao dịch
    UPDATE transactions
    SET
        confirmed_at = CURRENT_TIMESTAMP,
        is_fraud = IF(p_new_status = 'fraud', 1, 0),
        is_suspicious = IF(p_new_status = 'confirmed', 0, is_suspicious),
        status = p_new_status,
        processed_at = CURRENT_TIMESTAMP,
        processing_status = 'completed'
    WHERE transaction_id = p_transaction_id;

    -- Khóa tài khoản nếu là fraud
    IF p_new_status = 'fraud' THEN
        UPDATE accounts
        SET is_locked = 1
        WHERE account_id = v_account_id;
    END IF;

    -- Ghi log xác nhận
    INSERT INTO transaction_logs (
        transaction_id, account_id, action_type, old_status,
        new_status, performed_by, notes
    )
    VALUES (
        p_transaction_id, v_account_id, 'confirm',
        v_old_status, p_new_status, p_performed_by, p_notes
    );

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_customer_behavior_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_customer_behavior_daily`(IN p_customer_id INT, IN p_trans_date DATE)
BEGIN
    DELETE FROM customer_behavior_daily
    WHERE customer_id = p_customer_id AND trans_date = p_trans_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_customer_behavior_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_customer_behavior_monthly`(
    IN p_customer_id INT,
    IN p_month_start_date DATE
)
BEGIN
    DELETE FROM customer_behavior_monthly
    WHERE customer_id = p_customer_id AND month_start_date = p_month_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_customer_behavior_weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_customer_behavior_weekly`(
    IN p_customer_id INT,
    IN p_week_start_date DATE
)
BEGIN
    DELETE FROM customer_behavior_weekly
    WHERE customer_id = p_customer_id AND week_start_date = p_week_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_merchant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_merchant`(IN p_merchant_id INT)
BEGIN
    DELETE FROM merchants WHERE merchant_id = p_merchant_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_merchant_behavior_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_merchant_behavior_daily`(
    IN p_merchant_id INT,
    IN p_trans_date DATE
)
BEGIN
    DELETE FROM merchant_behavior_daily
    WHERE merchant_id = p_merchant_id AND trans_date = p_trans_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_merchant_behavior_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_merchant_behavior_monthly`(
    IN p_merchant_id INT,
    IN p_month_start_date DATE
)
BEGIN
    DELETE FROM merchant_behavior_monthly
    WHERE merchant_id = p_merchant_id AND month_start_date = p_month_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_merchant_behavior_weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_merchant_behavior_weekly`(
    IN p_merchant_id INT,
    IN p_week_start_date DATE
)
BEGIN
    DELETE FROM merchant_behavior_weekly
    WHERE merchant_id = p_merchant_id AND week_start_date = p_week_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_transaction`(IN p_transaction_id INT)
BEGIN
    DELETE FROM transactions WHERE transaction_id = p_transaction_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_transaction_time_features` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_transaction_time_features`(IN p_transaction_id INT)
BEGIN
    DELETE FROM transaction_time_features WHERE transaction_id = p_transaction_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_zip_code` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_zip_code`(
    IN p_zip VARCHAR(10)
)
BEGIN
    -- In bản ghi sắp bị xóa
    SELECT * 
    FROM zip_codes
    WHERE zip = p_zip;

    -- Xóa bản ghi
    DELETE FROM zip_codes
    WHERE zip = p_zip;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `detect_transactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `detect_transactions`(IN p_transaction_id INT)
BEGIN
    DECLARE v_amt DECIMAL(15, 2);
    DECLARE v_customer_id INT;
    DECLARE v_account_id INT;
    DECLARE v_merchant_id INT;
    DECLARE v_trans_date DATE;
    DECLARE v_is_suspicious BOOLEAN DEFAULT FALSE;
    DECLARE v_reason TEXT DEFAULT '';
    DECLARE v_reason_codes TEXT DEFAULT '';
    DECLARE v_processing_status VARCHAR(20) DEFAULT 'completed';
    DECLARE v_status VARCHAR(20);

    DECLARE v_avg_amt DECIMAL(10, 2);
    DECLARE v_trans_count INT;
    DECLARE v_is_night BOOLEAN DEFAULT FALSE;
    DECLARE v_is_weekend BOOLEAN DEFAULT FALSE;
    DECLARE v_distance_km DECIMAL(10, 2);
    DECLARE v_merchant_risk DECIMAL(5, 4);
    DECLARE v_merchant_suspicious BOOLEAN DEFAULT FALSE;

    -- Lấy thông tin giao dịch
    SELECT t.amt, t.account_id, t.merchant_id, t.trans_date
    INTO v_amt, v_account_id, v_merchant_id, v_trans_date
    FROM transactions t
    WHERE t.transaction_id = p_transaction_id;

    SELECT customer_id INTO v_customer_id
    FROM accounts WHERE account_id = v_account_id;

    SELECT trans_time_is_night, trans_date_is_weekend
    INTO v_is_night, v_is_weekend
    FROM transaction_time_features
    WHERE transaction_id = p_transaction_id;

    SELECT ST_Distance_Sphere(z.location, m.location) / 1000
    INTO v_distance_km
    FROM customers c
    JOIN customer_addresses ca ON c.customer_id = ca.customer_id
    JOIN zip_codes z ON ca.zip = z.zip
    JOIN merchants m ON m.merchant_id = v_merchant_id
    WHERE c.customer_id = v_customer_id
    LIMIT 1;

    -- ⚠️ Cập nhật đúng tên cột ở đây
    SELECT customer_num_trans_1_day, customer_avg_amount_1_day
    INTO v_trans_count, v_avg_amt
    FROM customer_behavior_daily
    WHERE customer_id = v_customer_id AND trans_date = v_trans_date;

    SELECT merchant_risk_1_day
    INTO v_merchant_risk
    FROM merchant_behavior_daily
    WHERE merchant_id = v_merchant_id AND trans_date = v_trans_date;

    SET v_merchant_suspicious = IF(v_merchant_risk > 0.5, TRUE, FALSE);

    -- Kiểm tra nghi ngờ
    IF v_distance_km > 1000 THEN
        SET v_is_suspicious = TRUE;
        SET v_reason = CONCAT(v_reason, 'Khoảng cách địa lý lớn hơn 1000km. ');
        SET v_reason_codes = CONCAT(v_reason_codes, 'geo_distance,');
    END IF;

    IF v_amt > 2 * v_avg_amt AND v_is_night THEN
        SET v_is_suspicious = TRUE;
        SET v_reason = CONCAT(v_reason, 'Số tiền lớn bất thường và xảy ra vào ban đêm. ');
        SET v_reason_codes = CONCAT(v_reason_codes, 'unusual_amount_night,');
    END IF;

    IF v_trans_count > 5 THEN
        SET v_is_suspicious = TRUE;
        SET v_reason = CONCAT(v_reason, 'Số lần giao dịch trong ngày vượt quá bình thường. ');
        SET v_reason_codes = CONCAT(v_reason_codes, 'high_frequency,');
    END IF;

    IF v_merchant_suspicious THEN
        SET v_is_suspicious = TRUE;
        SET v_reason = CONCAT(v_reason, 'Người bán có rủi ro cao. ');
        SET v_reason_codes = CONCAT(v_reason_codes, 'merchant_risk,');
    END IF;

    IF v_is_weekend THEN
        SET v_is_suspicious = TRUE;
        SET v_reason = CONCAT(v_reason, 'Giao dịch diễn ra vào cuối tuần. ');
        SET v_reason_codes = CONCAT(v_reason_codes, 'weekend,');
    END IF;

    IF v_is_suspicious THEN
        SET v_status = 'suspicious';
        INSERT INTO transaction_logs (transaction_id, account_id, action_type, action_time, performed_by, notes)
        VALUES (p_transaction_id, v_account_id, 'detect_fraud', NOW(), 'system', v_reason);
    ELSE
        SET v_status = 'normal';
        SET v_reason_codes = NULL;
    END IF;

    UPDATE transactions
    SET is_suspicious = v_is_suspicious,
        suspicious_reason = v_reason_codes,
        suspicious_at = IF(v_is_suspicious, NOW(), NULL),
        status = v_status,
        processing_status = v_processing_status
    WHERE transaction_id = p_transaction_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `detect_transactions_by_geo_behavior_merch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `detect_transactions_by_geo_behavior_merch`(
    IN p_transaction_id INT
)
BEGIN
    DECLARE v_distance_km DOUBLE DEFAULT 0;
    DECLARE v_is_night TINYINT(1) DEFAULT 0;
    DECLARE v_is_weekend TINYINT(1) DEFAULT 0;
    DECLARE v_avg_amount DECIMAL(15,2) DEFAULT 0;
    DECLARE v_transaction_amount DECIMAL(15,2) DEFAULT 0;
    DECLARE v_customer_id INT DEFAULT 0;
    DECLARE v_merchant_id INT DEFAULT 0;
    DECLARE v_merchant_risk DECIMAL(15,4) DEFAULT 0;
    DECLARE v_transaction_count INT DEFAULT 0;
    DECLARE v_avg_transaction_count INT DEFAULT 0;  -- Added variable for avg transaction count
    DECLARE v_category VARCHAR(50);
    DECLARE v_is_merchant_suspicious TINYINT(1) DEFAULT 0;

    -- 1. Lấy thông tin giao dịch
    SELECT t.amt, a.customer_id, t.merchant_id, t.category
    INTO v_transaction_amount, v_customer_id, v_merchant_id, v_category
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.transaction_id = p_transaction_id;

    -- 2. Lấy khoảng cách giữa vị trí khách hàng và merchant
    SELECT ST_Distance_Sphere(z.location, m.location)/1000 INTO v_distance_km
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    JOIN customers c ON a.customer_id = c.customer_id
    JOIN customer_addresses ca ON c.customer_id = ca.customer_id
    JOIN zip_codes z ON ca.zip = z.zip
    JOIN merchants m ON t.merchant_id = m.merchant_id
    WHERE t.transaction_id = p_transaction_id
    LIMIT 1;

    -- 3. Lấy thời gian ban đêm và cuối tuần
    SELECT trans_time_is_night, trans_date_is_weekend
    INTO v_is_night, v_is_weekend
    FROM transaction_time_features
    WHERE transaction_id = p_transaction_id;

    -- 4. Lấy hành vi khách hàng (ưu tiên daily -> weekly -> monthly)
    SELECT customer_avg_amount_1_day, customer_num_trans_1_day
    INTO v_avg_amount, v_avg_transaction_count
    FROM customer_behavior_daily
    WHERE customer_id = v_customer_id
    LIMIT 1;

    IF v_avg_amount IS NULL THEN
        SELECT customer_avg_amount_7_day, customer_num_trans_7_day / 7
        INTO v_avg_amount, v_avg_transaction_count
        FROM customer_behavior_weekly
        WHERE customer_id = v_customer_id
        LIMIT 1;
    END IF;

    IF v_avg_amount IS NULL THEN
        SELECT customer_avg_amount_30_day, customer_num_trans_30_day / 30
        INTO v_avg_amount, v_avg_transaction_count
        FROM customer_behavior_monthly
        WHERE customer_id = v_customer_id
        LIMIT 1;
    END IF;

    SET v_avg_amount = IFNULL(v_avg_amount, 0);
    SET v_transaction_count = IFNULL(v_transaction_count, 1); -- prevent divide by 0
    SET v_avg_transaction_count = IFNULL(v_avg_transaction_count,1);

    -- 5. Lấy merchant risk
    SELECT merchant_risk_1_day
    INTO v_merchant_risk
    FROM merchant_behavior_daily
    WHERE merchant_id = v_merchant_id
    LIMIT 1;

    SET v_merchant_risk = IFNULL(v_merchant_risk, 0);

    -- 6. Đánh giá merchant có đáng ngờ không
    SELECT
        CASE
            WHEN COUNT(*) = 0 THEN 0
            WHEN SUM(is_fraud) > 0.5 * COUNT(*) THEN 1
            ELSE 0
        END
    INTO v_is_merchant_suspicious
    FROM transactions
    WHERE merchant_id = v_merchant_id;

    -- 7. Trả kết quả
    SELECT
        p_transaction_id AS transaction_id,
        v_distance_km AS distance_km,
        v_is_night AS is_night,
        v_is_weekend AS is_weekend,
        v_transaction_amount AS transaction_amount,
        v_avg_amount AS avg_amount,
        v_transaction_count AS transaction_freq,
        v_merchant_risk AS merchant_risk,
        v_category AS category,
        v_is_merchant_suspicious AS is_merchant_suspicious,
        CASE
            WHEN v_distance_km > 1000
                 OR (v_transaction_amount > 2 * v_avg_amount AND v_is_night = 1)
                 OR v_transaction_count > 3 * v_avg_transaction_count  -- Compare transaction count
                 OR v_merchant_risk > 0.5
                 OR v_is_merchant_suspicious = 1
                 OR v_is_weekend = 1
            THEN 1
            ELSE 0
        END AS is_suspicious;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_customer_behavior_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_customer_behavior_daily`(
    IN p_customer_id INT,
    IN p_trans_date DATE,
    IN p_num_trans INT,
    IN p_avg_amount DECIMAL(15,2)
)
BEGIN
    INSERT INTO customer_behavior_daily
    VALUES (p_customer_id, p_trans_date, p_num_trans, p_avg_amount);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_customer_behavior_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_customer_behavior_monthly`(
    IN p_customer_id INT,
    IN p_month_start_date DATE,
    IN p_customer_num_trans_30_day INT,
    IN p_customer_avg_amount_30_day DECIMAL(15,2)
)
BEGIN
    INSERT INTO customer_behavior_monthly VALUES (p_customer_id, p_month_start_date, p_customer_num_trans_30_day, p_customer_avg_amount_30_day);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_customer_behavior_weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_customer_behavior_weekly`(
    IN p_customer_id INT,
    IN p_week_start_date DATE,
    IN p_customer_num_trans_7_day INT,
    IN p_customer_avg_amount_7_day DECIMAL(15,2)
)
BEGIN
    INSERT INTO customer_behavior_weekly VALUES (p_customer_id, p_week_start_date, p_customer_num_trans_7_day, p_customer_avg_amount_7_day);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_merchant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_merchant`(
    IN p_merchant VARCHAR(100),
    IN p_merch_lat DECIMAL(10,6),
    IN p_merch_long DECIMAL(10,6)
)
BEGIN
    INSERT INTO merchants (merchant, merch_lat, merch_long)
    VALUES (p_merchant, p_merch_lat, p_merch_long);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_merchant_behavior_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_merchant_behavior_daily`(
    IN p_merchant_id INT,
    IN p_trans_date DATE,
    IN p_merchant_num_trans_1_day DECIMAL(15,2),
    IN p_merchant_risk_1_day DECIMAL(15,4)
)
BEGIN
    INSERT INTO merchant_behavior_daily VALUES (p_merchant_id, p_trans_date, p_merchant_num_trans_1_day, p_merchant_risk_1_day);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_merchant_behavior_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_merchant_behavior_monthly`(
    IN p_merchant_id INT,
    IN p_month_start_date DATE,
    IN p_merchant_num_trans_30_day DECIMAL(15,2),
    IN p_merchant_risk_30_day DECIMAL(15,4),
    IN p_merchant_risk_90_day DECIMAL(15,4)
)
BEGIN
    INSERT INTO merchant_behavior_monthly VALUES (
        p_merchant_id, p_month_start_date, 
        p_merchant_num_trans_30_day, 
        p_merchant_risk_30_day, 
        p_merchant_risk_90_day
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_merchant_behavior_weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_merchant_behavior_weekly`(
    IN p_merchant_id INT,
    IN p_week_start_date DATE,
    IN p_merchant_num_trans_7_day DECIMAL(15,2),
    IN p_merchant_risk_7_day DECIMAL(15,4)
)
BEGIN
    INSERT INTO merchant_behavior_weekly VALUES (p_merchant_id, p_week_start_date, p_merchant_num_trans_7_day, p_merchant_risk_7_day);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_transaction`(
    IN p_account_id INT,
    IN p_trans_num VARCHAR(50),
    IN p_trans_date DATE,
    IN p_trans_time TIME,
    IN p_unix_time BIGINT,
    IN p_category VARCHAR(50),
    IN p_amt DECIMAL(15,2),
    IN p_is_fraud TINYINT,
    IN p_merchant_id INT
)
BEGIN
    INSERT INTO transactions (account_id, trans_num, trans_date, trans_time, unix_time, category, amt, is_fraud, merchant_id)
    VALUES (p_account_id, p_trans_num, p_trans_date, p_trans_time, p_unix_time, p_category, p_amt, p_is_fraud, p_merchant_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_transaction_time_features` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_transaction_time_features`(
    IN p_transaction_id INT,
    IN p_trans_time_secs INT,
    IN p_trans_time_hrs TINYINT,
    IN p_trans_time_is_night TINYINT,
    IN p_trans_time_day VARCHAR(15),
    IN p_trans_date_is_weekend TINYINT
)
BEGIN
    INSERT INTO transaction_time_features
    VALUES (p_transaction_id, p_trans_time_secs, p_trans_time_hrs, p_trans_time_is_night, p_trans_time_day, p_trans_date_is_weekend);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_zip_code` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_zip_code`(
    IN p_zip VARCHAR(10),
    IN p_lat DECIMAL(10,6),
    IN p_long DECIMAL(10,6),
    IN p_city VARCHAR(100),
    IN p_state VARCHAR(10),
    IN p_pop INT
)
BEGIN
    -- Chèn dữ liệu
    INSERT INTO zip_codes (zip, lat, `long`, city, state, population, location)
    VALUES (
        p_zip,
        p_lat,
        p_long,
        p_city,
        p_state,
        p_pop,
        ST_SRID(POINT(p_long, p_lat), 4326)
    );

    -- In ra bản ghi vừa thêm
    SELECT *
    FROM zip_codes
    WHERE zip = p_zip;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_new_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_new_transaction`(
    IN in_customer_id INT,
    IN in_acct_num VARCHAR(30),
    IN in_merchant_id INT,
    IN in_trans_num VARCHAR(50),
    IN in_trans_date DATE,
    IN in_trans_time TIME,
    IN in_unix_time BIGINT,
    IN in_category VARCHAR(50),
    IN in_amt DECIMAL(15,2)
)
BEGIN
    DECLARE v_transaction_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        RESIGNAL;
    END;

    CALL add_transaction_with_check(
        in_customer_id, in_acct_num, in_merchant_id,
        in_trans_num, in_trans_date, in_trans_time,
        in_unix_time, in_category, in_amt
    );

    SET v_transaction_id = LAST_INSERT_ID();
    CALL detect_transactions(v_transaction_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_accounts`(
    IN p_account_id INT
)
BEGIN
    DELETE FROM accounts WHERE account_id = p_account_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_credit_cards` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_credit_cards`(
    IN p_card_id INT
)
BEGIN
    DELETE FROM credit_cards WHERE card_id = p_card_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_customers`(
    IN p_customer_id INT
)
BEGIN
    DELETE FROM customers WHERE customer_id = p_customer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_customer_addresses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_customer_addresses`(
    IN p_address_id INT
)
BEGIN
    DELETE FROM customer_addresses WHERE address_id = p_address_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_customer_jobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_customer_jobs`(
    IN p_job_id INT
)
BEGIN
    DELETE FROM customer_jobs WHERE job_id = p_job_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_accounts`(
    IN p_customer_id INT, IN p_acct_num VARCHAR(30)
)
BEGIN
    INSERT INTO accounts (customer_id, acct_num) VALUES (p_customer_id, p_acct_num);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_credit_cards` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_credit_cards`(
    IN p_account_id INT, IN p_cc_num VARCHAR(20)
)
BEGIN
    INSERT INTO credit_cards (account_id, cc_num) VALUES (p_account_id, p_cc_num);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_customers`(
    IN p_ssn VARCHAR(15), IN p_first VARCHAR(50), IN p_last VARCHAR(50),
    IN p_gender VARCHAR(10), IN p_dob DATE, IN p_profile VARCHAR(100)
)
BEGIN
    INSERT INTO customers (ssn, first, last, gender, dob, profile)
    VALUES (p_ssn, p_first, p_last, p_gender, p_dob, p_profile);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_customer_addresses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_customer_addresses`(
    IN p_customer_id INT, IN p_street VARCHAR(100), IN p_city VARCHAR(100),
    IN p_state VARCHAR(10), IN p_zip VARCHAR(10), IN p_lat DECIMAL(10,6),
    IN p_long DECIMAL(10,6), IN p_city_pop INT
)
BEGIN
    INSERT INTO customer_addresses (customer_id, street, city, state, zip, lat, `long`, city_pop)
    VALUES (p_customer_id, p_street, p_city, p_state, p_zip, p_lat, p_long, p_city_pop);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_customer_jobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_customer_jobs`(
    IN p_customer_id INT, IN p_job VARCHAR(100)
)
BEGIN
    INSERT INTO customer_jobs (customer_id, job) VALUES (p_customer_id, p_job);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_accounts`(
    IN p_account_id INT, IN p_acct_num VARCHAR(30)
)
BEGIN
    UPDATE accounts SET acct_num = p_acct_num WHERE account_id = p_account_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_credit_cards` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_credit_cards`(
    IN p_card_id INT, IN p_cc_num VARCHAR(20)
)
BEGIN
    UPDATE credit_cards SET cc_num = p_cc_num WHERE card_id = p_card_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_customers`(
    IN p_customer_id INT, IN p_first VARCHAR(50), IN p_last VARCHAR(50),
    IN p_gender VARCHAR(10), IN p_dob DATE, IN p_profile VARCHAR(100)
)
BEGIN
    UPDATE customers
    SET first = p_first, last = p_last, gender = p_gender, dob = p_dob, profile = p_profile
    WHERE customer_id = p_customer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_customer_addresses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_customer_addresses`(
    IN p_address_id INT, IN p_street VARCHAR(100), IN p_city VARCHAR(100),
    IN p_state VARCHAR(10), IN p_zip VARCHAR(10), IN p_lat DECIMAL(10,6),
    IN p_long DECIMAL(10,6), IN p_city_pop INT
)
BEGIN
    UPDATE customer_addresses
    SET street = p_street, city = p_city, state = p_state, zip = p_zip,
        lat = p_lat, `long` = p_long, city_pop = p_city_pop
    WHERE address_id = p_address_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_customer_jobs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_customer_jobs`(
    IN p_job_id INT, IN p_job VARCHAR(100)
)
BEGIN
    UPDATE customer_jobs SET job = p_job WHERE job_id = p_job_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_customer_behavior` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_customer_behavior`()
BEGIN
    -- TẠO bảng tạm DAILY
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_daily_behavior AS
    SELECT 
        a.customer_id, 
        CURDATE() AS trans_date, 
        COUNT(t.transaction_id) AS customer_num_trans_1_day, 
        AVG(t.amt) AS customer_avg_amount_1_day
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.trans_date = CURDATE()
    GROUP BY a.customer_id;

    -- XÓA dữ liệu bảng tạm nếu có (nếu bảng tồn tại rồi)
    TRUNCATE TABLE tmp_daily_behavior;

    -- CHÈN dữ liệu mới vào bảng tạm
    INSERT INTO tmp_daily_behavior
    SELECT 
        a.customer_id, 
        CURDATE() AS trans_date, 
        COUNT(t.transaction_id), 
        AVG(t.amt)
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.trans_date = CURDATE()
    GROUP BY a.customer_id;

    -- INSERT hoặc UPDATE vào bảng chính từ bảng tạm
    INSERT INTO customer_behavior_daily (customer_id, trans_date, customer_num_trans_1_day, customer_avg_amount_1_day)
    SELECT customer_id, trans_date, customer_num_trans_1_day, customer_avg_amount_1_day FROM tmp_daily_behavior
    ON DUPLICATE KEY UPDATE
        customer_num_trans_1_day = VALUES(customer_num_trans_1_day),
        customer_avg_amount_1_day = VALUES(customer_avg_amount_1_day);

    -- TƯƠNG TỰ CHO WEEKLY
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_weekly_behavior AS
    SELECT 
        a.customer_id, 
        DATE_SUB(CURDATE(), INTERVAL 6 DAY) AS week_start_date, 
        COUNT(t.transaction_id) AS customer_num_trans_7_day, 
        AVG(t.amt) AS customer_avg_amount_7_day
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND CURDATE()
    GROUP BY a.customer_id;

    TRUNCATE TABLE tmp_weekly_behavior;

    INSERT INTO tmp_weekly_behavior
    SELECT 
        a.customer_id, 
        DATE_SUB(CURDATE(), INTERVAL 6 DAY), 
        COUNT(t.transaction_id), 
        AVG(t.amt)
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND CURDATE()
    GROUP BY a.customer_id;

    INSERT INTO customer_behavior_weekly (customer_id, week_start_date, customer_num_trans_7_day, customer_avg_amount_7_day)
    SELECT customer_id, week_start_date, customer_num_trans_7_day, customer_avg_amount_7_day FROM tmp_weekly_behavior
    ON DUPLICATE KEY UPDATE
        customer_num_trans_7_day = VALUES(customer_num_trans_7_day),
        customer_avg_amount_7_day = VALUES(customer_avg_amount_7_day);

    -- TƯƠNG TỰ CHO MONTHLY
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_monthly_behavior AS
    SELECT 
        a.customer_id, 
        DATE_SUB(CURDATE(), INTERVAL 29 DAY) AS month_start_date, 
        COUNT(t.transaction_id) AS customer_num_trans_30_day, 
        AVG(t.amt) AS customer_avg_amount_30_day
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 29 DAY) AND CURDATE()
    GROUP BY a.customer_id;

    TRUNCATE TABLE tmp_monthly_behavior;

    INSERT INTO tmp_monthly_behavior
    SELECT 
        a.customer_id, 
        DATE_SUB(CURDATE(), INTERVAL 29 DAY), 
        COUNT(t.transaction_id), 
        AVG(t.amt)
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 29 DAY) AND CURDATE()
    GROUP BY a.customer_id;

    INSERT INTO customer_behavior_monthly (customer_id, month_start_date, customer_num_trans_30_day, customer_avg_amount_30_day)
    SELECT customer_id, month_start_date, customer_num_trans_30_day, customer_avg_amount_30_day FROM tmp_monthly_behavior
    ON DUPLICATE KEY UPDATE
        customer_num_trans_30_day = VALUES(customer_num_trans_30_day),
        customer_avg_amount_30_day = VALUES(customer_avg_amount_30_day);

    -- DROP bảng tạm nếu cần (tuỳ chọn)
    DROP TEMPORARY TABLE IF EXISTS tmp_daily_behavior;
    DROP TEMPORARY TABLE IF EXISTS tmp_weekly_behavior;
    DROP TEMPORARY TABLE IF EXISTS tmp_monthly_behavior;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_customer_behavior_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_customer_behavior_daily`(
    IN p_customer_id INT,
    IN p_trans_date DATE,
    IN p_num_trans INT
)
BEGIN
    UPDATE customer_behavior_daily
    SET customer_num_trans_1_day = p_num_trans
    WHERE customer_id = p_customer_id AND trans_date = p_trans_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_customer_behavior_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_customer_behavior_monthly`(
    IN p_customer_id INT,
    IN p_month_start_date DATE,
    IN p_customer_num_trans_30_day INT,
    IN p_customer_avg_amount_30_day DECIMAL(15,2)
)
BEGIN
    UPDATE customer_behavior_monthly
    SET customer_num_trans_30_day = p_customer_num_trans_30_day,
        customer_avg_amount_30_day = p_customer_avg_amount_30_day
    WHERE customer_id = p_customer_id AND month_start_date = p_month_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_customer_behavior_weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_customer_behavior_weekly`(
    IN p_customer_id INT,
    IN p_week_start_date DATE,
    IN p_customer_num_trans_7_day INT,
    IN p_customer_avg_amount_7_day DECIMAL(15,2)
)
BEGIN
    UPDATE customer_behavior_weekly
    SET customer_num_trans_7_day = p_customer_num_trans_7_day,
        customer_avg_amount_7_day = p_customer_avg_amount_7_day
    WHERE customer_id = p_customer_id AND week_start_date = p_week_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_fraud_investigation_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_fraud_investigation_status`(
    IN p_investigation_id INT,
    IN p_new_status VARCHAR(50)
)
BEGIN
    DECLARE v_transaction_id INT;
    DECLARE v_account_id INT;
    DECLARE v_now DATETIME;
    DECLARE v_old_status VARCHAR(50);

    -- Handler để rollback nếu có lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    SET v_now = NOW();

    -- Lấy transaction_id và account_id liên quan đến cuộc điều tra
    SELECT fi.transaction_id, fi.account_id
    INTO v_transaction_id, v_account_id
    FROM fraud_investigations fi
    WHERE fi.investigation_id = p_investigation_id;

    START TRANSACTION;

    -- Lưu trạng thái cũ
    SELECT status INTO v_old_status
    FROM fraud_investigations
    WHERE investigation_id = p_investigation_id;

    -- Cập nhật trạng thái điều tra
    UPDATE fraud_investigations
    SET status = p_new_status
    WHERE investigation_id = p_investigation_id;

    -- Nếu trạng thái là đóng thì ghi thời gian kết thúc điều tra
    IF p_new_status LIKE 'closed%' THEN
        UPDATE fraud_investigations
        SET investigation_end_date = v_now
        WHERE investigation_id = p_investigation_id;
    END IF;

    -- Xử lý theo trạng thái mới
    IF p_new_status = 'closed - fraud confirmed' THEN
        UPDATE transactions
        SET
            is_fraud = 1,
            status = 'fraud',
            processing_status = 'completed',
            processed_at = v_now,
            fraud_resolved_at = v_now
        WHERE transaction_id = v_transaction_id;

        UPDATE accounts
        SET is_locked = 1,
            locked_at = v_now
        WHERE account_id = v_account_id AND is_locked = 0;

    ELSEIF p_new_status = 'closed - not fraud' THEN
        UPDATE transactions
        SET
            is_fraud = 0,
            is_suspicious = 0,
            status = 'normal',
            processing_status = 'completed',
            processed_at = v_now,
            fraud_resolved_at = v_now
        WHERE transaction_id = v_transaction_id;

        UPDATE accounts
        SET is_locked = 0,
            locked_at = NULL
        WHERE account_id = v_account_id AND is_locked = 1;
    END IF;

    -- Ghi log hành động
    INSERT INTO transaction_logs (
        transaction_id, account_id, action_type, old_status,
        new_status, performed_by, action_time, notes
    )
    VALUES (
        v_transaction_id, v_account_id, 'investigation-update',
        v_old_status, p_new_status, 'fraud_team', v_now,
        CONCAT('Investigation status changed from "', v_old_status, '" to "', p_new_status, '"')
    );

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_merchant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_merchant`(
    IN p_merchant_id INT,
    IN p_merchant VARCHAR(100),
    IN p_merch_lat DECIMAL(10,6),
    IN p_merch_long DECIMAL(10,6)
)
BEGIN
    UPDATE merchants
    SET merchant = p_merchant,
        merch_lat = p_merch_lat,
        merch_long = p_merch_long
    WHERE merchant_id = p_merchant_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_merchant_behavior` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_merchant_behavior`()
BEGIN
	-- DAILY
    INSERT INTO merchant_behavior_daily (
        merchant_id, trans_date,
        merchant_num_trans_1_day, merchant_risk_1_day
    )
    SELECT 
        m.merchant_id,
        CURDATE(),
        COUNT(t.transaction_id),
        IFNULL(SUM(t.is_fraud) / COUNT(t.transaction_id), 0)
    FROM merchants m
    LEFT JOIN transactions t ON m.merchant_id = t.merchant_id
    WHERE t.trans_date = CURDATE()
    GROUP BY m.merchant_id
    ON DUPLICATE KEY UPDATE
        merchant_num_trans_1_day = VALUES(merchant_num_trans_1_day),
        merchant_risk_1_day = VALUES(merchant_risk_1_day);
	
    -- WEEKLY
    INSERT INTO merchant_behavior_weekly (
        merchant_id, week_start_date,
        merchant_num_trans_7_day, merchant_risk_7_day
    )
    SELECT 
        m.merchant_id,
        DATE_SUB(CURDATE(), INTERVAL (DAYOFWEEK(CURDATE()) - 1) DAY),
        COUNT(t.transaction_id),
        IFNULL(SUM(t.is_fraud) / COUNT(t.transaction_id), 0)
    FROM merchants m
    LEFT JOIN transactions t ON m.merchant_id = t.merchant_id
    WHERE t.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND CURDATE()
    GROUP BY m.merchant_id
    ON DUPLICATE KEY UPDATE
        merchant_num_trans_7_day = VALUES(merchant_num_trans_7_day),
        merchant_risk_7_day = VALUES(merchant_risk_7_day);

   -- MONTHLY
    INSERT INTO merchant_behavior_monthly (
        merchant_id, month_start_date,
        merchant_num_trans_30_day, merchant_risk_30_day, merchant_risk_90_day
    )
    SELECT 
        m.merchant_id,
        DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY),
        COUNT(t1.transaction_id),
        IFNULL(SUM(t1.is_fraud) / COUNT(t1.transaction_id), 0),
        (
            SELECT IFNULL(SUM(t2.is_fraud) / COUNT(t2.transaction_id), 0)
            FROM transactions t2
            WHERE t2.merchant_id = m.merchant_id
              AND t2.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 89 DAY) AND CURDATE()
        )
    FROM merchants m
    LEFT JOIN transactions t1 ON m.merchant_id = t1.merchant_id
    WHERE t1.trans_date BETWEEN DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) - 1 DAY) AND CURDATE()
    GROUP BY m.merchant_id
    ON DUPLICATE KEY UPDATE
        merchant_num_trans_30_day = VALUES(merchant_num_trans_30_day),
        merchant_risk_30_day = VALUES(merchant_risk_30_day),
        merchant_risk_90_day = VALUES(merchant_risk_90_day);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_merchant_behavior_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_merchant_behavior_daily`(
    IN p_merchant_id INT,
    IN p_trans_date DATE,
    IN p_merchant_num_trans_1_day DECIMAL(15,2),
    IN p_merchant_risk_1_day DECIMAL(15,4)
)
BEGIN
    UPDATE merchant_behavior_daily
    SET merchant_num_trans_1_day = p_merchant_num_trans_1_day,
        merchant_risk_1_day = p_merchant_risk_1_day
    WHERE merchant_id = p_merchant_id AND trans_date = p_trans_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_merchant_behavior_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_merchant_behavior_monthly`(
    IN p_merchant_id INT,
    IN p_month_start_date DATE,
    IN p_merchant_num_trans_30_day DECIMAL(15,2),
    IN p_merchant_risk_30_day DECIMAL(15,4),
    IN p_merchant_risk_90_day DECIMAL(15,4)
)
BEGIN
    UPDATE merchant_behavior_monthly
    SET merchant_num_trans_30_day = p_merchant_num_trans_30_day,
        merchant_risk_30_day = p_merchant_risk_30_day,
        merchant_risk_90_day = p_merchant_risk_90_day
    WHERE merchant_id = p_merchant_id AND month_start_date = p_month_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_merchant_behavior_weekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_merchant_behavior_weekly`(
    IN p_merchant_id INT,
    IN p_week_start_date DATE,
    IN p_merchant_num_trans_7_day DECIMAL(15,2),
    IN p_merchant_risk_7_day DECIMAL(15,4)
)
BEGIN
    UPDATE merchant_behavior_weekly
    SET merchant_num_trans_7_day = p_merchant_num_trans_7_day,
        merchant_risk_7_day = p_merchant_risk_7_day
    WHERE merchant_id = p_merchant_id AND week_start_date = p_week_start_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_transaction`(
    IN p_transaction_id INT,
    IN p_amt DECIMAL(15,2),
    IN p_is_fraud TINYINT
)
BEGIN
    UPDATE transactions
    SET amt = p_amt,
        is_fraud = p_is_fraud
    WHERE transaction_id = p_transaction_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_transaction_time_features` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_transaction_time_features`(
    IN p_transaction_id INT,
    IN p_trans_time_is_night TINYINT
)
BEGIN
    UPDATE transaction_time_features
    SET trans_time_is_night = p_trans_time_is_night
    WHERE transaction_id = p_transaction_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_zip_code` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_zip_code`(
    IN p_zip VARCHAR(10),
    IN p_lat DECIMAL(10,6),
    IN p_long DECIMAL(10,6),
    IN p_city VARCHAR(100),
    IN p_state VARCHAR(10),
    IN p_pop INT
)
BEGIN
    -- Cập nhật bản ghi
    UPDATE zip_codes
    SET 
        lat = p_lat,
        `long` = p_long,
        city = p_city,
        state = p_state,
        population = p_pop,
        location = ST_SRID(POINT(p_long, p_lat), 4326)
    WHERE zip = p_zip;

    -- In ra bản ghi sau khi cập nhật
    SELECT * 
    FROM zip_codes
    WHERE zip = p_zip;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `transactions`
--

USE `transactions`;

--
-- Final view structure for view `suspicious_transactions_by_customer`
--

/*!50001 DROP VIEW IF EXISTS `suspicious_transactions_by_customer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suspicious_transactions_by_customer` AS select `c`.`customer_id` AS `customer_id`,`c`.`first` AS `first`,`c`.`last` AS `last`,`t`.`transaction_id` AS `transaction_id`,`t`.`trans_date` AS `trans_date`,`t`.`trans_time` AS `trans_time`,`t`.`amt` AS `amt`,`t`.`suspicious_reason` AS `suspicious_reason` from ((`transactions` `t` join `accounts` `a` on((`t`.`account_id` = `a`.`account_id`))) join `customers` `c` on((`a`.`customer_id` = `c`.`customer_id`))) where ((`t`.`is_suspicious` = true) and `t`.`transaction_id` in (select max(`t2`.`transaction_id`) from (`transactions` `t2` join `accounts` `a2` on((`t2`.`account_id` = `a2`.`account_id`))) where (`t2`.`is_suspicious` = true) group by `a2`.`customer_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `suspicious_transactions_by_merchant`
--

/*!50001 DROP VIEW IF EXISTS `suspicious_transactions_by_merchant`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suspicious_transactions_by_merchant` AS select `m`.`merchant_id` AS `merchant_id`,`m`.`merchant` AS `merchant_name`,`t`.`transaction_id` AS `transaction_id`,`t`.`trans_date` AS `trans_date`,`t`.`trans_time` AS `trans_time`,`t`.`amt` AS `amt`,`t`.`suspicious_reason` AS `suspicious_reason` from (`transactions` `t` join `merchants` `m` on((`t`.`merchant_id` = `m`.`merchant_id`))) where ((`t`.`is_suspicious` = true) and `t`.`transaction_id` in (select max(`t2`.`transaction_id`) from `transactions` `t2` where (`t2`.`is_suspicious` = true) group by `t2`.`merchant_id`)) */;
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

-- Dump completed on 2025-05-20  9:33:52
