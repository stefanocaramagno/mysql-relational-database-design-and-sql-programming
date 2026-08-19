-- PUNTO 0
-- Creare lo schema del database, con vincoli di integrità referenziale. 
CREATE DATABASE n37_06_dicembre_2023;
USE n37_06_dicembre_2023;

-- CREAZIONE TABELLA: CLIENTE
CREATE TABLE IF NOT EXISTS CLIENTE(
	codiceFiscale varchar(25),
    citta varchar(25) NOT NULL,
    indirizzo varchar(25) NOT NULL,
    telefono varchar(25) NOT NULL,
    numeroCatering integer NOT NULL,
    PRIMARY KEY(codiceFiscale)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: RISTORANTE
CREATE TABLE IF NOT EXISTS RISTORANTE(
	partitaIVA varchar(25),
    nome varchar(25) NOT NULL,
    PRIMARY KEY(partitaIVA)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: MENU
CREATE TABLE IF NOT EXISTS MENU(
	id integer,
    costoTotale integer NOT NULL,
    ristorante varchar(25) NOT NULL,
    PRIMARY KEY(id),
    INDEX indiceRistorante(ristorante),
    FOREIGN KEY(ristorante) REFERENCES RISTORANTE(partitaIVA)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: CATERING
CREATE TABLE IF NOT EXISTS CATERING(
	codice integer,
    dataCatering date NOT NULL,
    cliente varchar(25) NOT NULL,
    menu integer NOT NULL,
    numeroInvitatati integer NOT NULL,
    costoTotale integer NOT NULL,
    PRIMARY KEY(codice),
    INDEX indiceCliente(cliente),
    INDEX indiceMenu(menu),
    FOREIGN KEY(cliente) REFERENCES CLIENTE(codiceFiscale),
    FOREIGN KEY(menu) REFERENCES MENU(id)
) Engine = 'InnoDB';   

-- CREAZIONE TABELLA: INVITATO
CREATE TABLE IF NOT EXISTS INVITATO(
	id integer,
    cognome varchar(25) NOT NULL,
    nome varchar(25) NOT NULL,
    catering integer NOT NULL,
    PRIMARY KEY(id),
    INDEX indiceCatering(catering),
    FOREIGN KEY(catering) REFERENCES CATERING(codice)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: PORTATA
CREATE TABLE IF NOT EXISTS PORTATA(
	id integer,
    nome varchar(25),
    costo integer,
    PRIMARY KEY(id)
) Engine = 'InnoDB';

-- CREAZIONE TABELLA: COMPONENTE
CREATE TABLE IF NOT EXISTS COMPONENTE(
	idMenu integer,
    idPortata integer,
    PRIMARY KEY(idMenu, idPortata),
    INDEX indiceIdMenu(idMenu),
    INDEX indiceIdPortata(idPortata),
    FOREIGN KEY(idMenu) REFERENCES MENU(id),
	FOREIGN KEY(idPortata) REFERENCES PORTATA(id)
) Engine = 'InnoDB';

-- DATI PER TABELLA: CLIENTE
INSERT INTO Cliente VALUES('CLBNDR92C19H224W', 'Siracusa','Viale Scala Greca 276', '0931497648', 1);
INSERT INTO Cliente VALUES('MFCSMR42T19H2U4W', 'Troina','Via dei muratori 2', '0944497648', 2);
INSERT INTO Cliente VALUES('STFSPN46THGH2U4K', 'Augusta','Via dei ciarlatani 2', '0944400658', 3);
INSERT INTO Cliente VALUES('MSCFBR435945FJJK', 'Roma', 'Via della olimpiade 27', '0931441301', 1);

-- DATI PER TABELLA: RISTORANTE
INSERT INTO Ristorante VALUES('PIVA12345', 'Terra2');
INSERT INTO Ristorante VALUES('PIVA55545', 'Barbuto');
INSERT INTO Ristorante VALUES('PIVA20094', 'La Brace');

-- DATI PER TABELLA: MENU
INSERT INTO Menu VALUES(1, 22,'PIVA12345');
INSERT INTO Menu VALUES(2, 20,'PIVA12345');
INSERT INTO Menu VALUES(3, 30,'PIVA55545');
INSERT INTO Menu VALUES(4, 24,'PIVA55545');
INSERT INTO Menu VALUES(5, 30,'PIVA20094');

-- DATI PER TABELLA: CATERING
INSERT INTO Catering VALUES(1, '2016-06-16','CLBNDR92C19H224W', 1, 98, 100);
INSERT INTO Catering VALUES(2, '2016-07-17','MFCSMR42T19H2U4W', 2, 90, 80);
INSERT INTO Catering VALUES(3, '2016-01-17','MFCSMR42T19H2U4W', 2, 190, 150);
INSERT INTO Catering VALUES(4, '2016-01-17','STFSPN46THGH2U4K', 3, 200, 180);
INSERT INTO Catering VALUES(5, '2016-02-29','MSCFBR435945FJJK', 4, 300, 250);

-- DATI PER TABELLA: INVITATO
INSERT INTO Invitato VALUES(1, 'Calabretta', 'Andrea', 1);
INSERT INTO Invitato VALUES(2, 'Alessandra','Casinotti', 1);
INSERT INTO Invitato VALUES(3, 'Fabrizio','Muscia', 1);
INSERT INTO Invitato VALUES(4, 'Angelo','Aloscari', 1);
INSERT INTO Invitato VALUES(5, 'Olimpia','Bottaro', 1);
INSERT INTO Invitato VALUES(6, 'Massimo','Aloscari', 1);
INSERT INTO Invitato VALUES(7, 'Erica','Aloscari', 1);
INSERT INTO Invitato VALUES(8, 'Carmela','Malara', 2);
INSERT INTO Invitato VALUES(9, 'Sebastiano','Calabretta', 2);
INSERT INTO Invitato VALUES(10, 'Francesco','Caruso', 2);
INSERT INTO Invitato VALUES(11, 'Laura','Moreno', 2);
INSERT INTO Invitato VALUES(12, 'Antonio','Blanco', 2);
INSERT INTO Invitato VALUES(13, 'Antonio','Spina', 4);
INSERT INTO Invitato VALUES(14, 'Daniele','Vercelli', 4);
INSERT INTO Invitato VALUES(15, 'Silvio','Berlusconi', 4);
INSERT INTO Invitato VALUES(16, 'Romano','Prodi', 4);
INSERT INTO Invitato VALUES(17, 'Gaetano','Monti', 4);
INSERT INTO Invitato VALUES(18, 'Paqui','Moreno', 4);

-- DATI PER TABELLA: PORTATA
INSERT INTO Portata VALUES(1, 'pasta al forno', 10);
INSERT INTO Portata VALUES(2, 'pasta alle vongole', 14);
INSERT INTO Portata VALUES(3, 'caprese', 4);
INSERT INTO Portata VALUES(4, 'patate al forno', 3);
INSERT INTO Portata VALUES(5, 'orata', 15);
INSERT INTO Portata VALUES(6, 'pasta al forno', 10);
INSERT INTO Portata VALUES(7, 'margherita', 5);
INSERT INTO Portata VALUES(8, 'capricciosa', 6);

-- DATI PER TABELLA: COMPONENTE
INSERT INTO Componente VALUES(1,1);
INSERT INTO Componente VALUES(1,2);
INSERT INTO Componente VALUES(1,3);
INSERT INTO Componente VALUES(1,7);
INSERT INTO Componente VALUES(2,4);
INSERT INTO Componente VALUES(2,7);
INSERT INTO Componente VALUES(2,8);
INSERT INTO Componente VALUES(3,1);
INSERT INTO Componente VALUES(3,3);
INSERT INTO Componente VALUES(3,5);
INSERT INTO Componente VALUES(3,6);

-- PUNTO 1
-- Selezionare tutti i catering organizzati da un dato cliente.
DELIMITER //
CREATE PROCEDURE getCateringByCliente
(IN datoCliente varchar(25))
BEGIN
    SELECT CATERING.*
    FROM CATERING
    WHERE CATERING.cliente = datoCliente;
END //
DELIMITER ;

-- PUNTO 2
-- Selezionare il menu che è stato più utilizzato in catering in un dato anno. 
-- Usare una vista per risolvere la procedura.
DELIMITER //
CREATE PROCEDURE getMenuPiuUsatoByAnno
(IN datoAnno integer)
BEGIN
    SELECT MENU.*
    FROM MENU
    INNER JOIN CATERING ON MENU.id = CATERING.menu 
    WHERE YEAR(CATERING.dataCatering) = datoAnno
    GROUP BY CATERING.menu
    ORDER BY COUNT(CATERING.menu) DESC
    LIMIT 1;
END //
DELIMITER ;

-- PUNTO 3
-- Calcolare il numero medio per anno di catering ai quali ha partecipato uno specifico INVITATO.
-- Selezionare tra tutti i menù usati in un catering, la portata (o portate) che ha il costo più elevato.
DELIMITER //
CREATE PROCEDURE getNumeroMedioCateringPerAnnoByInvitato
(IN datoInvitato INT)
BEGIN
    SELECT 
        YEAR(CATERING.dataCatering) AS anno,
        COUNT(CATERING.codice) AS numeroMedioCatering
    FROM CATERING
    INNER JOIN INVITATO ON CATERING.codice = INVITATO.catering
    WHERE INVITATO.id = datoInvitato
    GROUP BY YEAR(CATERING.dataCatering);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE getPortataPiuCostosaByCatering
(IN datoCatering integer)
BEGIN
    SELECT PORTATA.*
    FROM CATERING
    INNER JOIN MENU ON CATERING.menu = MENU.id
    INNER JOIN COMPONENTE ON MENU.id = COMPONENTE.idMenu
    INNER JOIN PORTATA ON COMPONENTE.idPortata = PORTATA.id
    WHERE CATERING.codice = datoCatering
    ORDER BY PORTATA.costo DESC
    LIMIT 1;
END //
DELIMITER ;

DELIMITER //

-- PUNTO 4
-- Lo schema inoltre prevede degli attributi che devono essere aggiornati automaticamente. 
-- Scrivere i trigger per la loro gestione. 

-- 1) N_CATERING su CLIENTE. Ogni volta che un cliente organizza un catering, 
-- l’attributo deve essere incrementato. 
DELIMITER //
CREATE TRIGGER IncrementaNumeroCatering
AFTER INSERT ON CATERING
FOR EACH ROW
BEGIN
    UPDATE CLIENTE
    SET numeroCatering = numeroCatering + 1
    WHERE codiceFiscale = NEW.cliente;
END;
//
DELIMITER ;

-- 2) COSTO_TOTALE in MENU che dipende dal costo delle portate associate al menu
-- (associazione memorizzata nella tabella COMPONENTE).
DELIMITER //
CREATE TRIGGER aggiornaCostoMenu
AFTER INSERT ON COMPONENTE
FOR EACH ROW
BEGIN
    UPDATE MENU
    SET costoTotale = (SELECT SUM(PORTATA.costo)
		               FROM PORTATA
                       INNER JOIN COMPONENTE ON PORTATA.id = COMPONENTE.idPortata
                       WHERE COMPONENTE.idMenu = NEW.idMenu)
    WHERE id = NEW.idMenu;
END;
//
DELIMITER ;

-- 3) NUM_INVITATI e COSTO_TOTALE su CATERING. 
-- Il costo totale dipende dal numero degli invitati e dal costo del menu associato.
DELIMITER //
CREATE TRIGGER aggionaNumeroInvitati
AFTER INSERT ON INVITATO
FOR EACH ROW
BEGIN
    UPDATE CATERING
    SET numeroInvitatati = (SELECT COUNT(INVITATO.id)
		                    FROM INVITATO
                            WHERE catering = NEW.catering)
    WHERE codice = NEW.catering;
END;
//
DELIMITER ;    

DELIMITER //
CREATE TRIGGER aggionaCostoTotale
AFTER INSERT ON CATERING
FOR EACH ROW
BEGIN
    UPDATE CATERING
    SET costoTotale = NEW.numeroInvitatati * (SELECT MENU.costoTotale
					                          FROM MENU
					                          WHERE menu = NEW.menu)
    WHERE codice = NEW.codice;
END;
//
DELIMITER ;    















