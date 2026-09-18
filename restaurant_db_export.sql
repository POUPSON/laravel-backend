-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: restaurant_db
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.22.04.3

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
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `prix` decimal(8,2) NOT NULL,
  `sous_categorie_id` bigint unsigned NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `articles_sous_categorie_id_foreign` (`sous_categorie_id`),
  CONSTRAINT `articles_sous_categorie_id_foreign` FOREIGN KEY (`sous_categorie_id`) REFERENCES `sous_categories` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Pizza Margherita',NULL,5000.00,3,1,'2026-09-14 11:08:28','2026-09-14 11:08:28'),(2,'Kadji','Kadji',1000.00,6,1,'2026-09-15 08:42:06','2026-09-15 08:42:06'),(3,'Beignets haricots','Beignets farine avec de l\' haricot',1000.00,1,1,'2026-09-16 18:05:40','2026-09-16 18:05:40'),(4,'Koki-plantain','Koki avec du plaitain murs',1500.00,3,1,'2026-09-16 18:06:33','2026-09-16 18:06:33'),(5,'Ndole riz poulet','Ndole avec du riz blanc et du poulet',2000.00,3,1,'2026-09-16 18:07:31','2026-09-16 18:07:31'),(6,'Salade de fruits','Salade avec ananas, mangue, pastèque',1500.00,4,1,'2026-09-16 18:09:51','2026-09-16 18:09:51'),(7,'33','Bières',1000.00,6,1,'2026-09-16 18:10:54','2026-09-16 18:10:54'),(8,'Fondant au chocolat','Gâteau fondant au chocolat',1500.00,4,1,'2026-09-16 18:17:03','2026-09-16 18:17:03'),(9,'Cheesecake','Gâteau au fromage frais',2000.00,4,1,'2026-09-16 18:17:27','2026-09-16 18:17:27'),(10,'Crevettes marinées','Crevettes marinées',2000.00,1,1,'2026-09-16 18:19:17','2026-09-16 18:19:17'),(11,'Castel Beer','Castel Beer',1000.00,6,1,'2026-09-16 18:21:39','2026-09-16 18:21:39'),(12,'Mutzig','Mutzig',1000.00,6,1,'2026-09-16 18:21:50','2026-09-16 18:21:50'),(13,'Guinness','Guinness',1000.00,6,1,'2026-09-16 18:22:06','2026-09-16 18:22:06'),(14,'Jus de Gingembre','Jus de Gingembre',1500.00,8,1,'2026-09-16 18:23:17','2026-09-16 18:23:17'),(15,'Jus de Baobab','Jus de Baobab',1000.00,8,1,'2026-09-16 18:23:35','2026-09-16 18:23:35'),(16,'Jus de Tamarin','Jus de Tamarin',1000.00,8,1,'2026-09-16 18:23:48','2026-09-16 18:23:48'),(17,'Jus de Foléré','Jus de Foléré',1000.00,8,1,'2026-09-16 18:24:06','2026-09-16 18:24:06'),(18,'Orangina','Orangina',1000.00,7,1,'2026-09-16 18:25:52','2026-09-16 18:25:52'),(19,'D\'jino','D\'jino',1200.00,7,1,'2026-09-16 18:26:09','2026-09-16 18:26:09');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commandes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `numero_table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'non_payee',
  `total` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commandes_user_id_foreign` (`user_id`),
  CONSTRAINT `commandes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commandes`
--

LOCK TABLES `commandes` WRITE;
/*!40000 ALTER TABLE `commandes` DISABLE KEYS */;
INSERT INTO `commandes` VALUES (1,2,'1','payee',10000.00,'2026-09-14 11:09:49','2026-09-15 08:49:25'),(4,2,'1','payee',10000.00,'2026-09-15 09:19:30','2026-09-18 11:40:03'),(5,2,'4','payee',1000.00,'2026-09-16 19:24:05','2026-09-18 11:49:43'),(6,2,'8','payee',3500.00,'2026-09-18 11:49:36','2026-09-18 11:49:51');
/*!40000 ALTER TABLE `commandes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_commandes`
--

DROP TABLE IF EXISTS `detail_commandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_commandes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `commande_id` bigint unsigned NOT NULL,
  `article_id` bigint unsigned NOT NULL,
  `quantite` int NOT NULL,
  `prix_unitaire` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_commandes_commande_id_foreign` (`commande_id`),
  KEY `detail_commandes_article_id_foreign` (`article_id`),
  CONSTRAINT `detail_commandes_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `detail_commandes_commande_id_foreign` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_commandes`
--

LOCK TABLES `detail_commandes` WRITE;
/*!40000 ALTER TABLE `detail_commandes` DISABLE KEYS */;
INSERT INTO `detail_commandes` VALUES (1,1,1,2,5000.00,'2026-09-14 11:09:49','2026-09-14 11:09:49'),(5,4,1,2,5000.00,'2026-09-15 09:19:30','2026-09-15 09:19:30'),(6,5,3,1,1000.00,'2026-09-16 19:24:05','2026-09-16 19:24:05'),(7,6,3,1,1000.00,'2026-09-18 11:49:37','2026-09-18 11:49:37'),(8,6,6,1,1500.00,'2026-09-18 11:49:37','2026-09-18 11:49:37'),(9,6,13,1,1000.00,'2026-09-18 11:49:37','2026-09-18 11:49:37');
/*!40000 ALTER TABLE `detail_commandes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
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
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_09_14_094130_add_role_to_users_table',1),(5,'2026_09_14_094200_create_sous_categories_table',1),(6,'2026_09_14_094224_create_articles_table',1),(7,'2026_09_14_094314_create_commandes_table',1),(8,'2026_09_14_094351_create_detail_commandes_table',1),(9,'2026_09_14_095017_create_personal_access_tokens_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'auth_token','2198938ee96477c33078899d2db3ffd271266a7b3738b281bdba7682a4518c5a','[\"*\"]',NULL,NULL,'2026-09-14 11:05:27','2026-09-14 11:05:27'),(2,'App\\Models\\User',1,'auth_token','87cd7c72ba1bc8c577e1dde72b82c35596eabfb083a4e834bb45d3a642094e35','[\"*\"]','2026-09-14 11:08:28',NULL,'2026-09-14 11:06:29','2026-09-14 11:08:28'),(3,'App\\Models\\User',2,'auth_token','e1e3c2d98e1a5c9f242a07fff56791a23ef0653692ee513148f3ee423f373ebf','[\"*\"]','2026-09-14 12:34:00',NULL,'2026-09-14 11:09:24','2026-09-14 12:34:00'),(4,'App\\Models\\User',1,'auth_token','bb6aaf4222e9ed82a81c3cbe09abe8024737e7d622de3965d2a6727488722595','[\"*\"]','2026-09-15 08:06:20',NULL,'2026-09-15 08:03:05','2026-09-15 08:06:20'),(5,'App\\Models\\User',2,'auth_token','cd928fde8a47fbdf9642d1dad492c42a0792945d587b835955ab0548fd9fe33b','[\"*\"]','2026-09-15 08:19:24',NULL,'2026-09-15 08:13:00','2026-09-15 08:19:24'),(7,'App\\Models\\User',1,'auth_token','874e00f8a4b03a63090304ba30b1aa2d0ad3b3ad8734ef4da31f75b5bbcf6735','[\"*\"]','2026-09-15 08:42:07',NULL,'2026-09-15 08:39:15','2026-09-15 08:42:07'),(8,'App\\Models\\User',2,'auth_token','5733fcd654ddcc94eab36cf8baada1aa5aab442f82e50e4c5798cb3d8d3eade0','[\"*\"]','2026-09-15 08:43:21',NULL,'2026-09-15 08:42:14','2026-09-15 08:43:21'),(9,'App\\Models\\User',2,'auth_token','eb30a44f3f2a71c53a4fd52d0c82b3d8c74cad0b38aaf34ec331dfe6f5ac59d2','[\"*\"]','2026-09-15 08:43:27',NULL,'2026-09-15 08:43:25','2026-09-15 08:43:27'),(10,'App\\Models\\User',1,'auth_token','0c9cbc8e3eddfc46f1011a63d5f7a4d6ce632e6b664949849368d6d47edf9089','[\"*\"]','2026-09-15 08:49:46',NULL,'2026-09-15 08:43:33','2026-09-15 08:49:46'),(11,'App\\Models\\User',2,'auth_token','d40c40ff7621a0074843a976d08d709a72800bbc31f94d3047980272a3c967fb','[\"*\"]','2026-09-15 10:04:28',NULL,'2026-09-15 09:18:57','2026-09-15 10:04:28'),(12,'App\\Models\\User',1,'auth_token','a31c49779a52ae35a5a9b401853f27cbaca003570cdecb93af7a8f1474868770','[\"*\"]','2026-09-15 11:43:30',NULL,'2026-09-15 10:28:14','2026-09-15 11:43:30'),(14,'App\\Models\\User',2,'auth_token','25e4fd987b1851d44e23143ac3c94867d7f6e5eb4b1106bc93104e8411ad8dd7','[\"*\"]','2026-09-15 11:58:00',NULL,'2026-09-15 11:57:16','2026-09-15 11:58:00'),(15,'App\\Models\\User',1,'auth_token','109bfbdc71b8c091622a8ea696c7e2dcf33953464c894c7b97c4bcfb78fae38b','[\"*\"]','2026-09-15 12:06:56',NULL,'2026-09-15 12:00:20','2026-09-15 12:06:56'),(16,'App\\Models\\User',2,'auth_token','958b1ad2e5db75c5f447bf0a19924405a6dc2bf1579eb42366a7a174218414bf','[\"*\"]','2026-09-15 22:02:50',NULL,'2026-09-15 12:07:01','2026-09-15 22:02:50'),(17,'App\\Models\\User',1,'auth_token','3fc2a8dda9a53f1660728db666275e87a4b22e17b075319592e33714d1c211a8','[\"*\"]','2026-09-15 22:10:33',NULL,'2026-09-15 22:10:16','2026-09-15 22:10:33'),(18,'App\\Models\\User',1,'auth_token','b92427a1912bed836f349513a010dc18ea334443a2ed65d5a028a2bc5638cfd5','[\"*\"]','2026-09-15 22:18:46',NULL,'2026-09-15 22:10:23','2026-09-15 22:18:46'),(19,'App\\Models\\User',2,'auth_token','ae49ea81b3ef1e9318732fd5491f7607c6211c03f1af21cbef6142a924eb72cc','[\"*\"]',NULL,NULL,'2026-09-16 17:37:28','2026-09-16 17:37:28'),(20,'App\\Models\\User',2,'auth_token','a82d52defa8d8bbe4a14551372016c567a2ef74b71de7e78879dfccbf198bd6a','[\"*\"]','2026-09-16 17:37:42',NULL,'2026-09-16 17:37:40','2026-09-16 17:37:42'),(21,'App\\Models\\User',1,'auth_token','ac0221eb945be7a238d75f72de0e05f384e529af3a2d9182d1eb581a72c2f9ef','[\"*\"]','2026-09-16 18:13:21',NULL,'2026-09-16 17:38:20','2026-09-16 18:13:21'),(22,'App\\Models\\User',2,'auth_token','d78d4297c255d41c334c3605efa2050101dd7e1e5ee960e56d7a6ef87c610c5e','[\"*\"]','2026-09-16 18:16:14',NULL,'2026-09-16 18:13:57','2026-09-16 18:16:14'),(23,'App\\Models\\User',1,'auth_token','689bb8051d283247a924e08ea6528130b642ecea42cf6218a916a57a7472a66b','[\"*\"]','2026-09-16 19:07:25',NULL,'2026-09-16 18:16:42','2026-09-16 19:07:25'),(24,'App\\Models\\User',2,'auth_token','c7a451a58f850f2b0013e30c866ebeb32824982c9377babb66d707e88bce59a2','[\"*\"]','2026-09-16 19:08:15',NULL,'2026-09-16 19:07:33','2026-09-16 19:08:15'),(25,'App\\Models\\User',1,'auth_token','5242528ee05802ffb23f623e2a0c8e7ba0da8ca7fc55ace34fc515edd467417f','[\"*\"]','2026-09-16 19:08:52',NULL,'2026-09-16 19:08:26','2026-09-16 19:08:52'),(26,'App\\Models\\User',2,'auth_token','d610b73316f27b69c497c2b2361d566a87ea46e420b2c2522d7534bedea4598c','[\"*\"]','2026-09-18 11:40:05',NULL,'2026-09-16 19:09:00','2026-09-18 11:40:05'),(27,'App\\Models\\User',1,'auth_token','56e56e6ba87778fb62faf6653a8988337799e2240f8bf199b6490e54c8b81d4c','[\"*\"]','2026-09-18 11:49:09',NULL,'2026-09-18 11:40:30','2026-09-18 11:49:09'),(28,'App\\Models\\User',2,'auth_token','5f67df8dc945dc31c3f4a1c197fafc1c56f601774ea8bec304e1c5590f99675a','[\"*\"]','2026-09-18 11:49:52',NULL,'2026-09-18 11:49:22','2026-09-18 11:49:52'),(29,'App\\Models\\User',1,'auth_token','0970a4d8267a934808d79b0851b84065ec1af9b74c1ad8cb0959a3e2dc18bcca','[\"*\"]','2026-09-18 12:05:52',NULL,'2026-09-18 11:50:09','2026-09-18 12:05:52'),(30,'App\\Models\\User',1,'auth_token','40d2ae1aa45986441120bc6569f23e10fd5a3cc2b5e6346f89b6006b226d310c','[\"*\"]','2026-09-18 11:57:43',NULL,'2026-09-18 11:55:52','2026-09-18 11:57:43');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sous_categories`
--

DROP TABLE IF EXISTS `sous_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sous_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sous_categories`
--

LOCK TABLES `sous_categories` WRITE;
/*!40000 ALTER TABLE `sous_categories` DISABLE KEYS */;
INSERT INTO `sous_categories` VALUES (1,'Amuses-bouches','plat','2026-09-14 11:02:36','2026-09-14 11:02:36'),(2,'Entrées','plat','2026-09-14 11:02:37','2026-09-14 11:02:37'),(3,'Plats principaux','plat','2026-09-14 11:02:37','2026-09-14 11:02:37'),(4,'Desserts','plat','2026-09-14 11:02:38','2026-09-14 11:02:38'),(6,'Bières','boisson','2026-09-14 11:02:38','2026-09-14 11:02:38'),(7,'boissons gazeuses','boisson','2026-09-14 11:02:39','2026-09-16 18:25:20'),(8,'Jus naturels','boisson','2026-09-14 11:02:39','2026-09-16 18:23:04');
/*!40000 ALTER TABLE `sous_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'serveur',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin1','admin@test.com',NULL,'$2y$12$dvuAuR5TpYbBTV4XyxKKge4mg1BDqNCy7Hl3xKEOIVydWosF8E.EG','admin',NULL,'2026-09-14 11:03:30','2026-09-15 22:11:47'),(2,'Serveur1','serveur@test.com',NULL,'$2y$12$dvuAuR5TpYbBTV4XyxKKge4mg1BDqNCy7Hl3xKEOIVydWosF8E.EG','serveur',NULL,'2026-09-14 11:03:30','2026-09-15 10:29:02');
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

-- Dump completed on 2026-09-18 16:03:21
