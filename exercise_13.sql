-- PUNTO 1
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n15_25_novembre_2019;
USE n15_25_novembre_2019;

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
-- Scrivere una procedura per trovare le informazioni di 
-- una data persona (o più persone) date le prime 3 lettere del nome.
DELIMITER //
CREATE PROCEDURE getPersonaByPrime3CifreNome
(IN datePrime3CifreNome varchar(3))
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
		WHERE PERSONA.nome LIKE CONCAT(datePrime3CifreNome, '%');
END //
DELIMITER ;
CALL getPersonaByPrime3CifreNome('ANT');
SELECT PERS.* 
FROM PERS;

-- PUNTO 3
-- Scrivere una procedura per reperire tutte gli attestati 
-- (tutti gli attributi) rilasciati nel corso in un dato anno.
DELIMITER //
CREATE PROCEDURE getAttestatiByAnno
(IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS ATT;
	CREATE TEMPORARY TABLE ATT(
		persona varchar(30),
		qualifica integer,
		dataAttestato date
	);
    
    INSERT INTO ATT
		SELECT ATTESTATO.*
		FROM ATTESTATO
		WHERE YEAR(dataAttestato) = datoAnno;
END //
DELIMITER ;
CALL getAttestatiByAnno(2018);
SELECT ATT.* 
FROM ATT;

-- PUNTO 4
-- Scrivere una procedura per reperire tutte le informazioni di persone 
-- che hanno ottenuto una qualifica per una data competenza (dato il nome) in un dato anno.
DELIMITER //
CREATE PROCEDURE getPersoneQualificaPerUnaCompetenzaByAnno
(IN dataCompetenza varchar(30),
 IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_QUAL;
	CREATE TEMPORARY TABLE PERS_QUAL(
		CF varchar(30),
		nome varchar(30),
		cognome varchar(30),
		dataNascita date,
		indirizzo varchar(30),
		N_qualifiche integer
	);
    
    INSERT INTO PERS_QUAL
		SELECT PERSONA.*
		FROM PERSONA
		INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona
		INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
		INNER JOIN COMPETENZA ON QUALIFICA.competenzaAcquisita = COMPETENZA.codice
		WHERE YEAR(ATTESTATO.dataAttestato) = datoAnno AND COMPETENZA.nome = dataCompetenza;
END //
DELIMITER ;
CALL getPersoneQualificaPerUnaCompetenzaByAnno('informatica', 2018);
SELECT PERS_QUAL.* 
FROM PERS_QUAL;

-- PUNTO 5
-- Scrivere una procedura per calcolare quanti attestati sono stati rilasciati per ogni anno 
-- a partire da un dato anno passato (incluso l’anno stesso) come ingresso alla procedura. 
-- (Nota: non mostrare gli anni in cui non sono stati rilasciati attestati).
DELIMITER //
CREATE PROCEDURE getNumeroAttestatiByAnnoMinimo
(IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS COUNT_ATT;
	CREATE TEMPORARY TABLE COUNT_ATT(
		anno integer,
        contatore integer
	);
	
	INSERT INTO COUNT_ATT
		SELECT 
			YEAR(ATTESTATO.dataAttestato),
			COUNT(ATTESTATO.persona) AS numeroAttestati
		FROM ATTESTATO
		WHERE YEAR(ATTESTATO.dataAttestato) >= datoAnno
		GROUP BY YEAR(ATTESTATO.dataAttestato)
		HAVING COUNT(ATTESTATO.persona) > 0
		ORDER BY YEAR(ATTESTATO.dataAttestato);
END //
DELIMITER ;
CALL getNumeroAttestatiByAnnoMinimo(1994);
SELECT COUNT_ATT.* 
FROM COUNT_ATT;

-- PUNTO 6
-- Calcolare il numero medio di persone nate in ciascun anno 
-- (considerare l’intervallo di anni a partire dall’anno in cui 
-- è nata la persona più anziana fino ad oggi).
SELECT 
    YEAR(PERSONA.dataNascita),
    COUNT(PERSONA.CF)
FROM PERSONA
GROUP BY YEAR(PERSONA.dataNascita)
ORDER BY YEAR(PERSONA.dataNascita);

-- PUNTO 7
-- Scrivere la procedura del punto 5 mostrando anche gli anni in cui 
-- non sono stati rilasciati attestati.
DELIMITER //
CREATE PROCEDURE getNumeroAttestatiByAnnoMinimo
(IN datoAnno integer)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS LISTA_ANNI;
    CREATE TEMPORARY TABLE LISTA_ANNI(
		anno integer
    );
    
    WHILE datoAnno <= (SELECT MAX(YEAR(ATTESTATO.dataAttestato))
                       FROM ATTESTATO)
	DO
        INSERT INTO LISTA_ANNI
			SELECT datoAnno;
            SET datoAnno = datoAnno + 1;
	END WHILE;

	DROP TEMPORARY TABLE IF EXISTS COUNT_ATT;
	CREATE TEMPORARY TABLE COUNT_ATT(
		anno integer,
        contatore integer
	);
	
	INSERT INTO COUNT_ATT
		SELECT 
            LISTA_ANNI.anno AS anno,
            COUNT(ALL YEAR(ATTESTATO.dataAttestato)) AS numeroAttestati
		FROM ATTESTATO
        RIGHT JOIN LISTA_ANNI ON YEAR(ATTESTATO.dataAttestato) = LISTA_ANNI.anno
		GROUP BY LISTA_ANNI.anno;
END //
DELIMITER ;
CALL getNumeroAttestatiByAnnoMinimo(1994);
SELECT COUNT_ATT.* 
FROM COUNT_ATT;

-- PUNTO 8
-- Scrivere una vista per calcolare tutte le persone che hanno acquisito 
-- una qualifica introdotta nell’anno più recente 
-- (tra tutti gli anni in cui sono state introdotte qualifiche).
CREATE VIEW PersoneQualificaAnnoPiuRecente AS
SELECT PERSONA.*
FROM PERSONA 
INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona
INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
WHERE QUALIFICA.annoIntroduzione = (SELECT MAX(QUALIFICA.annoIntroduzione)
				    				FROM QUALIFICA);

-- PUNTO 9
-- Scrivere una vista per trovare tutte le persone che hanno utilizzato 
-- tutte le qualifiche nello stesso anno in cui le hanno ottenute.
CREATE VIEW PersoneQualificheAnnoOttenimento AS
SELECT PERSONA.*
FROM PERSONA
INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona
INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
INNER JOIN USO ON QUALIFICA.codice = USO.qualifica
WHERE YEAR(USO.dataUso) = YEAR(ATTESTATO.dataAttestato);

-- PUNTO 10
-- Calcolare il tempo medio (in anni) trascorso tra quando una qualifica è stata introdotta 
-- e quando il primo attestato per quella qualifica è stato rilasciato 
-- (da calcolare solo per le qualifiche per cui sono stati rilasciati attestati).
SELECT 
    QUALIFICA.nome,
    (YEAR(MIN(ATTESTATO.dataAttestato)) - QUALIFICA.annoIntroduzione) AS differenzaAnni
FROM ATTESTATO
INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
GROUP BY QUALIFICA.codice;

-- PUNTO 11
-- Implementare un trigger per impedire l’inserimento in USO se sono trascorsi 
-- meno di due anni solari dall’ottenimento dell’attestato
DELIMITER //
CREATE TRIGGER controlloInserimentoUSO
BEFORE INSERT ON USO
FOR EACH ROW
BEGIN
    DECLARE data_Attestato date;
    SELECT ATTESTATO.dataAttestato
    INTO data_Attestato
    FROM attestato
    WHERE persona = NEW.persona AND qualifica = NEW.qualifica;
    IF (YEAR(NEW.dataUso) - YEAR(data_Attestato)) < 2
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Non è possibile inserire in USO';
    END IF;
END;
//
DELIMITER ;





