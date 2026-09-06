-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n36_22_novembre_2023;
USE n36_22_novembre_2023;

-- CREAZIONE TABELLA: PILOTA
CREATE TABLE IF NOT EXISTS PILOTA(
	codiceFiscale varchar(16),
	nome varchar(255), 
	cognome varchar(255), 
	dataNascita date, 
	indirizzo varchar(255), 
	numeroGare integer,
    PRIMARY KEY(codiceFiscale)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: CAMPIONATO
CREATE TABLE IF NOT EXISTS CAMPIONATO(
	codice integer, 
	nome varchar(255), 
	tipo varchar(255), 
	pilotiVincitori integer,
    PRIMARY KEY(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: GARA
CREATE TABLE IF NOT EXISTS GARA(
	codice integer, 
	difficolta integer, 
	coefficente integer, 
	annoIntroduzione integer, 
	campionatoAppartenenza integer,
	INDEX idx_camp(campionatoAppartenenza),
	FOREIGN KEY(campionatoAppartenenza) REFERENCES CAMPIONATO(codice),
    PRIMARY KEY(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: VITTORIE
CREATE TABLE IF NOT EXISTS VITTORIE(
	pilota varchar(16), 
	gara integer, 
	dataVittoria DATE,
	INDEX idx_pil(pilota),
	INDEX idx_gara(Gara),
	FOREIGN KEY(pilota) REFERENCES PILOTA(codiceFiscale),
	FOREIGN KEY(gara) REFERENCES GARA(codice),
	PRIMARY KEY(pilota, gara, dataVittoria)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: ALBO
CREATE TABLE IF NOT EXISTS ALBO(
	pilota varchar(16), 
	campionato integer, 
	anno integer,
	INDEX idx_pil(pilota),
	INDEX idx_camp(campionato),
	FOREIGN KEY(pilota) REFERENCES PILOTA(codiceFiscale),
	FOREIGN KEY(campionato) REFERENCES CAMPIONATO(codice),
	PRIMARY KEY(pilota, campionato)
) Engine = 'InnoDB';

-- DATI PER TABELLA: PILOTA
INSERT INTO PILOTA VALUES('CLBNDR92C19H224W','Enrico','La Torre','1986-06-16','Via delle scale 5', 3);
INSERT INTO PILOTA VALUES('MFCSMR42T19H2U4W','Marco','Rossi','1942-12-15','Via dei martiri 3', 1);
INSERT INTO PILOTA VALUES('STFSPN46THGH2U4K','Stefano','Rotondini','1958-05-03','Via cavour 4', 4);
INSERT INTO PILOTA VALUES('MSCFBR435945FJJK','Giovanna','Puliafito','1990-07-12','Via consolare valeria 6', 2);
INSERT INTO PILOTA VALUES('GTISRT34C65F377O','Davide','Mangoni','1978-01-23','Via della zecca 65', 1);
INSERT INTO PILOTA VALUES('LOLRTI75F82R642T','Ernesto','Polini','1989-03-20','Via Garibaldi 5', 3);

-- DATI PER TABELLA: CAMPIONATO
INSERT INTO CAMPIONATO VALUES(1, 'WRC', 'Mondiale', 210);
INSERT INTO CAMPIONATO VALUES(2, 'EuRally', 'Europeo', 250);
INSERT INTO CAMPIONATO VALUES(3, 'CIR', 'Italiano', 200);
INSERT INTO CAMPIONATO VALUES(4, 'DeutschRally', 'Tedesco', 130);

-- DATI PER TABELLA: GARA
INSERT INTO GARA VALUES(1, 2, 4, 1970, 1);
INSERT INTO GARA VALUES(2, 3, 2, 2010, 2);
INSERT INTO GARA VALUES(3, 3, 1, 2015, 3);
INSERT INTO GARA VALUES(4, 1, 2, 2000, 4);

-- DATI PER TABELLA: VITTORIE
INSERT INTO VITTORIE VALUES('CLBNDR92C19H224W', 1, '1987-12-11');
INSERT INTO VITTORIE VALUES('MFCSMR42T19H2U4W', 2, '2016-12-03');
INSERT INTO VITTORIE VALUES('STFSPN46THGH2U4K', 1, '2012-05-07');
INSERT INTO VITTORIE VALUES('CLBNDR92C19H224W', 3, '1999-03-08');
INSERT INTO VITTORIE VALUES('GTISRT34C65F377O', 4, '2000-06-15');
INSERT INTO VITTORIE VALUES('LOLRTI75F82R642T', 1, '2001-11-22');
INSERT INTO VITTORIE VALUES('MSCFBR435945FJJK', 3, '2010-08-10');

-- DATI PER TABELLA: ALBO
INSERT INTO ALBO VALUES('GTISRT34C65F377O', 1, '2000');
INSERT INTO ALBO VALUES('CLBNDR92C19H224W', 2, '2010');
INSERT INTO ALBO VALUES('GTISRT34C65F377O', 3, '2007');
INSERT INTO ALBO VALUES('STFSPN46THGH2U4K', 4, '1988');
INSERT INTO ALBO VALUES('MSCFBR435945FJJK', 2, '2010');

-- PUNTO 1
-- Scrivere una procedura per trovare tutti i piloti (codiceFiscale, nome e cognome) 
-- che hanno vinto gare svolte in un dato anno fornito come ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getPilotiVincitoriByAnno
(IN datoAnno varchar(4))
BEGIN
    SELECT PILOTA.codiceFiscale, PILOTA.nome, PILOTA.cognome
    FROM PILOTA
    INNER JOIN VITTORIE ON PILOTA.codiceFiscale = VITTORIE.pilota
    WHERE YEAR(VITTORIE.dataVittoria) = datoAnno;
END //
DELIMITER ;

-- PUNTO 2
-- Scrivere una procedura per trovare tutti i piloti (codiceFiscale, nome e cognome) 
-- che non hanno vinto una gara in un anno dato come ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getPilotiNonVincitoriByAnno
(IN datoAnno varchar(4))
BEGIN
    SELECT PILOTA.codiceFiscale, PILOTA.nome, PILOTA,cognome
    FROM PILOTA
    LEFT JOIN VITTORIE ON PILOTA.codiceFiscale = VITTORIE.pilota
    LEFT JOIN GARA ON VITTORIE.gara = GARA.codice AND YEAR(VITTORIE.dataVittoria) = datoAnno
    WHERE GARA.codice IS NULL;
END //
DELIMITER ;

-- PUNTO 3
-- Scrivere una procedura per trovare tutti i campionati (tutte le informazioni) 
-- che ha vinto un pilota, il cui nome e cognome sono dati come ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getCampionatiVintiByPilota
(IN datoNome varchar(20), datoCognome varchar(20))
BEGIN
    SELECT CAMPIONATO.*
    FROM CAMPIONATO
    INNER JOIN GARA ON GARA.campionatoAppartenenza = CAMPIONATO.codice
    INNER JOIN VITTORIE ON GARA.codice = VITTORIE.gara  
    INNER JOIN PILOTA ON VITTORIE.pilota = PILOTA.codiceFiscale
    WHERE PILOTA.nome = datoNome AND PILOTA.cognome = datoCognome;
END //
DELIMITER ;

-- PUNTO 4
-- Scrivere una procedura per trovare tutti i piloti (codiceFiscale, nome e cognome) 
-- che hanno vinto gare nel loro anno di introduzione.
DELIMITER //
CREATE PROCEDURE getPilotiVincitoriAnnoIntroduzione()
BEGIN
    SELECT PILOTA.codiceFiscale, PILOTA.nome, PILOTA.cognome
    FROM PILOTA
    INNER JOIN VITTORIE ON PILOTA.codiceFiscale = VITTORIE.pilota
    INNER JOIN GARA ON VITTORIE.gara = GARA.codice
    WHERE GARA.annoIntroduzione = YEAR(VITTORIE.dataVittoria);
END //
DELIMITER ;

-- PUNTO 5
-- Scrivere una procedura per trovare il pilota (solo codiceFiscale) che ha vinto più 
-- gare con un livello di difficoltà dato in ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getPilotaVincenteDifficolta
(IN dataDifficolta integer)
BEGIN
    SELECT PILOTA.codiceFiscale
    FROM PILOTA
    INNER JOIN VITTORIE ON PILOTA.codiceFiscale = VITTORIE.pilota
    INNER JOIN GARA ON VITTORIE.gara = GARA.codice
    WHERE GARA.difficolta = dataDifficolta
    GROUP BY PILOTA.codiceFiscale
    ORDER BY COUNT(VITTORIE.gara) DESC
    LIMIT 1;
END //
DELIMITER ;

-- PUNTO 6
-- Scrivere una procedura per trovare il numero medio per anno di gare vinte 
-- per campionato da un pilota (solo codiceFiscale), fornito come ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getNumeroMedioGareVinteByPilota
(IN datoPilota varchar(25))
BEGIN 
	SELECT
		COUNT(VITTORIE.gara) AS numeroVittorie,
        	YEAR(VITTORIE.dataVittoria) AS anno
	FROM PILOTA
    INNER JOIN VITTORIE ON PILOTA.codiceFiscale = VITTORIE.pilota
    WHERE PILOTA.codiceFiscale = datoPilota
    GROUP BY YEAR(VITTORIE.dataVittoria);
END //
DELIMITER ;

-- PUNTO 7
-- Scrivere una vista per calcolare tutti i piloti (codiceFiscale, nome e cognome) 
-- che hanno vinto solo gare con il minimo coefficiente di importanza usando il binding.
CREATE VIEW PilotiVinteGareMinimoCoefficente AS
SELECT PILOTA.codiceFiscale, PILOTA.nome, PILOTA.cognome
FROM PILOTA
INNER JOIN VITTORIE ON PILOTA.codiceFiscale = VITTORIE.pilota
INNER JOIN GARA ON VITTORIE.gara = GARA.codice
WHERE GARA.coefficente = (SELECT MIN(GARA.coefficente)
			  			  FROM GARA);
                          
-- PUNTO 8
-- Implementare i trigger per mantenere allineati gli attributi:
-- 1) N_Gare su PILOTI;
-- 2) PilotiVincitori su CAMPIONATO.
DELIMITER //
CREATE TRIGGER aggiornaNumeroGare
AFTER INSERT ON VITTORIE
FOR EACH ROW
BEGIN 
    UPDATE PILOTA
    SET PILOTA.numeroGare = PILOTA.numeroGare + 1
    WHERE PILOTA.codiceFiscale = NEW.pilota;
END; 
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER aggiornaPilotiVincitori
AFTER INSERT ON ALBO
FOR EACH ROW
BEGIN 
    UPDATE CAMPIONATO
    SET CAMPIONATO.pilotiVincitori = CAMPIONATO.pilotiVincitori + 1
    WHERE CAMPIONATO.codice = NEW.campionato;
END; 
//
DELIMITER ;

-- PUNTO 9
-- Implementare il trigger che aggiorni dinamicamente la tabella ALBO 
-- sulla base degli inserimenti fatto in tabella VITTORIE. 
DELIMITER //
CREATE TRIGGER aggiornaAlbo
AFTER INSERT ON VITTORIE
FOR EACH ROW
BEGIN 
    INSERT INTO ALBO(pilota, campionato, anno) 
    SELECT NEW.pilota, GARA.campionatoAppartenenza, YEAR(NEW.dataVittoria)
    FROM GARA
    WHERE GARA.codice = NEW.gara;
END; 
//
DELIMITER ;

-- PUNTO 10
-- Si vuole rappresentare una base dati per la gestione di una catena di centri di 
-- servizio per il noleggio delle videocassette, tenendo conto delle seguenti informazioni: 
-- 1) Ogni centro di servizio è identificato attraverso un codice numerico univoco; 
-- inoltre viene riportato l’indirizzo del centro ed il numero di telefono, 
-- 2) I film disponibili presso la catena sono identificati dal titolo e dal nome del regista; 
-- inoltre sono noti l’anno in cui il film è stato girato, l’elenco degli attori principali del film, 
-- il costo corrente di noleggio della videocassetta ed eventualmente i film disponibili presso la catena 
-- di cui il film in questione rappresenta la versione “remake”. 
-- 3) Per ogni film è nota la collocazione all’interno di ciascun centro di servizio. 
-- In particolare, sono noti il settore, la posizione all’interno del settore ed il numero di copie in cui il 
-- film è disponibile. Ciascun settore è identificato attraverso un codice numerico univoco all’interno del 
-- centro di servizi e dal codice del centro di servizio stesso. 
-- 4) Per ogni film sono noti i centri di distribuzione da cui è fornito ed il costo relativo. 
-- Tali centri di distribuzione sono caratterizzati dal nome del centro di distribuzione, 
-- da un recapito e sono identificati attraverso un codice numerico.

CREATE DATABASE gestioneCentroNoleggioVideocassette;
USE gestioneCentroNoleggioVideocassette;

CREATE TABLE IF NOT EXISTS CENTRO(
    codice integer,
    indirizzo varchar(20) NOT NULL,
    telefono integer UNIQUE NOT NULL,
    PRIMARY KEY(codice)
) Engine = 'InnoDB';

CREATE TABLE IF NOT EXISTS SETTORE(
    codice integer,
    centro varchar(20),
    PRIMARY KEY(codice, centro),
    INDEX indiceCentro(centro),
    FOREIGN KEY(centro) REFERENCES CENTRO(codice)
) Engine = 'InnoDB';

CREATE TABLE IF NOT EXISTS FILM(
	regista varchar(20),
    titolo varchar(20),
    costoNoleggio integer NOT NULL,
    anno varchar(4) NOT NULL,
    PRIMARY KEY(regista, titolo)
) Engine = 'InnoDB';

CREATE TABLE IF NOT EXISTS ATTORI(
    regista varchar(20),
    titolo varchar(20),
    attore varchar(20) NOT NULL,
    PRIMARY KEY(regista, titolo),
    INDEX indiceRegista(regista),
    INDEX indiceTitolo(titolo),
    FOREIGN KEY(regista, titolo) REFERENCES FILM(regista, titolo)
) Engine = 'InnoDB';

CREATE TABLE IF NOT EXISTS COLLOCAZIONE(
    centro varchar(20),
    settore varchar(20),
    regista varchar(20),
    titolo varchar(20),
    numeroCopie integer NOT NULL,
    posizione varchar(20) NOT NULL,
    PRIMARY KEY(centro, settore, regista, titolo),
    INDEX indiceCentro(centro),
    INDEX indiceSettore(settore),
    INDEX indiceRegista(regista),
    INDEX indiceTitolo(titolo),    
    FOREIGN KEY(centro) REFERENCES CENTRO(codice),
    FOREIGN KEY(settore) REFERENCES SETTORE(codice),
    FOREIGN KEY(regista, titolo) REFERENCES FILM(regista, titolo)
 ) Engine = 'InnoDB';   

CREATE TABLE IF NOT EXISTS REMAKE(
    registaRemake varchar(20),
    titoloRemake varchar(20),
    registaFilmOriginale varchar(20) NOT NULL,
    titoloFilmOriginale varchar(20) NOT NULL,
    PRIMARY KEY(registaRemake, titoloRemake),
    INDEX indiceRegistaRemake(registaRemake),
    INDEX indiceTitoloRemake(titoloRemake),
    FOREIGN KEY(registaRemake, titoloRemake) REFERENCES FILM(regista, titolo)
 ) Engine = 'InnoDB';   
 
 CREATE TABLE IF NOT EXISTS DISTRIBUTORE(
    codice integer,
    nome varchar(20) NOT NULL,
    indirizzo varchar(20) NOT NULL,
    PRIMARY KEY(codice)
) Engine = 'InnoDB';   

CREATE TABLE IF NOT EXISTS DISTRIBUITO_DA(
    regista varchar(20),
    titolo varchar(20),
    distributore varchar(20),
    costo integer NOT NULL,
    PRIMARY KEY(regista, titolo, distributore),
    INDEX indiceRegita(regista),
    INDEX indiceTitolo(titolo),
    INDEX indiceDistributore(distributore),
    FOREIGN KEY(regista, titolo) REFERENCES FILM(regista, titolo),
    FOREIGN KEY(distributore) REFERENCES DISTRIBUTORE(codice)
) Engine = 'InnoDB';      