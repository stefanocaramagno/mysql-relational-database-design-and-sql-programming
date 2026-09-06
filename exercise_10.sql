-- PUNTO 1
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n38_15_dicembre_2023;
USE n38_15_dicembre_2023;

-- CREAZIONE TABELLA: PERSONA
CREATE TABLE IF NOT EXISTS PERSONA(
	id integer,
    nome varchar(30) NOT NULL,
    nazionalita varchar(30) NOT NULL,
    dataNascita date NOT NULL,
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: ACCOUNT 
CREATE TABLE IF NOT EXISTS ACCOUNT(
	id integer,
    persona integer NOT NULL,
    dataCreazione date NOT NULL,
    saldo integer,
    PRIMARY KEY(id),
	INDEX indicePersona(persona),
    FOREIGN KEY(persona) REFERENCES PERSONA(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: CARTA
CREATE TABLE IF NOT EXISTS CARTA(
	id integer,
    account integer NOT NULL,
    numero varchar(30) NOT NULL,
    circuito varchar(30) NOT NULL,
    credito boolean,
    PRIMARY KEY(id),
	INDEX indiceAccount(account),
    FOREIGN KEY(account) REFERENCES ACCOUNT(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: TRANSAZIONE
CREATE TABLE IF NOT EXISTS TRANSAZIONE(
	id integer,
    accountSorgente integer NOT NULL,
    accountDestinazione integer NOT NULL,
    importo integer,
    data date NOT NULL,
    PRIMARY KEY(id),
	INDEX indiceAccountSorgente(accountSorgente),
	INDEX indiceAccountaccountDestinazione(accountDestinazione),
    FOREIGN KEY(accountSorgente) REFERENCES ACCOUNT(id),
    FOREIGN KEY(accountDestinazione) REFERENCES ACCOUNT(id)    
) Engine = 'InnoDB';

-- DATI PER TABELLA: PERSONA
insert into PERSONA values (1, 'Antonio', 'Italy', '1990-12-12');
insert into PERSONA values (2, 'Barbara', 'Italy', '1991-11-11');
insert into PERSONA values (3, 'Carlo', 'Italy', '1992-10-10');
insert into PERSONA values (4, 'David', 'UK', '1993-09-09');

-- DATI PER TABELLA: ACCOUNT
insert into ACCOUNT values(1, 1, '2017-07-07',-100);
insert into ACCOUNT values(2, 1, '2018-08-08',-200);
insert into ACCOUNT values(3, 2, '2019-09-09',600);
insert into ACCOUNT values(4, 3, '2014-04-04',200);
insert into ACCOUNT values(5, 4, '2020-02-20',-500);

-- DATI PER TABELLA: CARTA
insert into CARTA values(1, 1, '1230-0000', 'visa', 1);
insert into CARTA values(2, 3, '1231-1111', 'visa', 0);
insert into CARTA values(3, 3, '1232-2222', 'masterCARTA', 0);
insert into CARTA values(4, 3, '4560-0000', 'masterCARTA', 0);
insert into CARTA values(5, 4, '4561-1111', 'visa', 0);
insert into CARTA values(6, 4, '1233-3333', 'visa', 0);

-- DATI PER TABELLA: TRANSAZIONE
insert into TRANSAZIONE values(1, 1, 3, 100, '2021-01-01');
insert into TRANSAZIONE values(2, 2, 4, 200, '2021-02-02');
insert into TRANSAZIONE values(3, 4, 1, 300, '2021-03-03');
insert into TRANSAZIONE values(4, 5, 2, 400, '2021-04-04');
insert into TRANSAZIONE values(5, 5, 3, 500, '2021-05-05');

-- PUNTO 2
-- Eseguire un trasferimento di fondi da una persona ad un’altra 
-- (quindi scrivere la transazione e aggiornare i relativi account) 
-- in modo atomico (i.e., tramite una transazione SQL, da non 
-- confondere con la transazione del testo che si riferisce a quelle economiche).
START TRANSACTION;
UPDATE ACCOUNT 
	SET ACCOUNT.saldo = ACCOUNT.saldo - 10
    WHERE ACCOUNT.id = 1;
UPDATE ACCOUNT 
	SET ACCOUNT.saldo = ACCOUNT.saldo + 10
    WHERE ACCOUNT.id = 3;
INSERT INTO TRANSAZIONE VALUES (1,3,10,curdate());
COMMIT;

-- PUNTO 3
-- Creare una procedura per mostrare le persone (nome) di una data nazionalità 
-- (passata come input alla procedura) e che hanno creato un account dopo un dato anno 
-- (anche questo passato come input alla procedura). 
-- Ogni persona dovrebbe apparire solo una volta nel risultato. 
DELIMITER //
CREATE PROCEDURE getPersoneByNaziontalitaAnno
(IN dataNaziontalita varchar(30),
 IN datoAnno integer)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_NAZ_ACC;
	CREATE TEMPORARY TABLE PERS_NAZ_ACC(
		nome varchar(30)
	);

	INSERT INTO PERS_NAZ_ACC
		SELECT DISTINCT(PERSONA.nome)
		FROM PERSONA
		INNER JOIN ACCOUNT ON PERSONA.id = ACCOUNT.persona
		WHERE PERSONA.nazionalita = dataNaziontalita AND YEAR(ACCOUNT.dataCreazione) > datoAnno;
END //
DELIMITER ;
CALL getPersoneByNaziontalitaAnno('Italy',2018);
SELECT PERS_NAZ_ACC.* 
FROM PERS_NAZ_ACC;

-- PUNTO 4
-- Creare una procedura per mostra le persone (nome, paese) che possiedono carte di debito il 
-- cui numero inizia con tre cifre passate come input alla procedura. 
-- Ogni persona dovrebbe apparire solo una volta nel risultato.
DELIMITER //
CREATE PROCEDURE getPersoneBy3PrimeCifreNumeroCarta
(IN date3PrimeCifreNumeroCarta varchar(3))
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_CART;
	CREATE TEMPORARY TABLE PERS_CART(
		nome varchar(30),
        nazionalita varchar(30)
	);

	INSERT INTO PERS_CART
		SELECT DISTINCT(PERSONA.nome), PERSONA.nazionalita
		FROM PERSONA
		INNER JOIN ACCOUNT ON PERSONA.id = ACCOUNT.persona
		INNER JOIN CARTA ON ACCOUNT.id = CARTA.account
		WHERE CARTA.numero LIKE CONCAT(date3PrimeCifreNumeroCarta, '%');
END //
DELIMITER ; 
CALL getPersoneBy3PrimeCifreNumeroCarta('123');
SELECT PERS_CART.* 
FROM PERS_CART;

-- PUNTO 5
-- Per tutte le persone (nome, paese), mostra l'importo medio di denaro che hanno inviato tramite 
-- trasferimenti. Il risultato dovrebbe includere le persone che non hanno trasferito alcun denaro 
-- (mostrando 0 come importo medio).
SELECT PERSONA.nome, PERSONA.nazionalita, IFNULL(SUM(TRANSAZIONE.importo), 0)   
FROM PERSONA
INNER JOIN ACCOUNT ON PERSONA.id = ACCOUNT.persona
LEFT JOIN TRANSAZIONE ON ACCOUNT.id = TRANSAZIONE.accountSorgente
GROUP BY PERSONA.id;

-- PUNTO 6
-- Creare una procedura per mostrare la persona (solo id) che possiede il maggior numero di 
-- carte di un determinato tipo (provare la procedura con “VISA”).
DELIMITER //
CREATE PROCEDURE getPersonaMaggiorNumeroCarta()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS PERS_MAX_CART;
	CREATE TEMPORARY TABLE PERS_MAX_CART(
		id integer
	);

	INSERT INTO PERS_MAX_CART
		SELECT PERSONA.id
		FROM PERSONA
		INNER JOIN ACCOUNT ON PERSONA.id = ACCOUNT.persona
		INNER JOIN CARTA ON ACCOUNT.id = CARTA.account
		WHERE CARTA.circuito = 'VISA'
		GROUP BY PERSONA.id
		ORDER BY COUNT(PERSONA.id) DESC
		LIMIT 1;
END //
DELIMITER ; 
CALL getPersonaMaggiorNumeroCarta();
SELECT PERS_MAX_CART.* 
FROM PERS_MAX_CART;

-- PUNTO 7
-- Creare un trigger che aggiorni il saldo negli account coinvolti in una transazione.
DELIMITER //
CREATE TRIGGER aggiornaSaldo
AFTER INSERT ON TRANSAZIONE
FOR EACH ROW 
BEGIN
	UPDATE ACCOUNT
    SET ACCOUNT.saldo = ACCOUNT.saldo - NEW.importo
    WHERE ACCOUNT.id = NEW.accountSorgente;
    
	UPDATE ACCOUNT
    SET ACCOUNT.saldo = ACCOUNT.saldo + NEW.importo
    WHERE ACCOUNT.id = NEW.accountDestinazione;
END;
//
DELIMITER ;

-- PUNTO 8
-- Per tutti gli account (nome del proprietario, ID dell'account), verifica la congruenza del loro 
-- saldo, ovvero verificare che il valore di saldo nella tabella ACCOUNT corrisponda 
-- effettivamente alla differenza tra l'importo totale di denaro ricevuto e l'importo totale di denaro 
-- inviato presente in TRANSAZIONE.