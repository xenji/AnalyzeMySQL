CREATE TABLE `bar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_registred` date DEFAULT NULL,
  `foo_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `foo` (
  `foo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(3000) DEFAULT NULL,
  `value` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`foo_id`),
  KEY `IDX_name` (`name`(255))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;