-- PUNTO 1
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n17_25_novembre_2019;
USE n17_25_novembre_2019;

-- CREAZIONE TABELLA: PERSONA
CREATE TABLE IF NOT EXISTS PERSONA(
	codiceFiscale varchar(30),
    nome varchar(30) NOT NULL,
    cognome varchar(30) NOT NULL,
    dataNascita date NOT NULL,
    indirizzo varchar(30) NOT NULL,
    numeroVaccini integer NOT NULL,
    PRIMARY KEY(codiceFiscale)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: MALATTIA
CREATE TABLE IF NOT EXISTS MALATTIA(
	codice integer,
    nome varchar(30) NOT NULL,
    tipo varchar(30) NOT NULL,
    personeContagiate integer NOT NULL,
    PRIMARY KEY(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: VACCINO
CREATE TABLE IF NOT EXISTS VACCINO(
	codice integer,
    rischio integer NOT NULL,
    importanza integer NOT NULL,
    annoIntroduzione integer NOT NULL,
    malattiaPrevenuta integer NOT NULL,
	PRIMARY KEY(codice),
	INDEX indiceMalattiaPrevenuta(malattiaPrevenuta),
    FOREIGN KEY(malattiaPrevenuta) REFERENCES MALATTIA(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: VACCINAZIONE
CREATE TABLE IF NOT EXISTS VACCINAZIONE(
	persona varchar(30),
    vaccino integer,
    dataVaccinazione date NOT NULL,
    PRIMARY KEY(persona, vaccino),
	INDEX indicePersona(persona),
	INDEX indiceVaccino(vaccino),
    FOREIGN KEY(persona) REFERENCES PERSONA(codiceFiscale),
    FOREIGN KEY(vaccino) REFERENCES VACCINO(codice)
) Engine = 'InnoDB';   

-- CREAZIONE TABELLA: CONTAGIO
CREATE TABLE IF NOT EXISTS CONTAGIO(
	persona varchar(30),
    malattia integer,
    dataDiagnosi date NOT NULL,
    PRIMARY KEY(persona, malattia),
	INDEX indicePersona(persona),
	INDEX indiceMalattia(malattia),
    FOREIGN KEY(persona) REFERENCES PERSONA(codiceFiscale),
    FOREIGN KEY(malattia) REFERENCES MALATTIA(codice)
) Engine = 'InnoDB';  

-- DATI PER TABELLA: PERSONA
INSERT INTO PERSONA VALUES('CLBNDR92C19H224W','Enrico','La Torre','1986-06-16','Via delle scale 5', 3);
INSERT INTO PERSONA VALUES('MFCSMR42T19H2U4W','Marco','Rossi','1942-12-15','Via dei martiri 3', 1);
INSERT INTO PERSONA VALUES('STFSPN46THGH2U4K','Stefano','Rotondini','1958-05-03','Via cavour 4', 4);
INSERT INTO PERSONA VALUES('MSCFBR435945FJJK','Giovanna','Puliafito','1990-07-12','Via consolare valeria 6', 2);
INSERT INTO PERSONA VALUES('GTISRT34C65F377O','Davide','Mangoni','1978-01-23','Via della zecca 65', 1);
INSERT INTO PERSONA VALUES('LOLRTI75F82R642T','Ernesto','Polini','1989-03-20','Via Garibaldi 5', 3);

-- DATI PER TABELLA: MALATTIA
INSERT INTO MALATTIA VALUES(1, 'Malaria', 'contagiosa', 20);
INSERT INTO MALATTIA VALUES(2, 'Influenza cinese', 'contagiosa', 150);
INSERT INTO MALATTIA VALUES(3, 'Aviaria', 'contagiosa', 250);
INSERT INTO MALATTIA VALUES(4, 'Tirosenemia', 'erditaria', 2);

-- DATI PER TABELLA: VACCINO
INSERT INTO VACCINO VALUES(1, 2, 4, 1970, 1);
INSERT INTO VACCINO VALUES(2, 5, 4, 2010, 2);
INSERT INTO VACCINO VALUES(3, 5, 4, 2015, 3);
INSERT INTO VACCINO VALUES(4, 1, 4, 2000, 4);

-- DATI PER TABELLA: VACCINAZIONE
INSERT INTO VACCINAZIONE VALUES('CLBNDR92C19H224W', 1, '1987-12-11');
INSERT INTO VACCINAZIONE VALUES('MFCSMR42T19H2U4W', 2, '2016-12-03');
INSERT INTO VACCINAZIONE VALUES('STFSPN46THGH2U4K', 1, '2012-05-07');
INSERT INTO VACCINAZIONE VALUES('CLBNDR92C19H224W', 3, '1999-03-08');
INSERT INTO VACCINAZIONE VALUES('GTISRT34C65F377O', 4, '2000-06-15');
INSERT INTO VACCINAZIONE VALUES('LOLRTI75F82R642T', 1, '2001-11-22');
INSERT INTO VACCINAZIONE VALUES('MSCFBR435945FJJK', 3, '2010-08-10');

-- DATI PER TABELLA: CONTAGGIO
INSERT INTO CONTAGIO VALUES('GTISRT34C65F377O', 1, '2016-01-03');
INSERT INTO CONTAGIO VALUES('CLBNDR92C19H224W', 2, '2002-05-30');
INSERT INTO CONTAGIO VALUES('GTISRT34C65F377O', 3, '2001-11-21');
INSERT INTO CONTAGIO VALUES('STFSPN46THGH2U4K', 4, '1999-10-05');
INSERT INTO CONTAGIO VALUES('MSCFBR435945FJJK', 2, '2016-08-15');

-- PUNTO 2
-- Scrivere una procedura per trovare le informazioni di una data persona (o più persone) 
-- date le prime 3 cifre del codice fiscale.
DELIMITER //
CREATE PROCEDURE getPersonaByPrime3CifreCodiceFiscale
(IN datePrime3CifreCodiceFiscale varchar(3))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS;
	CREATE TEMPORARY TABLE PERS(
		CF varchar(30),
		nome varchar(30),
		cognome varchar(30),
		dataNascita date,
		indirizzo varchar(30),
		N_qualifiche integer
	);
    
	INSERT INTO PERS 
		SELECT PERSONA.*
		FROM PERSONA
		WHERE PERSONA.codiceFiscale LIKE CONCAT(datePrime3CifreCodiceFiscale, '%');
END //
DELIMITER ;
CALL getPersonaByPrime3CifreCodiceFiscale('CLB');
SELECT PERS.* 
FROM PERS;

-- PUNTO 3
-- Scrivere una procedura per reperire tutti i vaccini (tutti gli attributi) 
-- che sono stati introdotti in un dato anno.
DELIMITER //
CREATE PROCEDURE getVacciniByAnno
(IN datoAnno integer)
BEGIN 
	DROP TEMPORARY TABLE IF EXISTS VACC;
	CREATE TEMPORARY TABLE VACC(
		codice integer,
		rischio integer,
		importanza integer,
		annoIntroduzione integer,
		malattiaPrevenuta integer
	);
    
	INSERT INTO VACC 
		SELECT VACCINO.*
		FROM VACCINO
		WHERE annoIntroduzione = datoAnno;
END //
DELIMITER ;    
CALL getVacciniByAnno(2015);
SELECT VACC.* 
FROM VACC;

-- PUNTO 4
-- Scrivere una procedura per reperire tutte le informazioni 
-- di persone che si sono vaccinate per una data malattia.
DELIMITER //
CREATE PROCEDURE getPersoneVaccinateByMalattia
(IN dataMalattia varchar(30))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_VACC;
	CREATE TEMPORARY TABLE PERS_VACC(
		CF varchar(30),
		nome varchar(30),
		cognome varchar(30),
		dataNascita date,
		indirizzo varchar(30),
		N_qualifiche integer
	);
    
	INSERT INTO PERS_VACC 
		SELECT PERSONA.*
		FROM PERSONA
		INNER JOIN VACCINAZIONE ON PERSONA.codiceFiscale = VACCINAZIONE.persona
		INNER JOIN VACCINO ON VACCINAZIONE.vaccino = VACCINO.codice
		INNER JOIN MALATTIA ON VACCINO.malattiaPrevenuta = MALATTIA.codice
		WHERE MALATTIA.nome = dataMalattia;
END //
DELIMITER ;   
CALL getPersoneVaccinateByMalattia('Malaria');
SELECT PERS_VACC.* 
FROM PERS_VACC;

-- PUNTO 5
-- Scrivere una procedura per calcolare quanti vaccini sono stati introdotti 
-- per ogni anno a partire da un certo anno (incluso l’anno stesso) 
-- dato come ingresso alla procedura. 
-- (Nota: non mostrare gli anni in cui non sono stati introdotti vaccini).
DELIMITER //
CREATE PROCEDURE getVacciniPerAnnoByAnno
(IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS COUNT_VACC;
	CREATE TEMPORARY TABLE COUNT_VACC(
		anno integer,
        contatore integer
	);
    
    INSERT INTO COUNT_VACC
		SELECT
			VACCINO.annoIntroduzione,
			COUNT(VACCINO.codice) AS numeroVaccini
		FROM VACCINO
		WHERE VACCINO.annoIntroduzione >= datoAnno
		GROUP BY VACCINO.annoIntroduzione
		HAVING COUNT(VACCINO.codice) > 0
		ORDER BY VACCINO.annoIntroduzione;
END //
DELIMITER ; 
CALL getVacciniPerAnnoByAnno(1994);
SELECT COUNT_VACC.* 
FROM COUNT_VACC;

-- PUNTO 6
-- Calcolare il numero medio annuo di vaccinazioni effettuate.
SELECT 
    YEAR(VACCINAZIONE.dataVaccinazione) AS anno,
    COUNT(VACCINAZIONE.persona) AS numeroVaccini
FROM VACCINAZIONE
GROUP BY YEAR(VACCINAZIONE.dataVaccinazione);

-- PUNTO 7 
-- Scrivere la procedura del punto 5 mostrando anche gli anni in 
-- cui non sono stati introdotti vaccini.
DELIMITER //
CREATE PROCEDURE getVacciniPerAnnoByAnno
(IN datoAnno integer)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS LISTA_ANNI;
    CREATE TEMPORARY TABLE LISTA_ANNI(
		anno integer
    );
    
    WHILE datoAnno <= (SELECT MAX(VACCINO.annoIntroduzione)
                       FROM VACCINO)
	DO
        INSERT INTO LISTA_ANNI
			SELECT datoAnno;
            SET datoAnno = datoAnno + 1;
	END WHILE;

	DROP TEMPORARY TABLE IF EXISTS COUNT_VACC;
	CREATE TEMPORARY TABLE COUNT_VACC(
		anno integer,
        contatore integer
	);
    
    INSERT INTO COUNT_VACC
		SELECT
            LISTA_ANNI.anno AS anno,
			COUNT(ALL VACCINO.annoIntroduzione) AS numeroVaccini
		FROM VACCINO
        RIGHT JOIN LISTA_ANNI ON VACCINO.annoIntroduzione = LISTA_ANNI.anno
		GROUP BY LISTA_ANNI.anno;
END //
DELIMITER ; 
CALL getVacciniPerAnnoByAnno(1994);
SELECT COUNT_VACC.* 
FROM COUNT_VACC;

-- PUNTO 8 (NON FATTA)
-- Scrivere una vista per calcolare tutte le persone che non si sono vaccinate 
-- con il vaccino che ha il livello massimo di importanza.
                            
-- PUNTO 9
-- Scrivere una vista per trovare tutte le persone che nonostante si 
-- siano vaccinate per un data malattia hanno poi contratto la malattia stessa.
CREATE VIEW PersoneVaccinateContaggiate AS
SELECT PERSONA.*
FROM VACCINAZIONE
LEFT JOIN PERSONA ON VACCINAZIONE.persona = PERSONA.codiceFiscale
LEFT JOIN CONTAGIO ON PERSONA.codiceFiscale = CONTAGIO.persona
WHERE dataVaccinazione < dataDiagnosi;

-- PUNTO 10 (NON FATTA)
-- Calcolare il tempo medio trascorso tra il vaccino 
-- e il seguente contagio per tutte le persone di cui al punto 9.

-- PUNTO 11
-- Implementare i trigger per mantenere allineati gli attributi:
-- 1) N_Vaccini su PERSONA e PersoneContagiate su MALATTIA;
-- 2) PersoneContagiate su MALATTIA.
DELIMITER //
CREATE TRIGGER aggiornaNumeroVaccini
AFTER INSERT ON VACCINAZIONE
FOR EACH ROW
BEGIN
    UPDATE PERSONA
    SET PERSONA.numeroVaccini = PERSONA.numeroVaccini + 1
    WHERE PERSONA.codiceFiscale = NEW.persona;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER aggiornaPersoneContaggiate
AFTER INSERT ON CONTAGIO
FOR EACH ROW
BEGIN
    UPDATE MALATTIA
    SET MALATTIA.personeContaggiate = MALATTIA.personeContaggiate + 1
    WHERE MALATTIA.codice = NEW.malattia;
END;
//
DELIMITER ;






