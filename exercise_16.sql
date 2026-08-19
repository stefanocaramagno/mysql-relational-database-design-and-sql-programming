-- PUNTO 1
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n20_25_novembre_2019;
USE n20_25_novembre_2019;

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
-- Scrivere una procedura per trovare le informazioni di una data persona 
-- (o più persone) date le ultime 3 lettere del nome.
DELIMITER //
CREATE PROCEDURE getPersonaByUltime3CifreNome
(IN dateUltime3CifreNome varchar(3))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS;
	CREATE TEMPORARY TABLE PERS(
		codiceFiscale varchar(30),
		nome varchar(30),
		cognome varchar(30),
		dataNascita date,
		indirizzo varchar(30),
		numeroVaccini integer
	);

	INSERT INTO PERS
		SELECT PERSONA.*
		FROM PERSONA
		WHERE PERSONA.nome LIKE CONCAT('%',dateUltime3CifreNome);
END //
DELIMITER ;
CALL getPersonaByUltime3CifreNome('ico');
SELECT PERS.* 
FROM PERS;

-- PUNTO 3
-- Scrivere una procedura per reperire tutti i vaccini (tutti gli attributi) 
-- la cui importanza è inferiore ad un dato valore.
DELIMITER //
CREATE PROCEDURE getVacciniByImportanza
(IN dataImportanza integer)
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
		WHERE VACCINO.importanza < dataImportanza;
END //
DELIMITER ;
CALL getVacciniByImportanza(5);
SELECT VACC.* 
FROM VACC;

-- PUNTO 4
-- Scrivere una procedura per reperire tutte le informazioni di 
-- persone che non hanno mai contratto una data malattia.
DELIMITER //
CREATE PROCEDURE getPersoneByMalattia
(IN dataMalattia varchar(30))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_NO_MALATTIA;
	CREATE TEMPORARY TABLE PERS_NO_MALATTIA(
		codiceFiscale varchar(30),
		nome varchar(30),
		cognome varchar(30),
		dataNascita date,
		indirizzo varchar(30),
		numeroVaccini integer
	);

	INSERT INTO PERS_NO_MALATTIA
		SELECT PERSONA.*
		FROM PERSONA
		INNER JOIN CONTAGIO ON PERSONA.codiceFiscale = CONTAGIO.persona
		INNER JOIN MALATTIA ON CONTAGIO.malattia = MALATTIA.codice
		WHERE MALATTIA.nome != dataMalattia;
END //
DELIMITER ;
CALL getPersoneByMalattia('Malaria');
SELECT PERS_NO_MALATTIA.* 
FROM PERS_NO_MALATTIA;

-- PUNTO 5
-- Scrivere una procedura per calcolare, per ogni anno, quante persone si siano vaccinate con un vaccino (o vaccini) 
-- di un dato livello di rischio a partire da un dato anno passato (incluso l’anno stesso) come ingresso alla procedura. 
-- (Nota: non mostrare gli anni in cui nessuno si sia vaccinato con un vaccino con il dato livello di rischio). 
DELIMITER //
CREATE PROCEDURE getNumeroPersoneVaccinoByRischio
(IN datoRischio integer,
 IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_VACC;
    CREATE TEMPORARY TABLE PERS_VACC(
		anno integer,
        numeroPersone integer
	);
    
    INSERT INTO PERS_VACC
		SELECT
			YEAR(VACCINAZIONE.dataVaccinazione) AS anno,
			COUNT(VACCINAZIONE.persona) AS numeroPersone
		FROM VACCINAZIONE
		INNER JOIN VACCINO ON VACCINAZIONE.vaccino = VACCINO.codice
		WHERE VACCINO.rischio = datoRischio AND YEAR(VACCINAZIONE.dataVaccinazione) >= datoAnno
		GROUP BY YEAR(VACCINAZIONE.dataVaccinazione)
		HAVING COUNT(VACCINAZIONE.persona) > 0
		ORDER BY YEAR(VACCINAZIONE.dataVaccinazione);
END //
DELIMITER ;
CALL getNumeroPersoneVaccinoByRischio(2, 2000);
SELECT PERS_VACC.*
FROM PERS_VACC;

-- PUNTO 6
-- Calcolare mediamente il numero di vaccinazioni annue.
SELECT AVG(numeroVaccinazioni) AS MediaVaccinazioni
FROM (SELECT 
		YEAR(VACCINAZIONE.dataVaccinazione) AS anno,
		COUNT(VACCINAZIONE.persona) AS numeroVaccinazioni
	  FROM VACCINAZIONE
	  GROUP BY YEAR(VACCINAZIONE.dataVaccinazione)) AS VaccinazioniPerAnno;

-- PUNTO 7
-- Scrivere la procedura del punto 5 mostrando anche gli anni in cui nessuno si 
-- sia vaccinato con vaccini con il dato livello di rischio. 
DELIMITER //
CREATE PROCEDURE getNumeroPersoneVaccinoByRischio
(IN datoRischio integer,
 IN datoAnno integer)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS LISTA_ANNI;
    CREATE TEMPORARY TABLE LISTA_ANNI(
		anno integer
    );
    
    WHILE datoAnno <= (SELECT MAX(YEAR(VACCINAZIONE.dataVaccinazione))
                       FROM VACCINAZIONE)
	DO
        INSERT INTO LISTA_ANNI
			SELECT datoAnno;
            SET datoAnno = datoAnno + 1;
	END WHILE;

	DROP TEMPORARY TABLE IF EXISTS PERS_VACC;
    CREATE TEMPORARY TABLE PERS_VACC(
		anno integer,
        numeroPersone integer
	);
    
    INSERT INTO PERS_VACC
		SELECT
            LISTA_ANNI.anno AS anno,
			COUNT(ALL YEAR(VACCINAZIONE.dataVaccinazione)) AS numeroPersone
		FROM VACCINAZIONE
		INNER JOIN VACCINO ON VACCINAZIONE.vaccino = VACCINO.codice
        RIGHT JOIN LISTA_ANNI ON YEAR(VACCINAZIONE.dataVaccinazione) = LISTA_ANNI.anno   
		WHERE VACCINO.rischio = datoRischio 
		GROUP BY LISTA_ANNI.anno;
END //
DELIMITER ;
CALL getNumeroPersoneVaccinoByRischio(2, 2000);
SELECT PERS_VACC.*
FROM PERS_VACC;

-- PUNTO 8
-- Scrivere una vista per calcolare tutte le persone che si sono vaccinate con il vaccino più utilizzato.
CREATE VIEW PersoneVaccinateVacciniPiuUsato AS
SELECT PERSONA.*
FROM PERSONA
INNER JOIN VACCINAZIONE ON PERSONA.codiceFiscale = VACCINAZIONE.persona
WHERE VACCINAZIONE.vaccino = (SELECT VACCINAZIONE.vaccino
							  FROM VACCINAZIONE
							  GROUP BY VACCINAZIONE.vaccino
							  ORDER BY COUNT(VACCINAZIONE.vaccino) DESC
							  LIMIT 1);

-- PUNTO 9
-- Scrivere una procedura per trovare, mostrando tutte le informazioni, il vaccino (o vaccini) 
-- per il quale non c’è mai stato un contagio.

-- PUNTO 10
-- Scrivere una procedura per calcolare il tempo massimo trascorso tra la data di nascita 
-- e la data di vaccinazione per una data malattia.
DELIMITER //
CREATE PROCEDURE getTempoMassimoDataNascitaDataVaccinazioneByMalattia
(IN dataMalattia varchar(30))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS TEMP_MAX;
    CREATE TEMPORARY TABLE TEMP_MAX(
		tempoMassimo integer
    );
    
    INSERT INTO TEMP_MAX
		SELECT MAX(DATEDIFF(VACCINAZIONE.dataVaccinazione, PERSONA.dataNascita)) as TempoMassimo
        FROM PERSONA
        INNER JOIN VACCINAZIONE ON PERSONA.codiceFiscale = VACCINAZIONE.persona
        INNER JOIN VACCINO ON VACCINAZIONE.vaccino = VACCINO.codice
        INNER JOIN MALATTIA ON VACCINO.malattiaPrevenuta = MALATTIA.codice
        INNER JOIN CONTAGIO ON MALATTIA.codice = CONTAGIO.malattia 
        WHERE MALATTIA.nome = dataMalattia;
END //
DELIMITER ;
CALL getTempoMassimoDataNascitaDataVaccinazioneByMalattia('Malaria');
SELECT TEMP_MAX.*
FROM TEMP_MAX;

-- PUNTO 11
-- Implementare un trigger per impedire la vaccinazione di una persona, 
-- per una data malattia, se ha già contratto la malattia stessa.
DELIMITER //
CREATE TRIGGER controlloInserimentoVaccinazione
BEFORE INSERT ON VACCINAZIONE
FOR EACH ROW
BEGIN
	DECLARE malattia integer;
    DECLARE persona integer;
    
    SELECT MALATTIA.codice
    INTO malattia
    FROM MALATTIA 
    WHERE MALATTIA.codice = NEW.malattia;

    SELECT PERSONA.codiceFiscale
    INTO persona
    FROM PERSONA 
    WHERE PERSONA.codiceFiscale = NEW.persona;
    
    IF malattia = (SELECT CONTAGIO.malattia
				   FROM CONTAGIO
                   WHERE CONTAGIO.malattia = malattia) 
		AND persona = (SELECT CONTAGIO.persona
					   FROM CONTAGIO
					   WHERE CONTAGIO.persona = persona) 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Non è possibile inserire in VACCINAZIONE';
	END IF;
END;
//
DELIMITER 
    