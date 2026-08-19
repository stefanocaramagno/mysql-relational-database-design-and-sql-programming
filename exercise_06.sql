-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n33_08_novembre_2023;
USE n33_08_novembre_2023;

-- CREAZIONE TABELLA: PERSONA 
CREATE TABLE IF NOT EXISTS PERSONA(
	id integer,
    nome varchar(20) NOT NULL,
    cognome varchar (20) NOT NULL,
    anno_di_nascita varchar(4) NOT NULL,
    indirizzo varchar(50) NOT NULL,
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: MACCHINA 
CREATE TABLE IF NOT EXISTS MACCHINA(
	targa varchar(20),
    modello varchar(20) NOT NULL,
    anno varchar(4) NOT NULL,
    PRIMARY KEY(targa)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: INCIDENTE 
CREATE TABLE IF NOT EXISTS INCIDENTE(
	numero integer,
    data_incidente date NOT NULL,
    luogo varchar(20) NOT NULL,
    PRIMARY KEY(numero)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: PROPRIETARI 
CREATE TABLE IF NOT EXISTS PROPRIETARI(
	id_persona integer,
    targa varchar(20),
    PRIMARY KEY(id_persona, targa),
    INDEX indiceIdPersona(id_persona),
    INDEX indiceTarga(targa),
    FOREIGN KEY(id_persona) REFERENCES PERSONA(id) ON UPDATE CASCADE,
    FOREIGN KEY(targa) REFERENCES MACCHINA(targa) ON UPDATE CASCADE
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: PARTECIPA 
CREATE TABLE IF NOT EXISTS PARTECIPA(
	id_persona integer,
    macchina varchar(20),
    numero_incidente integer,
    costo integer NOT NULL,
    PRIMARY KEY(id_persona, macchina, numero_incidente),
    INDEX indiceIdPersona(id_persona),
    INDEX indiceMacchina(macchina),
    INDEX indiceNumeroIncidente(numero_incidente),
    FOREIGN KEY(id_persona) REFERENCES PERSONA(id) ON UPDATE CASCADE,
    FOREIGN KEY(macchina) REFERENCES MACCHINA(targa) ON UPDATE CASCADE,
    FOREIGN KEY(numero_incidente) REFERENCES INCIDENTE(numero) ON UPDATE CASCADE
) Engine = 'InnoDB';
	
-- DATI PER TABELLA: PERSONA 
insert into PERSONA values ('1','Luca','Rossi','1970','Via Firenze - CT');
insert into PERSONA values ('2','Giacomo','Verdi','1980','Via Milano - CT');
insert into PERSONA values ('3','Luca','Felice','1970','Via Pasubio - ME');
insert into PERSONA values ('4','Gigi','La Trottola','1970','Via Alcide De Gasperi - PA');
insert into PERSONA values ('5','Mino','Reitano','1977','Via Messina - NA');

-- DATI PER TABELLA: MACCHINA 
insert into MACCHINA values ('CT7177','Berlina','2007');
insert into MACCHINA values ('CT7547','Spider','2001');
insert into MACCHINA values ('CT4347','Monovolume','1997');
insert into MACCHINA values ('CT3212','Cadillac','1987');
insert into MACCHINA values ('CT5153','Berlina','1953');
insert into MACCHINA values ('CT5435','Station Vagon','1957');

-- DATI PER TABELLA: PROPRIETARI 
insert into PROPRIETARI values (1,'CT7177');
insert into PROPRIETARI values (1,'CT7547');
insert into PROPRIETARI values (2,'CT4347');
insert into PROPRIETARI values (3,'CT3212');
insert into PROPRIETARI values (4,'CT5153');
insert into PROPRIETARI values (5,'CT5435');

-- DATI PER TABELLA: INCIDENTE 
insert into INCIDENTE values (1,current_date(),'Catania');
insert into INCIDENTE values (2,'2007-08-12','Messina');
insert into INCIDENTE values (3,'2006-07-08','Catania');
insert into INCIDENTE values (4,'2008-08-11','Napoli');
insert into INCIDENTE values (5,'2005-09-11','Catania');
insert into INCIDENTE values (6,'1999-08-11','Palermo');
insert into INCIDENTE values (7,'2002-03-03','Catania');

-- DATI PER TABELLA: PARTECIPA 
insert into PARTECIPA values(1,'CT7177',1,10000);
insert into PARTECIPA values(1,'CT7177',2,5000);
insert into PARTECIPA values(2,'CT4347',2,3000);
insert into PARTECIPA values(3,'CT3212',4,5000);
insert into PARTECIPA values(3,'CT3212',5,5000);
insert into PARTECIPA values(2,'CT4347',7,1000);
insert into PARTECIPA values(5,'CT5435',2,5000);
insert into PARTECIPA values(4,'CT5153',7,50000);
insert into PARTECIPA values(4,'CT5153',6,500);

-- PUNTO 1
-- Creare una vista per calcolare il numero di incidenti 
-- e il costo totale degli incidenti avvenuti in 
-- ogni città e per ogni anno.
CREATE VIEW vistaIncidentiPerCittaAnno AS
SELECT 
    COUNT(INCIDENTE.numero) AS numero_incidenti,
    SUM(PARTECIPA.costo) AS costo_totale,
    INCIDENTE.luogo AS citta, 
    YEAR(INCIDENTE.data_incidente) as anno
FROM INCIDENTE
INNER JOIN PARTECIPA ON INCIDENTE.numero = PARTECIPA.numero_incidente
GROUP BY INCIDENTE.luogo, YEAR(INCIDENTE.data_incidente);

-- PUNTO 2
-- Una procedura per trovare la persona (id) che ha avuto 
-- l’incidente con il costo massimo in un dato anno.
DELIMITER //
CREATE PROCEDURE getPersonaCostoMassimoByAnno
(IN datoAnno varchar(4))
BEGIN
    SELECT PERSONA.id
    FROM PERSONA
    INNER JOIN PARTECIPA ON PERSONA.id = PARTECIPA.id_persona
    INNER JOIN INCIDENTE ON PARTECIPA.numero_incidente = INCIDENTE.numero
    WHERE YEAR(INCIDENTE.data_incidente) = datoAnno
    ORDER BY PARTECIPA.costo DESC
    LIMIT 1;
END //
DELIMITER ;    

-- PUNTO 3
-- Una procedura per trovare il costo totale per anno degli incidenti 
-- avvenuti in un dato luogo e il costo totale di tutti gli incidenti.
DELIMITER //
CREATE PROCEDURE getCostoTotale
(IN datoLuogo varchar(20))
BEGIN 
    SELECT 
	    YEAR(INCIDENTE.data_incidente) AS anno,
	    SUM(PARTECIPA.costo) AS costoTotalePerAnno
    FROM PARTECIPA
    INNER JOIN INCIDENTE ON PARTECIPA.numero_incidente = INCIDENTE.numero
    WHERE INCIDENTE.luogo = datoLuogo
    GROUP BY YEAR(INCIDENTE.data_incidente); 
    SELECT SUM(PARTECIPA.costo) AS costoTotale
    FROM PARTECIPA
    INNER JOIN INCIDENTE ON PARTECIPA.numero_incidente = INCIDENTE.numero
    WHERE INCIDENTE.luogo = datoLuogo;     
END //
DELIMITER ;  

-- PUNTO 4
-- Una procedura per trovare il numero medio e il costo medio degli incidenti 
-- per anno avvenuti in una data città. Usare la vista creata precedentemente.
DELIMITER //
CREATE PROCEDURE getNumeroMedioCostoMedioPerAnnoByCitta
(IN dataCitta varchar(20), 
 OUT numero_medio integer,
 OUT costo_medio integer)
BEGIN
    SELECT 
	    AVG(vistaIncidentiPerCittaAnno.numeroIncidenti) AS numero_medio, 
	    AVG(vistaIncidentiPerCittaAnno.costo) AS costo_medio
    FROM vistaIncidentiPerCittaAnno
    WHERE vistaIncidentiPerCittaAnno.citta = dataCitta;
END //
DELIMITER ;     

-- PUNTO 5
-- Una procedura per trovare gli incidenti in cui è coinvolta una specifica persona 
-- (identificata tramite il suo id). 
-- ATTENZIONE: più righe non possono essere memorizzate in una variabile di tipo OUT, 
-- ma in una tabella temporanea.
DELIMITER //
CREATE PROCEDURE getIncidentiByPersona
(IN datoID integer)
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS TabellaTemporaneaIncidenti (
        numeroIncidente integer,
        dataIncidente date,
        luogo varchar(20),
        costo integer
	);

	INSERT INTO TabellaTemporaneaIncidenti
	SELECT 
	    INCIDENTE.numero,
        INCIDENTE.data_incidente,
        INCIDENTE.luogo,
        PARTECIPA.costo
    FROM INCIDENTE 
    INNER JOIN PARTECIPA ON INCIDENTE.numero = PARTECIPA.numero_incidente
    WHERE PARTECIPA.id_persona = datoID;
    
    SELECT *
    FROM TabellaTemporaneaIncidenti; 
    DROP TEMPORARY TABLE IF EXISTS TabellaTemporaneaIncidenti;
END //
DELIMITER ;  

-- PUNTO 6
-- Una procedura per trovare targhe e modelli di tutte le auto coinvolte 
-- in un dato incidente.
DELIMITER //
CREATE PROCEDURE getTargheModelliByIncidente
(IN datoIncidente integer)
BEGIN
    SELECT MACCHINA.targa, MACCHINA.modello
    FROM MACCHINA
    INNER JOIN PARTECIPA ON MACCHINA.targa = PARTECIPA.macchina
    WHERE PARTECIPA.numero_incidente = datoIncidente;
END //
DELIMITER ; 

-- PUNTO 7
-- Impostare una tassa per incidente, da inserire in una nuova tabella
-- TASSE(TARGA,ID_INCIDENTE,tassa), per tutte le auto coinvolte in un dato incidente.
CREATE TABLE IF NOT EXISTS TASSE(
    targa varchar(20),
    id_incidente integer,
    tassa integer,
    PRIMARY KEY(targa, id_incidente),
    FOREIGN KEY(targa) REFERENCES MACCHINA(targa),
    FOREIGN KEY(id_incidente) REFERENCES INCIDENTE(numero)
) Engine = 'InnoDB';

-- PUNTO 8
-- Creare una vista STATISTICHE(id_persona, n_auto, media_costo, media_inc)
-- dove si terrà traccia per ogni persona del numero di auto possedute, 
-- il numero e costo medio di incidenti per anno.
CREATE VIEW Statistiche AS
SELECT 
    PARTECIPA.id_persona, 
    COUNT(DISTINCT PROPRIEARI.targa) AS numero_auto, 
    AVG(PARTECIPA.costo) AS media_costo, 
    AVG(PARTECIPA.numero_incidente) AS media_incidenti
FROM PARTECIPA
INNER JOIN PROPRIETARI ON PARTECIPA.id_persona = PROPRIETARI.id_persona
GROUP BY PARTECIPA.id_persona;






