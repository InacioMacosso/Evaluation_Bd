drop database if exists evaluation1;

create database evaluation1;

use evaluation1;

CREATE TABLE `client` (
	`cli_num` INT(11) NOT NULL,
	`cli_nom` VARCHAR(50) NULL DEFAULT NULL,
	`cli_adresse` VARCHAR(50) NULL DEFAULT NULL,
	`cli_tel` VARCHAR(30) NULL DEFAULT NULL,
	PRIMARY KEY (`cli_num`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE INDEX idx_nom
ON client (cli_nom);

CREATE TABLE `commande` (
	`com_num` INT(11) NOT NULL,
	`cli_num` INT(11) NULL DEFAULT NULL,
	`com_date` DATETIME NULL DEFAULT NULL,
	`com_obs` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`com_num`),
	CONSTRAINT `command_client_FK` FOREIGN KEY (`cli_num`) REFERENCES `client` (`cli_num`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `est_compose` (
	`com_num` INT(11) NOT NULL,
	`pro_num` INT(11) NOT NULL,
	`est_qte` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`com_num`, `pro_num`),
	CONSTRAINT `est_compose_commande_FK` FOREIGN KEY (`com_num`) REFERENCES `commande` (`com_num`),
	CONSTRAINT `est_compose_produit_FK` FOREIGN KEY (`pro_num`) REFERENCES `produit` (`pro_num`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `produit` (
	`pro_num` INT(11) NOT NULL,
	`pro_libelle` VARCHAR(50) NULL DEFAULT NULL,
	`pro_description` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`pro_num`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
