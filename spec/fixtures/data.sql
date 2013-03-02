LOCK TABLES `bar` WRITE;
/*!40000 ALTER TABLE `bar` DISABLE KEYS */;

INSERT INTO `bar` (`id`, `date_registred`, `foo_id`)
VALUES
	(1,'2013-03-02',1),
	(2,'2013-03-02',3);

/*!40000 ALTER TABLE `bar` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `foo` WRITE;
/*!40000 ALTER TABLE `foo` DISABLE KEYS */;

INSERT INTO `foo` (`foo_id`, `name`, `value`)
  VALUES
  (1,'test',0),
  (2,'test2',400),
  (3,'test3',15000);

/*!40000 ALTER TABLE `foo` ENABLE KEYS */;
UNLOCK TABLES;