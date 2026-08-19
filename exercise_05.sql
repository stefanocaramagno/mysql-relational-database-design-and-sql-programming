-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n32_08_novembre_2023;
USE n32_08_novembre_2023;

-- CREAZIONE TABLELLA: ATTORI
CREATE TABLE IF NOT EXISTS ATTORI(
    codiceAttore integer,
    nome varchar(20) NOT NULL,
    annoNascita integer NOT NULL,
    nazionalità varchar(20) NOT NULL,
    PRIMARY KEY(codiceAttore)
) Engine = 'InnoDB';

-- CREAZIONE TABLELLA: FILM
CREATE TABLE IF NOT EXISTS FILM(
    codiceFilm integer,
    titolo varchar(20) NOT NULL,
    annoProduzione integer NOT NULL,
    nazionalità varchar(20) NOT NULL,
    regista varchar(20) NOT NULL,
    genere varchar(20) NOT NULL,
    PRIMARY KEY(codiceFilm)
) Engine = 'InnoDB';

-- CREAZIONE TABLELLA: RECITA
CREATE TABLE IF NOT EXISTS RECITA(
    codiceAttore integer,
    codiceFilm integer,
    PRIMARY KEY(codiceAttore, codiceFilm),
    INDEX indiceCodiceAttore(codiceAttore),
    INDEX indiceCodiceFilm(codiceFilm),
    FOREIGN KEY(codiceAttore) REFERENCES ATTORI(codiceAttore) ON UPDATE CASCADE,
    FOREIGN KEY(codiceFilm) REFERENCES FILM(codiceFilm) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- CREAZIONE TABLELLA: SALE
CREATE TABLE IF NOT EXISTS SALE(
    codiceSala integer,
    posti integer NOT NULL,
    nome varchar(20) NOT NULL,
    citta varchar(20) NOT NULL,
    PRIMARY KEY(codiceSala)
) Engine = 'InnoDB';

-- CREAZIONE TABLELLA: PROIEZIONI
CREATE TABLE IF NOT EXISTS PROIEZIONI(
    codiceProiezione integer,
    codiceFilm integer NOT NULL,
    codiceSala integer NOT NULL,
    incasso integer NOT NULL,
    dataProiezione date NOT NULL,
    PRIMARY KEY(codiceProiezione),
    INDEX indiceCodiceFilm(codiceFilm),
    INDEX indiceCodiceSala(codiceSala),
    FOREIGN KEY(codiceFilm) REFERENCES FILM(codiceFilm) ON UPDATE CASCADE,
    FOREIGN KEY(codiceSala) REFERENCES SALE(codiceSala) ON UPDATE CASCADE  
) Engine = 'InnoDB';

-- DATI PER TABELLA: ATTORI
insert into ATTORI values (1,'Will Smith',1968,'USA');
insert into ATTORI values (2,'Brad Pitt',1963,'USA');
insert into ATTORI values (3,'Leonardo Di Caprio',1974,'USA');
insert into ATTORI values (4,'Johnny Depp',1963,'USA');
insert into ATTORI values (5,'Meryl Streep',1949,'USA');
insert into ATTORI values (6,'Stefano Accorsi',1971,'ITA');
insert into ATTORI values (7,'Pierfrancesco Favino',1969,'ITA');
insert into ATTORI values (8,'Vincent Cassel',1966,'FRA');
insert into ATTORI values (9,'Jean Reno',1948,'FRA');
insert into ATTORI values (10,'Jude Law',1972,'ENG');
insert into ATTORI values (11,'Adam Driver',1983,'USA');
insert into ATTORI values (12,'Jennifer Aniston',1969,'USA');
insert into ATTORI values (13,'Monica Bellucci',1964,'ITA');
insert into ATTORI values (14, 'Emma Watson', 1990, 'ENG');

-- DATI PER TABELLA: FILM
insert into FILM values (1,'The Post',2017,'USA', 'Steven Spielberg', 'drammatico');
insert into FILM values (2,'Inglourious Bastards',2009,'USA', 'Quentin Tarantino', 'guerra');
insert into FILM values (3,'La fabbrica di cioccolato',2005,'USA', 'Tim Burton', 'fantastico');
insert into FILM values (4,'Io, Robot',2004,'USA', 'Alex Proyas', 'fantascienza');
insert into FILM values (5,'L''ultimo bacio',2004,'ITA', 'Gabriele Muccino', 'sentimentale');
insert into FILM values (6,'Il cigno nero',2010,'USA', 'Darren Aronofsky', 'fantascienza');
insert into FILM values (7,'Léon',1994,'FRA', 'Luc Besson', 'thriller');
insert into FILM values (8,'A.I.-Intelligenza artificiale',2001,'USA', 'Steven Spielberg', 'fantascienza');
insert into FILM values (9,'Inception',2001,'USA', 'Christopher Nolan', 'fantascienza');
insert into FILM values (10,'The Matrix',1999,'USA', 'Lana Wachowski', 'fantascienza');
insert into FILM values (11,'Waking Life',2001,'USA', 'Richard Linklater', 'fantastico');
insert into FILM values (12,'Tape',2001,'USA', 'Richard Linklater', 'drammatico');
insert into FILM values (13,'eXistenZ',1999,'ENG', 'David Cronenberg', 'fantascienza');

-- DATI PER TABELLA: RECITA
insert into RECITA values (1,4);
insert into RECITA values (2,2);
insert into RECITA values (3,9);
insert into RECITA values (4,3);
insert into RECITA values (5,1);
insert into RECITA values (6,5);
insert into RECITA values (7,5);
insert into RECITA values (8,6);
insert into RECITA values (9,7);
insert into RECITA values (10,8);
insert into RECITA values (10,12);

-- DATI PER TABELLA: SALE
insert into SALE values (1, 200, 'Mastroianni', 'Roma');
insert into SALE values (2, 300, 'Troisi', 'Napoli');
insert into SALE values (3, 150, 'La Scala', 'Milano');
insert into SALE values (4, 1780, 'Metropolitan', 'Catania');
insert into SALE values (5, 650, 'Alfieri', 'Cagliari');
insert into SALE values (6, 700, 'Manzoni', 'Cassino');
insert into SALE values (7, 150, 'Cinema Paradiso', 'Roma');

-- DATI PER TABELLA: PROIEZIONI
insert into PROIEZIONI values (1, 1, 1, 150000, '2017/12/11');
insert into PROIEZIONI values (2, 5, 2, 120000, '2015/10/03');
insert into PROIEZIONI values (3, 5, 3, 220000, '2016/05/21'); 
insert into PROIEZIONI values (4, 6, 1, 110000, '2018/01/20');
insert into PROIEZIONI values (5, 10, 4, 120000, '2023/11/15');
insert into PROIEZIONI values (6, 8, 4, 160200, '2023/09/05');
insert into PROIEZIONI values (7, 9, 1, 222000, '2022/12/17');
insert into PROIEZIONI values (8, 2, 4, 90000, '2017/02/15');
insert into PROIEZIONI values (9, 4, 3, 120500, '2018/05/28');
insert into PROIEZIONI values (10, 6, 5, 140400, '2017/04/14');

-- PUNTO 1 
-- Il nome di tutte le sale in una data città;
DELIMITER //
CREATE PROCEDURE getSaleByCitta
(IN dataCitta varchar(20))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS SAL_CITT;
	CREATE TEMPORARY TABLE SAL_CITT(
		nome varchar(30)
	);
    
    INSERT INTO SAL_CITT
		SELECT SALE.nome
		FROM SALE
		WHERE SALE.citta = dataCitta;
END //
DELIMITER ;
CALL getSaleByCitta('Roma');
SELECT SAL_CITT.* 
FROM SAL_CITT;

-- PUNTO 2
-- Il titolo ed il genere di film proiettati in un dato giorno
DELIMITER //
CREATE PROCEDURE getTitoloGenereByGiorno 
(IN datoGiorno date)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS FILM_CITT;
	CREATE TEMPORARY TABLE FILM_CITT(
		titolo varchar(30),
        film varchar(30)
	);
    
    INSERT INTO FILM_CITT
		SELECT FILM.titolo, FILM.genere
		FROM FILM
		INNER JOIN PROIEZIONI ON FILM.codiceFilm = PROIEZIONI.codiceFilm
		WHERE PROIEZIONI.dataProiezione = datoGiorno;
END //
DELIMITER ;   
CALL getTitoloGenereByGiorno('2017/12/11');
SELECT FILM_CITT.* 
FROM FILM_CITT; 

-- PUNTO 3
-- Il titolo dei film in cui recitano due specifici attori 
DELIMITER //
CREATE PROCEDURE getTitoloFilmByDueAttori
(IN datoCodicePrimoAttore integer,
 IN datoCodiceSecondoAttore integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS FILM_ATT;
	CREATE TEMPORARY TABLE FILM_ATT(
		titolo varchar(30)
	);
	
    INSERT INTO FILM_ATT
		SELECT DISTINCT(FILM.titolo)
		FROM FILM
		INNER JOIN RECITA ON FILM.codiceFilm = RECITA.codiceFilm
		WHERE RECITA.codiceAttore = datoCodicePrimoAttore OR RECITA.codiceAttore = datoCodiceSecondoAttore;
END // 
DELIMITER ;
CALL getTitoloFilmByDueAttori(6,7);
SELECT FILM_ATT.* 
FROM FILM_ATT; 

-- PUNTO 4
-- Per ogni film di un dato regista, il titolo del film, 
-- il numero totale di proiezioni in una data città e il relativo incasso
DELIMITER //
CREATE PROCEDURE getTitoloNumProiezioniIncassoByRegistaCitta
(IN datoRegista varchar(20),
 IN dataCitta varchar(20))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS FILM_PROIEZ_INC;
	CREATE TEMPORARY TABLE FILM_PROIEZ_INC(
        titolo varchar(30),
        numeroProiezioni integer,
        incasso integer
	);
    
    INSERT INTO FILM_PROIEZ_INC
		SELECT 
			FILM.titolo, 
			COUNT(PROIEZIONI.codiceProiezione) AS totaleProiezioni, 
			SUM(PROIEZIONI.incasso) AS totaleIncasso
		FROM FILM
		INNER JOIN PROIEZIONI ON FILM.codiceFilm = PROIEZIONI.codiceFilm
		INNER JOIN SALE ON PROIEZIONI.codiceSala = SALE.codiceSala
		WHERE FILM.regista = datoRegista AND SALE.citta = dataCitta
		GROUP BY FILM.titolo;
END // 
DELIMITER ;    
CALL getTitoloNumProiezioniIncassoByRegistaCitta('Gabriele Muccino', 'Napoli');
SELECT FILM_PROIEZ_INC.* 
FROM FILM_PROIEZ_INC; 

-- PUNTO 5 
-- I titoli dei film che non sono mai stati proiettati in una data città 
-- e quelli che sono stati proiettati SOLO in quella città 
-- (le operazioni devono essere fatte entrambe o nessuna delle due).

-- PUNTO 6 
-- Il nome degli attori di una data nazionalità che non hanno mai recitato 
-- in film di un dato regista
DELIMITER //
CREATE PROCEDURE getNomeAttoriByNaziontalitaRegista
(IN dataNazionalita varchar(20),
 IN datoRegista varchar(20))
BEGIN
 	DROP TEMPORARY TABLE IF EXISTS ATT_NO_FILM_REGIS;
	CREATE TEMPORARY TABLE ATT_NO_FILM_REGIS(
		nome varchar(30)
	);
    
	INSERT INTO ATT_NO_FILM_REGIS   
		SELECT ATTORI.nome
		FROM ATTORI
		LEFT JOIN RECITA ON ATTORI.codiceAttore = RECITA.codiceAttore 
		LEFT JOIN FILM ON RECITA.codiceFilm = FILM.codiceFilm 
		WHERE ATTORI.nazionalità = dataNazionalita 
			AND (FILM.regista IS NULL OR FILM.regista OR NOT FILM.regista = datoRegista);
END // 
DELIMITER ;  
CALL getNomeAttoriByNaziontalitaRegista('USA', 'Steven Spielberg');
SELECT ATT_NO_FILM_REGIS.* 
FROM ATT_NO_FILM_REGIS; 

-- PUNTO 7
-- CREARE LE SEGUENTI VISTE:

-- 1. STATS_FILM (Cod_Film, N_Attori, N_citta_proiezioni, tot_incasso)
-- Dove N_Attori è il numero di attori che hanno recitato in un film e N_citta_proiezioni, 
-- il numero di città dove il fim è stato proiettato.
CREATE VIEW STATS_FILM AS
SELECT 
    FILM.codiceFilm, 
    COUNT(DISTINCT RECITA.codiceAttore) AS numeroAttori, 
    COUNT(DISTINCT SALE.citta) AS numeroCitta, 
    SUM(PROIEZIONI.incasso) AS incassoTotale
FROM FILM
INNER JOIN RECITA ON FILM.codiceFilm = RECITA.codiceFilm
INNER JOIN PROIEZIONI ON FILM.codiceFilm = PROIEZIONI.codiceFilm
INNER JOIN SALE ON PROIEZIONI.codiceSala = SALE.codiceSala
GROUP BY FILM.codiceFilm;

-- 2. STATS_ATTORI(CodAttore, Cognome, Nome, N_Film)
-- Dove N_Film è il numero di film in cui l’attore ha recitato e tot_incasso quanto hanno 
-- incassato in totale quei film.
CREATE VIEW STATS_ATTORI AS
SELECT
    ATTORI.codiceAttore,
    ATTORI.nome,
    COUNT(DISTINCT FILM.codiceFilm) AS numeroFilm,
    SUM(PROIEZIONI.incasso) AS incassoTotale
FROM ATTORI
INNER JOIN RECITA ON ATTORI.codiceAttore = RECITA.codiceAttore
INNER JOIN FILM ON RECITA.codiceFilm = FILM.codiceFilm
INNER JOIN PROIEZIONI ON FILM.codiceFilm = PROIEZIONI.codiceFilm
GROUP BY ATTORI.codiceAttore, ATTORI.nome;
    
	
	


