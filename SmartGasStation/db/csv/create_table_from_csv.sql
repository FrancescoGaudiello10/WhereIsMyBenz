DROP TABLE IF EXISTS "implants";
CREATE TABLE "implants" (
	`idImpianto`	  TEXT NOT NULL,
	`Gestore`	      TEXT,
	`Bandiera`	    TEXT,
	`TipoImpianto`  TEXT,
	`NomeImpianto`  TEXT,
	`Indirizzo`	    TEXT,
	`Comune`	      TEXT,
	`Provincia`	    TEXT,
	`latitude`	    float,
	`longitude`	    float,
	`distance`	    float,
	`created_at`	  datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	  datetime,
	PRIMARY KEY(`idImpianto`)
);

DROP TABLE IF EXISTS "prices";
CREATE TABLE "prices" (
	`idImpianto`	    TEXT NOT NULL,
	`descCarburante`	TEXT,
	`prezzo`	        TEXT,
	`isSelf`	        TEXT,
	`dtComu`	        TEXT,
	`created_at`	    datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	    datetime
);

.mode csv
.separator ;
.import csv/implants.csv implants
.import csv/prices.csv prices
UPDATE "implants" SET created_at  = CURRENT_TIMESTAMP;
UPDATE "prices" SET created_at    = CURRENT_TIMESTAMP;
.quit


