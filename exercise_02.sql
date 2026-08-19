-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n29_24_ottobre_2023;
USE n29_24_ottobre_2023;

-- CREAZIONE TABELLA: IMPIEGATO
CREATE TABLE IF NOT EXISTS IMPIEGATO(
	matricola varchar(20),
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    dipartimento varchar(20) NOT NULL,
    stipendio_annuale integer,
    PRIMARY KEY(matricola)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: DIPARTIMENTO
CREATE TABLE IF NOT EXISTS DIPARTIMENTO(
	nome_dipartimento varchar(20),
    indirizzo varchar(30) NOT NULL,
    citta varchar(20) NOT NULL,
    PRIMARY KEY(nome_dipartimento)
) Engine = 'InnoDB';

-- DATI PER TABELLA: IMPIEGATO
insert into IMPIEGATO values ('1','Luca','Rossi','Produzione',10000);
insert into IMPIEGATO values ('2','Giacomo','Verdi','Amministrazione',20583);
insert into IMPIEGATO values ('3','Luca','Felice','Produzione',65783);
insert into IMPIEGATO values ('4','Gigi','La Trottola','Direzione',78547);
insert into IMPIEGATO values ('5','Mino','Reitano','Distribuzione ',6743);
insert into IMPIEGATO values ('6','Francesco','Turiano','Produzione',78345);
insert into IMPIEGATO values ('7','Giuseppe','Rossi','Amministrazione',7854);
insert into IMPIEGATO values ('8','Luciano','Ligabue','Produzione',78356);
insert into IMPIEGATO values ('9','Francesco','Rossi','Amministrazione',23432);
insert into IMPIEGATO values ('10','Francesco','Turiano','Produzione',56433);
insert into IMPIEGATO values ('11','Luca','Infelice','Produzione',76533);
insert into IMPIEGATO values ('12','Carlo','Franco','Direzione',64332);
insert into IMPIEGATO values ('13','Beppe','Reitano','Amministrazione ',23500);
insert into IMPIEGATO values ('14','Francisco','Loi','Direzione',43000);
insert into IMPIEGATO values ('15','Pino','Ignoto','Produzione',22000);
insert into IMPIEGATO values ('16','Luciano','Lima','Distribuzione',12500);
insert into IMPIEGATO values ('17','Ester','Tramonatana','Amministrazione',54363);
insert into IMPIEGATO values ('18','Francesca','Coco','Produzione',23456);
insert into IMPIEGATO values ('21','Francesca','Franco','Distribuzione',12350);

-- DATI PER TABELLA: DIPARTIMENTO
insert into DIPARTIMENTO values ('Produzione','Via Firenze','Torino');
insert into DIPARTIMENTO values ('Amministrazione','Via Milano','Catania');
insert into DIPARTIMENTO values ('Direzione','Via Pasubio','Milano');
insert into DIPARTIMENTO values ('Distribuzione','Via Alcide De Gasperi','Torino');

-- PUNTO 1
-- Lo stipendio settimanale dell’impiegato ‘Rossi’.
SELECT IMPIEGATO.stipendio_annuale / 52 AS stipendio_settimanale
FROM IMPIEGATO
WHERE IMPIEGATO.cognome = 'Rossi';

-- PUNTO 2 
-- In quale città lavorano i dipendenti (JOIN IMPLICITO).
SELECT IMPIEGATO.*, DIPARTIMENTO.citta
FROM DIPARTIMENTO, IMPIEGATO
WHERE DIPARTIMENTO.nome_dipartimento = IMPIEGATO.dipartimento;

-- PUNTO 2 
-- In quale città lavorano i dipendenti (JOIN ESPLICITO).
SELECT IMPIEGATO.*, DIPARTIMENTO.citta
FROM DIPARTIMENTO
INNER JOIN IMPIEGATO ON DIPARTIMENTO.nome_dipartimento = IMPIEGATO.dipartimento;

-- PUNTO 3 
-- Selezionare le città (in modo univoco) dove lavorano impiegati di cognome ‘Rossi’.
SELECT DISTINCT DIPARTIMENTO.citta
FROM DIPARTIMENTO
INNER JOIN IMPIEGATO ON DIPARTIMENTO.nome_dipartimento = IMPIEGATO.dipartimento
WHERE IMPIEGATO.cognome = 'Rossi';

-- PUNTO 4:
-- Numero di Impiegati di cognome ‘Franco’.
SELECT COUNT(IMPIEGATO.cognome) AS numeroImpiegati
FROM IMPIEGATO
WHERE IMPIEGATO.cognome = 'Franco';

-- PUNTO 5
-- Per calcolare il numero di diversi valori dell'Attributo Stipendio 
-- fra tutte le righe impiegato.
SELECT DISTINCT(IMPIEGATO.stipendio_annuale) AS stipendi_diversi
FROM IMPIEGATO;

-- PUNTO 6
-- Somma degli stipendi del Dipartimento Amministrazione.
SELECT SUM(IMPIEGATO.stipendio_annuale) AS somma_stipendi
FROM IMPIEGATO
WHERE IMPIEGATO.dipartimento = 'Amministrazione';

-- PUNTO 7
-- Estrarre stipendi minimi, massimo e medi tra quelli degli impiegati.
SELECT 
    MIN(IMPIEGATO.stipendio_annuale) AS stipendioMinimo, 
    MAX(IMPIEGATO.stipendio_annuale) AS stipendioMassimo,  
    AVG(IMPIEGATO.stipendio_annuale) AS stipendioMedio
FROM IMPIEGATO;

-- PUNTO 8
-- Estrarre il massimo stipendio tra quelli degli impiegati che lavorano 
-- in uno specifico dipartimento con sede a Milano.
SELECT MAX(IMPIEGATO.stipendio_annuale)
FROM IMPIEGATO
WHERE IMPIEGATO.dipartimento = (SELECT DIPARTIMENTO.nome_dipartimento
                                FROM DIPARTIMENTO
				                WHERE DIPARTIMENTO.citta = 'Milano');

-- PUNTO 9
-- Calcolare la somma degli stipendi per dipartimento purchè tale somma sia > 100.
SELECT SUM(IMPIEGATO.stipendio_annuale) AS somma_stipendi
FROM IMPIEGATO
GROUP BY IMPIEGATO.dipartimento
HAVING BY SUM(IMPIEGATO.stipendio_annuale) > 100;


