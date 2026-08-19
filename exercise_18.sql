-- PUNTO 1
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n33_20_dicembre_2023;
USE n33_20_dicembre_2023;

-- CREAZIONE TABELLA: RIVISTA
CREATE TABLE IF NOT EXISTS RIVISTA(
	id integer,
    nome varchar(30),
    nazione varchar(30),
    impact_factor float,
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: ARTICOLO
CREATE TABLE IF NOT EXISTS ARTICOLO(
	id integer,
    titolo varchar(30),
    rivista integer,
    anno integer,
    PRIMARY KEY(id),
    INDEX indiceRivista(rivista),
    FOREIGN KEY(rivista) REFERENCES RIVISTA(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: PERSONA
CREATE TABLE IF NOT EXISTS PERSONA(
	id integer,
    nome varchar(30),
    cognome varchar(30),
    istituzione varchar(30),
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: AUTORE
CREATE TABLE IF NOT EXISTS AUTORE(
	articolo integer,
    persona integer,
    posizione integer,
    PRIMARY KEY(articolo, persona),
    INDEX indiceArticolo(articolo),
    INDEX indicePersona(persona),
    FOREIGN KEY(articolo) REFERENCES ARTICOLO(id),
    FOREIGN KEY(persona) REFERENCES  PERSONA(id)
) Engine = 'InnoDB';

-- DATI PER TABELLA: RIVISTA 
insert into RIVISTA values(1, 'TPAMI', 'US', 15.5);
insert into RIVISTA values(2, 'IJCV', 'UK', 8.5);
insert into RIVISTA values(3, 'CVIU', 'France', 4.5);
insert into RIVISTA values(4, 'MTAP', 'Greece', 4.5);

-- DATI PER TABELLA: ARTICOLO
insert into ARTICOLO values(1, 'A new method', 1, 2015);
insert into ARTICOLO values(2, 'Better results', 2, 2018);
insert into ARTICOLO values(3, 'A survey', 3, 2019);
insert into ARTICOLO values(4, 'More data', 1, 2019);

-- DATI PER TABELLA: PERSONA
insert into PERSONA values(1, 'Andrea', 'Abate', 'MIT');
insert into PERSONA values(2, 'Bruno', 'Barbieri', 'UNICT');
insert into PERSONA values(3, 'Jack', 'Johnson', 'MILA');
insert into PERSONA values(4, 'Carlo', 'Conti', 'UCF');

-- DATI PER TABELLA: AUTORE
insert into AUTORE values(1, 1, 1);
insert into AUTORE values(1, 2, 2);
insert into AUTORE values(1, 3, 3);
insert into AUTORE values(2, 1, 2);
insert into AUTORE values(2, 2, 1);
insert into AUTORE values(2, 3, 3);
insert into AUTORE values(3, 1, 1);
insert into AUTORE values(4, 4, 1);
insert into AUTORE values(4, 1, 2);

-- PUNTO 2
-- Creare una procedura che mostra gli autori(nome, cognome, istituzione) che hanno pubblicato 
-- un articolo in un anno fornito come ingresso alla procedura.
-- Ciascun autore dovrebbe comparire solo una volta nel risultato.
-- Provare la procedura con l'anno 2019.
DELIMITER //
CREATE PROCEDURE getAutoreArticoloByAnno
(IN datoAnno integer)
BEGIN   
    DROP TEMPORARY TABLE IF EXISTS AUT_ART;
    CREATE TEMPORARY TABLE AUT_ART(
		nome varchar(30),
        cognome varchar(30),
        istituzione varchar(30)
    );

    INSERT INTO AUT_ART
        SELECT 
			PERSONA.nome AS nomeAutore,
            PERSONA.cognome AS cognomeAutore,
            PERSONA.istituzione AS istituzioneAutore
        FROM PERSONA
        INNER JOIN AUTORE ON PERSONA.id = AUTORE.persona
        INNER JOIN ARTICOLO ON AUTORE.articolo = ARTICOLO.id
        WHERE ARTICOLO.anno = datoAnno
        GROUP BY PERSONA.id;
END //
DELIMITER ;
CALL getAutoreArticoloByAnno(2019);
SELECT AUT_ART.*
FROM AUT_ART;

-- PUNTO 3
-- Creare una procedura per mostrare il primo l'autore (nome, cognome, istituzione)
-- degli articoli pubblicati sulle riviste con fattore di impatto superiore ad una soglia fornita 
-- in ingresso alla procedura.
DELIMITER //
CREATE PROCEDURE getAutoreArticoliRivisteByFattoreDiImpatto
(IN datoFattoreDiImpatto float)
BEGIN   
    DROP TEMPORARY TABLE IF EXISTS AUT_ART_RIV;
    CREATE TEMPORARY TABLE AUT_ART_RIV(
		nome varchar(30),
        cognome varchar(30),
        istituzione varchar(30),
    );

    INSERT INTO AUT_ART_RIV
        SELECT 
			PERSONA.nome AS nomeAutore,
            PERSONA.cognome AS cognomeAutore,
            PERSONA.istituzione AS istituzioneAutore
        FROM PERSONA
        INNER JOIN AUTORE ON PERSONA.id = AUTORE.persona
        INNER JOIN ARTICOLO ON AUTORE.articolo = ARTICOLO.id
        INNER JOIN RIVISTA ON ARTICOLO.rivista = RIVISTA.id
        WHERE RIVISTA.impact_factor > datoFattoreDiImpatto
        ORDER BY RIVISTA.impact_factor
        LIMIT 1;
END //
DELIMITER ;
CALL getAutoreArticoliRivisteByFattoreDiImpatto(7.0);
SELECT AUT_ART_RIV.*
FROM AUT_ART_RIV;

-- PUNTO 4
-- Mostra il numero medio di autori negli articoli pubblicati da ciascuna rivista
-- (nome, paese). La query deve mostrare anche le riviste che non hanno pubblicato articoli.
SELECT
	IFNULL(COUNT(AUTORE.persona), 0) AS numeroAutori,
	RIVISTA.nome AS nomeRivista,
	RIVISTA.nazione AS nazioneRivista
FROM AUTORE
INNER JOIN ARTICOLO ON AUTORE.articolo = ARTICOLO.id
RIGHT JOIN RIVISTA ON ARTICOLO.rivista = RIVISTA.id
GROUP BY RIVISTA.id;

-- PUNTO 5
-- Creare la tabella RIEPILOGO_PUBBLICAZIONI(_PERSONA_, N_ARTICOLI, IMPACT_FACTOR_MEDIO)
-- La tabella descrive per ogni persona, quanti articoli ha fatto e l'impact factor medio delle riviste 
-- dove ha pubblicato (quindi l'impact factor medio delle riviste dove sono pubblicati gli articoli di 
-- cui la persona è autore.
-- Creare un trigger che aggiorni automaticamente tale tabella.
CREATE TABLE IF NOT EXISTS RIEPILOGO_PUBBLICAZIONI(
	persona integer,
    N_articoli integer,
    impact_factor_medio float,
    PRIMARY KEY(persona),
    FOREIGN KEY(persona) REFERENCES PERSONA(id)
) Engine = 'InnoDB';

DELIMITER //
CREATE TRIGGER aggiornaRiepilogoPubblicazioni
AFTER INSERT ON AUTORE
FOR EACH ROW
BEGIN
    DECLARE total_articoli INTEGER;
    DECLARE avg_impact_factor FLOAT;

    SELECT COUNT(*), AVG(RIVISTA.impact_factor)
    INTO total_articoli, avg_impact_factor
    FROM ARTICOLO
    JOIN RIVISTA ON ARTICOLO.rivista = RIVISTA.id
    WHERE ARTICOLO.id IN (SELECT articolo FROM AUTORE WHERE persona = NEW.persona);

    IF (SELECT COUNT(*) 
		FROM RIEPILOGO_PUBBLICAZIONI 
        WHERE persona = NEW.persona) > 0 THEN
        UPDATE RIEPILOGO_PUBBLICAZIONI
        SET N_articoli = total_articoli, impact_factor_medio = avg_impact_factor
        WHERE persona = NEW.persona;
    ELSE
        INSERT INTO RIEPILOGO_PUBBLICAZIONI(persona, N_articoli, impact_factor_medio)
        VALUES (NEW.persona, total_articoli, avg_impact_factor);
    END IF;
END;
//
DELIMITER ;

-- PUNTO 6
-- Popolare la tabella RIEPILOGO_PUBBLICAZIONI con i valori gia presenti nella base di dati.
INSERT INTO RIEPILOGO_PUBBLICAZIONI
	SELECT 
		AUTORE.persona AS persona,
		COUNT(AUTORE.articolo) AS N_articoli,
		AVG(RIVISTA.impact_factor) AS impact_factor_medio
	FROM AUTORE
    INNER JOIN ARTICOLO ON AUTORE.articolo = ARTICOLO.id
    INNER JOIN RIVISTA ON ARTICOLO.rivista = RIVISTA.id
    GROUP BY AUTORE.persona;
	


