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
	`regione`	        TEXT NOT NULL,
	`sigla`	            TEXT,
	`provincia`	        TEXT,
	`created_at`	    datetime DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	    datetime
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

--Carica stazioni di prova
INSERT INTO "stations" VALUES ('1','ESSO','Mario Rossi','Via Ariosto 22,Roma','1.798','1.578',NULL,NULL,'0.789','0.687','1',NULL,'1',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO "stations" VALUES ('2','AGIP','Luca Verdi','Via Eudossiana 18,Roma','1.345','1.254',NULL,'1.867',NULL,'0.782','1','1','1',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO "stations" VALUES ('3','Q8','Gianni Ben','Via Ariosto 22,Roma','1.798','1.578','1.389',NULL,'0.789','0.687',NULL,NULL,'1',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

.quit


