-- PUNTO 1
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n19_25_novembre_2019;
USE n19_25_novembre_2019;

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
	INDEX indceVaccino(vaccino),
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

-- DATI PER TABELLA: CONTAGIO
INSERT INTO CONTAGIO VALUES('GTISRT34C65F377O', 1, '2016-01-03');
INSERT INTO CONTAGIO VALUES('CLBNDR92C19H224W', 2, '2002-05-30');
INSERT INTO CONTAGIO VALUES('GTISRT34C65F377O', 3, '2001-11-21');
INSERT INTO CONTAGIO VALUES('STFSPN46THGH2U4K', 4, '1999-10-05');
INSERT INTO CONTAGIO VALUES('MSCFBR435945FJJK', 2, '2016-08-15');

-- PUNTO 2
-- Scrivere una procedura per trovare le informazioni di una data persona (o più persone) 
-- date le ultime 3 lettere del cognome.
DELIMITER //
CREATE PROCEDURE getPersoneByUltime3CifreCognome
(IN dateUltime3CifreCognome varchar(3))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS;
    CREATE TEMPORARY TABLE PERS(
		codiceFiscale varchar(30),
        nome varchar(30),
        cognome varchar(30),
        datNascita varchar(30),
		indirizzo varchar(30),
        numeroVaccini varchar(30)
	);
    
    INSERT INTO PERS
		SELECT PERSONA.*
        FROM PERSONA
        WHERE PERSONA.cognome LIKE CONCAT('%', dateUltime3CifreCognome);
END //
DELIMITER ;
CALL getPersoneByUltime3CifreCognome('rre');
SELECT PERS.*
FROM PERS;

-- PUNTO 3
-- Scrivere una procedura per reperire tutte le vaccinazioni 
-- (tutti gli attributi) a partire da un dato anno.
DELIMITER //
CREATE PROCEDURE getVaccinazioniByAnno
(IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS VACC;
    CREATE TEMPORARY TABLE VACC(
		persona varchar(30),
        vaccino integer,
        dataVaccinazione date
	);
    
    INSERT INTO VACC
		SELECT VACCINAZIONE.*
        FROM VACCINAZIONE
        WHERE YEAR(VACCINAZIONE.dataVaccinazione) > datoAnno;
END //
DELIMITER ;
CALL getVaccinazioniByAnno('1999');
SELECT VACC.*
FROM VACC;
    
-- PUNTO 4
-- Scrivere una procedura per reperire tutte le informazioni di persone 
-- che non hanno contratto una data malattia.
DELIMITER //
CREATE PROCEDURE getPersoneNonContrattoMalattiaByMalattia
(IN dataMalattia varchar(30))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_NO_MALAT;
    CREATE TEMPORARY TABLE PERS_NO_MALAT(
		codiceFiscale varchar(30),
        nome varchar(30),
        cognome varchar(30),
        datNascita varchar(30),
		indirizzo varchar(30),
        numeroVaccini varchar(30)
	);
    
    INSERT INTO PERS_NO_MALAT
		SELECT PERSONA.*
        FROM PERSONA
        INNER JOIN CONTAGIO ON PERSONA.codiceFiscale = CONTAGIO.persona
        INNER JOIN MALATTIA ON CONTAGIO.malattia = MALATTIA.codice
        WHERE MALATTIA.nome != dataMalattia;
END //
DELIMITER ;
CALL getPersoneNonContrattoMalattiaByMalattia('Malaria');
SELECT PERS_NO_MALAT.*
FROM PERS_NO_MALAT;

-- PUNTO 5
-- Scrivere una procedura per calcolare, per ogni anno, quante persone hanno 
-- contratto una data malattia a partire da un dato anno 
-- (incluso l’anno stesso) definiti come ingresso alla procedura. 
-- (Nota: non mostrare gli anni in cui nessuno ha contratto la data malattia).
DELIMITER //
CREATE PROCEDURE getNumeroPersonePerAnnoByAnno
(IN datoAnno integer,
 IN dataMalattia integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_MALAT;
    CREATE TEMPORARY TABLE PERS_MALAT(
		anno integer,
        numeroPersone integer
	);
    
    INSERT INTO PERS_MALAT
		SELECT 
			YEAR(CONTAGIO.dataDiagnosi) AS anno,
            COUNT(CONTAGIO.persona) AS numeroPersone
		FROM CONTAGIO
        WHERE YEAR(CONTAGIO.dataDiagnosi) >= datoAnno AND CONTAGIO.malattia = dataMalattia
        GROUP BY YEAR(CONTAGIO.dataDiagnosi)
        HAVING COUNT(CONTAGIO.persona) > 0
        ORDER BY YEAR(CONTAGIO.dataDiagnosi);
END //
DELIMITER ;
CALL getNumeroPersonePerAnnoByAnno(2002, 2);
SELECT PERS_MALAT.*
FROM PERS_MALAT;

-- PUNTO 6
-- Calcolare il numero medio di persone che nonostante fossero vaccinate 
-- hanno poi contratto la malattia.
SELECT COUNT(PERSONA.codiceFiscale)  AS numeroPersoneVaccinateMalate
FROM PERSONA
INNER JOIN VACCINAZIONE ON PERSONA.codiceFiscale = VACCINAZIONE.persona
INNER JOIN CONTAGIO ON PERSONA.codiceFiscale = CONTAGIO.persona;

-- PUNTO 7
-- Scrivere la procedura del punto 5 mostrando anche gli anni
-- in cui nessuno ha contratto la malattia.
DELIMITER //
CREATE PROCEDURE getNumeroPersonePerAnnoByAnno
(IN datoAnno integer,
 IN dataMalattia integer)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS LISTA_ANNI;
    CREATE TEMPORARY TABLE LISTA_ANNI(
		anno integer
    );
    
    WHILE datoAnno <= (SELECT MAX(YEAR(CONTAGIO.dataDiagnosi))
                       FROM CONTAGIO)
	DO
        INSERT INTO LISTA_ANNI
			SELECT datoAnno;
            SET datoAnno = datoAnno + 1;
	END WHILE;

	DROP TEMPORARY TABLE IF EXISTS PERS_MALAT;
    CREATE TEMPORARY TABLE PERS_MALAT(
		anno integer,
        numeroPersone integer
	);
    
    INSERT INTO PERS_MALAT
		SELECT 
            LISTA_ANNI.anno AS anno,
            COUNT(ALL YEAR(CONTAGIO.dataDiagnosi)) AS numeroPersone
		FROM CONTAGIO
        RIGHT JOIN LISTA_ANNI ON YEAR(CONTAGIO.dataDiagnosi) = LISTA_ANNI.anno
        GROUP BY LISTA_ANNI.anno;
END //
DELIMITER ;
CALL getNumeroPersonePerAnnoByAnno(2002, 2);
SELECT PERS_MALAT.*
FROM PERS_MALAT;

-- PUNTO 8
-- Scrivere una vista per calcolare tutte le persone che si sono 
-- vaccinate con il vaccino che ha il livello minimo di importanza.
CREATE VIEW PersoneVaccinateMinimaImportanza AS
SELECT PERSONA.*
FROM PERSONA
INNER JOIN VACCINAZIONE ON PERSONA.codiceFiscale = VACCINAZIONE.persona
LEFT JOIN VACCINO ON VACCINAZIONE.vaccino = VACCINO.codice
WHERE VACCINO.importanza = (SELECT MIN(VACCINO.importanza)
							FROM VACCINO);

-- PUNTO 9
-- Scrivere una procedura per trovare, mostrando tutte le informazioni, 
-- il vaccino (o vaccini) meno efficace, 
-- ovvero il vaccino che ha avuto il maggior numero di contagi dopo la vaccinazione.
DELIMITER //
CREATE PROCEDURE getVaccinoMenoEfficace()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS VACC_MEN_EFF;
    CREATE TEMPORARY TABLE VACC_MEN_EFF(
		codice integer,
		rischio integer,
		importanza integer,
		annoIntroduzione integer,
		malattiaPrevenuta integer
    );
    
    INSERT INTO VACC_MEN_EFF
		SELECT VACCINO.*
        FROM VACCINO
        INNER JOIN VACCINAZIONE ON VACCINO.codice = VACCINAZIONE.vaccino
        INNER JOIN CONTAGIO ON VACCINAZIONE.persona = CONTAGIO.persona
        WHERE VACCINO.malattiaPrevenuta = CONTAGIO.malattia
        GROUP BY VACCINAZIONE.vaccino
        ORDER BY COUNT(VACCINAZIONE.vaccino) DESC
        LIMIT 1;
END //
DELIMITER ;
CALL getVaccinoMenoEfficace();
SELECT VACC_MEN_EFF.*
FROM VACC_MEN_EFF;

-- PUNTO 10
-- Scrivere una procedura per calcolare il tempo medio trascorso 
-- tra la data di nascita e il vaccino per una data malattia.
DELIMITER //
CREATE PROCEDURE getTempoMedioNascitaVaccinoByMalattia
(IN dataMalattia integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS TEMP_MED;
    CREATE TEMPORARY TABLE TEMP_MED(
		tempoMedio integer
	);
    
    INSERT INTO TEMP_MED
		SELECT AVG(DATEDIFF(VACCINAZIONE.dataVaccinazione, PERSONA.dataNascita)) AS tempoMedio
        FROM PERSONA
        INNER JOIN VACCINAZIONE ON PERSONA.codiceFiscale = VACCINAZIONE.persona
        INNER JOIN VACCINO ON VACCINAZIONE.vaccino = VACCINO.codice
        WHERE VACCINO.malattiaPrevenuta = dataMalattia;
END //
DELIMITER ;
CALL getTempoMedioNascitaVaccinoByMalattia(1);
SELECT TEMP_MED.*
FROM TEMP_MED;

-- PUNTO 11
-- Implementare un trigger per impedire la vaccinazione di minorenni 
-- con il vaccino a più alto livello di rischio.
DELIMITER //
CREATE TRIGGER controlloVaccinazione
BEFORE INSERT ON VACCINAZIONE
FOR EACH ROW
BEGIN
	DECLARE rischio integer;
    DECLARE etaPersona integer;
    
    SELECT VACCINO.rischio
    INTO rischio
    FROM VACCINO
    WHERE VACCINO.codice = NEW.vaccino;
    
    SELECT TIMESTAMPDIFF(YEAR, PERSONA.dataNascita, currdate())
    INTO etaPersona
    FROM PERSONA
    WHERE PERSONA.codiceFiscale = NEW.persona;
    
    IF etaPersona < 18 AND rischio = (SELECT MAX(VACCINO.rischio)
									  FROM VACCINO)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Non è possibile inserire in VACCINAZIONE';
    END IF;
END;
//
DELIMITER 





