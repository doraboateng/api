
create table `alphabets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `script_code` varchar(4) DEFAULT NULL,
  `names` text COLLATE utf8mb4_unicode_ci,
  `letters` text COLLATE utf8mb4_unicode_ci,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `cultures` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `language_code` varchar(7) DEFAULT NULL,
  `names` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `definitions` (
  `id` bigint unsigned not null AUTO_INCREMENT,
  `type` tinyint unsigned NOT NULL,
  `sub_type` varchar(10) NOT NULL,
  `titles` text COLLATE utf8mb4_unicode_ci,
  `languages` text COLLATE utf8mb4_unicode_ci,

  `de_practical_translation` text,
  `de_literal_translation` text,
  `de_meaning` text,

  `en_practical_translation` text,
  `en_literal_translation` text,
  `en_meaning` text,

  `es_practical_translation` text,
  `es_literal_translation` text,
  `es_meaning` text,

  `fr_practical_translation` text,
  `fr_literal_translation` text,
  `fr_meaning` text,

  `it_practical_translation` text,
  `it_literal_translation` text,
  `it_meaning` text,

  `pt_practical_translation` text,
  `pt_literal_translation` text,
  `pt_meaning` text,

  `reference` text COLLATE utf8mb4_unicode_ci,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1248 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `languages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(7) NOT NULL,
  `parent_code` varchar(7) NULL,
  `names` text COLLATE utf8mb4_unicode_ci,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(3) NOT NULL,
  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
