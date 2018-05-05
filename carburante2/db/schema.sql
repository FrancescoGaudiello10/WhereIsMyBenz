CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);

CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "provider" varchar, "uid" varchar, "admin" boolean DEFAULT 0, "idImpianto" text, "luogo_preferito" varchar, "stazione_preferita" varchar, "carburante_preferito" varchar, "litri_serbatoio" integer);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");

CREATE TABLE IF NOT EXISTS "stations" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "Bandiera" varchar, "Nome" varchar, "Indirizzo" varchar, "Benzina" float, "Diesel" float, "Super" float, "Excellium" float, "Metano" float, "GPL" float, "allDay" boolean, "Self" boolean, "autoLavaggio" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);

CREATE TABLE IF NOT EXISTS "comments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "commenter" varchar, "body" text, "stars" integer, "station_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, CONSTRAINT "fk_rails_be93d8ae79"
FOREIGN KEY ("station_id")
  REFERENCES "stations" ("id")
);

CREATE INDEX "index_comments_on_station_id" ON "comments" ("station_id");

CREATE TABLE IF NOT EXISTS "implants" (
	`idImpianto`	TEXT NOT NULL,
	`Gestore`	TEXT,
	`Bandiera`	TEXT,
	`TipoImpianto`	TEXT,
	`NomeImpianto`	TEXT,
	`Indirizzo`	TEXT,
	`Comune`	TEXT,
	`Provincia`	TEXT,
	`latitude`	TEXT,
	`longitude`	TEXT,
	`distance`	float,
	`created_at`	datetime,
	`updated_at`	datetime,
	PRIMARY KEY(`idImpianto`)
);

CREATE TABLE IF NOT EXISTS "prices" (
	`idImpianto`	TEXT NOT NULL,
	`descCarburante`	TEXT,
	`prezzo`	TEXT,
	`isSelf`	TEXT,
	`dtComu`	TEXT,
	`created_at`	datetime,
	`updated_at`	datetime
);
