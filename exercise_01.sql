-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n28_18_ottobre_2023;
USE n28_18_ottobre_2023;

-- CREAZIONE TABELLA: IMPIEGATO
CREATE TABLE IF NOT EXISTS IMPIEGATO(
	id integer,
	nome varchar(20) NOT NULL,
	cognome varchar(20) NOT NULL,
	anno integer NOT NULL,
	indirizzo varchar(50) NOT NULL,
	citta varchar(20) NOT NULL, 
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: AZIENDA
CREATE TABLE IF NOT EXISTS AZIENDA(
	nome varchar(20),
	citta varchar(30) NOT NULL,
    PRIMARY KEY(nome)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: LAVORA
CREATE TABLE IF NOT EXISTS LAVORA(
	id_impiegato integer,
	azienda varchar(20),
	salario integer,
    PRIMARY KEY(id_impiegato, azienda),
	INDEX new_id(id_impiegato),
	INDEX new_azienda(azienda),
	FOREIGN KEY(id_impiegato) REFERENCES IMPIEGATO(id) on update cascade,
	FOREIGN KEY(azienda) REFERENCES AZIENDA(nome) on update cascade
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: CAPI
CREATE TABLE IF NOT EXISTS CAPI(
	id_impiegato integer,
	id_capo integer NOT NULL,
    PRIMARY KEY (id_impiegato),
	INDEX new_capo(id_capo),
	INDEX new_impiegato(id_impiegato),
	FOREIGN KEY (id_impiegato) REFERENCES IMPIEGATO(id) on update cascade, 
	FOREIGN KEY (id_capo) REFERENCES IMPIEGATO(id) on update cascade
) Engine = 'InnoDB';

-- DATI PER TABELLA: IMPIEGATO 
insert into IMPIEGATO values ('1','Luca','Rossi','1970','Via Firenze','Torino');
insert into IMPIEGATO values ('2','Giacomo','Verdi','1980','Via Milano','Catania');
insert into IMPIEGATO values ('3','Luca','Felice','1970','Via Pasubio','Milano');
insert into IMPIEGATO values ('4','Gigi','La Trottola','1983','Via Alcide De Gasperi','Torino');
insert into IMPIEGATO values ('5','Mino','Reitano','1959','Via Messina ','Catania');
insert into IMPIEGATO values ('6','Francesco','Turiano','1967','Via Messina','Torino');
insert into IMPIEGATO values ('7','Giuseppe','Turiano','1973','Via Mele','Torino');
insert into IMPIEGATO values ('8','Luciano','Ligabue','1965','Via Peppoli','Catania');
insert into IMPIEGATO values ('9','Francesco','Tramonatana','1937','Via Pinco','Milano');
insert into IMPIEGATO values ('10','Francesco','Turiano','1942','Via Hotel','Catania');
insert into IMPIEGATO values ('11','Luca','Infelice','1965','Via Pasubio','Milano');
insert into IMPIEGATO values ('12','Carlo','Trottola','1980','Via Alcide De Gasperi','Torino');
insert into IMPIEGATO values ('13','Beppe','Reitano','1937','Via Messina ','Catania');
insert into IMPIEGATO values ('14','Francisco','Loi','1947','Via Messina','Torino');
insert into IMPIEGATO values ('15','Pino','Ignoto','1957','Via Mele','Torino');
insert into IMPIEGATO values ('16','Luciano','Lima','1965','Via Peppoli','Catania');
insert into IMPIEGATO values ('17','Ester','Tramonatana','1978','Via Pinco','Milano');
insert into IMPIEGATO values ('18','Francesca','Coco','1967','Via Hotel','Catania');
insert into IMPIEGATO values ('21','Francesca','Coco','1967','Via Hotel','Catania');

-- DATI PER TABELLA: CAPI 
insert into CAPI values (15,1);
insert into CAPI values (2,1);
insert into CAPI values (5,3);
insert into CAPI values (8,3);
insert into CAPI values (9,3);
insert into CAPI values (7,4);
insert into CAPI values (4,13);
insert into CAPI values (6,11);
insert into CAPI values (11,12);
insert into CAPI values (16,18);
insert into CAPI values (17,18);

-- DATI PER TABELLA: AZIENDA 
insert into AZIENDA values ('FASTWEB','Milano');
insert into AZIENDA values ('TELECOM','Torino');
insert into AZIENDA values ('MORGAN STANLEY','Catania');
insert into AZIENDA values ('CISCO','Catania');
insert into AZIENDA values ('ACCENTURE','Milano');
insert into AZIENDA values ('FIAT','Torino');

-- DATI PER TABELLA: LAVORA 
insert into LAVORA values (1,'FASTWEB',10000);
insert into LAVORA values (2,'FASTWEB',20583);
insert into LAVORA values (3,'TELECOM',65783);
insert into LAVORA values (4,'CISCO',78547);
insert into LAVORA values (5,'TELECOM',6743);
insert into LAVORA values (6,'MORGAN STANLEY',78345);
insert into LAVORA values (7,'CISCO',7854);
insert into LAVORA values (8,'TELECOM',78356);
insert into LAVORA values (9,'TELECOM',23432);
insert into LAVORA values (10,'FIAT',56433);
insert into LAVORA values (11,'MORGAN STANLEY',76533);
insert into LAVORA values (12,'MORGAN STANLEY',64332);
insert into LAVORA values (13,'CISCO',23500);
insert into LAVORA values (14,'CISCO',43000);
insert into LAVORA values (15,'FASTWEB',22000);
insert into LAVORA values (16,'FIAT',12500);
insert into LAVORA values (17,'FIAT',54363);
insert into LAVORA values (18,'FIAT',23456);

-- PUNTO 1 
-- Selezionare nome, cognome, città, azienda degli impiegati 
-- che lavorano alla "CISCO" e hanno un salario maggiore di 10000. 
SELECT IMPIEGATO.nome, IMPIEGATO.cognome, IMPIEGATO.citta, LAVORA.azienda
FROM IMPIEGATO
INNER JOIN LAVORA ON IMPIEGATO.id = LAVORA.id_impiegato
WHERE LAVORA.azienda = 'CISCO' AND LAVORA.salario > 1000;

-- PUNTO 2 
-- Selezionare nome, cognome degli impiegati che non lavorano alla "FIAT". 
SELECT IMPIEGATO.nome, IMPIEGATO.cognome
FROM IMPIEGATO
INNER JOIN LAVORA ON IMPIEGATO.id = LAVORA.id_impiegato
WHERE NOT LAVORA.nome = 'FIAT';

-- PUNTO 3 
-- Selezionare nome, cognome, città, azienda degli impiegati che lavorano alla "ACCENTURE". 
SELECT IMPIEGATO.nome, IMPIEGATO.cognome, IMPIEGATO.citta, LAVORA.azienda
FROM IMPIEGATO
INNER JOIN LAVORA ON IMPIEGATO.id = LAVORA.id_impiegato
WHERE LAVORA.azienda = 'ACCENTURE'; 

-- PUNTO 4 
-- Selezionare i dati delle aziende che si trovano nella 
-- stessa città di "FASTWEB" esclusa "FASTWEB" 
SELECT AZIENDA.* 
FROM AZIENDA
WHERE AZIENDA.citta = (SELECT AZIENDA.citta
                       FROM AZIENDA
                       WHERE AZIENDA.nome = 'FASTWEB')
					   AND NOT AZIENDA.nome = 'FASTWEB';

-- PUNTO 5 
-- Selezionare nome e cognome degli impiegati e del relativo capo. 
SELECT 
	IMPIEGATO.nome, 
	IMPIEGATO.cognome, 
	C.nome AS nome_capo, 
	C.cognome AS cognome_capo
FROM IMPIEGATO
LEFT JOIN CAPI ON IMPIEGATO.id = CAPI.id_impiegato
LEFT JOIN IMPIEGATO AS C ON CAPI.id_capo = C.id;

-- PUNTO 6 
-- Selezionare, per ogni azienda, nome e cognome di tutti gli impiegati inclusi i loro capi.
SELECT 
	AZIENDA.nome AS nome_azienda, 
	IMPIEGATO.nome, 
	IMPIEGATO.cognome, 
	C.nome AS nome_capo, 
	C.cognome AS cognome_capo
FROM AZIENDA
LEFT JOIN LAVORA ON AZIENDA.nome = LAVORA.azienda
LEFT JOIN IMPIEGATO ON LAVORA.id_impiegato = IMPIEGATO.id
LEFT JOIN CAPI ON IMPIEGATO.id = CAPI.id_impiegato
LEFT JOIN IMPIEGATO AS C ON CAPI.id_capo = C.id;

-- PUNTO 7
-- Selezionare nome e cognome di tutti gli impiegati che guadagnano più dei loro capi. 
SELECT IMPIEGATO.nome, IMPIEGATO.cognome
FROM IMPIEGATO
INNER JOIN LAVORA ON IMPIEGATO.id = LAVORA.id_impiegato
INNER JOIN CAPI ON LAVORA.id_impiegato = CAPI.id_impiegato
INNER JOIN IMPIEGATO AS C ON CAPI.id_capo = C.id
WHERE LAVORA.salario > (SELECT LAVORA.salario
			      FROM LAVORA
                        WHERE LAVORA.id_impiegato = CAPI.id_capo);

-- PUNTO 8
-- Selezionare le informazioni di tutte le persone nate a Catania 
-- tra il 1960 e il 1970 che lavorano a Milano.
SELECT IMPIEGATO.*
FROM AZIENDA
INNER JOIN LAVORA ON AZIENDA.nome = LAVORA.azienda
INNER JOIN IMPIEGATO ON LAVORA.id_impiegato = IMPIEGATO.id
WHERE AZIENDA.citta = 'Milano' AND IMPIEGATO.citta = 'Catania' AND IMPIEGATO.anno BETWEEN 1960 AND 1970;




