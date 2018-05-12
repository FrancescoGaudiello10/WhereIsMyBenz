DROP TABLE IF EXISTS "implants";
CREATE TABLE "implants" (
	`idImpianto`	    int NOT NULL,
	`Gestore`	        TEXT,
	`Bandiera`	        TEXT,
	`TipoImpianto`      TEXT,
	`NomeImpianto`      TEXT,
	`Indirizzo`	        TEXT,
	`Comune`	        TEXT,
	`Provincia`	        TEXT,
	`latitude`	        float,
	`longitude`	        float,
	`distance`	        float,
	`created_at`	    datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	    datetime,
	PRIMARY KEY(`idImpianto`)
);

DROP TABLE IF EXISTS "prices";
CREATE TABLE "prices" (
	`idImpianto`	    int NOT NULL,
	`descCarburante`	TEXT,
	`prezzo`	        float,
	`isSelf`	        boolean,
	`dtComu`	        TEXT,
	`created_at`	    datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	    datetime
);

DROP TABLE IF EXISTS "prices_old";
CREATE TABLE "prices_old" (
	`idImpianto`	    int NOT NULL,
	`descCarburante`	TEXT,
	`prezzo`	        float,
	`isSelf`	        boolean,
	`dtComu`	        TEXT,
	`created_at`	    datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	    datetime
);

DROP TABLE IF EXISTS "regioni";
CREATE TABLE "regioni" (
	`regione`	          TEXT NOT NULL,
	`sigla`	            TEXT,
	`provincia`	        TEXT,
	`created_at`	      datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	      datetime
);

.mode csv
.separator ;
.import csv/implants.csv implants
.import csv/prices.csv prices
.import csv/prices_17_mar_18.csv prices_old
.import csv/regioni.csv regioni

UPDATE "implants"   SET created_at    = CURRENT_TIMESTAMP;
UPDATE "prices"     SET created_at    = CURRENT_TIMESTAMP;
UPDATE "prices_old" SET created_at    = CURRENT_TIMESTAMP;
UPDATE "regioni"    SET created_at    = CURRENT_TIMESTAMP;

.quit


