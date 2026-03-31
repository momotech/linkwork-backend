-- Reverse engineered from LinkWork/back entities + service query patterns
-- Target: MySQL 8.x

CREATE DATABASE IF NOT EXISTS `linkwork`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE `linkwork`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- 1) 任务表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_task` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `task_no` VARCHAR(64) NOT NULL,
  `role_id` BIGINT NOT NULL,
  `role_name` VARCHAR(128) DEFAULT NULL,
  `prompt` LONGTEXT,
  `status` VARCHAR(32) NOT NULL DEFAULT 'pending',
  `image` VARCHAR(255) DEFAULT NULL,
  `selected_model` VARCHAR(255) DEFAULT NULL,
  `assembly_id` BIGINT DEFAULT NULL,
  `config_json` LONGTEXT,
  `source` VARCHAR(16) NOT NULL DEFAULT 'MANUAL',
  `cron_job_id` BIGINT DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `creator_ip` VARCHAR(64) DEFAULT NULL,
  `updater_id` VARCHAR(64) DEFAULT NULL,
  `updater_name` VARCHAR(128) DEFAULT NULL,
  `tokens_used` INT NOT NULL DEFAULT 0,
  `input_tokens` INT DEFAULT NULL,
  `output_tokens` INT DEFAULT NULL,
  `request_count` INT DEFAULT NULL,
  `token_limit` BIGINT DEFAULT NULL,
  `usage_percent` DECIMAL(7,4) DEFAULT NULL,
  `duration_ms` BIGINT NOT NULL DEFAULT 0,
  `report_json` LONGTEXT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_no` (`task_no`),
  KEY `idx_task_creator_created` (`creator_id`, `created_at`),
  KEY `idx_task_role_created` (`role_id`, `created_at`),
  KEY `idx_task_status_created` (`status`, `created_at`),
  KEY `idx_task_cron_job` (`cron_job_id`),
  KEY `idx_task_deleted_created` (`is_deleted`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务表';

-- ------------------------------------------------------------
-- 2) 岗位表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_workstation` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `role_no` VARCHAR(64) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `description` TEXT,
  `category` VARCHAR(32) DEFAULT NULL,
  `icon` VARCHAR(512) DEFAULT NULL,
  `image` VARCHAR(512) DEFAULT NULL,
  `prompt` LONGTEXT,
  `status` VARCHAR(32) DEFAULT 'active',
  `config_json` JSON DEFAULT NULL,
  `is_public` TINYINT(1) NOT NULL DEFAULT 0,
  `max_employees` INT NOT NULL DEFAULT 1,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `updater_id` VARCHAR(64) DEFAULT NULL,
  `updater_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_workstation_role_no` (`role_no`),
  KEY `idx_workstation_name` (`name`),
  KEY `idx_workstation_category` (`category`),
  KEY `idx_workstation_status` (`status`),
  KEY `idx_workstation_creator` (`creator_id`),
  KEY `idx_workstation_visibility` (`is_deleted`, `is_public`, `creator_id`),
  KEY `idx_workstation_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位表';

-- ------------------------------------------------------------
-- 3) 岗位收藏表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_user_favorite_workstation` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(64) NOT NULL,
  `role_id` BIGINT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_role_favorite` (`user_id`, `role_id`),
  KEY `idx_favorite_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏岗位';

-- ------------------------------------------------------------
-- 4) 技能表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_skill` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `skill_no` VARCHAR(64) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `display_name` VARCHAR(255) DEFAULT NULL,
  `description` TEXT,
  `implementation` LONGTEXT,
  `status` VARCHAR(32) NOT NULL DEFAULT 'draft',
  `is_public` TINYINT(1) NOT NULL DEFAULT 0,
  `branch_name` VARCHAR(255) DEFAULT NULL,
  `latest_commit` VARCHAR(64) DEFAULT NULL,
  `last_synced_at` DATETIME DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `updater_id` VARCHAR(64) DEFAULT NULL,
  `updater_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_skill_no` (`skill_no`),
  KEY `idx_skill_name` (`name`),
  KEY `idx_skill_branch_name` (`branch_name`),
  KEY `idx_skill_visibility` (`is_deleted`, `status`, `is_public`, `creator_id`),
  KEY `idx_skill_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='技能表';

-- ------------------------------------------------------------
-- 5) MCP 服务表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_mcp_server` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `mcp_no` VARCHAR(64) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `endpoint` VARCHAR(1024) DEFAULT NULL,
  `description` TEXT,
  `visibility` VARCHAR(16) NOT NULL DEFAULT 'private',
  `status` VARCHAR(16) NOT NULL DEFAULT 'unknown',
  `type` VARCHAR(16) NOT NULL DEFAULT 'http',
  `url` VARCHAR(2048) DEFAULT NULL,
  `headers` JSON DEFAULT NULL,
  `network_zone` VARCHAR(20) NOT NULL DEFAULT 'external',
  `health_check_url` VARCHAR(2048) DEFAULT NULL,
  `health_latency_ms` INT DEFAULT NULL,
  `health_message` VARCHAR(1024) DEFAULT NULL,
  `consecutive_failures` INT NOT NULL DEFAULT 0,
  `version` VARCHAR(64) DEFAULT NULL,
  `tags` JSON DEFAULT NULL,
  `last_health_at` DATETIME DEFAULT NULL,
  `config_json` JSON DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `updater_id` VARCHAR(64) DEFAULT NULL,
  `updater_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_mcp_no` (`mcp_no`),
  KEY `idx_mcp_name` (`name`),
  KEY `idx_mcp_type` (`type`),
  KEY `idx_mcp_status` (`status`),
  KEY `idx_mcp_visibility` (`visibility`, `creator_id`),
  KEY `idx_mcp_creator_created` (`creator_id`, `created_at`),
  KEY `idx_mcp_deleted_created` (`is_deleted`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='MCP 服务表';

-- ------------------------------------------------------------
-- 6) MCP 用户凭证配置
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_mcp_user_config` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(64) NOT NULL,
  `mcp_server_id` BIGINT NOT NULL,
  `headers` JSON DEFAULT NULL,
  `url_params` JSON DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_mcp` (`user_id`, `mcp_server_id`),
  KEY `idx_mcp_user_config_server` (`mcp_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户 MCP 个人凭证配置';

-- ------------------------------------------------------------
-- 7) MCP 使用量日汇总
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_mcp_usage_daily` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `mcp_name` VARCHAR(128) NOT NULL,
  `call_count` INT NOT NULL DEFAULT 0,
  `req_bytes` BIGINT NOT NULL DEFAULT 0,
  `resp_bytes` BIGINT NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_date_user_mcp` (`date`, `user_id`, `mcp_name`),
  KEY `idx_mcp_usage_user_date` (`user_id`, `date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='MCP 使用量日汇总';

-- ------------------------------------------------------------
-- 8) GitLab 授权表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_user_auth_gitlab` (
  `id` BIGINT NOT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `gitlab_id` BIGINT NOT NULL,
  `username` VARCHAR(128) DEFAULT NULL,
  `name` VARCHAR(128) DEFAULT NULL,
  `avatar_url` VARCHAR(1024) DEFAULT NULL,
  `access_token` TEXT,
  `refresh_token` TEXT,
  `token_alias` VARCHAR(64) DEFAULT NULL,
  `expires_at` DATETIME DEFAULT NULL,
  `scope` VARCHAR(255) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_gitlab_user_scope` (`user_id`, `gitlab_id`, `scope`),
  KEY `idx_gitlab_user_deleted_updated` (`user_id`, `is_deleted`, `updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户 GitLab 授权';

-- ------------------------------------------------------------
-- 9) 任务-Git 认证映射
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_task_git_auth` (
  `task_id` VARCHAR(64) NOT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `provider` VARCHAR(32) NOT NULL,
  `gitlab_auth_id` BIGINT DEFAULT NULL,
  `expires_at` DATETIME DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`task_id`),
  KEY `idx_task_git_auth_user` (`user_id`),
  KEY `idx_task_git_auth_gitlab` (`gitlab_auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务与 Git 认证映射';

-- ------------------------------------------------------------
-- 10) 审批表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_approval` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `approval_no` VARCHAR(64) NOT NULL,
  `task_no` VARCHAR(64) DEFAULT NULL,
  `request_id` VARCHAR(128) DEFAULT NULL,
  `task_title` VARCHAR(255) DEFAULT NULL,
  `action` LONGTEXT,
  `description` TEXT,
  `risk_level` VARCHAR(16) DEFAULT NULL,
  `status` VARCHAR(32) NOT NULL DEFAULT 'pending',
  `decision` VARCHAR(32) DEFAULT NULL,
  `comment` TEXT,
  `operator_id` VARCHAR(64) DEFAULT NULL,
  `operator_name` VARCHAR(128) DEFAULT NULL,
  `operator_ip` VARCHAR(64) DEFAULT NULL,
  `expired_at` DATETIME DEFAULT NULL,
  `decided_at` DATETIME DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_approval_no` (`approval_no`),
  KEY `idx_approval_task_no` (`task_no`),
  KEY `idx_approval_request_id` (`request_id`),
  KEY `idx_approval_creator_status_created` (`creator_id`, `status`, `created_at`),
  KEY `idx_approval_status_expired` (`status`, `expired_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='审批表';

-- ------------------------------------------------------------
-- 11) 构建记录
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_build_record` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `build_no` VARCHAR(64) NOT NULL,
  `role_id` BIGINT DEFAULT NULL,
  `role_name` VARCHAR(128) DEFAULT NULL,
  `status` VARCHAR(32) NOT NULL,
  `image_tag` VARCHAR(512) DEFAULT NULL,
  `duration_ms` BIGINT DEFAULT NULL,
  `error_message` TEXT,
  `log_url` VARCHAR(2048) DEFAULT NULL,
  `config_snapshot` JSON DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_build_no` (`build_no`),
  KEY `idx_build_role_created` (`role_id`, `created_at`),
  KEY `idx_build_status_created` (`status`, `created_at`),
  KEY `idx_build_creator_created` (`creator_id`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='镜像构建记录';

-- ------------------------------------------------------------
-- 12) 安全策略
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_security_policy` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `description` TEXT,
  `type` VARCHAR(32) NOT NULL,
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `rules_json` LONGTEXT,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_policy_type_created` (`type`, `created_at`),
  KEY `idx_policy_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='安全策略';

-- ------------------------------------------------------------
-- 13) 定时任务
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_cron_job` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `job_name` VARCHAR(255) NOT NULL,
  `creator_id` VARCHAR(64) NOT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `role_id` BIGINT NOT NULL,
  `role_name` VARCHAR(128) DEFAULT NULL,
  `model_id` VARCHAR(255) NOT NULL,
  `file_ids_json` LONGTEXT,
  `schedule_type` VARCHAR(16) NOT NULL,
  `cron_expr` VARCHAR(128) DEFAULT NULL,
  `interval_ms` BIGINT DEFAULT NULL,
  `run_at` DATETIME DEFAULT NULL,
  `timezone` VARCHAR(64) DEFAULT NULL,
  `task_content` LONGTEXT,
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `delete_after_run` TINYINT(1) NOT NULL DEFAULT 0,
  `max_retry` INT NOT NULL DEFAULT 3,
  `consecutive_failures` INT NOT NULL DEFAULT 0,
  `next_fire_time` DATETIME DEFAULT NULL,
  `notify_mode` VARCHAR(32) DEFAULT NULL,
  `notify_target` VARCHAR(255) DEFAULT NULL,
  `total_runs` INT NOT NULL DEFAULT 0,
  `last_run_time` DATETIME DEFAULT NULL,
  `last_run_status` VARCHAR(32) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_cron_job_creator_deleted_created` (`creator_id`, `is_deleted`, `created_at`),
  KEY `idx_cron_job_role_deleted_enabled` (`role_id`, `is_deleted`, `enabled`),
  KEY `idx_cron_job_due` (`enabled`, `is_deleted`, `next_fire_time`),
  KEY `idx_cron_job_schedule_type` (`schedule_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务';

-- ------------------------------------------------------------
-- 14) 定时任务运行记录
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_cron_job_run` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `cron_job_id` BIGINT NOT NULL,
  `task_no` VARCHAR(64) DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `role_id` BIGINT DEFAULT NULL,
  `status` VARCHAR(32) NOT NULL,
  `trigger_type` VARCHAR(32) DEFAULT NULL,
  `planned_fire_time` DATETIME DEFAULT NULL,
  `started_at` DATETIME DEFAULT NULL,
  `finished_at` DATETIME DEFAULT NULL,
  `duration_ms` BIGINT DEFAULT NULL,
  `error_message` TEXT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cron_run_job_created` (`cron_job_id`, `created_at`),
  KEY `idx_cron_run_task_no` (`task_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务运行记录';

-- ------------------------------------------------------------
-- 15) 用户偏好（User Soul）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_user_soul` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(64) NOT NULL,
  `soul` LONGTEXT,
  `template_id` VARCHAR(64) DEFAULT NULL,
  `creator_id` VARCHAR(64) DEFAULT NULL,
  `creator_name` VARCHAR(128) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_user_soul_user_deleted_updated` (`user_id`, `is_deleted`, `updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户偏好配置';

-- ------------------------------------------------------------
-- 16) 文件元数据
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_file` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `file_id` VARCHAR(64) NOT NULL,
  `file_name` VARCHAR(512) NOT NULL,
  `file_size` BIGINT NOT NULL,
  `file_type` VARCHAR(32) NOT NULL,
  `content_type` VARCHAR(128) DEFAULT NULL,
  `space_type` VARCHAR(32) NOT NULL,
  `workstation_id` VARCHAR(64) DEFAULT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `oss_path` VARCHAR(1024) NOT NULL,
  `parsed_oss_path` VARCHAR(1024) DEFAULT NULL,
  `parse_status` VARCHAR(32) DEFAULT NULL,
  `memory_index_status` VARCHAR(32) DEFAULT NULL,
  `file_hash` CHAR(64) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_workspace_file_id` (`file_id`),
  KEY `idx_workspace_user_space_ws_deleted_created` (`user_id`, `space_type`, `workstation_id`, `deleted_at`, `created_at`),
  KEY `idx_workspace_user_space_name_ws_deleted` (`user_id`, `space_type`, `file_name`, `workstation_id`, `deleted_at`),
  KEY `idx_workspace_user_oss_deleted` (`user_id`, `oss_path`, `deleted_at`),
  KEY `idx_workspace_file_hash` (`file_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件元数据';

-- ------------------------------------------------------------
-- 17) 文件树节点
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkwork_file_node` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `node_id` VARCHAR(64) NOT NULL,
  `parent_id` VARCHAR(64) DEFAULT NULL,
  `entry_type` VARCHAR(16) NOT NULL,
  `name` VARCHAR(512) NOT NULL,
  `space_type` VARCHAR(32) NOT NULL,
  `workstation_id` VARCHAR(64) DEFAULT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `file_id` VARCHAR(64) DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_file_node_node_id` (`node_id`),
  KEY `idx_file_node_user_space_ws_parent_deleted` (`user_id`, `space_type`, `workstation_id`, `parent_id`, `deleted_at`),
  KEY `idx_file_node_user_space_ws_name_parent_deleted` (`user_id`, `space_type`, `workstation_id`, `name`, `parent_id`, `deleted_at`),
  KEY `idx_file_node_parent_deleted` (`parent_id`, `deleted_at`),
  KEY `idx_file_node_file_deleted` (`file_id`, `deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件树节点';

SET FOREIGN_KEY_CHECKS = 1;
