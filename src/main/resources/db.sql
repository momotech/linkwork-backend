-- LinkWork MySQL schema export
-- Export date: 2026-03-28
-- Includes database/user bootstrap for local staging import.

CREATE DATABASE IF NOT EXISTS `linkwork`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;


USE `linkwork`;

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_approval` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approval_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `risk_level` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decision` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `operator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operator_ip` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expired_at` datetime DEFAULT NULL,
  `decided_at` datetime DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_approval_approval_no` (`approval_no`),
  KEY `idx_linkwork_approval_task_no` (`task_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_build_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `build_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration_ms` bigint DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `log_url` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_snapshot` json DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_build_record_build_no` (`build_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_cron_job` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_ids_json` longtext COLLATE utf8mb4_unicode_ci,
  `schedule_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cron_expr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interval_ms` bigint DEFAULT NULL,
  `run_at` datetime DEFAULT NULL,
  `timezone` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_content` longtext COLLATE utf8mb4_unicode_ci,
  `enabled` tinyint(1) DEFAULT '1',
  `delete_after_run` tinyint(1) DEFAULT '0',
  `max_retry` int DEFAULT '0',
  `consecutive_failures` int DEFAULT '0',
  `next_fire_time` datetime DEFAULT NULL,
  `notify_mode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notify_target` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_runs` int DEFAULT '0',
  `last_run_time` datetime DEFAULT NULL,
  `last_run_status` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_cron_job_run` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cron_job_id` bigint DEFAULT NULL,
  `task_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trigger_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_fire_time` datetime DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `duration_ms` bigint DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_file` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `file_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `workstation_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oss_path` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parsed_oss_path` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parse_status` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memory_index_status` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_hash` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_file_file_id` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_file_node` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `node_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `workstation_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_file_node_node_id` (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_mcp_server` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mcp_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `endpoint` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `visibility` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'private',
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'unknown',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headers` json DEFAULT NULL,
  `network_zone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'external',
  `health_check_url` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `health_latency_ms` int DEFAULT NULL,
  `health_message` text COLLATE utf8mb4_unicode_ci,
  `consecutive_failures` int DEFAULT '0',
  `version` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` json DEFAULT NULL,
  `last_health_at` datetime DEFAULT NULL,
  `config_json` json DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_mcp_server_mcp_no` (`mcp_no`),
  KEY `idx_linkwork_mcp_server_name` (`name`),
  KEY `idx_linkwork_mcp_server_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_mcp_usage_daily` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mcp_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_count` int DEFAULT '0',
  `req_bytes` bigint DEFAULT '0',
  `resp_bytes` bigint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_linkwork_mcp_usage_daily_date_user` (`date`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_mcp_user_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mcp_server_id` bigint DEFAULT NULL,
  `headers` json DEFAULT NULL,
  `url_params` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_linkwork_mcp_user_config_user_id` (`user_id`),
  KEY `idx_linkwork_mcp_user_config_server_id` (`mcp_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_security_policy` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `rules_json` longtext COLLATE utf8mb4_unicode_ci,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_skill` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `skill_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `implementation` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '1',
  `branch_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latest_commit` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_synced_at` datetime DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_skill_name` (`name`),
  UNIQUE KEY `uk_linkwork_skill_skill_no` (`skill_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint DEFAULT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prompt` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selected_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assembly_id` bigint DEFAULT NULL,
  `config_json` longtext COLLATE utf8mb4_unicode_ci,
  `source` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cron_job_id` bigint DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_ip` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tokens_used` int DEFAULT '0',
  `input_tokens` int DEFAULT '0',
  `output_tokens` int DEFAULT '0',
  `request_count` int DEFAULT '0',
  `token_limit` bigint DEFAULT NULL,
  `usage_percent` decimal(10,4) DEFAULT NULL,
  `duration_ms` bigint DEFAULT '0',
  `report_json` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_task_task_no` (`task_no`),
  KEY `idx_linkwork_task_status` (`status`),
  KEY `idx_linkwork_task_role_id` (`role_id`),
  KEY `idx_linkwork_task_creator_id` (`creator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_task_git_auth` (
  `task_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gitlab_auth_id` bigint DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`task_id`),
  KEY `idx_linkwork_task_git_auth_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_user_auth_gitlab` (
  `id` bigint NOT NULL,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gitlab_id` bigint DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_token` text COLLATE utf8mb4_unicode_ci,
  `refresh_token` text COLLATE utf8mb4_unicode_ci,
  `token_alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_linkwork_user_auth_gitlab_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_user_favorite_workstation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_user_favorite_role` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_user_soul` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soul` longtext COLLATE utf8mb4_unicode_ci,
  `template_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_user_soul_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkwork_workstation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `category` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prompt` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `config_json` json DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '1',
  `max_employees` int DEFAULT NULL,
  `creator_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updater_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_linkwork_workstation_role_no` (`role_no`),
  KEY `idx_linkwork_workstation_status` (`status`),
  KEY `idx_linkwork_workstation_creator_id` (`creator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
