-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n31_31_ottobre_2023;
USE n31_31_ottobre_2023;

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
    INDEX indiceCodiceFilm(codiceFilm)
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
-- Selezionare il nome delle sale nelle città con nome “Ca%i%”.
SELECT SALE.nome
FROM SALE
WHERE SALE.citta LIKE 'Ca%i%';

-- PUNTO 2 
-- Calcolare la media degli incassi dei film in cui un attore ha recitato, 
-- purché tale media sia maggiore di 15000.
SELECT AVG(PROIEZIONI.incasso) AS media_incassi
FROM RECITA
INNER JOIN PROIEZIONI ON RECITA.codiceFilm = PROIEZIONI.codiceFilm
WHERE RECITA.codiceAttore = <codiceAttore> 
GROUP BY RECITA.codiceAttore
HAVING AVG(PROIEZIONI.incasso) > 15000;

-- PUNTO 3 
-- Selezionare i registi che hanno diretto almeno un film nel 2001.
SELECT DISTINCT FILM.regista
FROM FILM
WHERE FILM.annoProduzione = 2001;

-- PUNTO 4
-- Selezionare tutte le informazioni degli attori che hanno recitato 
-- in un film di “fantascienza”.
SELECT ATTORI.*
FROM ATTORI
INNER JOIN RECITA ON ATTORI.codiceAttore = RECITA.codiceAttore
INNER JOIN FILM ON RECITA.codiceFilm = FILM.codiceFilm
WHERE FILM.genere = 'fantascienza';

-- PUNTO 5
-- Elencare tutti gli attori e i film in cui hanno recitato, 
-- includendo anche gli attori che non hanno recitato in nessun film.
SELECT ATTORI.*, FILM.titolo
FROM ATTORI
INNER JOIN RECITA ON ATTORI.codiceAttore = RECITA.codiceAttore
INNER JOIN FILM ON FILM.codiceFilm = RECITA.codiceFilm

-- PUNTO 6
-- Selezionare i film che sono stati proiettati in almeno una sala con più di 200 posti. 
-- Per tali film, oltre al titolo, visualizzare anche regista, genere e anno di produzione.
SELECT FILM.titolo, FILM.regista, FILM.genere, FILM.annoProduzione
FROM FILM
INNER JOIN PROIEZIONI ON FILM.codiceFilm = PROIEZIONI.codiceFilm
INNER JOIN SALE ON PROIEZIONI.codiceSala = SALE.codiceSala
WHERE SALE.posti > 200;

-- PUNTO 7
-- Selezionare i film che non hanno attori di nazionalità “USA”.
SELECT DISTINCT FILM.titolo
FROM FILM
INNER JOIN RECITA ON FILM.codiceFilm = RECITA.codiceFilm
INNER JOIN ATTORI ON RECITA.codiceAttore = ATTORI.codiceAttore
WHERE NOT ATTORI.nazionalità = 'USA';

-- PUNTO 8
-- Selezionare i film con un incasso superiore alla media degli incassi dei film del 2001. 
-- Per tali film, selezionare anche il relativo incasso totale.
SELECT FILM.titolo, PROIEZIONI.incasso AS massimoIncasso
FROM FILM
INNER JOIN PROIEZIONI ON FILM.codiceFilm = PROIEZIONI.codiceFilm
WHERE PROIEZIONI.incasso > (SELECT AVG(P.incasso)
			                FROM FILM AS F
                            INNER JOIN PROIEZIONI P ON FILM.codiceFilm = P.codiceFilm
                            WHERE F.annoProduzione = 2001);

