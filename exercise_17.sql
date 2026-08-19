-- PUNTO 0
-- Implementare lo schema in SQL mantenendo tutti i vincoli di integrità referenziale.
CREATE DATABASE n32_27_novembre_2021;
USE n32_27_novembre_2021;

-- CREAZIONE TABELLA: PERSONA
CREATE TABLE PERSONA(
	CF VARCHAR(16) PRIMARY KEY,
	Nome VARCHAR(255),
	Cognome VARCHAR(255),
	DataNascita DATE,
	Indirizzo VARCHAR(255),
	N_qualifiche INTEGER
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: COMPETENZA
CREATE TABLE COMPETENZA(
	Codice INTEGER PRIMARY KEY,
	Nome VARCHAR(255), 
	Tipo VARCHAR(255)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: QUALIFICA
CREATE TABLE QUALIFICA(
	Codice INTEGER PRIMARY KEY,
	Nome VARCHAR(30),
	Importanza INTEGER, 
	AnnoIntroduzione INTEGER,
	CompetenzaAcquisita INTEGER,
	N_Persone INTEGER,
	INDEX idx_C(CompetenzaAcquisita),
	FOREIGN KEY (CompetenzaAcquisita) REFERENCES COMPETENZA(Codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: ATTESTATO
CREATE TABLE ATTESTATO(
	Persona VARCHAR(16),
	Qualifica INTEGER,
	Data DATE,
	PRIMARY KEY(Persona,Qualifica),
	INDEX idx_pax(Persona),
	INDEX idx_qual(Qualifica),
	FOREIGN KEY(Persona) REFERENCES PERSONA(CF),
	FOREIGN KEY(Qualifica) REFERENCES QUALIFICA(Codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: USO
CREATE TABLE USO(
	Persona VARCHAR(16),
	Qualifica INTEGER,
	Data DATE,
	PRIMARY KEY(Persona,Qualifica),
	INDEX idx_pax1(Persona),
	INDEX idx_mal(Qualifica),
	FOREIGN KEY(Persona) REFERENCES PERSONA(CF),
	FOREIGN KEY(Qualifica) REFERENCES QUALIFICA(Codice)
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
insert into USO values('FFFFFF00X00ZZZZY', 3, '2019-08-15');
insert into USO values('HHHHHH00X00ZZZZY', 6, '2020-05-27');
insert into USO values('IIIIII00X00ZZZZY', 8, '2021-03-10');
insert into USO values('BBBBBB00X00ZZZZY', 6, '2022-09-14');
insert into USO values('LLLLLL00X00ZZZZY', 5, '2023-01-30');
insert into USO values('LLLLLL00X00ZZZZY', 2, '2023-05-18');
insert into USO values('MMMMMM00X00ZZZZY', 2, '2022-12-07');
insert into USO values('FFFFFF00X00ZZZZY', 4, '2021-09-23');
insert into USO values('IIIIII00X00ZZZZY', 5, '2020-04-15');
insert into USO values('HHHHHH00X00ZZZZY', 7, '2019-07-28');
insert into USO values('AAAAAA00X00ZZZZY', 2, '2016-08-09');
insert into USO values('CCCCCC00X00ZZZZY', 6, '2017-01-12');
insert into USO values('CCCCCC00X00ZZZZY', 2, '2018-03-25');
insert into USO values('EEEEEE00X00ZZZZY', 4, '2019-11-30');
insert into USO values('GGGGGG00X00ZZZZY', 5, '2020-06-14');

-- PUNTO 1
-- Scrivere le query per trovare le qualifiche usate il minor numero di volte 
-- (che devono essere state usate almeno una volta) 
-- e quelle che non sono mai state usate. 
SELECT QUALIFICA.*
FROM QUALIFICA
INNER JOIN USO ON QUALIFICA.codice = USO.qualifica
GROUP BY USO.qualifica
HAVING COUNT(USO.qualifica) = (SELECT MIN(numeriQualifiche)
							   FROM (SELECT COUNT(USO.qualifica) AS numeriQualifiche
									 FROM USO
									 GROUP BY USO.qualifica
									 HAVING COUNT(USO.qualifica) >= 1) AS T);
                                     
SELECT QUALIFICA.*
FROM QUALIFICA
WHERE QUALIFICA.codice NOT IN (SELECT USO.qualifica
							   FROM USO);

-- PUNTO 2
-- Creare una procedura che, dati in ingresso il codice fiscale di una persona 
-- e due valori interi corrispondenti a due anni, restituisca tutte le qualifiche 
-- che quella persona ha conseguito nell'arco temporale compreso tra i due anni (inclusi). 
-- Per esempio, dato il codice fiscale ‘AAA’, e gli anni 2010 e 2021, 
-- la procedura deve restituire tutte le qualifiche della persona ‘AAA’ 
-- ottenute tra il 2010 e il 2021 (inclusi). 
-- Le informazioni di interesse sono tutte quelle della persona, 
-- il nome della qualifica e il nome della competenza acquisita.
DELIMITER //
CREATE PROCEDURE getQualificheIntervalloTemporaleByPersonaAnni
(IN dataPersona varchar(30),
 IN datoPrimoAnno integer,
 IN datoSecondoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS QUAL_ANNI;
    CREATE TEMPORARY TABLE QUAL_ANNI(
		codiceFiscale_persona varchar(30),
        nome_persona varchar(30),
        cognome_persona varchar(30),
        dataNascita_persona date,
        indirizzo_persona varchar(30),
        N_qualifiche_persona integer,
		qualifica varchar(30),
        competenza varchar(30)
	);
    
    INSERT INTO QUAL_ANNI
		SELECT PERSONA.*, QUALIFICA.nome, COMPETENZA.nome
        FROM PERSONA
        INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona 
        INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
        INNER JOIN COMPETENZA ON QUALIFICA.competenzaAcquisita = COMPETENZA.codice
        WHERE ATTESTATO.persona = dataPersona 
			AND YEAR(ATTESTATO.data) >= datoPrimoAnno 
			AND YEAR(ATTESTATO.data) <= datoSecondoAnno;
END //
DELIMITER ;
CALL getQualificheIntervalloTemporaleByPersonaAnni('AAA', 2018, 2021);
SELECT QUAL_ANNI.*
FROM QUAL_ANNI;

-- PUNTO 3
-- Scrivere una procedura per trovare tutte le qualifiche (da restituire tramite tabella temporanea) 
-- relative a tutte le competenze che hanno un nome di cui sono specificate la seconda, 
-- terza e quarta lettera (passate come un singolo argomento alla procedura). 
-- Per esempio, date in input le tre lettere “NFO”, bisogna trovare tutte le competenze che 
-- abbiano queste tre lettere come seconda, terza e quarta lettera (per esempio “INFORMATICA”) 
-- e trovare tutte le qualifiche per quella competenza. 
DELIMITER //
CREATE PROCEDURE getQualificaBySecondaTerzaQuartaCifraNomeCompetenza
(IN dateSecondaTerzaQuartaCifraNomeCompetenza varchar(3))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS QUAL;
    CREATE TEMPORARY TABLE QUAL(
		codice integer,
        nome varchar(30),
        importanza integer,
        annoIntroduzione integer,
        competenzaAcquisita integer,
        N_persone integer
    );
    
    INSERT INTO QUAL
		SELECT QUALIFICA.*
        FROM QUALIFICA
        INNER JOIN COMPETENZA ON QUALIFICA.competenzaAcquisita = COMPETENZA.codice
        WHERE SUBSTRING(COMPETENZA.nome, 2, 3) = dateSecondaTerzaQuartaCifraNomeCompetenza;
END //
DELIMITER ;
CALL getQualificaBySecondaTerzaQuartaCifraNomeCompetenza('NFO');
SELECT QUAL.*
FROM QUAL;

-- PUNTO 4
-- Scrivere una procedura per trovare tutte le persone che posseggono almeno N competenze differenti, 
-- dove N è un parametro di ingresso alla procedura (si considera che una persona possiede una competenza 
-- se possiede un attestato per una qualifica che fa riferimento a quella competenza). 
-- Per esempio, se N=2, trovare tute le persone che posseggano 
-- qualifica che si riferiscano ad almeno 2 diverse competenze. 
DELIMITER //
CREATE PROCEDURE getPersoneQualificheDifferentiByNumeroCompetenze
(IN datoNumeroCompetenze integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_QUAL_DIFF;
    CREATE TEMPORARY TABLE PERS_QUAL_DIFF(
		CF varchar(30),
        nome varchar(30),
        cognome varchar(30),
        dataNascita date,
        indirizzo varchar(30),
        N_qualifiche varchar(30),
        numeroCompetenze integer
	);
    
    INSERT INTO PERS_QUAL_DIFF
		SELECT 
			PERSONA.*, 
			COUNT(DISTINCT QUALIFICA.competenzaAcquisita) AS numeroCompetenze
		FROM PERSONA
		INNER JOIN ATTESTATO ON PERSONA.CF = ATTESTATO.persona
		INNER JOIN QUALIFICA ON ATTESTATO.qualifica = QUALIFICA.codice
		INNER JOIN COMPETENZA ON QUALIFICA.competenzaAcquisita = COMPETENZA.codice
		GROUP BY ATTESTATO.persona
		HAVING COUNT(DISTINCT QUALIFICA.competenzaAcquisita) >= datoNumeroCompetenze;
END //
DELIMITER ;
CALL getPersoneQualificheDifferentiByNumeroCompetenze(3);
SELECT PERS_QUAL_DIFF.*
FROM PERS_QUAL_DIFF;

-- PUNTO 5
-- Creare una vista che tenga traccia per ogni persona di quali qualifiche ha e, 
-- se sono state usate, di quando sono state usate. 
-- La vista deve contenere tutti gli attributi della persona, il nome, il tipo della competenza 
-- a cui fa riferimento la qualifica, data di acquisizione e data di uso della qualifica 
-- (o NULL qualora non sia stata usata). 
CREATE VIEW PersoneQualifiche AS
SELECT 
	PERSONA.*,
    COMPETENZA.nome AS nomeCompetenza,
    COMPETENZA.tipo AS tipoCompetenza,
    QUALIFICA.nome AS nomeQualifica,
    ATTESTATO.data AS dataAttestato,
    USO.data AS dataUso
FROM PERSONA
INNER JOIN USO ON USO.persona = PERSONA.CF
INNER JOIN QUALIFICA ON USO.qualifica = QUALIFICA.codice
INNER JOIN ATTESTATO ON QUALIFICA.codice = ATTESTATO.qualifica
INNER JOIN COMPETENZA ON QUALIFICA.competenzaAcquisita = COMPETENZA.codice;

-- PUNTO 6
-- Creare una tabella RENDICONTAZIONE (ANNO, INTROITO) per tenere traccia dei guadagni 
-- dei corsi di formazione per ogni anno. 
-- Supporre che il rilascio di ogni attestato costi 100 €. 
-- Riempire inizialmente la tabella con i valori presenti
-- nell’istanza della base di dati fornita, e successivamente creare un trigger che aggiorni 
-- il valore di introito per ogni attestato rilasciato. 
CREATE TABLE IF NOT EXISTS RENDICONTAZIONE(
	anno integer,
	introito integer
) Engine = 'InnoDB';

INSERT INTO RENDICONTAZIONE
	SELECT
		YEAR(ATTESTATO.data) AS anno,
        (COUNT(ATTESTATO.persona)) * 100 AS introito
	FROM ATTESTATO
    GROUP BY YEAR(ATTESTATO.data);

DELIMITER //
CREATE TRIGGER aggiornaIntroito
AFTER INSERT ON ATTESTATO
FOR EACH ROW
BEGIN
	UPDATE RENDICONTAZIONE
    SET RENDICONTAZIONE.introito = RENDICONTAZIONE.introito + 100
    WHERE anno = YEAR(NEW.data);
END;
//
DELIMITER 

-- PUNTO 7
-- Creare e riempire una tabella TARIFFARIO(QUALIFICA, NOME_QUALIFICA, COSTO) 
-- che assegni un costo ad ogni qualifica, calcolato, in euro, come 100 x C, dove C è pari a 
-- 1 se il livello di importanza è minore o uguale a 5; 
-- 2 se è maggiore di 5 e minore o uguale a 7; 
-- 3 se è maggiore di 7. 
-- Qualifica e nome_qualifica in TARIFFARIO rappresentano 
-- il codice e il nome della qualifica presente nella tabella QUALIFICA.
CREATE TABLE IF NOT EXISTS TARIFFARIO(
	qualifica integer,
    nomeQualifica varchar(30),
    costo integer,
    PRIMARY KEY(qualifica),
    FOREIGN KEY(qualifica) REFERENCES QUALIFICA(codice)
) Engine = 'InnoDB';

INSERT INTO TARIFFARIO
	SELECT 
		QUALIFICA.codice,
        QUALIFICA.nome,
	    CASE 
			WHEN QUALIFICA.importanza <= 5 THEN 100
            WHEN QUALIFICA.importanza > 5 AND QUALIFICA.importanza <= 7 THEN 2*100
            WHEN QUALIFICA.importanza > 7 THEN 3*100
        END AS costo
	FROM QUALIFICA;

-- PUNTO 8
-- Si consideri il seguente schema di base di dati relazionale che rappresenta una realtà bancaria, 
-- e i relativi vincoli di integrità referenziale. 
-- Implementare il seguente schema SQL. 
CREATE DATABASE realtaBancaria;
USE realtaBancaria;

-- Persone(_CodiceFiscale_, Cognome, Nome, DataDiNascita)
CREATE TABLE IF NOT EXISTS PERSONE(
	codiceFiscale varchar(30),
    cognome varchar(30),
    nome varchar(30),
    dataNascita date,
    PRIMARY KEY(codiceFiscale)
) Engine = 'InnoDB';

-- Qualifiche(_Codice_, Descrizione)
CREATE TABLE IF NOT EXISTS QUALIFICHE(
	codice integer,
    descrizione varchar(30),
    PRIMARY KEY(codice)
) Engine = 'InnoDB';   

-- Dipendenti(_CodiceFiscale_, Filiale, Qualifica)
-- FK: CodiceFiscale -> Persone(CodiceFiscale)
-- FK: Qualifica -> Qualifiche(Codice)
-- Constr: Filiale chiave, non primaria
CREATE TABLE IF NOT EXISTS DIPENDENTI(
	codiceFiscale varchar(30),
    filiale varchar(30) UNIQUE,
    qualifica integer,
    PRIMARY KEY(codiceFiscale),
    INDEX indiceCodice(codice),
    INDEX indiceQualifica(qualifica),
    FOREIGN KEY(codice) REFERENCES PERSONE(codiceFiscale),
    FOREIGN KEY(qualifica) REFERENCES QUALIFICHE(codice)
) Engine = 'InnoDB';   

-- Filiali(_Codice_, Città, Direttore)
-- FK: Direttore -> Persone(CodiceFiscale)
-- Constr: Direttore non può avere valori nulli
CREATE TABLE IF NOT EXISTS FILIALI(
	codice integer,
    citta varchar(30),
    direttore varchar(30) NOT NULL,
    PRIMARY KEY(codice),
    INDEX indiceDirettore(direttore),
    FOREIGN KEY(direttore) REFERENCES PERSONE(codiceFiscale)
) Engine = 'InnoDB';   

-- Agenzie (_Numero_, _Filiale_, Indirizzo)
-- FK: Filiale -> Filiali(Codice)
-- Constr: Indirizzo deve iniziare con “T”
CREATE TABLE IF NOT EXISTS AGENZIE(
	numero integer,
	filiale integer,
	indirizzo varchar(30) CHECK(indizzo LIKE 'T%'),
	PRIMARY KEY(numero, filiale),
	FOREIGN KEY(filiale) REFERENCES FILIALI(codice)
) Engine = 'InnoDB';   

-- ContiCorrenti (_Numero_, Agenzia, Filiale)
-- FK: (Agenzia,Filiale) -> Agenzie(Numero,Filiale)
-- Constr: Numero deve essere maggiore di 1000
CREATE TABLE IF NOT EXISTS CONTI_CORRENTI(
	numero integer CHECK(numero > 1000),
    agenzia integer,
    filiale integer,
    PRIMARY KEY(numero),
    FOREIGN KEY(agenzia, filiale) REFERENCES AGENZIE(numero, filiale)
) Engine = 'InnoDB';   

-- Titolarita_CC (_Conto_, _Titolare_)
-- FK: Conto -> ContiCorrenti(Numero)
-- FK: Titolare -> Persone(CodiceFiscale)
CREATE TABLE IF NOT EXISTS TITOLARITA_CC(
	conto integer,
	titolare varchar(30),
	PRIMARY KEY(conto, titolare),
	FOREIGN KEY(conto) REFERENCES CONTI_CORRENTI(numero),
	FOREIGN KEY(titolare) REFERENCES PERSONE(codiceFiscale)
) Engine = 'InnoDB';   
