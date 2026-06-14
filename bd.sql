-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.11.16-MariaDB - MariaDB Server
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para pke
CREATE DATABASE IF NOT EXISTS `pke` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `pke`;

-- Copiando estrutura para tabela pke.account_ban_history
CREATE TABLE IF NOT EXISTS `account_ban_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.account_bans
CREATE TABLE IF NOT EXISTS `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.account_viplist
CREATE TABLE IF NOT EXISTS `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `notify` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `premdays` int(11) NOT NULL DEFAULT 0,
  `lastday` int(10) unsigned NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL DEFAULT '',
  `creation` int(11) NOT NULL DEFAULT 0,
  `pontos` int(11) NOT NULL DEFAULT 0,
  `creationIp` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.blocked_ips
CREATE TABLE IF NOT EXISTS `blocked_ips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL DEFAULT 0,
  `bloqueado` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.bonificacoes
CREATE TABLE IF NOT EXISTS `bonificacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_admin_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `valorMin` int(11) NOT NULL,
  `valorMax` int(11) NOT NULL,
  `porcentagem` int(11) NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.boss_ranking
CREATE TABLE IF NOT EXISTS `boss_ranking` (
  `classificacao` int(11) NOT NULL,
  `player` varchar(255) NOT NULL,
  PRIMARY KEY (`classificacao`,`player`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_categoria_wiki
CREATE TABLE IF NOT EXISTS `config_categoria_wiki` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_inicio
CREATE TABLE IF NOT EXISTS `config_inicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pc` text DEFAULT NULL,
  `mobile32` text DEFAULT NULL,
  `mobile64` text DEFAULT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `youtube` varchar(255) DEFAULT NULL,
  `regras` longtext DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_bazar
CREATE TABLE IF NOT EXISTS `config_permission_bazar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_bonificacao
CREATE TABLE IF NOT EXISTS `config_permission_bonificacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_inicio
CREATE TABLE IF NOT EXISTS `config_permission_inicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_noticia
CREATE TABLE IF NOT EXISTS `config_permission_noticia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_pacotes
CREATE TABLE IF NOT EXISTS `config_permission_pacotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) DEFAULT 'F',
  `ler` varchar(1) DEFAULT 'F',
  `atualizar` varchar(1) DEFAULT 'F',
  `deletar` varchar(1) DEFAULT 'F',
  `status` varchar(1) DEFAULT 'F',
  `id_account` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_promocional
CREATE TABLE IF NOT EXISTS `config_permission_promocional` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_push
CREATE TABLE IF NOT EXISTS `config_permission_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_quests
CREATE TABLE IF NOT EXISTS `config_permission_quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_team
CREATE TABLE IF NOT EXISTS `config_permission_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_permission_wiki
CREATE TABLE IF NOT EXISTS `config_permission_wiki` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criar` varchar(1) NOT NULL DEFAULT 'F',
  `ler` varchar(1) NOT NULL DEFAULT 'F',
  `atualizar` varchar(1) NOT NULL DEFAULT 'F',
  `deletar` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `id_account` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_promocional
CREATE TABLE IF NOT EXISTS `config_promocional` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_admin_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `name_account` varchar(255) NOT NULL,
  `apelido` varchar(255) DEFAULT NULL,
  `porcentagem` int(11) NOT NULL,
  `codigo` text NOT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp(),
  `status` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_quests
CREATE TABLE IF NOT EXISTS `config_quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_admin_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `storage` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'T',
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_team
CREATE TABLE IF NOT EXISTS `config_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_account` int(11) NOT NULL,
  `apelido` varchar(50) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `imutavel` varchar(1) NOT NULL DEFAULT 'F',
  `status` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_vocations
CREATE TABLE IF NOT EXISTS `config_vocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_vocation` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.config_wiki
CREATE TABLE IF NOT EXISTS `config_wiki` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_admin_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `categoria_id` int(11) NOT NULL,
  `titulo` text NOT NULL,
  `corpo` longtext NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.download
CREATE TABLE IF NOT EXISTS `download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pc` text NOT NULL,
  `mobile` text NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.global_storage
CREATE TABLE IF NOT EXISTS `global_storage` (
  `key` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guild_invites
CREATE TABLE IF NOT EXISTS `guild_invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`) USING BTREE,
  KEY `player_id` (`player_id`,`guild_id`) USING BTREE,
  CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guild_members
CREATE TABLE IF NOT EXISTS `guild_members` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT '',
  `leader` tinyint(4) NOT NULL DEFAULT 0,
  `contribution` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`),
  KEY `guild_id` (`guild_id`),
  KEY `rank_id` (`rank_id`),
  CONSTRAINT `guild_members_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_members_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_members_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guild_ranks
CREATE TABLE IF NOT EXISTS `guild_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `permissions` int(11) NOT NULL DEFAULT 0,
  `default` tinyint(4) NOT NULL DEFAULT 0,
  `leader` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`),
  CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guild_wars
CREATE TABLE IF NOT EXISTS `guild_wars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild1` int(11) NOT NULL DEFAULT 0,
  `guild2` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `goldBet` int(11) NOT NULL DEFAULT 0,
  `duration` bigint(20) NOT NULL DEFAULT 0,
  `killsMax` int(11) NOT NULL DEFAULT 0,
  `forced` tinyint(4) NOT NULL DEFAULT 0,
  `started` bigint(20) NOT NULL DEFAULT 0,
  `ended` bigint(20) NOT NULL DEFAULT 0,
  `winner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `guild1` (`guild1`),
  KEY `guild2` (`guild2`),
  KEY `winner` (`winner`),
  CONSTRAINT `guild_wars_ibfk_1` FOREIGN KEY (`guild1`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_wars_ibfk_2` FOREIGN KEY (`guild2`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_wars_ibfk_3` FOREIGN KEY (`winner`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guilds
CREATE TABLE IF NOT EXISTS `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` bigint(20) unsigned NOT NULL DEFAULT 0,
  `level` int(10) unsigned NOT NULL DEFAULT 1,
  `gold` bigint(20) unsigned NOT NULL DEFAULT 0,
  `buffs` blob DEFAULT NULL,
  `wars_won` int(10) unsigned NOT NULL DEFAULT 0,
  `wars_lost` int(10) unsigned NOT NULL DEFAULT 0,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `join_status` tinyint(4) NOT NULL DEFAULT 1,
  `language` tinyint(4) NOT NULL DEFAULT 1,
  `required_level` int(11) NOT NULL DEFAULT 1,
  `emblem` int(11) NOT NULL DEFAULT 1,
  `pacifism` bigint(20) NOT NULL DEFAULT 0,
  `pacifism_status` tinyint(4) NOT NULL DEFAULT 0,
  `buffs_save` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `ownerid` (`ownerid`),
  CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guilds_inbox
CREATE TABLE IF NOT EXISTS `guilds_inbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  `date` bigint(20) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL,
  `text` varchar(255) NOT NULL,
  `finished` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guilds_inbox_old
CREATE TABLE IF NOT EXISTS `guilds_inbox_old` (
  `player_id` int(11) NOT NULL,
  `target_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  `date` bigint(20) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL,
  `text` varchar(255) NOT NULL,
  `finished` tinyint(4) NOT NULL DEFAULT 0,
  KEY `player_id` (`player_id`),
  CONSTRAINT `guilds_inbox_old_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guilds_player_inbox
CREATE TABLE IF NOT EXISTS `guilds_player_inbox` (
  `player_id` int(11) NOT NULL,
  `inbox_id` int(11) NOT NULL,
  KEY `player_id` (`player_id`),
  KEY `inbox_id` (`inbox_id`),
  CONSTRAINT `guilds_player_inbox_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  CONSTRAINT `guilds_player_inbox_ibfk_2` FOREIGN KEY (`inbox_id`) REFERENCES `guilds_inbox` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.guildwar_kills
CREATE TABLE IF NOT EXISTS `guildwar_kills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warid` int(11) NOT NULL DEFAULT 0,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT 0,
  `targetguild` int(11) NOT NULL DEFAULT 0,
  `time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `warid` (`warid`),
  CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.historico_bazar
CREATE TABLE IF NOT EXISTS `historico_bazar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(255) DEFAULT NULL,
  `account_id_comprador` int(11) NOT NULL,
  `account_id_vendedor` int(11) NOT NULL,
  `char_id` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  `pix` varchar(1) NOT NULL DEFAULT 'F',
  `pago_comprador` varchar(1) NOT NULL DEFAULT 'F',
  `pago_vendedor` varchar(1) NOT NULL DEFAULT 'F',
  `status_pagamento` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.historico_mp
CREATE TABLE IF NOT EXISTS `historico_mp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(250) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  `multiplicador` int(11) NOT NULL DEFAULT 1,
  `promocional_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `date_created` date DEFAULT NULL,
  `create_admin_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.historico_mp_shop
CREATE TABLE IF NOT EXISTS `historico_mp_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(250) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `full` varchar(1) NOT NULL DEFAULT 'F',
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `item_id_tibia` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `date_created` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.historico_pagamentos
CREATE TABLE IF NOT EXISTS `historico_pagamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(250) DEFAULT NULL,
  `tipo` varchar(255) NOT NULL,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `valor` int(11) NOT NULL,
  `id_pacote` int(11) DEFAULT NULL,
  `multiplicador` decimal(5,1) NOT NULL DEFAULT 1.0,
  `promocional_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `entregue` int(11) NOT NULL DEFAULT 0,
  `qrcode` mediumtext DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.house_lists
CREATE TABLE IF NOT EXISTS `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL,
  KEY `house_id` (`house_id`),
  CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.houses
CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `paid` int(10) unsigned NOT NULL DEFAULT 0,
  `warnings` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `bid` int(11) NOT NULL DEFAULT 0,
  `bid_end` int(11) NOT NULL DEFAULT 0,
  `last_bid` int(11) NOT NULL DEFAULT 0,
  `highest_bidder` int(11) NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `beds` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `town_id` (`town_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.ip_bans
CREATE TABLE IF NOT EXISTS `ip_bans` (
  `ip` int(10) unsigned NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`ip`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.market_history
CREATE TABLE IF NOT EXISTS `market_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL DEFAULT 0,
  `expires_at` bigint(20) unsigned NOT NULL,
  `inserted` bigint(20) unsigned NOT NULL,
  `state` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`,`sale`),
  CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.market_offers
CREATE TABLE IF NOT EXISTS `market_offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `created` bigint(20) unsigned NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT 0,
  `price` bigint(20) unsigned NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `attributes` blob DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale` (`itemtype`),
  KEY `created` (`created`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.noticias
CREATE TABLE IF NOT EXISTS `noticias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_admin_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `titulo` text NOT NULL,
  `texto` longtext DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `date_created` datetime DEFAULT current_timestamp(),
  `date_update` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.pacotes
CREATE TABLE IF NOT EXISTS `pacotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `id_item_pacote` int(11) NOT NULL,
  `cor_pacote` varchar(100) NOT NULL,
  `caminho_tag` varchar(255) DEFAULT NULL,
  `caminho_itens` longtext DEFAULT NULL,
  `created_admin_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `valor_cortado` decimal(10,2) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'F',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_update` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cod` varchar(1000) NOT NULL,
  `method` varchar(200) NOT NULL,
  `status` varchar(255) NOT NULL,
  `price` float(9,2) DEFAULT NULL,
  `delivery` int(11) NOT NULL DEFAULT 0 COMMENT '0,1',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `mercadopago` int(11) NOT NULL DEFAULT 0,
  `bank_transfer` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.pix_payment
CREATE TABLE IF NOT EXISTS `pix_payment` (
  `player_id` int(11) NOT NULL,
  `loc_id` int(11) NOT NULL,
  `txid` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `creation` varchar(255) DEFAULT NULL,
  UNIQUE KEY `txid` (`txid`),
  UNIQUE KEY `loc` (`loc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_deaths
CREATE TABLE IF NOT EXISTS `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) unsigned NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT 1,
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT 0,
  `unjustified` tinyint(1) NOT NULL DEFAULT 0,
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT 0,
  KEY `player_id` (`player_id`),
  KEY `killed_by` (`killed_by`),
  KEY `mostdamage_by` (`mostdamage_by`),
  CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_depotitems
CREATE TABLE IF NOT EXISTS `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` mediumint(9) NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_inboxitems
CREATE TABLE IF NOT EXISTS `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` mediumint(9) NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_items
CREATE TABLE IF NOT EXISTS `player_items` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `pid` int(11) NOT NULL DEFAULT 0,
  `sid` int(11) NOT NULL DEFAULT 0,
  `itemtype` mediumint(9) NOT NULL DEFAULT 0,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL,
  KEY `player_id` (`player_id`),
  KEY `sid` (`sid`),
  CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_namelocks
CREATE TABLE IF NOT EXISTS `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL,
  PRIMARY KEY (`player_id`),
  KEY `namelocked_by` (`namelocked_by`),
  CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_seller
CREATE TABLE IF NOT EXISTS `player_seller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_seller` int(11) NOT NULL,
  `char_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `pix_blocked` varchar(1) NOT NULL DEFAULT 'F',
  `date_pix_blocked` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_spells
CREATE TABLE IF NOT EXISTS `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.player_storage
CREATE TABLE IF NOT EXISTS `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `key` int(10) unsigned NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`,`key`),
  CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 1,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 500,
  `vocation` int(11) NOT NULL DEFAULT 0,
  `image` text DEFAULT NULL,
  `health` int(11) NOT NULL DEFAULT 150,
  `healthmax` int(11) NOT NULL DEFAULT 150,
  `experience` bigint(20) NOT NULL DEFAULT 13752,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 510,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `manamax` int(11) NOT NULL DEFAULT 0,
  `manaspent` int(10) unsigned NOT NULL DEFAULT 0,
  `soul` int(10) unsigned NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 13,
  `posx` int(11) NOT NULL DEFAULT 2474,
  `posy` int(11) NOT NULL DEFAULT 1793,
  `posz` int(11) NOT NULL DEFAULT 1,
  `conditions` blob DEFAULT NULL,
  `cap` int(11) NOT NULL DEFAULT 6,
  `sex` int(11) NOT NULL DEFAULT 0,
  `lastlogin` bigint(20) unsigned NOT NULL DEFAULT 0,
  `lastip` varchar(255) DEFAULT NULL,
  `save` tinyint(1) NOT NULL DEFAULT 1,
  `skull` tinyint(1) NOT NULL DEFAULT 0,
  `skulltime` int(11) NOT NULL DEFAULT 0,
  `lastlogout` bigint(20) unsigned NOT NULL DEFAULT 0,
  `blessings` tinyint(4) NOT NULL DEFAULT 0,
  `onlinetime` int(11) DEFAULT 0,
  `deletion` bigint(20) NOT NULL DEFAULT 0,
  `balance` bigint(20) unsigned NOT NULL DEFAULT 0,
  `offlinetraining_time` smallint(5) unsigned NOT NULL DEFAULT 43200,
  `offlinetraining_skill` int(11) NOT NULL DEFAULT -1,
  `stamina` smallint(5) unsigned NOT NULL DEFAULT 2520,
  `skill_fist` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_fist_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `skill_club` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_club_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `skill_sword` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_sword_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `skill_axe` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_axe_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `skill_dist` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_dist_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `skill_shielding` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_shielding_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `skill_fishing` int(10) unsigned NOT NULL DEFAULT 10,
  `skill_fishing_tries` bigint(20) unsigned NOT NULL DEFAULT 0,
  `pokemons` varchar(2000) NOT NULL DEFAULT '',
  `creationdate` int(11) DEFAULT NULL,
  `lookaura` int(11) NOT NULL DEFAULT 0,
  `lookwings` int(11) NOT NULL DEFAULT 0,
  `lookshader` int(11) NOT NULL DEFAULT 0,
  `diamond` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `account_id` (`account_id`),
  KEY `vocation` (`vocation`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.players_online
CREATE TABLE IF NOT EXISTS `players_online` (
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.players_stringstorages
CREATE TABLE IF NOT EXISTS `players_stringstorages` (
  `player_id` int(11) NOT NULL,
  `key` int(11) NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`player_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.pokeball_stats
CREATE TABLE IF NOT EXISTS `pokeball_stats` (
  `player_id` int(11) NOT NULL,
  `pokemonName` varchar(255) NOT NULL,
  `poke` int(11) NOT NULL DEFAULT 0,
  `great` int(11) NOT NULL DEFAULT 0,
  `ultra` int(11) NOT NULL DEFAULT 0,
  `saffari` int(11) NOT NULL DEFAULT 0,
  `master` int(11) NOT NULL DEFAULT 0,
  `moon` int(11) NOT NULL DEFAULT 0,
  `tinker` int(11) NOT NULL DEFAULT 0,
  `sora` int(11) NOT NULL DEFAULT 0,
  `dusk` int(11) NOT NULL DEFAULT 0,
  `yume` int(11) NOT NULL DEFAULT 0,
  `tale` int(11) NOT NULL DEFAULT 0,
  `net` int(11) NOT NULL DEFAULT 0,
  `janguru` int(11) NOT NULL DEFAULT 0,
  `magu` int(11) NOT NULL DEFAULT 0,
  `fast` int(11) NOT NULL DEFAULT 0,
  `heavy` int(11) NOT NULL DEFAULT 0,
  `premier` int(11) NOT NULL DEFAULT 0,
  `delta` int(11) NOT NULL DEFAULT 0,
  `esferadepal` int(11) NOT NULL DEFAULT 0,
  `esferamega` int(11) NOT NULL DEFAULT 0,
  `esferagiga` int(11) NOT NULL DEFAULT 0,
  `esferatera` int(11) NOT NULL DEFAULT 0,
  `esferaultra` int(11) NOT NULL DEFAULT 0,
  `esferalendaria` int(11) NOT NULL DEFAULT 0,
  `super` int(11) NOT NULL DEFAULT 0,
  `especial` int(11) NOT NULL DEFAULT 0,
  `divine` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`,`pokemonName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.pokemon_points
CREATE TABLE IF NOT EXISTS `pokemon_points` (
  `player_id` int(11) NOT NULL,
  `pokemonName` varchar(255) NOT NULL,
  `pontos` int(11) NOT NULL,
  PRIMARY KEY (`player_id`,`pokemonName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.push
CREATE TABLE IF NOT EXISTS `push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_admin_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `mensagem` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.redeem_codes
CREATE TABLE IF NOT EXISTS `redeem_codes` (
  `id` int(11) NOT NULL,
  `serial` text DEFAULT NULL,
  `type` text DEFAULT NULL,
  `player_id` int(11) DEFAULT NULL,
  `max_uses` int(11) DEFAULT NULL,
  `total_used` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.server_config
CREATE TABLE IF NOT EXISTS `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`config`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.shop_historico
CREATE TABLE IF NOT EXISTS `shop_historico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `shop_item_id` int(11) NOT NULL,
  `item_id_tibia` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `full` varchar(1) NOT NULL DEFAULT 'F',
  `desconto` int(11) DEFAULT NULL,
  `valor` int(11) NOT NULL,
  `entregue` int(11) NOT NULL DEFAULT 0,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.shop_history
CREATE TABLE IF NOT EXISTS `shop_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` int(11) NOT NULL,
  `player` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `title` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account` (`account`),
  KEY `player` (`player`),
  CONSTRAINT `shop_history_ibfk_1` FOREIGN KEY (`account`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shop_history_ibfk_2` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.shop_image
CREATE TABLE IF NOT EXISTS `shop_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_item_id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL DEFAULT 1,
  `caminho` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.shop_item
CREATE TABLE IF NOT EXISTS `shop_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id_tibia` int(11) DEFAULT NULL,
  `created_admin_id` int(11) DEFAULT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `categoria_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `maximo` int(11) DEFAULT NULL,
  `descricao` text NOT NULL,
  `desconto` int(11) DEFAULT NULL,
  `valor` int(11) NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'T',
  `date_created` datetime DEFAULT NULL,
  `date_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.suporte
CREATE TABLE IF NOT EXISTS `suporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `update_admin_id` int(11) DEFAULT NULL,
  `image1` text DEFAULT NULL,
  `image2` text DEFAULT NULL,
  `titulo` varchar(50) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.suporte_respostas
CREATE TABLE IF NOT EXISTS `suporte_respostas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suporte_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `resposta` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.tile_store
CREATE TABLE IF NOT EXISTS `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL,
  KEY `house_id` (`house_id`),
  CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.tokenvalidat
CREATE TABLE IF NOT EXISTS `tokenvalidat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_account` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expired` varchar(1) DEFAULT 'F',
  `validation_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela pke.verificar_callback
CREATE TABLE IF NOT EXISTS `verificar_callback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passou` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para trigger pke.oncreate_guilds_leader
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER oncreate_guilds_leader
AFTER INSERT ON guilds
FOR EACH ROW
INSERT INTO guild_ranks (name, permissions, guild_id, leader)
VALUES ('the Leader', -1, NEW.id, 1)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger pke.oncreate_guilds_member
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER oncreate_guilds_member
AFTER INSERT ON guilds
FOR EACH ROW
INSERT INTO guild_ranks (name, permissions, guild_id, is_default)
VALUES ('a Member', 0, NEW.id, 1)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger pke.set_date_created
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER set_date_created
BEFORE INSERT ON historico_mp
FOR EACH ROW
SET NEW.date_created = CURDATE()//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger pke.set_date_created_historico_mp_shop
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER set_date_created_historico_mp_shop
BEFORE INSERT ON historico_mp_shop
FOR EACH ROW
SET NEW.date_created = CURDATE()//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
