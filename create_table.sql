-- Forward Engineer SQL CREATE Script
-- https://dev.mysql.com/doc/workbench/en/wb-forward-engineering-sql-scripts.html
-- https://docs.oracle.com/cd/E19078-01/mysql/mysql-workbench/workbench-faq.html

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `youtube`.`users` (
  `user_id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `birth_date` DATE NULL,
  `gender` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postal_code` INT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `playlist_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `create_date` DATETIME NULL,
  `state` ENUM('private', 'public') NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `video_id` INT NOT NULL,
  `title` VARCHAR(200) NULL,
  `description` TEXT NULL,
  `size` INT NULL,
  `video_file` VARCHAR(45) NULL,
  `video_duration` INT NULL,
  `thumbnail_url` VARCHAR(45) NULL,
  `reproduction_number` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `state` ENUM('public', 'ocult', 'private') NULL,
  `user` INT NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`video_id`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `user`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`playlist_video` (
  `playlist_id` INT NULL,
  `video_id` INT NULL,
  INDEX `playlist_id_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `playlist_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlist` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`video_etiquets` (
  `video_etiquet_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`video_etiquet_id`),
  CONSTRAINT `video_etiquet_is`
    FOREIGN KEY (`video_etiquet_id`)
    REFERENCES `youtube`.`etiquets_has_video` (`etiquets_has_video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`likes_dislikes_videos` (
  `user_id` INT NULL,
  `video_id` INT NULL,
  `value` TINYINT NULL,
  `date` DATETIME NULL,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`comments_comments_like_dislike` (
  `user_id` INT NOT NULL,
  `date` DATETIME NULL,
  `value` TINYINT NULL,
  `comments_comment_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `comments_comment_id`),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`etiquets_has_video` (
  `etiquets_has_video_id` INT NOT NULL,
  `video_id` INT NULL,
  PRIMARY KEY (`etiquets_has_video_id`),
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`comments_video` (
  `video_id` INT NULL,
  `comment_id` INT NOT NULL,
  `comment_text` TEXT NULL,
  `date` DATETIME NULL,
  `user_id` INT NULL,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  PRIMARY KEY (`comment_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `canal_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `creation_date` DATE NULL,
  `user` INT NULL,
  PRIMARY KEY (`canal_id`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `user`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`subscribers` (
  `canal_id` INT NULL,
  `user_id` INT NULL,
  INDEX `canal_id_idx` (`canal_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `canal_id`
    FOREIGN KEY (`canal_id`)
    REFERENCES `youtube`.`canal` (`canal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
