DROP TABLE IF EXISTS Stovejimo_vietos_rezervacija;
DROP TABLE IF EXISTS Kambario_atsiliepimas;
DROP TABLE IF EXISTS Sporto_sales_rezervacija;
DROP TABLE IF EXISTS Kambario_rezervacija;
DROP TABLE IF EXISTS Treniruote;
DROP TABLE IF EXISTS Stovejimo_vieta;
DROP TABLE IF EXISTS Klientas;
DROP TABLE IF EXISTS Kambarys;
DROP TABLE IF EXISTS Administratorius;
DROP TABLE IF EXISTS Mokejimo_besena;
DROP TABLE IF EXISTS Kambario_tipas;
DROP TABLE IF EXISTS Aukštas;
DROP TABLE IF EXISTS Treneris;
DROP TABLE IF EXISTS Naudotojas;
CREATE TABLE Naudotojas
(
	id_Naudotojas int NOT NULL,
	naudotojo_vardas varchar (255) NOT NULL,
	naudotojo_pavarde varchar (255) NOT NULL,
	elektroninis_paštas varchar (255) NOT NULL,
	slaptažodis varchar (255) NOT NULL,
	PRIMARY KEY(id_Naudotojas)
);

CREATE TABLE Treneris
(
	id_Treneris int NOT NULL,
	trenerio_vardas varchar (255) NOT NULL,
	trenerio_pavarde varchar (255) NOT NULL,
	darbo_patirtis int NOT NULL,
	trenerio_telefono_numeris varchar (255) NOT NULL,
	trenerio_gimimo_data date NOT NULL,
	trenerio_lytis varchar (255) NOT NULL,
	specifikacija xml NOT NULL,
	PRIMARY KEY(id_Treneris)
);

CREATE TABLE Aukštas
(
	id_Aukštas int NOT NULL,
	name varchar (7) NOT NULL,
	PRIMARY KEY(id_Aukštas)
);
INSERT INTO Aukštas(id_Aukštas, name) VALUES(1, 'pirmas');
INSERT INTO Aukštas(id_Aukštas, name) VALUES(2, 'antras');
INSERT INTO Aukštas(id_Aukštas, name) VALUES(3, 'trecias');

CREATE TABLE Kambario_tipas
(
	id_Kambario_tipas int NOT NULL,
	name varchar (22) NOT NULL,
	PRIMARY KEY(id_Kambario tipas)
);
INSERT INTO Kambario_tipas(id_Kambario tipas, name) VALUES(1, 'ekonomine klase');
INSERT INTO Kambario_tipas(id_Kambario tipas, name) VALUES(2, 'verslo klase');
INSERT INTO Kambario_tipas(id_Kambario tipas, name) VALUES(3, 'prezidentinis numeris ');

CREATE TABLE Mokejimo_busena
(
	id_Mokejimo_busena int NOT NULL,
	name varchar (10) NOT NULL,
	PRIMARY KEY(id_Mokejimo busena)
);
INSERT INTO Mokejimo_busena(id_Mokejimo busena, name) VALUES(1, 'Apmoketa');
INSERT INTO Mokejimo_busena(id_Mokejimo busena, name) VALUES(2, 'Neapmoketa');
INSERT INTO Mokejimo_busena(id_Mokejimo busena, name) VALUES(3, 'Atšaukta');

CREATE TABLE Administratorius
(
	id_Naudotojas int NOT NULL,
	PRIMARY KEY(id_Naudotojas),
	FOREIGN KEY(id_Naudotojas) REFERENCES Naudotojas (id_Naudotojas)
);

CREATE TABLE Kambarys
(
	kambario_numeris varchar (6) NOT NULL,
	kambario_užimtumas boolean NOT NULL,
	nakties_kaina double NOT NULL,
	vietu_kiekis int NOT NULL,
	kaina decimal (6,2) NOT NULL,
	tipas int NOT NULL,
	PRIMARY KEY(kambario_numeris),
	FOREIGN KEY(tipas) REFERENCES Kambario_tipas (id_Kambario tipas)
);

CREATE TABLE Klientas
(
	id_Naudotojas int NOT NULL,
	kliento_telefono_numeris varchar (255) NOT NULL,
	kliento_gimimo_data date NOT NULL,
	kliento_lytis varchar (255) NOT NULL,
	PRIMARY KEY(id_Naudotojas),
	FOREIGN KEY(id_Naudotojas) REFERENCES Naudotojas (id_Naudotojas)
);

CREATE TABLE Stovejimo_vieta
(
	vietos_id varchar (255) NOT NULL,
	užimta_nuo date NOT NULL,
	užimta_iki date NOT NULL,
	vietos_užimtumas boolean NOT NULL,
	aukštas int NOT NULL,
	PRIMARY KEY(vietos id),
	FOREIGN KEY(aukštas) REFERENCES Aukštas (id_Aukštas)
);

CREATE TABLE Treniruote
(
	treniruotes_nr int NOT NULL,
	treniruotes_pradžia date NOT NULL,
	treniruotes_pabaiga date NOT NULL,
	laisvu_vietu_kiekis int NOT NULL,
	fk_Trenerisid_Treneris int NOT NULL,
	PRIMARY KEY(treniruotes_nr),
	CONSTRAINT veda FOREIGN KEY(fk_Trenerisid_Treneris) REFERENCES Treneris (id_Treneris)
);

CREATE TABLE Kambario_rezervacija
(
	id_Kambario_rezervacija int NOT NULL,
	pradžia date NOT NULL,
	pabaiga date NOT NULL,
	mokejimo_busena int NOT NULL,
	fk_Klientasid_Naudotojas int NOT NULL,
	fk_Kambaryskambario_numeris varchar (6) NOT NULL,
	PRIMARY KEY(id_Kambario rezervacija),
	FOREIGN KEY(mokejimo busena) REFERENCES Mokejimo_busena (id_Mokejimo busena),
	CONSTRAINT pateikia FOREIGN KEY(fk_Klientasid_Naudotojas) REFERENCES Klientas (id_Naudotojas),
	CONSTRAINT turi FOREIGN KEY(fk_Kambaryskambario numeris) REFERENCES Kambarys (kambario numeris)
);

CREATE TABLE Sporto_sales_rezervacija
(
	id_Sporto_sales_rezervacija int NOT NULL,
	laiko_pradžia int NOT NULL,
	laiko_pabaiga int NOT NULL,
	fk_Klientasid_Naudotojas int NOT NULL,
	fk_Treniruotetreniruotes_nr int NOT NULL,
	PRIMARY KEY(id_Sporto_sales_rezervacija),
	CONSTRAINT daro FOREIGN KEY(fk_Klientasid_Naudotojas) REFERENCES Klientas (id_Naudotojas),
	CONSTRAINT rezervuoja FOREIGN KEY(fk_Treniruotetreniruotes nr) REFERENCES Treniruote (treniruotes nr)
);

CREATE TABLE Kambario_atsiliepimas
(
	id_Kambario_atsiliepimas int NOT NULL,
	komentaras varchar (255) NOT NULL,
	atsiliepimo_data date NOT NULL,
	fk_Kambario_rezervacijaid_Kambario_rezervacija int NOT NULL,
	fk_Klientasid_Naudotojas int NOT NULL,
	PRIMARY KEY(id_Kambario_atsiliepimas),
	UNIQUE(fk_Klientasid_Naudotojas),
	CONSTRAINT turi FOREIGN KEY(fk_Kambario rezervacijaid_Kambario rezervacija) REFERENCES Kambario_rezervacija (id_Kambario rezervacija),
	CONSTRAINT pateikia FOREIGN KEY(fk_Klientasid_Naudotojas) REFERENCES Klientas (id_Naudotojas)
);

CREATE TABLE Stovejimo_vietos_rezervacija
(
	id_Stovejimo_vietos_rezervacija int NOT NULL,
	stovejimo_vietos_pradžia date NOT NULL,
	stovejimo_vietos_pabaiga date NOT NULL,
	fk_Kambario_rezervacijaid_Kambario_rezervacija int NOT NULL,
	fk_Stovejimo_vietavietos_id varchar (255) NOT NULL,
	PRIMARY KEY(id_Stovejimo vietos rezervacija),
	UNIQUE(fk_Kambario rezervacijaid_Kambario rezervacija),
	UNIQUE(fk_Stovejimo vietavietos id),
	CONSTRAINT daro FOREIGN KEY(fk_Kambario rezervacijaid_Kambario rezervacija) REFERENCES Kambario_rezervacija (id_Kambario rezervacija),
	CONSTRAINT užrezervuoja FOREIGN KEY(fk_Stovejimo vietavietos id) REFERENCES Stovejimo_vieta (vietos id)
);