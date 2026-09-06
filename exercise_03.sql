-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n30_25_ottobre_2023;
USE n30_25_ottobre_2023;

-- CREAZIONE TABELLA: PERSONA 
CREATE TABLE IF NOT EXISTS PERSONA(
	id integer,
    nome varchar(20) NOT NULL,
    cognome varchar (20) NOT NULL,
    anno_di_nascita varchar(4) NOT NULL,
    indirizzo varchar(50) NOT NULL,
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: MACCHINA 
CREATE TABLE IF NOT EXISTS MACCHINA(
	targa varchar(20),
    modello varchar(20) NOT NULL,
    anno varchar(4) NOT NULL,
    PRIMARY KEY(targa)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: INCIDENTE 
CREATE TABLE IF NOT EXISTS INCIDENTE(
	numero integer,
    data_incidente date NOT NULL,
    luogo varchar(20) NOT NULL,
    PRIMARY KEY(numero)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: PROPRIETARI 
CREATE TABLE IF NOT EXISTS PROPRIETARI(
	id_persona integer,
    targa varchar(20),
    PRIMARY KEY(id_persona, targa),
    INDEX indiceIdPersona(id_persona),
    INDEX indiceTarga(targa),
    FOREIGN KEY(id_persona) REFERENCES PERSONA(id) ON UPDATE CASCADE,
    FOREIGN KEY(targa) REFERENCES MACCHINA(targa) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: PARTECIPA 
CREATE TABLE IF NOT EXISTS PARTECIPA(
	id_persona integer,
    macchina varchar(20),
    numero_incidente integer,
    costo integer NOT NULL,
    PRIMARY KEY(id_persona, macchina, numero_incidente),
    INDEX indiceIdPersona(id_persona),
    INDEX indiceMacchina(macchina),
    INDEX indiceNumeroIncidente(numero_incidente),
    FOREIGN KEY(id_persona) REFERENCES PERSONA(id) ON UPDATE CASCADE,
    FOREIGN KEY(macchina) REFERENCES MACCHINA(targa) ON UPDATE CASCADE,
    FOREIGN KEY(numero_incidente) REFERENCES INCIDENTE(numero) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- DATI PER TABELLA: PERSONA 
insert into PERSONA values ('1','Luca','Rossi','1970','Via Firenze - CT');
insert into PERSONA values ('2','Giacomo','Verdi','1980','Via Milano - CT');
insert into PERSONA values ('3','Luca','Felice','1970','Via Pasubio - ME');
insert into PERSONA values ('4','Gigi','La Trottola','1970','Via Alcide De Gasperi - PA');
insert into PERSONA values ('5','Mino','Reitano','1977','Via Messina - NA');

-- DATI PER TABELLA: MACCHINA 
insert into MACCHINA values ('CT7177','Berlina','2007');
insert into MACCHINA values ('CT7547','Spider','2001');
insert into MACCHINA values ('CT4347','Monovolume','1997');
insert into MACCHINA values ('CT3212','Cadillac','1987');
insert into MACCHINA values ('CT5153','Berlina','1953');
insert into MACCHINA values ('CT5435','Station Vagon','1957');

-- DATI PER TABELLA: PROPRIETARI 
insert into PROPRIETARI values (1,'CT7177');
insert into PROPRIETARI values (1,'CT7547');
insert into PROPRIETARI values (2,'CT4347');
insert into PROPRIETARI values (3,'CT3212');
insert into PROPRIETARI values (4,'CT5153');
insert into PROPRIETARI values (5,'CT5435');

-- DATI PER TABELLA: INCIDENTE 
insert into INCIDENTE values (1,current_date(),'Catania');
insert into INCIDENTE values (2,'2007-08-12','Messina');
insert into INCIDENTE values (3,'2006-07-08','Catania');
insert into INCIDENTE values (4,'2008-08-11','Napoli');
insert into INCIDENTE values (5,'2005-09-11','Catania');
insert into INCIDENTE values (6,'1999-08-11','Palermo');
insert into INCIDENTE values (7,'2002-03-03','Catania');

-- DATI PER TABELLA: PARTECIPA 
insert into PARTECIPA values(1,'CT7177',1,10000);
insert into PARTECIPA values(1,'CT7177',2,5000);
insert into PARTECIPA values(2,'CT4347',2,3000);
insert into PARTECIPA values(3,'CT3212',4,5000);
insert into PARTECIPA values(3,'CT3212',5,5000);
insert into PARTECIPA values(2,'CT4347',7,1000);
insert into PARTECIPA values(5,'CT5435',2,5000);
insert into PARTECIPA values(4,'CT5153',7,50000);
insert into PARTECIPA values(4,'CT5153',6,500);

-- PUNTO 1
-- Trovare il costo massimo di un incidente avvenuto tra il 2008 e il 2023. 
-- Successivamente, trovare anche le informazioni delle persone coinvolte in tali incidenti. 
SELECT MAX(PARTECIPA.costo) AS costo_massimo, PERSONA.*
FROM PARTECIPA
INNER JOIN INCIDENTE ON PARTECIPA.numero_incidente = INCIDENTE.numero
INNER JOIN PERSONA ON PARTECIPA.id_persona = PERSONA.id
WHERE YEAR(INCIDENTE.data_incidente) BETWEEN 2008 AND 2023;

-- PUNTO 2
-- Trovare il costo degli incidenti di tutte le persone con ID < 5 e TARGA che inizi con ‘CT7’. 
SELECT SUM(PARTECIPA.costo) AS costo_totale
FROM PARTECIPA
WHERE PARTECIPA.id_persona < 5 AND PARTECIPA.macchina LIKE 'CT7%';

-- PUNTO 3
-- Trovare il numero totale di persone proprietarie (senza duplicati) 
-- di auto coinvolte in incidente nel 2007. 
SELECT COUNT(DISTINCT id_persona) AS numero_proprietari
FROM PROPRIETARI
INNER JOIN PARTECIPA ON PROPRIETARI.targa = PARTECIPA.macchina
INNER JOIN INCIDENTE ON PARTECIPA.numero_incidente = INCIDENTE.numero
WHERE YEAR(INCIDENTE.data_incidente) = 2007;

-- PUNTO 4
-- Trovare il numero di incidenti nelle quali le macchine coinvolte appartengono a Luca Rossi. 
SELECT COUNT(*) AS numero_incidenti
FROM PARTECIPA
INNER JOIN PROPRIETARI ON PARTECIPA.id_persona = PROPRIETARI.id_persona
INNER JOIN PERSONA ON PROPRIETARI.id_persona = PERSONA.id
WHERE PERSONA.nome = 'Luca' AND Persona.cognome = 'Rossi';

-- PUNTO 5 
-- Cancellare le macchine appartenenti a ‘Giacomo Verdi’ 
-- (N.B. Ogni persona puo’ avere piu’ di un’auto). 
DELETE MACCHINA FROM MACCHINA
INNER JOIN PROPRIETARI ON MACCHINA.targa = PROPRIETARI.targa
INNER JOIN PERSONA ON PROPRIETARI.id_persona = PERSONA.id
WHERE PERSONA.nome = "Giacomo" AND PERSONA.cognome = "Verdi";

-- PUNTO 6 
-- Incidenti avvenuti a Messina da tutte auto con targhe ‘CT’. 
SELECT INCIDENTE.*, PARTECIPA.macchina
FROM PARTECIPA
INNER JOIN INCIDENTE ON PARTECIPA.numero_incidente = INCIDENTE.numero
WHERE PARTECIPA.macchina LIKE 'CT%' AND INCIDENTE.luogo = 'Messina';

-- PUNTO 7
-- Tramite query nidificate trovate tutti gli incidenti 
-- che sono avvenuti nella stessa città e nella stessa data. 

-- PUNTO 8 
-- Trovare tutte le persone che hanno auto dello stesso modello 
SELECT PERSONA.*, MACCHINA.modello
FROM PERSONA
INNER JOIN PROPRIETARI ON PERSONA.id = PROPRIETARI.id_persona
INNER JOIN MACCHINA ON PROPRIETARI.targa = MACCHINA.targa
GROUP BY MACCHINA.modello
HAVING COUNT(MACCHINA.modello) > 1;


	
	
