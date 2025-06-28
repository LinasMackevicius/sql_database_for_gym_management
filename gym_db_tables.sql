-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema gym2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gym2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_lithuanian_ci ;
SHOW WARNINGS;
-- -----------------------------------------------------
-- Table `gym2`.`miestas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`miestas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`miestas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`klientas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`klientas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`klientas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vardas` VARCHAR(100) NOT NULL,
  `pavarde` VARCHAR(100) NOT NULL,
  `asmens_kodas` VARCHAR(13) NOT NULL UNIQUE,
  `adresas` VARCHAR (100) NOT NULL,
  `miestas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
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
-- Table `gym2`.`juridinis_asmuo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`juridinis_asmuo`;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`juridinis_asmuo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(100) NOT NULL,
  `pvm_moketojo_kodas` VARCHAR(100) NOT NULL UNIQUE,
  `imones_kodas` VARCHAR(13) NOT NULL UNIQUE,
  `adresas` VARCHAR(100) NULL,
  `miestas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_juridinis_asmuo_miestas1_idx` (`miestas_id`),
  CONSTRAINT `fk_juridinis_asmuo_miestas1`
    FOREIGN KEY (`miestas_id`)
    REFERENCES `gym2`.`miestas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
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
  `pavadinimas` VARCHAR(100) NOT NULL,
  `menesio_kaina` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`preke`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`preke` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`preke` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(255) NOT NULL,
  `aprasymas` VARCHAR(255) NULL,
  `tipas` ENUM('paslauga', 'preke') NOT NULL, 
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`prekes_kaina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`prekes_kaina`;
SHOW WARNINGS;
CREATE TABLE `gym2`.`prekes_kaina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `preke_id` INT NOT NULL,
  `standartine_kaina` DECIMAL(10,2) NOT NULL,
  `nuolaida` DECIMAL(5,2) NULL,
  `galutine_kaina` DECIMAL(10,2) GENERATED ALWAYS AS (`standartine_kaina` * (1 - IFNULL(`nuolaida`, 0) / 100)) STORED,
  `galiojimo_pradzia` DATE NOT NULL,
  `galiojimo_pabaiga` DATE DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prekes_kaina_preke1_idx` (`preke_id`),
  CONSTRAINT `fk_prekes_kaina_preke1`
    FOREIGN KEY (`preke_id`)
    REFERENCES `gym2`.`preke` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gym2`.`narystes_pasiulymas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`narystes_pasiulymas`;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`narystes_pasiulymas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naryste_id` INT NULL,
  `kodas` VARCHAR(45) NULL,
  `salies_kodas` CHAR(3) NULL,
  `kaina` DECIMAL(10,2) NULL,
  `valiuta` CHAR(3) NULL,
  `akcijos_kodas` VARCHAR(45) NULL,
  `aprasymas` VARCHAR(500) NULL, 
  PRIMARY KEY (`id`),
  INDEX `fk_narystes_pasiulymas_naryste1_idx` (`naryste_id`),
  CONSTRAINT `fk_narystes_pasiulymas_naryste1`
    FOREIGN KEY (`naryste_id`)
    REFERENCES `gym2`.`naryste` (`id`)
    ON DELETE CASCADE
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
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
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_paskyra_paskyros_busena1`
    FOREIGN KEY (`paskyros_busena_id`)
    REFERENCES `gym2`.`paskyros_busena` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`identifikavimo_tipas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`identifikavimo_tipas`;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`identifikavimo_tipas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(100) NOT NULL,
  `aprasymas` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`kliento_identifikavimas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_identifikavimas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`kliento_identifikavimas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `klientas_id` INT NOT NULL,
  `identifikavimo_kodas` VARCHAR(255) NOT NULL UNIQUE,
  `identifikavimo_tipas_id` INT NOT NULL, 
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_identifikavimas_klientas1_idx` (`klientas_id`),
  INDEX `fk_kliento_identifikavimas_identifikavimo_tipas1_idx` (`identifikavimo_tipas_id`),
  CONSTRAINT `fk_kliento_identifikavimas_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
CONSTRAINT `fk_kliento_identifikavimas_identifikavimo_tipas1`
    FOREIGN KEY (`identifikavimo_tipas_id`)
    REFERENCES `gym2`.`identifikavimo_tipas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
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
  `pavadinimas` VARCHAR(100) NOT NULL,
  `telefonas` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE(`pavadinimas`)
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
  `adresas` VARCHAR(100) NOT NULL,
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
-- Table `gym2`.`kliento_apsilankymas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`kliento_apsilankymas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`kliento_apsilankymas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apsilankymo_laikas` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sporto_klubo_filialas_id` INT NOT NULL,
  `kliento_identifikavimas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_apsilankymas_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  INDEX `fk_kliento_apsilankymas_kliento_identifikavimas1_idx` (`kliento_identifikavimas_id`),
  CONSTRAINT `fk_kliento_apsilankymas_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_apsilankymas_kliento_identifikavimas1`
    FOREIGN KEY (`kliento_identifikavimas_id`)
    REFERENCES `gym2`.`kliento_identifikavimas` (`id`)
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
  `pvm_moketojo_kodas` VARCHAR(20) NOT NULL,
  `banko_pavadinimas` VARCHAR(100) NULL,
  `banko_saskaita` VARCHAR(100) NULL,
  PRIMARY KEY (`sporto_klubas_id`),
  INDEX `fk_pardavejas_miestas1_idx` (`miestas_id`),
  INDEX `fk_pardavejas_sporto_klubas1_idx` (`sporto_klubas_id`),
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
  `klientas_id` INT NULL,
  `juridinis_asmuo_id` INT NULL,
  `pardavejas_id` INT NOT NULL,
  `paslaugu_menuo` DATE NOT NULL,
  `saskaitos_formavimo_data` DATE NOT NULL,
  `apmokejimo_data` DATE NULL,
  `apmokejimo_terminas_iki` DATE NOT NULL,
  `busena` ENUM ('apmoketa','neapmoketa') DEFAULT 'neapmoketa',
  `saskaitos_numeris` VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (`id`),
  INDEX `fk_saskaita_klientas1_idx` (`klientas_id`),
  INDEX `fk_saskaita_pardavejas1_idx` (`pardavejas_id`),
  INDEX `fk_saskaita_juridinis_asmuo1_idx` (`juridinis_asmuo_id`),
  CONSTRAINT `fk_saskaita_klientas1` 
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saskaita_pardavejas1` 
    FOREIGN KEY (`pardavejas_id`)
    REFERENCES `gym2`.`pardavejas` (`sporto_klubas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saskaita_juridinis_asmuo1` 
    FOREIGN KEY (`juridinis_asmuo_id`)
    REFERENCES `gym2`.`juridinis_asmuo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chk_one_pirkejas`
    CHECK (
    (klientas_id IS NOT NULL AND juridinis_asmuo_id IS NULL)
    OR
    (klientas_id IS NULL AND juridinis_asmuo_id IS NOT NULL)
  );
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
  `saskaita_id` INT NOT NULL,
  `preke_id` INT NULL,
  `narystes_pasiulymas_id` INT NULL,
  `kiekis` INT NOT NULL,
  `kaina_be_pvm` DECIMAL(10,2) NOT NULL,
  `pvm_tarifas` DECIMAL(5,2) NOT NULL, -- e.g. 21.00 for 21%
  `pvm_suma` DECIMAL(10,2) GENERATED ALWAYS AS (`kiekis` * `kaina_be_pvm` * (`pvm_tarifas` / 100)) STORED,
  `kaina_su_pvm` DECIMAL(10,2) GENERATED ALWAYS AS (`kiekis` * `kaina_be_pvm` * (1 + `pvm_tarifas` / 100)) STORED,
  PRIMARY KEY (`id`),
  INDEX `fk_saskaitos_eilute_saskaita1_idx` (`saskaita_id`),
  INDEX `fk_saskaitos_eilute_preke1_idx` (`preke_id`),
  INDEX `fk_saskaitos_eilute_narystes_pasiulymas1_idx` (`narystes_pasiulymas_id`),
  CONSTRAINT `fk_saskaitos_eilute_saskaita1`
    FOREIGN KEY (`saskaita_id`)
    REFERENCES `gym2`.`saskaita` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saskaitos_eilute_preke1`
    FOREIGN KEY (`preke_id`)
    REFERENCES `gym2`.`preke` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saskaitos_eilute_narystes_pasiulymas1`
    FOREIGN KEY (`narystes_pasiulymas_id`)
    REFERENCES `gym2`.`narystes_pasiulymas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chk_saskaitos_eilute_item_ref` CHECK (
    (`preke_id` IS NOT NULL AND `narystes_pasiulymas_id` IS NULL) OR
    (`preke_id` IS NULL AND `narystes_pasiulymas_id` IS NOT NULL)
  )
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
  `aprasymas` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
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
  `apmokejimo_budas_id` INT NOT NULL,
  `suma` DECIMAL(10,2) NOT NULL,
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
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

-- ------------------------------------------------------
-- Table `gym2`.`asmeninio_trenerio_klubas`
-- ------------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`asmeninio_trenerio_klubas`;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`asmeninio_trenerio_klubas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `asmeninis_treneris_id` INT NOT NULL,
  `sporto_klubo_filialas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_asmeninio_trenerio_klubas_asmeninis_treneris1_idx` (`asmeninis_treneris_id`),
  INDEX `fk_asmeninio_trenerio_klubas_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  UNIQUE (`asmeninis_treneris_id`, `sporto_klubo_filialas_id`),
  CONSTRAINT `fk_asmeninio_trenerio_klubas_asmeninis_treneris1`
    FOREIGN KEY (`asmeninis_treneris_id`)
    REFERENCES `gym2`.`asmeninis_treneris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_asmeninio_trenerio_klubas_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
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
  `pavadinimas` VARCHAR(100) NOT NULL,
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
  `pavadinimas` VARCHAR(100) NOT NULL,
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


-- ------------------------------------------------------
-- Table `gym2`.`grupes_trenerio_klubas`
-- ------------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`grupes_trenerio_klubas`;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`grupes_trenerio_klubas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grupes_treneris_id` INT NOT NULL,
  `sporto_klubo_filialas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_grupes_trenerio_klubas_grupes_treneris1_idx` (`grupes_treneris_id`),
  INDEX `fk_grupes_trenerio_klubas_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  UNIQUE(`grupes_treneris_id`, `sporto_klubo_filialas_id`),
  CONSTRAINT `fk_grupes_trenerio_klubas_grupes_treneris1`
    FOREIGN KEY (`grupes_treneris_id`)
    REFERENCES `gym2`.`grupes_treneris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupes_trenerio_klubas_sporto_klubo_filialas1`
    FOREIGN KEY (`sporto_klubo_filialas_id`)
    REFERENCES `gym2`.`sporto_klubo_filialas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB;
SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `gym2`.`mokejimo_daznis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`mokejimo_daznis` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`mokejimo_daznis` (
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
  `klientas_id` INT NOT NULL,
  `narystes_pasiulymas_id` INT NULL,
  `mokejimo_daznis_id` INT NOT NULL,
  `sutarties_numeris` VARCHAR(45) NULL,
  `galiojimo_pradzia` DATE NOT NULL,
  `galiojimo_pabaiga` DATE NOT NULL,
  `statusas` ENUM ('aktyvuotas', 'neaktyvuotas'),
  PRIMARY KEY (`id`),
  INDEX `fk_kliento_abonementas_klientas1_idx` (`klientas_id`),
  INDEX `fk_kliento_abonementas_mokejimo_daznis1_idx` (`mokejimo_daznis_id`),
  INDEX `fk_kliento_abonementas_narystes_pasiulymas1_idx` (`narystes_pasiulymas_id`),
  CONSTRAINT `fk_kliento_abonementas_klientas1`
    FOREIGN KEY (`klientas_id`)
    REFERENCES `gym2`.`klientas` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_abonementas_mokejimo_daznis1`
    FOREIGN KEY (`mokejimo_daznis_id`)
    REFERENCES `gym2`.`mokejimo_daznis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kliento_abonementas_narystes_pasiulymas1`
    FOREIGN KEY (`narystes_pasiulymas_id`)
    REFERENCES `gym2`.`narystes_pasiulymas` (`id`)
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
  INDEX `fk_asmenine_treniruote_asmeninis_treneris1_idx` (`asmeninis_treneris_id`),
  INDEX `fk_asmenine_treniruote_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  INDEX `fk_asmenine_treniruote_klientas1_idx` (`klientas_id`),
  UNIQUE INDEX `unique_asmeninis_treneris_pradzia` (`asmeninis_treneris_id`, `treniruotes_pradzia`),
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
  `pavadinimas` VARCHAR(100) NOT NULL,
  `intensyvumas` ENUM ('zemas', 'vidutinis', 'aukstas') NOT NULL,
  `sudetingumas` ENUM ('zemas', 'vidutinis', 'aukstas') NOT NULL,
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
  INDEX `fk_grupines_treniruotes_sesija_grupes_treneris1_idx` (`grupes_treneris_id`),
  INDEX `fk_grupines_treniruotes_sesija_sporto_klubo_filialas1_idx` (`sporto_klubo_filialas_id`),
  INDEX `fk_grupines_treniruotes_sesija_grupine_treniruote1_idx` (`grupine_treniruote_id`),
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
  `klientas_id` INT NOT NULL,
  `grupines_treniruotes_sesija_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`klientas_id`, `grupines_treniruotes_sesija_id`),
  INDEX `fk_kliento_grupines_treniruotes_sesija_klientas1_idx` (`klientas_id`),
  INDEX `fk_kliento_grupines_treniruotes_sesija_grupines_treniruotes_idx` (`grupines_treniruotes_sesija_id`),
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
  `pavadinimas` VARCHAR(100) NOT NULL,
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
  `naryste_id` INT NOT NULL,
  `paslauga_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_narystes_paslauga_paslauga1_idx` (`paslauga_id`),
  INDEX `fk_narystes_paslauga_naryste1_idx` (`naryste_id`), 
  CONSTRAINT `fk_narystes_paslauga_naryste1`
    FOREIGN KEY (`naryste_id`)
    REFERENCES `gym2`.`naryste` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_narystes_paslauga_paslauga1`
    FOREIGN KEY (`paslauga_id`)
    REFERENCES `gym2`.`paslauga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `gym2`.`gamintojas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym2`.`gamintojas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `gym2`.`gamintojas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pavadinimas` VARCHAR(100) NOT NULL UNIQUE,
  `aprasymas` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
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
  `gamintojas_id` INT NOT NULL,
  `pavadinimas` VARCHAR(100) NOT NULL,
  `aprasymas` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_inventoriaus_elementas_gamintojas1_idx` (`gamintojas_id`),
  CONSTRAINT `fk_inventoriaus_elementas_gamintojas1`
    FOREIGN KEY (`gamintojas_id`)
    REFERENCES `gym2`.`gamintojas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
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
  `kiekis` INT NOT NULL DEFAULT 0,
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
