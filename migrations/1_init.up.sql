
CREATE TABLE `alphabets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `script_code` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letters` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alphabets_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alphabet_language` (
  `alphabet_id` int(10) unsigned NOT NULL,
  `language_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `definitions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL,
  `sub_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `main_language_code` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `related_definitions` json DEFAULT NULL,
  `rating` tinyint(3) unsigned NOT NULL,
  `meta` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1248 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `definition_language` (
  `definition_id` int(10) unsigned NOT NULL,
  `language_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `definition_titles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `definition_id` int(10) unsigned NOT NULL,
  `alphabet_code` varchar(20) COLLATE utf8mb4_unicode_ci NULL,
  `title` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `definition_titles_definition_id_index` (`definition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1346 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_code` varchar(7) COLLATE utf8mb4_unicode_ci NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_names` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `languages_code_unique` (`code`),
  KEY `languages_parent_code_index` (`parent_code`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` json NOT NULL,
  `string` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `definition_id` int(10) unsigned NOT NULL,
  `language_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `practical` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `literal` text COLLATE utf8mb4_unicode_ci,
  `meaning` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `translations_definition_id_index` (`definition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1248 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `transliterations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `parent_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transliteration` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1348 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
