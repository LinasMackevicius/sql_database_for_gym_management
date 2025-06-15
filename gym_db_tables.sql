-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema gym2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gym2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gym2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_lithuanian_ci ;
SHOW WARNINGS;
USE `gym2` ;

-- -----------------------------------------------------
-- Table `gym2`.`klientas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`klientas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`klientas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vardas` VARCHAR(45) NOT NULL,
  `pavarde` VARCHAR(45) NOT NULL,
  `gimimo_data` DATE NULL,
  `lytis` ENUM('vyras', 'moteris', 'kita') NOT NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`kliento_paskyra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_paskyra` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`kliento_paskyra` (
  `klientas_id` INT NOT NULL,
  `el_pastas` VARCHAR(100) NOT NULL UNIQUE,
  `slaptazodis_hash` VARCHAR(255) NOT NULL,
  `paskyros_busena` ENUM('aktyvi', 'atostogos', 'uzblokuota', 'nepatvirtinta') DEFAULT 'nepatvirtinta',
  `sukurimo_data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`klientas_id`),
  CONSTRAINT `fk_kliento_paskyra_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `gym2`.`kliento_tapatybe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_tapatybe` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`kliento_tapatybe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `klientas_id` INT NOT NULL UNIQUE,
  `identifikavimo_kodas` VARCHAR(255) NOT NULL UNIQUE,
  `tipas` ENUM ('kortele','pin_kodas', 'NFC/bluetooth' , 'biometrinis', 'barcode/qr code') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_tapatybe_klientas1_idx` (`klientas_id`),
  CONSTRAINT `fk_kliento_tapatybe_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`kliento_apsilankymas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_apsilankymas` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`kliento_apsilankymas` (
  `id` INT NOT NULL AUTO_INCREMENT,

  `apsilankymo_laikas` DATETIME NOT NULL,

  `sporto_klubo_vieta_id` INT NOT NULL,

  `kliento_tapatybe_id` INT NOT NULL,

  PRIMARY KEY (`id`),
  INDEX `fk_kliento_apsilankymas_sporto_klubo_vieta1_idx` (`sporto_klubo_vieta_id`),
  INDEX `fk_kliento_apsilankymas_kliento_tapatybe1_idx` (`kliento_tapatybe_id`),

  CONSTRAINT `fk_kliento_apsilankymas_sporto_klubo_vieta1`
    FOREIGN KEY (`sporto_klubo_vieta_id`)
    REFERENCES `gym2`.`sporto_klubo_vieta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
  CONSTRAINT `fk_kliento_apsilankymas_kliento_tapatybe1`
    FOREIGN KEY (`kliento_tapatybe_id`)
    REFERENCES `gym2`.`kliento_tapatybe` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `gym2`.`kliento_telefonas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_telefonas` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`kliento_telefonas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `telefonas` VARCHAR(20) NOT NULL UNIQUE,
  `klientas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_telefonas_klientas1_idx` (`klientas_id`),
  CONSTRAINT `fk_kliento_telefonas_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;

--------------------------------------------------------
-- Table `gym2`.`asmeninis_treneris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`asmeninis_treneris` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`asmeninis_treneris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vardas` VARCHAR(45) NOT NULL,
  `pavarde` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`sporto_klubas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`sporto_klubas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`sporto_klubas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  `telefonas` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE(`pavadinimas`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`pareigos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`pareigos` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`pareigos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`darbuotojas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`darbuotojas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`darbuotojas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vardas` VARCHAR(45) NOT NULL,
  `pavarde` VARCHAR(45) NOT NULL,
  `sporto_klubas_id` INT NULL,
  `pareigos_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_darbuotojas_sporto_klubas1_idx` (`sporto_klubas_id`),
  INDEX `fk_darbuotojas_pareigos1_idx` (`pareigos_id`),
  CONSTRAINT `fk_darbuotojas_sporto_klubas1`
    FOREIGN KEY (`sporto_klubas_id`)
    REFERENCES `gym2`.`sporto_klubas` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_darbuotojas_pareigos1`
    FOREIGN KEY (`pareigos_id`)
    REFERENCES `gym2`.`pareigos` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION
   )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`el_pasto_paskirtis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`el_pasto_paskirtis` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`el_pasto_paskirtis` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`el_pastas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`el_pastas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`el_pastas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `el_pasto_adresas` VARCHAR(45) NOT NULL UNIQUE,
  `sporto_klubas_id` INT NOT NULL,
  `el_pasto_paskirtis_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_el_pastas_sporto_klubas1_idx` (`sporto_klubas_id`) ,
  INDEX `fk_el_pastas_el_pasto_paskirtis1_idx` (`el_pasto_paskirtis_id`),
  CONSTRAINT `fk_el_pastas_sporto_klubas1`
    FOREIGN KEY (`sporto_klubas_id`)
    REFERENCES `gym2`.`sporto_klubas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_el_pastas_el_pasto_paskirtis1`
    FOREIGN KEY (`el_pasto_paskirtis_id`)
    REFERENCES `gym2`.`el_pasto_paskirtis` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`grupes_treneris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`grupes_treneris` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`grupes_treneris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vardas` VARCHAR(45) NOT NULL,
  `pavarde` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`naryste`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`naryste` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`naryste` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  `menesio_kaina` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`mokejimo_budas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`mokejimo_budas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`mokejimo_budas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aprasymas` VARCHAR(225) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`narystes_kodas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`narystes_kodas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`narystes_kodas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `kodas` VARCHAR(45) NULL,
  `salies_kodas` CHAR(3) NULL,
  `kaina` DECIMAL(6,2) NULL,
  `valiuta` CHAR(3) NULL,
  `akcijos_kodas` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`kliento_abonementas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_abonementas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`kliento_abonementas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sutarties_numeris` VARCHAR(45) NULL UNIQUE,
  `klientas_id` INT NOT NULL UNIQUE,
  `naryste_id` INT NOT NULL,
  `mokejimo_budas_id` INT NOT NULL,
  `galiojimo_pradzia` DATE NOT NULL,
  `galiojimo_pabaiga` DATE NOT NULL,
  `narystes_kodas_id` INT NULL,
  INDEX `fk_kliento_abonementas_naryste1_idx` (`naryste_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_abonementas_klientas1_idx` (`klientas_id` ASC) INVISIBLE,
  INDEX `fk_kliento_abonementas_mokejimo_budas1_idx` (`mokejimo_budas_id` ASC) VISIBLE,
  INDEX `fk_kliento_abonementas_narystes_kodas1_idx` (`narystes_kodas_id` ASC) VISIBLE,
  CONSTRAINT `fk_kliento_abonementas_naryste1`
    FOREIGN KEY (`naryste_id`)
    REFERENCES `gym2`.`naryste` (`id`),
  CONSTRAINT `fk_kliento_abonementas_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE NO CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_abonementas_mokėjimo_budas1`
    FOREIGN KEY (`mokejimo_budas_id`)
    REFERENCES `gym2`.`mokejimo_budas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_abonementas_narystes_kodas1`
    FOREIGN KEY (`narystes_kodas_id`)
    REFERENCES `gym2`.`narystes_kodas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`miestas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`miestas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`miestas` (
  `id` INT NOT NULL,
  `pavadinimas` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`sporto_klubo_vieta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`sporto_klubo_vieta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`sporto_klubo_vieta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sporto_klubas_id` INT NOT NULL,
  `miestas_id` INT NOT NULL,
  `adresas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sporto_klubo_vieta_sporto_klubas1_idx` (`sporto_klubas_id` ASC) VISIBLE,
  INDEX `fk_sporto_klubo_vieta_miestas1_idx` (`miestas_id` ASC) VISIBLE,
  CONSTRAINT `fk_sporto_klubo_vieta_sporto_klubas1`
    FOREIGN KEY (`sporto_klubas_id`)
    REFERENCES `gym2`.`sporto_klubas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_sporto_klubo_vieta_miestas1`
    FOREIGN KEY (`miestas_id`)
    REFERENCES `gym2`.`miestas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`asmenine_treniruote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`asmenine_treniruote` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`asmenine_treniruote` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `asmeninis_treneris_id` INT NOT NULL,
  `sporto_klubo_vieta_id` INT NOT NULL,
  `klientas_id` INT NOT NULL UNIQUE,
  `treniruotes_pradzia` DATETIME NOT NULL,
  `treniruotes_pabaiga` DATETIME NOT NULL, -- Minimum 1 hour session duration;
  PRIMARY KEY (`id`),
  INDEX `fk_asmenine_treniruote_asmeninis_treneris1_idx` (`asmeninis_treneris_id` ASC) VISIBLE,
  INDEX `fk_asmenine_treniruote_sporto_klubo_vieta1_idx` (`sporto_klubo_vieta_id` ASC) VISIBLE,
  INDEX `fk_asmenine_treniruote_klientas1_idx` (`klientas_id` ASC) VISIBLE,
  UNIQUE INDEX `unique_asmeninis_treneris_pradzia` (`asmeninis_treneris_id` ASC, `treniruotes_pradzia` ASC) VISIBLE,
  CONSTRAINT `fk_asmenine_treniruote_asmeninis_treneris1`
    FOREIGN KEY (`asmeninis_treneris_id`)
    REFERENCES `gym2`.`asmeninis_treneris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asmenine_treniruote_sporto_klubo_vieta1`
    FOREIGN KEY (`sporto_klubo_vieta_id`)
    REFERENCES `gym2`.`sporto_klubo_vieta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  CONSTRAINT `fk_asmenine_treniruote_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`grupine_treniruote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`grupine_treniruote` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`grupine_treniruote` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`grupines_treniruotes_sesija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`grupines_treniruotes_sesija` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`grupines_treniruotes_sesija` (
  `grupines_treniruotes_sesija_id` INT NOT NULL AUTO_INCREMENT,
  `pradzios_laikas` DATETIME NOT NULL,
  `pabaigos_laikas` DATETIME NOT NULL,
  `grupes_treneris_grupes_trenerio_id` INT NOT NULL,
  `sporto_klubo_vieta_sporto_klubo_vietos_id` INT NOT NULL,
  `grupine_treniruote_grupines_treniruotes_id` INT NOT NULL,
  PRIMARY KEY (`grupines_treniruotes_sesija_id`),
  INDEX `fk_grupines_treniruotes_sesija_grupes_treneris1_idx` (`grupes_treneris_grupes_trenerio_id` ASC) VISIBLE,
  INDEX `fk_grupines_treniruotes_sesija_sporto_klubo_vieta1_idx` (`sporto_klubo_vieta_sporto_klubo_vietos_id` ASC) VISIBLE,
  INDEX `fk_grupines_treniruotes_sesija_grupine_treniruote1_idx` (`grupine_treniruote_grupines_treniruotes_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupines_treniruotes_sesija_grupes_treneris1`
    FOREIGN KEY (`grupes_treneris_grupes_trenerio_id`)
    REFERENCES `gym2`.`grupes_treneris` (`grupes_trenerio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupines_treniruotes_sesija_sporto_klubo_vieta1`
    FOREIGN KEY (`sporto_klubo_vieta_sporto_klubo_vietos_id`)
    REFERENCES `gym2`.`sporto_klubo_vieta` (`sporto_klubo_vietos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupines_treniruotes_sesija_grupine_treniruote1`
    FOREIGN KEY (`grupine_treniruote_grupines_treniruotes_id`)
    REFERENCES `gym2`.`grupine_treniruote` (`grupines_treniruotes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`kliento_grupines_treniruotes_sesija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_grupines_treniruotes_sesija` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`kliento_grupines_treniruotes_sesija` (
  `kliento_grupines_treniruotes_sesijos_id` INT NOT NULL AUTO_INCREMENT,
  `klientas_kliento_id` INT NULL,
  `grupines_treniruotes_sesija_grupines_treniruotes_sesija_id` INT NULL,
  PRIMARY KEY (`kliento_grupines_treniruotes_sesijos_id`),
  INDEX `fk_kliento_grupines_treniruotes_sesija_klientas1_idx` (`klientas_kliento_id` ASC) VISIBLE,
  INDEX `fk_kliento_grupines_treniruotes_sesija_grupines_treniruotes_idx` (`grupines_treniruotes_sesija_grupines_treniruotes_sesija_id` ASC) VISIBLE,
  CONSTRAINT `fk_kliento_grupines_treniruotes_sesija_klientas1`
    FOREIGN KEY (`klientas_kliento_id`)
    REFERENCES `gym2`.`klientas` (`kliento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_grupines_treniruotes_sesija_grupines_treniruotes_s1`
    FOREIGN KEY (`grupines_treniruotes_sesija_grupines_treniruotes_sesija_id`)
    REFERENCES `gym2`.`grupines_treniruotes_sesija` (`grupines_treniruotes_sesija_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`paslauga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`paslauga` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`paslauga` (
  `paslaugos_id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paslaugos_id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`narystes_paslauga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`narystes_paslauga` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`narystes_paslauga` (
  `narystes_paslaugos_id` INT NOT NULL AUTO_INCREMENT,
  `paslaugos_id` INT NOT NULL,
  `narystes_id` INT NOT NULL,
  PRIMARY KEY (`narystes_paslaugos_id`),
  INDEX `fk_narystes_paslauga_paslauga1_idx` (`paslaugos_id` ASC) VISIBLE,
  INDEX `fk_narystes_paslauga_naryste1_idx` (`narystes_id` ASC) VISIBLE,
  CONSTRAINT `fk_narystes_paslauga_naryste1`
    FOREIGN KEY (`narystes_id`)
    REFERENCES `gym2`.`naryste` (`narystes_id`),
  CONSTRAINT `fk_narystes_paslauga_paslauga1`
    FOREIGN KEY (`paslaugos_id`)
    REFERENCES `gym2`.`paslauga` (`paslaugos_id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`inventoriaus_elementas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`inventoriaus_elementas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`inventoriaus_elementas` (
  `inventoriaus_elemento_id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  `gamintojas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`inventoriaus_elemento_id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`sporto_klubo_inventorius`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`sporto_klubo_inventorius` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`sporto_klubo_inventorius` (
  `sporto_klubo_inventoriaus_id` INT NOT NULL AUTO_INCREMENT,
  `sporto_klubo_vieta_sporto_klubo_vietos_id` INT NOT NULL,
  `inventoriaus_elementas_inventoriaus_elemento_id` INT NOT NULL,
  `kiekis` INT NULL,
  PRIMARY KEY (`sporto_klubo_inventoriaus_id`),
  INDEX `fk_sporto_klubo_inventorius_sporto_klubo_vieta1_idx` (`sporto_klubo_vieta_sporto_klubo_vietos_id` ASC) VISIBLE,
  INDEX `fk_sporto_klubo_inventorius_inventoriaus elementas1_idx` (`inventoriaus_elementas_inventoriaus_elemento_id` ASC) VISIBLE,
  CONSTRAINT `fk_sporto_klubo_inventorius_sporto_klubo_vieta1`
    FOREIGN KEY (`sporto_klubo_vieta_sporto_klubo_vietos_id`)
    REFERENCES `gym2`.`sporto_klubo_vieta` (`sporto_klubo_vietos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sporto_klubo_inventorius_inventoriaus elementas1`
    FOREIGN KEY (`inventoriaus_elementas_inventoriaus_elemento_id`)
    REFERENCES `gym2`.`inventoriaus_elementas` (`inventoriaus_elemento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;
SHOW WARNINGS;

USE `gym2` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
