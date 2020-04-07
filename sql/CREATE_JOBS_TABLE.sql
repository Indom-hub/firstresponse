CREATE TABLE IF NOT EXISTS `firstresponse`.`jobs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`key`)
) COLLATE = 'latin1_swedish_ci'