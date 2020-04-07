CREATE TABLE IF NOT EXISTS `firstresponse`.`job_roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  `perm` INT NOT NULL DEFAULT 0,
  `job_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`key`),
  INDEX (job_id),
  FOREIGN KEY (job_id) REFERENCES jobs(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COLLATE = 'latin1_swedish_ci'