-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: 192.168.1.6    Database: Auditing-SAP-Minimal
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

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

--
-- Table structure for table `Recommendations`
--

DROP TABLE IF EXISTS `Recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recommendations` (
  `idRecommendations` int NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` longtext,
  `Recommendation` longtext,
  `How_to_Verify` longtext,
  `Related_Alert` varchar(255) DEFAULT 'No',
  `More_Information` longtext,
  `idRecommendations_Types` varchar(45) NOT NULL,
  PRIMARY KEY (`idRecommendations`,`idRecommendations_Types`),
  KEY `idRecomendations_Types_idx` (`idRecommendations_Types`),
  CONSTRAINT `fk_Recommendations_1` FOREIGN KEY (`idRecommendations_Types`) REFERENCES `Recommendations_Types` (`idRecommendations_Types`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recommendations`
--

LOCK TABLES `Recommendations` WRITE;
/*!40000 ALTER TABLE `Recommendations` DISABLE KEYS */;
INSERT INTO `Recommendations` VALUES (1,'SYSTEM User','The database user SYSTEM is the most powerful database user with irrevocable system priv­ileges. The SYSTEM user is active after database creation.','Use SYSTEM to create database users with the minimum privilege set required for their du­ties (for example, user administration, system administration). Then deactivate SYSTEM. You may however temporarily reactivate the SYSTEM user for emergency or bootstrapping tasks. See Deactivate the SYSTEM User in the SAP HANA Security Guide.','In the system view USERS, check the values in columns USER_DEACTIVATED, DEACTIVATION_TIME, and LAST_SUCCESSFUL_CONNECT for the user SYSTEM.','No','See the sections on predefined users and deactivating the SYSTEM user in the SAP HANA Security Guide.','2.1'),(1,'Open Ports','During installation, ports such as SQL 3<instance_no>15 and HTTP 80<instance_no> are opened by default.','Only ports that are needed for running your SAP HANA scenario should be open. For a list of required ports, see the SAP HANA Administration Guide.','Verify opened ports at operating system level using Linux commands such as netcat or netstat.','No','See the section on communication channel security in the SAP HANA Security Guide and the section on ports and connections in the SAP HANA Administration Guide.','2.2'),(1,'Instance SSFS Master Key','The instance secure store in the file system (SSFS) protects internal root keys in the file system. A unique master key is generated for the instance SSFS in every installation.','If you received your system pre-installed from a hardware or hosting partner, we recommend that you change the master key of the instance SSFS immediately after handover to ensure that it is not known outside of your organization.','Using the SAP HANA cockpit, check the change date of the master key.\n\nThis information is available in SAP HANA cockpit on the resource overview page.','84 (Insecure instance SSF encryption configuration)','See the section on server-side data encryption in the SAP HANA Security Guide and the section on changing the SSFS master keys in the SAP HANA Administration Guide.','2.3'),(1,'Operating System Users','Only operating system (OS) users that are needed for operating SAP HANA exist on the SAP HANA system, that is:\n- sapadm (required to authenticate to SAP Host Agent)\n- <sid>adm (required by the SAP HANA database)\n- <sid>crypt (if the local secure store has been installed)\n- Dedicated OS users for every tenant database if the system is configured for high isolation\n','Ensure that no additional unnecessary users exist.','Refer to your operating system documentation','No','See the section on predefned users in the SAP HANA Security Guide.','2.4'),(1,'Auditing','Auditing is disabled by default.','Verify whether auditing is required by your security concept, for example to fulfill specific compliance and regulatory requirements.','Check the status of auditing in the SAP HANA cockpit\n\nThis information is available on the Auditing card of the Database Overview page.\n\nAlternatively, you can execute the following statement:\n\nSELECT * FROM \"PUBLIC\" . \"M_INIFILE_CONTENTS\" WHERE SECTION = \'auditing configuration\' AND KEY = \'global_auditing_state\';','No','See the sections on auditing in the SAP HANA Security Guide and the SAP HANA Administration Guide.','2.5'),(1,'Trace Files','Basic tracing of activity in database components is enabled by default, with each database service writing to its own trace file. Other traces (for example, SQL trace, expensive statements trace, performance trace) must be explicitly enabled.\n\nUsers with the system privilege CATALOG READ can read the contents of trace files in the SAP HANA database explorer. At operating system level, any user in the SAPSYS group can access the trace directory: /usr/sap/<SID>/HDB<instance>/<host>/trace/<db_name>','- Enable tracing to troubleshoot specific problems only and then disable.\n\n- Exercise caution when setting or changing the trace level. A high trace level may expose certain security-relevant data (for example, database trace level DEBUG or SQL trace level ALL_WITH_RESULTS).\n\n- Delete trace files that are no longer needed.','You can check which traces are enabled and how they are configured, as well as view trace files in the SAP HANA database explorer.','No','See the section on security risks of trace and dump files in the SAP HANA Security Guide and the section on traces in the SAP HANA Administration Guide.','2.6'),(1,'SAML-Based User Authentication','All tenant databases use the same trust store as the system database for SAML-based user authentication','To prevent users of one tenant database being able to log on to other databases in the system (including the system database) using SAML, create individual certificate collections with the purpose SAML and SSL in every tenant database.\n\nIn addition, specify a non-existent trust store for every tenant database using the [communication] sslTrustStore property in the global.ini file.','Execute the following statements:\n\n- In the tenant database: SELECT * FROM PSES WHERE PURPOSE =\'SAML\' OR PURPOSE =\'SSL\';\n\n- In the system database: SELECT * FROM SYS_DATABASES.M_INIFILE_CONTENTS WHERE DATABASE_NAME=\'<TENANT_DB_NAME>\' AND SECTION=\'communication\' AND KEY = \'ssltruststore\';','No','See the sections on SSL configuration on the SAP HANA server and certficate collections in the SAP HANA Security Guide.','2.7'),(1,'XSA_ADMIN User','XSA_ADMIN is a first-level administrator user with irrevocable privileges. This user has unlimited access to the Controller and therefore needs to be handled carefully.','- Change the XSA_ADMIN password at regular intervals.\n\n- Avoid creating other powerful users with privileges similar to XSA_ADMIN.\n\n- Keep the number of people with XSA_ADMIN credentials as small as possible. Delegate specific tasks like space management to lesser-privileged users instead.\n\nAlternatively, set up lesser-privileged XS advanced users to run the server without the administrative user. Then deactivate the XSA_ADMIN user. See the next section.','SELECT DISTINCT USER_NAME FROM USER_PARAMETERS WHERE PARAMETER = \'XS_RC_XS_CONTROLLER_ADMIN\'\n\n// This statement can only be executed by a user administrator','No','See the section on predefined XS advanced users in the SAP HANA Security Guide.','3.1'),(1,'Space Isolation','The instances of applications in the same space run with the same operating system (OS) user. Each space can have a different OS user.','For space isolation, each space should use an own dedicated OS user only for this space.','Current space user mapping can be viewed with the xs spaces command. The user column shows the used OS user for each listed space.','No','See the section on organizations and spaces in the SAP HANA Security Guide.','3.2'),(1,'Network and Communication Security','The XS advanced platform router, which is realized by an SAP Web Dispatcher instance, exposes the public end point for the whole system. The router is configured in a way that all application and public server end points are represented by an external URL. External requests are routed to the appropriate back-end instance according to the internal routing table.','Limit network access to your system in a way that only the platform router\'s end points are accessible from outside the system. This can be accomplished by means of network zones and firewalls.','Get in touch with your network administrators.','No','See the sections on XS advanced application server components and public end points in the SAP HANA Security Guide.','3.3');
/*!40000 ALTER TABLE `Recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recommendations_Types`
--

DROP TABLE IF EXISTS `Recommendations_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recommendations_Types` (
  `idRecommendations_Types` varchar(45) NOT NULL,
  `Title` varchar(255) NOT NULL,
  PRIMARY KEY (`idRecommendations_Types`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recommendations_Types`
--

LOCK TABLES `Recommendations_Types` WRITE;
/*!40000 ALTER TABLE `Recommendations_Types` DISABLE KEYS */;
INSERT INTO `Recommendations_Types` VALUES ('2.1','Recommendations for Database Users, Roles, and Privileges'),('2.2','Recommendations for Network Configuration'),('2.3','Recommendations for Data Encryption'),('2.4','Recommendations for File System and Operating'),('2.5','Recommendations for Auditing Configuration'),('2.6','Recommendations for Trace and Dump Files'),('2.7','Recommendations for Tenant Database Management'),('3.1','Recommendations for XS Advanced Administration'),('3.2','Recommendations for Organizations and Spaces'),('3.3','Recommendations for Network Configuration');
/*!40000 ALTER TABLE `Recommendations_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Testing_Types`
--

DROP TABLE IF EXISTS `Testing_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Testing_Types` (
  `idTesting_Types` int NOT NULL,
  `Testing_Type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idTesting_Types`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Testing_Types`
--

LOCK TABLES `Testing_Types` WRITE;
/*!40000 ALTER TABLE `Testing_Types` DISABLE KEYS */;
INSERT INTO `Testing_Types` VALUES (1,'Query'),(2,'Command'),(3,'Walkthrough/Documentation request');
/*!40000 ALTER TABLE `Testing_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Testings`
--

DROP TABLE IF EXISTS `Testings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Testings` (
  `idTesting` int NOT NULL,
  `Query` varchar(255) NOT NULL,
  `IdRecommendation` int NOT NULL,
  `idRecommendation_Type` varchar(45) NOT NULL,
  `idTesting_Type` int NOT NULL,
  PRIMARY KEY (`idTesting`,`IdRecommendation`,`idRecommendation_Type`),
  KEY `fk_Testing_Queries_1_idx` (`IdRecommendation`),
  KEY `fk_Testing_Queries_2_idx` (`idRecommendation_Type`),
  KEY `fk_Testing_Queries_3_idx` (`idTesting_Type`),
  CONSTRAINT `fk_Testing_Queries_1` FOREIGN KEY (`IdRecommendation`) REFERENCES `Recommendations` (`idRecommendations`),
  CONSTRAINT `fk_Testing_Queries_2` FOREIGN KEY (`idRecommendation_Type`) REFERENCES `Recommendations_Types` (`idRecommendations_Types`),
  CONSTRAINT `fk_Testing_Queries_3` FOREIGN KEY (`idTesting_Type`) REFERENCES `Testing_Types` (`idTesting_Types`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Testings`
--

LOCK TABLES `Testings` WRITE;
/*!40000 ALTER TABLE `Testings` DISABLE KEYS */;
INSERT INTO `Testings` VALUES (1,'SELECT USER_DEACTIVATED, DEACTIVATION_TIME, LAST_SUCCESSFUL_CONNECT FROM USERS WHERE USER =\'SYSTEM\';',1,'2.1',1),(1,'nmap -sS -sU -p 1-65536 IP',1,'2.2',2),(1,'Evaluate performing requestings documentation/email, etc. the effective changing of  PKI SSFS after implementation',1,'2.3',3),(1,'cat /etc/passwd',1,'2.4',2),(1,'SELECT * FROM \"PUBLIC\" . \"M_INIFILE_CONTENTS\" WHERE SECTION = \'auditing configuration\' AND KEY = \'global_auditing_state\';',1,'2.5',1),(1,'Survey/check if Trace files (and which) are enabled and for how long are keept, and request examples/samples (if possible, to see them by using SAP HANA Database explorer, evaluate request access).',1,'2.6',3),(1,'SELECT * FROM SYS_DATABASES.M_INIFILE_CONTENTS WHERE DATABASE_NAME=\'<TENANT_DB_NAME>\' AND SECTION=\'communication\' AND KEY = \'ssltruststore\';',1,'2.7',1),(1,'SELECT DISTINCT USER_NAME FROM USER_PARAMETERS WHERE PARAMETER = \'XS_RC_XS_CONTROLLER_ADMIN\'',1,'3.1',1),(1,'xs spaces',1,'3.2',2),(1,'Request to IT, the network map or/and other documentation where it would be possible to evaluate the network segmentation and the interfaces with SAP server/database.',1,'3.3',3),(2,'If possible, evaluate the changing date of PKI SSFS.',1,'2.3',2);
/*!40000 ALTER TABLE `Testings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-23 23:28:04
