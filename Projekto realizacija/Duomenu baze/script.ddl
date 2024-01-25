#@(#) script.ddl

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
DROP TABLE IF EXISTS Auk�tas;
DROP TABLE IF EXISTS Treneris;
DROP TABLE IF EXISTS Naudotojas;
CREATE TABLE Naudotojas
(
	id_Naudotojas int NOT NULL,
	naudotojo vardas varchar (255) NOT NULL,
	naudotojo pavarde varchar (255) NOT NULL,
	elektroninis pa�tas varchar (255) NOT NULL,
	slapta�odis varchar (255) NOT NULL,
	PRIMARY KEY(id_Naudotojas)
);

CREATE TABLE Treneris
(
	id_Treneris int NOT NULL,
	trenerio vardas varchar (255) NOT NULL,
	trenerio pavarde varchar (255) NOT NULL,
	darbo patirtis int NOT NULL,
	trenerio telefono numeris varchar (255) NOT NULL,
	trenerio gimimo data date NOT NULL,
	trenerio lytis varchar (255) NOT NULL,
	specifikacija xml NOT NULL,
	PRIMARY KEY(id_Treneris)
);

CREATE TABLE Auk�tas
(
	id_Auk�tas int NOT NULL,
	name varchar (7) NOT NULL,
	PRIMARY KEY(id_Auk�tas)
);
INSERT INTO Auk�tas(id_Auk�tas, name) VALUES(1, 'pirmas');
INSERT INTO Auk�tas(id_Auk�tas, name) VALUES(2, 'antras');
INSERT INTO Auk�tas(id_Auk�tas, name) VALUES(3, 'trecias');

CREATE TABLE Kambario_tipas
(
	id_Kambario tipas int NOT NULL,
	name varchar (22) NOT NULL,
	PRIMARY KEY(id_Kambario tipas)
);
INSERT INTO Kambario_tipas(id_Kambario tipas, name) VALUES(1, 'ekonomine klase');
INSERT INTO Kambario_tipas(id_Kambario tipas, name) VALUES(2, 'verslo klase');
INSERT INTO Kambario_tipas(id_Kambario tipas, name) VALUES(3, 'prezidentinis numeris ');

CREATE TABLE Mokejimo_busena
(
	id_Mokejimo busena int NOT NULL,
	name varchar (10) NOT NULL,
	PRIMARY KEY(id_Mokejimo busena)
);
INSERT INTO Mokejimo_busena(id_Mokejimo busena, name) VALUES(1, 'Apmoketa');
INSERT INTO Mokejimo_busena(id_Mokejimo busena, name) VALUES(2, 'Neapmoketa');
INSERT INTO Mokejimo_busena(id_Mokejimo busena, name) VALUES(3, 'At�aukta');

CREATE TABLE Administratorius
(
	id_Naudotojas int NOT NULL,
	PRIMARY KEY(id_Naudotojas),
	FOREIGN KEY(id_Naudotojas) REFERENCES Naudotojas (id_Naudotojas)
);

CREATE TABLE Kambarys
(
	kambario numeris varchar (6) NOT NULL,
	kambario u�imtumas boolean NOT NULL,
	nakties_kaina double precision NOT NULL,
	vietu_kiekis int NOT NULL,
	kaina decimal (6,2) NOT NULL,
	tipas int NOT NULL,
	PRIMARY KEY(kambario numeris),
	FOREIGN KEY(tipas) REFERENCES Kambario_tipas (id_Kambario tipas)
);

CREATE TABLE Klientas
(
	id_Naudotojas int NOT NULL,
	kliento telefono numeris varchar (255) NOT NULL,
	kliento gimimo data date NOT NULL,
	kliento lytis varchar (255) NOT NULL,
	PRIMARY KEY(id_Naudotojas),
	FOREIGN KEY(id_Naudotojas) REFERENCES Naudotojas (id_Naudotojas)
);

CREATE TABLE Stovejimo_vieta
(
	vietos id varchar (255) NOT NULL,
	u�imta nuo date NOT NULL,
	u�imta iki date NOT NULL,
	vietos u�imtumas boolean NOT NULL,
	auk�tas int NOT NULL,
	PRIMARY KEY(vietos id),
	FOREIGN KEY(auk�tas) REFERENCES Auk�tas (id_Auk�tas)
);

CREATE TABLE Treniruote
(
	treniruotes nr int NOT NULL,
	treniruotes prad�ia date NOT NULL,
	treniruotes pabaiga date NOT NULL,
	laisvu vietu kiekis int NOT NULL,
	fk_Trenerisid_Treneris int NOT NULL,
	PRIMARY KEY(treniruotes nr),
	CONSTRAINT veda FOREIGN KEY(fk_Trenerisid_Treneris) REFERENCES Treneris (id_Treneris)
);

CREATE TABLE Kambario_rezervacija
(
	id_Kambario rezervacija int NOT NULL,
	prad�ia date NOT NULL,
	pabaiga date NOT NULL,
	mokejimo busena int NOT NULL,
	fk_Klientasid_Naudotojas int NOT NULL,
	fk_Kambaryskambario numeris varchar (6) NOT NULL,
	PRIMARY KEY(id_Kambario rezervacija),
	FOREIGN KEY(mokejimo busena) REFERENCES Mokejimo_busena (id_Mokejimo busena),
	CONSTRAINT pateikia FOREIGN KEY(fk_Klientasid_Naudotojas) REFERENCES Klientas (id_Naudotojas),
	CONSTRAINT turi FOREIGN KEY(fk_Kambaryskambario numeris) REFERENCES Kambarys (kambario numeris)
);

CREATE TABLE Sporto_sales_rezervacija
(
	id_Sporto sales rezervacija int NOT NULL,
	laiko prad�ia int NOT NULL,
	laiko pabaiga int NOT NULL,
	fk_Klientasid_Naudotojas int NOT NULL,
	fk_Treniruotetreniruotes nr int NOT NULL,
	PRIMARY KEY(id_Sporto sales rezervacija),
	CONSTRAINT daro FOREIGN KEY(fk_Klientasid_Naudotojas) REFERENCES Klientas (id_Naudotojas),
	CONSTRAINT rezervuoja FOREIGN KEY(fk_Treniruotetreniruotes nr) REFERENCES Treniruote (treniruotes nr)
);

CREATE TABLE Kambario_atsiliepimas
(
	id_Kambario atsiliepimas int NOT NULL,
	komentaras varchar (255) NOT NULL,
	atsiliepimo data date NOT NULL,
	fk_Kambario rezervacijaid_Kambario rezervacija int NOT NULL,
	fk_Klientasid_Naudotojas int NOT NULL,
	PRIMARY KEY(id_Kambario atsiliepimas),
	UNIQUE(fk_Klientasid_Naudotojas),
	CONSTRAINT turi FOREIGN KEY(fk_Kambario rezervacijaid_Kambario rezervacija) REFERENCES Kambario_rezervacija (id_Kambario rezervacija),
	CONSTRAINT pateikia FOREIGN KEY(fk_Klientasid_Naudotojas) REFERENCES Klientas (id_Naudotojas)
);

CREATE TABLE Stovejimo_vietos_rezervacija
(
	id_Stovejimo vietos rezervacija int NOT NULL,
	stovejimo_vietos_prad�ia date NOT NULL,
	stovejimo_vietos_pabaiga date NOT NULL,
	fk_Kambario rezervacijaid_Kambario rezervacija int NOT NULL,
	fk_Stovejimo vietavietos id varchar (255) NOT NULL,
	PRIMARY KEY(id_Stovejimo vietos rezervacija),
	UNIQUE(fk_Kambario rezervacijaid_Kambario rezervacija),
	UNIQUE(fk_Stovejimo vietavietos id),
	CONSTRAINT daro FOREIGN KEY(fk_Kambario rezervacijaid_Kambario rezervacija) REFERENCES Kambario_rezervacija (id_Kambario rezervacija),
	CONSTRAINT u�rezervuoja FOREIGN KEY(fk_Stovejimo vietavietos id) REFERENCES Stovejimo_vieta (vietos id)
);
