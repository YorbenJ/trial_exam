-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hospital` ;
USE `Hospital` ;

-- -----------------------------------------------------
-- Table `Hospital`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Medical` (
  `id` INT NOT NULL,
  `Overtime_rate` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Specialist` (
  `Field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Field_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctor` (
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `Address` VARCHAR(100) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Salary` DECIMAL(10,2) NULL,
  `Medical_id` INT NOT NULL,
  `Specialist_Field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE,
  INDEX `fk_Doctor_Medical_idx` (`Medical_id` ASC) VISIBLE,
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_Field_area` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Medical`
    FOREIGN KEY (`Medical_id`)
    REFERENCES `Hospital`.`Medical` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_Field_area`)
    REFERENCES `Hospital`.`Specialist` (`Field_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Patient` (
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Payment` (
  `id` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Appointment` (
  `id` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Time` TIME NOT NULL,
  `Doctor_Name` VARCHAR(45) NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  `Payment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_Name` ASC) VISIBLE,
  INDEX `fk_Appointment_Patient1_idx` (`Patient_Name` ASC) VISIBLE,
  INDEX `fk_Appointment_Payment1_idx` (`Payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_Name`)
    REFERENCES `Hospital`.`Doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_Name`)
    REFERENCES `Hospital`.`Patient` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Payment1`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `Hospital`.`Payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Bill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Total` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Payment_has_Bill` (
  `Payment_id` INT NOT NULL,
  `Bill_id` INT NOT NULL,
  PRIMARY KEY (`Payment_id`, `Bill_id`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_id` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `Hospital`.`Payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_id`)
    REFERENCES `Hospital`.`Bill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
