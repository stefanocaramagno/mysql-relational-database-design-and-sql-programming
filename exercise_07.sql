-- PUNTO 1
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n35_15_novembre_2023;
USE n35_15_novembre_2023;

-- CREAZIONE TABELLA: PERSONA
CREATE TABLE IF NOT EXISTS PERSONA(
	codiceFiscale varchar(20) NOT NULL,
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    dataNascita date NOT NULL,
    indirizzo varchar(30) NOT NULL,
    numeroQualifiche integer,
    PRIMARY KEY(codiceFiscale)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: COMPETENZA
CREATE TABLE IF NOT EXISTS COMPETENZA(
	codice integer NOT NULL,
    nome varchar(20) NOT NULL,
    tipo varchar(20) NOT NULL,
    PRIMARY KEY(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: QUALIFICA
CREATE TABLE IF NOT EXISTS QUALIFICA(
	codice integer NOT NULL,
    nome varchar(20) NOT NULL,
    importanza integer NOT NULL,
    annoIntroduzione integer NOT NULL,
    competenzaAcquisita integer NOT NULL,
    numeroPersone integer,
	PRIMARY KEY(codice),
    INDEX indiceCompetenzaAcquisita(competenzaAcquisita),
    FOREIGN KEY(competenzaAcquisita) REFERENCES COMPETENZA(codice) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: ATTESTATO
CREATE TABLE IF NOT EXISTS ATTESTATO(
	persona varchar(20) NOT NULL,
    qualifica integer NOT NULL,
    data_acquisizione date NOT NULL,
	PRIMARY KEY(persona, qualifica),
    INDEX indicePersona(persona),
    INDEX indiceQualifica(qualifica),
    FOREIGN KEY(persona) REFERENCES PERSONA(codiceFiscale) ON UPDATE CASCADE,
    FOREIGN KEY(qualifica) REFERENCES QUALIFICA(codice) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: USO
CREATE TABLE IF NOT EXISTS USO(
	persona varchar(20) NOT NULL,
    qualifica integer NOT NULL,
    data_uso date NOT NULL,
    PRIMARY KEY(persona, qualifica),
    INDEX indicePersona(persona),
    INDEX indiceQualifica(qualifica),
    FOREIGN KEY(persona) REFERENCES PERSONA(codiceFiscale) ON UPDATE CASCADE,
    FOREIGN KEY(qualifica) REFERENCES QUALIFICA(codice) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- DATI PER TABELLA: PERSONA
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('AAAAAA00X00ZZZZY', 'Antonio', 'Abate', '1979-05-14', 'Via Ancona, 1', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('BBBBBB00X00ZZZZY', 'Bruno', 'Bernardi', '1964-09-21', 'Via Biagi, 2', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('CCCCCC00X00ZZZZY', 'Carla', 'Comi', '1981-02-06', 'Via Cagliari, 3', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('DDDDDD00X00ZZZZY', 'Dario', 'Di Natale', '1975-05-06', 'Via Dante, 4', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('EEEEEE00X00ZZZZY', 'Enzo', 'Erri', '1985-07-30', 'Via Enna, 5', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('FFFFFF00X00ZZZZY', 'Francesco', 'Ferrante', '1988-12-08', 'Via Foggia, 6', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('GGGGGG00X00ZZZZY', 'Giorgia', 'Grandi', '1990-03-11', 'Via Genova, 6', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('HHHHHH00X00ZZZZY', 'Horace', 'Huxley', '1976-01-21', 'Via Heidelberg, 7', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('IIIIII00X00ZZZZY', 'Ilaria', 'Imbriani', '1986-09-15', 'Via Imola, 8', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('LLLLLL00X00ZZZZY', 'Luca', 'Leno', '1981-11-11', 'Via Luci, 9', 0);
insert into PERSONA(CodiceFiscale, Nome, Cognome, DataNascita, Indirizzo, NumeroQualifiche) values('MMMMMM00X00ZZZZY', 'Mario', 'Mirasi', '1980-02-25', 'Via Milano, 10', 0);

-- DATI PER TABELLA: COMPETENZA
insert into COMPETENZA(Codice, Nome, Tipo) values(1, 'informatica', 'tecnica');
insert into COMPETENZA(Codice, Nome, Tipo) values(2, 'elettronica', 'tecnica');
insert into COMPETENZA(Codice, Nome, Tipo) values(3, 'contabile', 'amministrativa');
insert into COMPETENZA(Codice, Nome, Tipo) values(4, 'legale', 'amministrativa');
insert into COMPETENZA(Codice, Nome, Tipo) values(5, 'statistica', 'tecnica');
insert into COMPETENZA(Codice, Nome, Tipo) values(6, 'marketing', 'commerciale');
insert into COMPETENZA(Codice, Nome, Tipo) values(7, 'pubblicitaria', 'commerciale');

-- DATI PER TABELLA: QUALIFICA
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(1, 'software engineer', 10, 2001, 1, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(2, 'web programmer', 9, 2001, 1, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(3, 'circuit designer', 8, 1998, 2, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(4, 'circuit tester', 7, 1998, 2, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(5, 'commercialista', 6, 1993, 3, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(6, 'assistente', 5, 1993, 3, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(7, 'consulente', 4, 1993, 4, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(8, 'data scientist', 8, 2002, 5, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(9, 'grafico', 7, 1999, 7, 0);
insert into QUALIFICA(Codice, Nome, Importanza, AnnoIntroduzione, CompetenzaAcquisita, NumeroPersone) values(10, 'analista vendite', 6, 1998, 6, 0);

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
-- Scrivere una procedura per trovare le informazioni di una 
-- data persona (o più persone) date le prime 3 cifre del codice fiscale. 
DELIMITER //
CREATE PROCEDURE getInformazioniPersonaBy3CifreCF
(IN datoPrefissoCodiceFiscale varchar(3))
BEGIN
    SELECT PERSONA.*
    FROM PERSONA
    WHERE PERSONA.codiceFiscale LIKE CONCAT(datoPrefissoCodiceFiscale, '%');
END //
DELIMITER ;

-- PUNTO 3 
-- Scrivere una procedura per reperire tutte le qualifiche (tutti gli attributi) 
-- che sono state introdotte in un dato anno. 
DELIMITER //
CREATE PROCEDURE getNuoveQualificheByAnno
(IN datoAnno integer)
BEGIN 
    SELECT QUALIFICA.*
    FROM QUALIFICA
    WHERE QUALIFICA.annoIntroduzione = datoAnno;
END //
DELIMITER ;

-- PUNTO 4
-- Scrivere una procedura per reperire tutte le informazioni di persone 
-- che hanno ottenuto una qualifica per una data competenza (dato il nome). 
DELIMITER // 
CREATE PROCEDURE getPersoneConQualificaAcquisitaByNome
(IN datoNome varchar(20))
BEGIN
    SELECT PERSONA.*
    FROM PERSONA
    INNER JOIN ATTESTATO ON PERSONA.codiceFiscale = ATTESTATO.persona
    INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
    INNER JOIN COMPETENZA ON QUALIFICA.codice = COMPETENZA.codice
    WHERE COMPETENZA.nome = datoNome;
END //
DELIMITER ;

-- PUNTO 5
-- Scrivere una procedura per calcolare quante qualifiche sono state introdotte 
-- per ogni anno a partire da un certo anno (incluso) dato come ingresso alla procedura. 
-- (Nota: non mostrare gli anni in cui non sono state introdotte qualifiche).
DELIMITER //
CREATE PROCEDURE getNumeroQualifichePerAnnobySogliaMinimaAnno
(IN datoAnno integer)
BEGIN
    SELECT non
        QUALIFICA.annoIntroduzione, 
        COUNT(QUALIFICA.codice) AS numeroQualifiche
    FROM QUALIFICA
    WHERE QUALIFICA.annoIntroduzione >= datoAnno
    GROUP BY QUALIFICA.annoIntroduzione;
END //
DELIMITER ;

-- PUNTO 6
-- Calcolare il numero medio annuo di attestati rilasciati (considerare 
-- l’intervallo di anni a partire dall’anno in cui è stato rilasciato il primo attestato fino ad oggi).
SELECT 
    YEAR(ATTESTATO.data_acquisizione), 
    COUNT(ATTESTATO.persona) AS numeroAttestati
FROM ATTESTATO
GROUP BY YEAR(ATTESTATO.data_acquisizione)
ORDER BY YEAR(ATTESTATO.data_acquisizione);

-- PUNTO 7 
-- Scrivere la procedura del punto 5 mostrando anche gli anni 
-- in cui non sono state introdotte qualifiche. 
DELIMITER //
CREATE PROCEDURE getNumeroQualifiche

-- PUNTO 8
-- Scrivere una vista per calcolare tutte le persone che hanno acquisito 
-- una qualifica con il massimo livello di importanza. 
CREATE VIEW VistaPersoneQualificaMassimaImportanza AS
SELECT PERSONA.*
FROM PERSONA
INNER JOIN ATTESTATO ON PERSONA.codiceFiscale = ATTESTATO.persona
INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
WHERE QUALIFICA.importanza = (SELECT MAX(QUALIFICA.importanza)
			                  FROM QUALIFICA);

-- PUNTO 9
-- Scrivere una vista per trovare tutte le persone che nonostante abbiano ottenuto 
-- delle qualifiche poi non le hanno effettivamente utilizzate.
CREATE VIEW VistaPersoneCheNonUsanoQualifiche AS
SELECT PERSONA.*
FROM PERSONA
INNER JOIN ATTESTATO ON PERSONA.codiceFiscale = ATTESTATO.persona
INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
WHERE PERSONA.codiceFiscale NOT IN (SELECT USO.persona
                                    FROM USO);

-- PUNTO 10 
-- Calcolare il tempo medio (in anni) trascorso tra quando un attestato 
-- è stato ottenuto e quando è stato poi effettivamente utilizzato 
-- (da calcolare solo per gli attestati che sono stati utilizzati).
SELECT 
    USO.persona,
    YEAR(USO.data_uso) AS annoUso,
    YEAR(ATTESTATO.data_acquisizione) AS annoAquisizione,
    (YEAR(USO.data_uso)- YEAR(ATTESTATO.data_acquisizione)) AS tempoTrascorso
FROM USO 
LEFT JOIN ATTESTATO ON USO.persona = ATTESTATO.persona;

-- PUNTO 11
-- Implementare i trigger per mantenere allineati gli attributi:
-- 1) N_qualifiche su PERSONA;
-- 2) N_Persone su QUALIFICA.
DELIMITER //
CREATE TRIGGER update_numeroQualifiche
AFTER INSERT ON ATTESTATO
FOR EACH ROW
BEGIN
    UPDATE PERSONA
    SET numeroQualifiche = (SELECT COUNT(*) 
		                    FROM ATTESTATO 
                            WHERE persona = NEW.persona)
    WHERE codiceFiscale = NEW.persona;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_numeroPersone
AFTER INSERT ON ATTESTATO
FOR EACH ROW
BEGIN
    UPDATE QUALIFICA
    SET numeroPersone = (SELECT COUNT(*) 
			             FROM ATTESTATO 
                         WHERE qualifica = NEW.qualifica)
    WHERE codice = NEW.qualifica;
END //
DELIMITER ;



