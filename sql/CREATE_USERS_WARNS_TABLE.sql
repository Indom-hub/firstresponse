CREATE TABLE IF NOT EXISTS `firstresponse`.`warns` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reason` TEXT NULL DEFAULT NULL,
  `warned_user` INT NOT NULL,
  `staff_user` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX (warned_user),
  INDEX (staff_user),
  FOREIGN KEY (warned_user) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (staff_user) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COLLATE = 'latin1_swedish_ci'