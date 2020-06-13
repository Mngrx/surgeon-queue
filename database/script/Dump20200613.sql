-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: surgeon
-- ------------------------------------------------------
-- Server version	10.4.13-MariaDB

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
-- Table structure for table `acessos`
--

DROP TABLE IF EXISTS `acessos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acessos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acessos`
--

LOCK TABLES `acessos` WRITE;
/*!40000 ALTER TABLE `acessos` DISABLE KEYS */;
INSERT INTO `acessos` VALUES (1,'ADM','2020-06-13 06:08:09','2020-06-13 06:08:09'),(2,'FAR','2020-06-13 06:08:09','2020-06-13 06:08:09'),(3,'SAL','2020-06-13 06:08:09','2020-06-13 06:08:09');
/*!40000 ALTER TABLE `acessos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cirurgia_etapa`
--

DROP TABLE IF EXISTS `cirurgia_etapa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cirurgia_etapa` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cirurgia_id` bigint(20) unsigned NOT NULL,
  `etapa_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cirurgia_etapa_cirurgia_id_foreign` (`cirurgia_id`),
  KEY `cirurgia_etapa_etapa_id_foreign` (`etapa_id`),
  CONSTRAINT `cirurgia_etapa_cirurgia_id_foreign` FOREIGN KEY (`cirurgia_id`) REFERENCES `cirurgias` (`id`),
  CONSTRAINT `cirurgia_etapa_etapa_id_foreign` FOREIGN KEY (`etapa_id`) REFERENCES `etapas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cirurgia_etapa`
--

LOCK TABLES `cirurgia_etapa` WRITE;
/*!40000 ALTER TABLE `cirurgia_etapa` DISABLE KEYS */;
INSERT INTO `cirurgia_etapa` VALUES (1,1,1,NULL,NULL),(2,1,2,NULL,NULL),(3,5,1,NULL,NULL),(4,6,1,NULL,NULL),(5,7,1,NULL,NULL),(6,5,2,NULL,NULL),(7,6,2,NULL,NULL),(8,7,2,NULL,NULL);
/*!40000 ALTER TABLE `cirurgia_etapa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cirurgias`
--

DROP TABLE IF EXISTS `cirurgias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cirurgias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `paciente_id` bigint(20) unsigned NOT NULL,
  `horario` datetime NOT NULL,
  `sala` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `equipamento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `confirmado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cirurgias_paciente_id_foreign` (`paciente_id`),
  CONSTRAINT `cirurgias_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cirurgias`
--

LOCK TABLES `cirurgias` WRITE;
/*!40000 ALTER TABLE `cirurgias` DISABLE KEYS */;
INSERT INTO `cirurgias` VALUES (1,1,'2020-06-15 03:41:00','FM131','Mante\r\nPão\r\nPalelaria','2020-06-13 09:49:04','2020-06-13 11:59:50','2020-06-13 11:59:50'),(5,2,'2020-06-18 09:00:00','GM213','Luva\r\nPé\r\nMédico','2020-06-13 12:01:13','2020-06-13 12:03:07','2020-06-13 12:03:07'),(6,2,'2020-06-18 09:00:00','GM213','Luva\r\nPé\r\nMédico','2020-06-13 12:01:51','2020-06-13 12:15:15','2020-06-13 12:15:15'),(7,3,'2020-06-17 06:06:00','LK412','Joia','2020-06-13 12:05:55','2020-06-13 12:15:20','2020-06-13 12:15:20');
/*!40000 ALTER TABLE `cirurgias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etapas`
--

DROP TABLE IF EXISTS `etapas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etapas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sigla` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapas`
--

LOCK TABLES `etapas` WRITE;
/*!40000 ALTER TABLE `etapas` DISABLE KEYS */;
INSERT INTO `etapas` VALUES (1,'FAR','Farmacia','2020-06-13 05:48:19','2020-06-13 05:48:19'),(2,'SAL','Sala','2020-06-13 05:48:19','2020-06-13 05:48:19');
/*!40000 ALTER TABLE `etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (9,'2014_10_12_000000_create_users_table',1),(10,'2019_08_19_000000_create_failed_jobs_table',1),(11,'2020_06_12_010000_create_pacientes_table',1),(12,'2020_06_12_024448_create_cirurgias_table',2),(13,'2020_06_12_024508_create_etapas_table',2),(14,'2020_06_12_024550_create_acessos_table',2),(17,'2020_06_13_070132_change_table_cirurgias',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pacientes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nascimento` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'Igor Barbosa Nogueira','153.349.367-77','1998-01-04','2020-06-13 09:48:42','2020-06-13 09:48:42'),(2,'Igor','000.000.000-00','2008-03-12','2020-06-13 12:01:13','2020-06-13 12:01:13'),(3,'Pedro','999.999.999-99','1985-02-18','2020-06-13 12:05:55','2020-06-13 12:05:55');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_acesso`
--

DROP TABLE IF EXISTS `user_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_acesso` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `acesso_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_acesso_user_id_foreign` (`user_id`),
  KEY `user_acesso_acesso_id_foreign` (`acesso_id`),
  CONSTRAINT `user_acesso_acesso_id_foreign` FOREIGN KEY (`acesso_id`) REFERENCES `acessos` (`id`),
  CONSTRAINT `user_acesso_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_acesso`
--

LOCK TABLES `user_acesso` WRITE;
/*!40000 ALTER TABLE `user_acesso` DISABLE KEYS */;
INSERT INTO `user_acesso` VALUES (1,1,1,'2020-06-13 06:08:09','2020-06-13 06:08:09'),(2,2,2,'2020-06-13 06:08:09','2020-06-13 06:08:09'),(3,3,3,'2020-06-13 06:08:09','2020-06-13 06:08:09');
/*!40000 ALTER TABLE `user_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Adminstrador','admin@surgeon.com','2020-06-13 05:29:52','$2y$12$LyQpyKaRcUei7z8/TbSKhOwXiz9XW8MuFI4Ga86Va608nFkXjnNxa',NULL,'2020-06-13 05:29:52','2020-06-13 05:29:52'),(2,'Farmacia','farmacia@surgeon.com','2020-06-13 05:29:52','$2y$12$LyQpyKaRcUei7z8/TbSKhOwXiz9XW8MuFI4Ga86Va608nFkXjnNxa',NULL,'2020-06-13 05:29:52','2020-06-13 05:29:52'),(3,'Salas','sala@surgeon.com','2020-06-13 05:29:52','$2y$12$LyQpyKaRcUei7z8/TbSKhOwXiz9XW8MuFI4Ga86Va608nFkXjnNxa',NULL,'2020-06-13 05:29:52','2020-06-13 05:29:52');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-13  6:17:29
