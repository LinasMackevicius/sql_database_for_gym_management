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
  `vardas` VARCHAR(100) NOT NULL,
  `pavarde` VARCHAR(100) NOT NULL,
  `asmens_kodas`  VARCHAR(13) NULL,
  `adresas` VARCHAR (100),
  `miestas_id` INT NOT NULL, 
  PRIMARY KEY (`id`) NOT NULL,
  INDEX `fk_klientas_miestas1_idx` (`miestas_id`),
  CONSTRAINT `fk_klientas_miestas1`
    FOREIGN KEY (`miestas_id`)
    REFERENCES `gym2`.`miestas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`paskyros_busena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`paskyros_busena`;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`paskyros_busena` (
  `id` INT NOT NULL,
  `pavadinimas` VARCHAR(255) NOT NULL UNIQUE
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`kliento_paskyra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_paskyra`;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`kliento_paskyra` (
  `klientas_id` INT NOT NULL,
  `el_pastas` VARCHAR(255) NOT NULL UNIQUE,
  `slaptazodis_hash` VARCHAR(255) NOT NULL,
  `paskyros_busena_id` INT NOT NULL,
  `sukurimo_data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_kliento_paskyra_klientas1_idx` (`klientas_id`),
  INDEX `fk_kliento_paskyra_paskyros_busena1_idx` (`paskyros_busena_id`),
  PRIMARY KEY (`klientas_id`),
  CONSTRAINT `fk_kliento_paskyra_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
  CONSTRAINT `fk_kliento_paskyra_paskyros_busena1`
    FOREIGN KEY (`paskyros_busena_id`)
    REFERENCES `gym2`.`paskyros_busena` (`id`)
    ON DELETE NO ACTION
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
  `klientas_id` INT NOT NULL,
  `identifikavimo_kodas` VARCHAR(255) NOT NULL UNIQUE,
  `tipas` ENUM ('kortele','pin_kodas', 'nfc_bluetooth' , 'biometrinis', 'barcode_qrcode') NOT NULL,
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
  `sporto_klubo_filialas_id` INT NOT NULL,
  `kliento_tapatybe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_apsilankymas_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  INDEX `fk_kliento_apsilankymas_kliento_tapatybe1_idx` (`kliento_tapatybe_id`),
  CONSTRAINT `fk_kliento_apsilankymas_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
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
-- Table `gym2`.`pardavejas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`pardavejas` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`pardavejas` (
  `sporto_klubas_id` INT NOT NULL,
  `miestas_id` INT NOT NULL,
  `adresas` VARCHAR(100) NULL,
  `pavadinimas` VARCHAR(100) NOT NULL,
  `imones_kodas` VARCHAR(50) NOT NULL,
  `banko_pavadinimas` VARCHAR(100) NULL,
  `banko_saskaita` VARCHAR(100) NULL,
  PRIMARY KEY (`sporto_klubas_id`),
  INDEX `fk_pardavejas_miestas1_idx` (`miestas_id`),
  CONSTRAINT `fk_pardavejas_miestas1`
    FOREIGN KEY (`miestas_id`)
    REFERENCES `gym2`.`miestas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pardavejas_sporto_klubas1`
    FOREIGN KEY (`sporto_klubas_id`)
    REFERENCES `gym2`.`sporto_klubas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`saskaita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`saskaita` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`saskaita` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `klientas_id` INT NOT NULL,
  `pardavejas_id` INT NOT NULL,
  `paslaugu_menuo` DATE NOT NULL,
  `saskaitos_formavimo_data` DATE NOT NULL,
  `apmokejimo_data` DATE NULL,
  `apmokejimo_terminas_iki` DATE NOT NULL,
  `busena` ENUM ('apmoketa','neapmoketa') DEFAULT 'neapmoketa',
  `bendra_suma` DECIMAL(10,2) NOT NULL,
  `saskaitos_numeris` VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (`id`),
  INDEX `fk_saskaita_klientas1_idx` (`klientas_id`),
  INDEX `fk_saskaita_pardavejas1_idx` (`pardavejas_id`),
  CONSTRAINT `fk_saskaita_klientas1` 
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saskaita_pardavejas1` 
    FOREIGN KEY (`pardavejas_id`)
    REFERENCES `gym2`.`pardavejas` (`sporto_klubas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;



-- -----------------------------------------------------
-- Table `gym2`.`apmokejimo_budas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`apmokejimo_budas` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`apmokejimo_budas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aprasymas` VARCHAR(100) NOT NULL
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`apmokejimas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`apmokejimas` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`apmokejimas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `saskaita_id` INT NOT NULL,
  `suma` DECIMAL(10,2) NOT NULL,
  `data` DATE NOT NULL,
  `apmokejimo_budas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_apmokejimas_saskaita1_idx` (`saskaita_id`),
  INDEX `fk_apmokejimo_budas_apmokejimas1_idx` (`apmokejimo_budas_id`),
  CONSTRAINT `fk_apmokejimas_saskaita1` 
    FOREIGN KEY (`saskaita_id`)
    REFERENCES `gym2`.`saskaita` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
  CONSTRAINT `fk_apmokejimo_budas_apmokejimas1` 
    FOREIGN KEY (`apmokejimo_budas_id`)
    REFERENCES `gym2`.`apmokejimo_budas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`saskaitos_eilute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`saskaitos_eilute` ;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `gym2`.`saskaitos_eilute` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `narystes_kodas_id` INT NULL,
  `saskaita_id` INT NOT NULL,
  `produktas` VARCHAR(100) NOT NULL, 
  `kiekis` INT NOT NULL,
  `kaina_be_pvm` DECIMAL(10,2) NOT NULL,
  `pvm_tarifas` DECIMAL(5,2) NOT NULL, -- e.g. 21.00 for 21%
  `pvm_suma` DECIMAL(10,2) GENERATED ALWAYS AS (`kiekis` * `kaina_be_pvm` * (`pvm_tarifas` / 100)) STORED,
  `kaina_su_pvm` DECIMAL(10,2) GENERATED ALWAYS AS (`kiekis` * `kaina_be_pvm` * (1 + `pvm_tarifas` / 100)) STORED,
  PRIMARY KEY (`id`),
  INDEX `fk_saskaitos_eilute_saskaita1_idx` (`saskaita_id`),
  INDEX `fk_saskaitos_eilute_narystes_kodas1_idx` (`narystes_kodas_id`),
  -- UNIQUE (`saskaita_id`, `narystes_kodas_id`),?
  CONSTRAINT `fk_saskaitos_eilute_saskaita1`
    FOREIGN KEY (`saskaita_id`)
    REFERENCES `gym2`.`saskaita` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saskaitos_eilute_narystes_kodas1`
    FOREIGN KEY (`narystes_kodas_id`)
    REFERENCES `gym2`.`narystes_kodas` (`id`)
    ON DELETE NO ACTION
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

-- ------------------------------------------------------
-- Table `gym2`.`asmeninis_treneris`
-- ------------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`asmeninis_treneris`;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`asmeninis_treneris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vardas` VARCHAR(100) NOT NULL,
  `pavarde` VARCHAR(100) NOT NULL,
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
  `vardas` VARCHAR(100) NOT NULL,
  `pavarde` VARCHAR(100) NOT NULL,
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
    ON DELETE NO ACTION
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
  `el_pasto_adresas` VARCHAR(255) NOT NULL UNIQUE,
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
  `vardas` VARCHAR(100) NOT NULL,
  `pavarde` VARCHAR(100) NOT NULL,
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
-- Table `gym2`.`narystes_kodas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`narystes_kodas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`narystes_kodas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naryste_id` INT NOT NULL,
  `kodas` VARCHAR(45) NULL,
  `salies_kodas` CHAR(3) NULL,
  `kaina` DECIMAL(10,2) NULL,
  `valiuta` CHAR(3) NULL,
  `akcijos_kodas` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_narystes_kodas_naryste1_idx` (`naryste_id`),
  CONSTRAINT `fk_narystes_kodas_naryste1`
    FOREIGN KEY (`naryste_id`)
    REFERENCES `gym2`.`naryste` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
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
-- Table `gym2`.`kliento_abonementas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_abonementas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`kliento_abonementas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sutarties_numeris` VARCHAR(45) NULL,
  `klientas_id` INT NOT NULL,
  `narystes_kodas_id` INT NULL,
  `mokejimo_budas_id` INT NOT NULL,
  `galiojimo_pradzia` DATE NOT NULL,
  `galiojimo_pabaiga` DATE NOT NULL,
  
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_abonementas_klientas1_idx` (`klientas_id`),
  INDEX `fk_kliento_abonementas_mokejimo_budas1_idx` (`mokejimo_budas_id`),
  INDEX `fk_kliento_abonementas_narystes_kodas1_idx` (`narystes_kodas_id`),
  UNIQUE (`klientas_id`, `narystes_kodas_id`),
  CONSTRAINT `fk_kliento_abonementas_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
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
-- Table `gym2`.`sporto_klubo_filialas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`sporto_klubo_filialas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`sporto_klubo_filialas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sporto_klubas_id` INT NOT NULL,
  `miestas_id` INT NOT NULL,
  `adresas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sporto_klubo_filialas_sporto_klubas1_idx` (`sporto_klubas_id`),
  INDEX `fk_sporto_klubo_filialas_miestas1_idx` (`miestas_id`),
  CONSTRAINT `fk_sporto_klubo_filialas_sporto_klubas1`
    FOREIGN KEY (`sporto_klubas_id`)
    REFERENCES `gym2`.`sporto_klubas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_sporto_klubo_filialas_miestas1`
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
  `sporto_klubo_filialas_id` INT NOT NULL,
  `klientas_id` INT NOT NULL,
  `treniruotes_pradzia` DATETIME NOT NULL,
  `treniruotes_pabaiga` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_asmenine_treniruote_asmeninis_treneris1_idx` (`asmeninis_treneris_id` ASC) VISIBLE,
  INDEX `fk_asmenine_treniruote_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id` ASC) VISIBLE,
  INDEX `fk_asmenine_treniruote_klientas1_idx` (`klientas_id` ASC) VISIBLE,
  UNIQUE INDEX `unique_asmeninis_treneris_pradzia` (`asmeninis_treneris_id` ASC, `treniruotes_pradzia` ASC) VISIBLE,
  CONSTRAINT `fk_asmenine_treniruote_asmeninis_treneris1`
    FOREIGN KEY (`asmeninis_treneris_id`)
    REFERENCES `gym2`.`asmeninis_treneris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asmenine_treniruote_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asmenine_treniruote_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE NO ACTION
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
  `intensyvumas` ENUM('zemas', 'vidutinis', 'aukstas') NOT NULL,
  `sudetingumas` ENUM('zemas', 'vidutinis', 'aukstas') NOT NULL,
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `pradzios_laikas` DATETIME NOT NULL,
  `pabaigos_laikas` DATETIME NOT NULL,
  `grupes_treneris_id` INT NOT NULL,
  `sporto_klubo_filialas_id` INT NOT NULL,
  `grupine_treniruote_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_grupines_treniruotes_sesija_grupes_treneris1_idx` (`grupes_treneris_id` ASC) VISIBLE,
  INDEX `fk_grupines_treniruotes_sesija_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id` ASC) VISIBLE,
  INDEX `fk_grupines_treniruotes_sesija_grupine_treniruote1_idx` (`grupine_treniruote_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupines_treniruotes_sesija_grupes_treneris1`
    FOREIGN KEY (`grupes_treneris_id`)
    REFERENCES `gym2`.`grupes_treneris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupines_treniruotes_sesija_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupines_treniruotes_sesija_grupine_treniruote1`
    FOREIGN KEY (`grupine_treniruote_id`)
    REFERENCES `gym2`.`grupine_treniruote` (`id`)
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `klientas_id` INT NULL,
  `grupines_treniruotes_sesija_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_grupines_treniruotes_sesija_klientas1_idx` (`klientas_id` ASC) VISIBLE,
  INDEX `fk_kliento_grupines_treniruotes_sesija_grupines_treniruotes_idx` (`grupines_treniruotes_sesija_id` ASC) VISIBLE,
  CONSTRAINT `fk_kliento_grupines_treniruotes_sesija_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_grupines_treniruotes_sesija_grupines_treniruotes_s1`
    FOREIGN KEY (`grupines_treniruotes_sesija_id`)
    REFERENCES `gym2`.`grupines_treniruotes_sesija` (`id`)
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`narystes_paslauga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`narystes_paslauga` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`narystes_paslauga` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `paslauga_id` INT NOT NULL,
  `naryste_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_narystes_paslauga_paslauga1_idx` (`paslauga_id`),
  INDEX `fk_narystes_paslauga_naryste1_idx` (`naryste_id`), 
  CONSTRAINT `fk_narystes_paslauga_naryste1`
    FOREIGN KEY (`naryste_id`)
    REFERENCES `gym2`.`naryste` (`id`),
  CONSTRAINT `fk_narystes_paslauga_paslauga1`
    FOREIGN KEY (`paslauga_id`)
    REFERENCES `gym2`.`paslauga` (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`inventoriaus_elementas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`inventoriaus_elementas` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`inventoriaus_elementas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(45) NOT NULL,
  `aprasymas` VARCHAR(510) NULL,
  `gamintojas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`sporto_klubo_inventorius`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`sporto_klubo_inventorius` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`sporto_klubo_inventorius` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sporto_klubo_filialas_id` INT NOT NULL,
  `inventoriaus_elementas_id` INT NOT NULL,
  `kiekis` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sporto_klubo_inventorius_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  INDEX `fk_sporto_klubo_inventorius_inventoriaus_elementas1_idx` (`inventoriaus_elementas_id`),
  CONSTRAINT `fk_sporto_klubo_inventorius_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sporto_klubo_inventorius_inventoriaus_elementas1`
    FOREIGN KEY (`inventoriaus_elementas_id`)
    REFERENCES `gym2`.`inventoriaus_elementas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;
SHOW WARNINGS;

USE `gym2` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
