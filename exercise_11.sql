-- PUNTO 1
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n14_25_novembre_2019;
USE n14_25_novembre_2019;

-- CREAZIONE TABELLA: PERSONA
CREATE TABLE IF NOT EXISTS PERSONA(
	CF varchar(30),
    nome varchar(30) NOT NULL,
    cognome varchar(30) NOT NULL,
    dataNascita date NOT NULL,
    indirizzo varchar(30) NOT NULL,
    N_qualifiche integer NOT NULL,
    PRIMARY KEY(CF)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: COMPETENZA
CREATE TABLE IF NOT EXISTS COMPETENZA(
	codice integer,
    nome varchar(30) NOT NULL,
    tipo varchar(30) NOT NULL,
    PRIMARY KEY(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: QUALIFICA
CREATE TABLE IF NOT EXISTS QUALIFICA(
	codice integer,
    nome varchar(30) NOT NULL,
    importanza integer NOT NULL,
    annoIntroduzione integer NOT NULL,
    competenzaAcquisita integer NOT NULL,
    N_Persone integer NOT NULL,
    PRIMARY KEY(codice),
    INDEX indiceCompetenzaAcquisita(competenzaAcquisita),
    FOREIGN KEY(competenzaAcquisita) REFERENCES COMPETENZA(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: ATTESTATO
CREATE TABLE IF NOT EXISTS ATTESTATO(
	persona varchar(30),
    qualifica integer,
    dataAttestato date NOT NULL,
    PRIMARY KEY(persona, qualifica),
    INDEX indicePersona1(persona),
    INDEX indiceQualifica1(qualifica),
    FOREIGN KEY(persona) REFERENCES PERSONA(CF),
    FOREIGN KEY(qualifica) REFERENCES QUALIFICA(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: USO
CREATE TABLE IF NOT EXISTS USO(
	persona varchar(30),
    qualifica integer,
    dataUso date NOT NULL,
    PRIMARY KEY(persona, qualifica),
    INDEX indicePersona2(persona),
    INDEX indiceQualifica2(qualifica),
    FOREIGN KEY(persona) REFERENCES PERSONA(CF),
    FOREIGN KEY(qualifica) REFERENCES QUALIFICA(codice)
) Engine = 'InnoDB';

-- DATI PER TABELLA: PERSONA
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('AAAAAA00X00ZZZZY', 'Antonio', 'Abate', '1979-05-14', 'Via Ancona, 1', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('BBBBBB00X00ZZZZY', 'Bruno', 'Bernardi', '1964-09-21', 'Via Biagi, 2', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('CCCCCC00X00ZZZZY', 'Carla', 'Comi', '1981-02-06', 'Via Cagliari, 3', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('DDDDDD00X00ZZZZY', 'Dario', 'Di Natale', '1975-05-06', 'Via Dante, 4', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('EEEEEE00X00ZZZZY', 'Enzo', 'Erri', '1985-07-30', 'Via Enna, 5', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('FFFFFF00X00ZZZZY', 'Francesco', 'Ferrante', '1988-12-08', 'Via Foggia, 6', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('GGGGGG00X00ZZZZY', 'Giorgia', 'Grandi', '1990-03-11', 'Via Genova, 6', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('HHHHHH00X00ZZZZY', 'Horace', 'Huxley', '1976-01-21', 'Via Heidelberg, 7', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('IIIIII00X00ZZZZY', 'Ilaria', 'Imbriani', '1986-09-15', 'Via Imola, 8', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('LLLLLL00X00ZZZZY', 'Luca', 'Leno', '1981-11-11', 'Via Luci, 9', 0);
insert into PERSONA(CF, Nome, Cognome, DataNascita, Indirizzo, N_qualifiche) values('MMMMMM00X00ZZZZY', 'Mario', 'Mirasi', '1980-02-25', 'Via Milano, 10', 0);

-- DATI PER TABELLA: COMPETENZA
insert into COMPETENZA(Codice, Nome, Tipo) values(1, 'informatica', 'tecnica');
insert into COMPETENZA(Codice, Nome, Tipo) values(2, 'elettronica', 'tecnica');
insert into COMPETENZA(Codice, Nome, Tipo) values(3, 'contabile', 'amministrativa');
insert into COMPETENZA(Codice, Nome, Tipo) values(4, 'legale', 'amministrativa');
insert into COMPETENZA(Codice, Nome, Tipo) values(5, 'statistica', 'tecnica');
insert into COMPETENZA(Codice, Nome, Tipo) values(6, 'marketing', 'commerciale');
insert into COMPETENZA(Codice, Nome, Tipo) values(7, 'pubblicitaria', 'commerciale');

-- DATI PER TABELLA: QUALIFICA
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(1, 'software engineer', 10, 2001, 1, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(2, 'web programmer', 9, 2001, 1, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(3, 'circuit designer', 8, 1998, 2, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(4, 'circuit tester', 7, 1998, 2, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(5, 'commercialista', 6, 1993, 3, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(6, 'assistente', 5, 1993, 3, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(7, 'consulente', 4, 1993, 4, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(8, 'data scientist', 8, 2002, 5, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(9, 'grafico', 7, 1999, 7, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, N_Persone) values(10, 'analista vendite', 6, 1998, 6, 0);

-- DATI PER TABELLA: ATTESTATO
insert into ATTESTATO values ('AAAAAA00X00ZZZZY', 1, '2018-05-20');
insert into ATTESTATO values('AAAAAA00X00ZZZZY', 3, '2018-05-20');
insert into ATTESTATO values('AAAAAA00X00ZZZZY', 8, '2018-05-20');
insert into ATTESTATO values('BBBBBB00X00ZZZZY', 2, '2017-09-14');
insert into ATTESTATO values('CCCCCC00X00ZZZZY', 3, '2016-01-12');
insert into ATTESTATO values('DDDDDD00X00ZZZZY', 4, '2015-08-22');
insert into ATTESTATO values('EEEEEE00X00ZZZZY', 5, '2016-04-08');
insert into ATTESTATO values('FFFFFF00X00ZZZZY', 6, '2017-10-05');
insert into ATTESTATO values('GGGGGG00X00ZZZZY', 7, '2018-06-19');
insert into ATTESTATO values('HHHHHH00X00ZZZZY', 8, '2017-08-26');
insert into ATTESTATO values('IIIIII00X00ZZZZY', 1, '2016-12-01');
insert into ATTESTATO values('LLLLLL00X00ZZZZY', 9, '2017-06-21');
insert into ATTESTATO values('MMMMMM00X00ZZZZY', 10, '2018-01-10');

-- DATI PER TABELLA: USO
insert into USO values('AAAAAA00X00ZZZZY', 1, '2018-09-21');
insert into USO values('BBBBBB00X00ZZZZY', 2, '2018-02-19');
insert into USO values('DDDDDD00X00ZZZZY', 4, '2017-10-06');
insert into USO values('EEEEEE00X00ZZZZY', 5, '2016-11-04');
insert into USO values('GGGGGG00X00ZZZZY', 7, '2018-11-02');

-- PUNTO 2
-- Scrivere una procedura per trovare le informazioni di una data persona 
-- (o più persone) date le ultime 3 lettere del cognome.
DELIMITER //
CREATE PROCEDURE getPersonaByUltime3CifreCognome
(IN dateUltime3CifreCognome varchar(3))
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
		WHERE PERSONA.cognome LIKE CONCAT('%', dateUltime3CifreCognome);
END //
DELIMITER ;
CALL getPersonaByUltime3CifreCognome('ATE');
SELECT PERS.* 
FROM PERS;

-- PUNTO 3
-- Scrivere una procedura per reperire tutte le competenze 
-- (tutti gli attributi) di tipo “tecnica” o “amministrativa”. 
DELIMITER //
CREATE PROCEDURE getCompetenzeTecnicheAmministrative()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS COMP;
	CREATE TEMPORARY TABLE COMP(
		codice integer,
        nome varchar(30),
        tipo varchar(30)
	);
    
	INSERT INTO COMP
		SELECT COMPETENZA.*
		FROM COMPETENZA
		WHERE COMPETENZA.tipo = 'tecnica' OR COMPETENZA.tipo = 'amministrativa';
END //
DELIMITER ;
CALL getCompetenzeTecnicheAmministrative();
SELECT COMP.* 
FROM COMP;

-- PUNTO 4
-- Scrivere una procedura per reperire tutte le informazioni di persone 
-- che hanno ottenuto una qualifica per almeno una 
-- tra due tipi di competenze, date in ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getPersoneQualificaByCompetenze
(IN dataPrimaCompetenza integer,
 IN dataSecondaCompetenza integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_COMP;
	CREATE TEMPORARY TABLE PERS_COMP(
		CF varchar(30),
		nome varchar(30),
		cognome varchar(30),
		dataNascita date,
		indirizzo varchar(30),
		N_qualifiche integer
	);
    
	INSERT INTO PERS_COMP
		SELECT PERSONA.*
		FROM PERSONA
		INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona
		INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
		INNER JOIN COMPETENZA ON QUALIFICA.competenzaAcquisita = COMPETENZA.codice
		WHERE COMPETENZA.tipo = dataPrimaCompetenza OR COMPETENZA.tipo = dataSecondaCompetenza;
END //
DELIMITER ;    
CALL getPersoneQualificaByCompetenze(1,2);
SELECT PERS_COMP.* 
FROM PERS_COMP;

-- PUNTO 5
-- Scrivere una procedura per calcolare quante persone sono nate in ciascun anno maggiore 
-- o uguale ad un anno passato come ingresso alla procedura. 
-- (Nota: non mostrare gli anni in cui non è nata nessuna persona).
DELIMITER //
CREATE PROCEDURE getPersoneNateByAnno
(IN datoAnno integer)
BEGIN 
	DROP TEMPORARY TABLE IF EXISTS COUNT_PERS;
	CREATE TEMPORARY TABLE COUNT_PERS(
		YEAR integer,
        COUNT integer
	);
	
	INSERT INTO COUNT_PERS
		SELECT 
			YEAR(PERSONA.dataNascita) AS anno,
			COUNT(PERSONA.CF) AS personeNate
		FROM PERSONA
		WHERE YEAR(PERSONA.dataNascita) >= datoAnno
		GROUP BY YEAR(PERSONA.dataNascita);
END //
DELIMITER ; 
CALL getPersoneNateByAnno(1980);
SELECT COUNT_PERS.* 
FROM COUNT_PERS;

-- PUNTO 6
-- Calcolare il numero medio annuo di qualifiche introdotte 
-- (considerare l’intervallo di anni a partire dall’anno in cui è 
-- stata introdotta la prima qualifica fino ad oggi).
SELECT 
    QUALIFICA.annoIntroduzione, 
    COUNT(QUALIFICA.codice) AS numeroQualifiche
FROM QUALIFICA
GROUP BY QUALIFICA.annoIntroduzione
ORDER BY QUALIFICA.annoIntroduzione;

-- PUNTO 7 
-- Scrivere la procedura del punto 5 mostrando anche gli anni in cui non sono nate persone.
DELIMITER //
CREATE PROCEDURE getPersoneNateByAnno
(IN datoAnno integer)
BEGIN 
	DROP TEMPORARY TABLE IF EXISTS LISTA_ANNI;
    CREATE TEMPORARY TABLE LISTA_ANNI(
		anno integer
    );

	WHILE datoAnno <= (SELECT MAX(YEAR(PERSONA.dataNascita))
					   FROM PERSONA)
	DO
		INSERT INTO LISTA_ANNI
			SELECT datoAnno;
            SET datoAnno = datoAnno + 1;
	END WHILE;		

	DROP TEMPORARY TABLE IF EXISTS COUNT_PERS;
	CREATE TEMPORARY TABLE COUNT_PERS(
		YEAR integer,
        COUNT integer
	);
	
	INSERT INTO COUNT_PERS
		SELECT 
			LISTA_ANNI.anno AS anno,
			COUNT(ALL YEAR(PERSONA.dataNascita)) AS numeroPersone
		FROM PERSONA
		RIGHT JOIN LISTA_ANNI ON YEAR(PERSONA.dataNascita) = LISTA_ANNI.anno
		GROUP BY LISTA_ANNI.anno;
END //
DELIMITER ; 
CALL getPersoneNateByAnno(1980);
SELECT COUNT_PERS.* 
FROM COUNT_PERS;

-- PUNTO 8
-- Scrivere una vista per calcolare tutte le persone 
-- che hanno utilizzato una qualifica con il minimo livello di importanza.
CREATE VIEW PersoneQualificaMinimoLivelloImportanza AS
SELECT 
    QUALIFICA.importanza,
    PERSONA.*
FROM PERSONA
INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona
INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
WHERE QUALIFICA.importanza = (SELECT MIN(QUALIFICA.importanza)
							  FROM QUALIFICA);

-- PUNTO 9 (NON FATTA)
-- Scrivere una vista per trovare tutte le persone che 
-- hanno usato tutte le qualifiche che hanno ottenuto.


-- PUNTO 10
-- Calcolare il tempo medio (in anni) trascorso tra quando una qualifica 
-- è stata introdotta e quando è stata utilizzata per la 
-- prima volta (da calcolare solo per le qualifiche che sono state utilizzate).
SELECT 
    QUALIFICA.nome,
    (YEAR(MIN(USO.dataUso)) - QUALIFICA.annoIntroduzione) AS differenzaAnni
FROM QUALIFICA
INNER JOIN USO ON QUALIFICA.codice = USO.qualifica
GROUP BY USO.qualifica;

-- PUNTO 11 
-- Implementare un trigger:
-- a) per impedire l’inserimento in USO se la data è precedente 
-- a quella di ottenimento dell’attestato;
DELIMITER //
CREATE TRIGGER controlloInserimentoUSO
BEFORE INSERT ON USO
FOR EACH ROW
BEGIN
    DECLARE data_Attestato date;
    SELECT ATTESTATO.dataAttestato 
    INTO data_Attestato 
    FROM ATTESTATO 
    WHERE persona = NEW.persona AND qualifica = NEW.qualifica;
    IF NEW.dataUso < data_Attestato 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Non è possibile inserire in USO';
    END IF;
END;
//
DELIMITER 
	
-- b) inserire invece in una tabella, creata la prima volta che il trigger è attivato, 
-- USO_PRIMA_ATTESTATO (stessi attributi di USO).
DELIMITER //
CREATE TRIGGER inserimentoUSO_PRIMA_ATTESTATO
BEFORE INSERT ON USO
FOR EACH ROW
BEGIN
    DECLARE data_Attestato date;
    SELECT ATTESTATO.dataAttestato 
    INTO data_Attestato 
    FROM ATTESTATO 
    WHERE persona = NEW.persona AND qualifica = NEW.qualifica;
    IF NEW.dataUso < data_Attestato 
	CREATE TABLE IF NOT EXISTS USO_PRIMA_ATTESTATO LIKE USO
        INSERT INTO USO_PRIMA_ATTESTATO VALUES (NEW.persona, NEW.qualifica, NEW.dataUso);
    END IF;
END;
//
DELIMITER 
