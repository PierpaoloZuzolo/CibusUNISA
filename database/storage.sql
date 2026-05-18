DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;

DROP TABLE IF EXISTS dettaglio_ordine;
DROP TABLE IF EXISTS ordine;
DROP TABLE IF EXISTS prodotto;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS utente;

CREATE TABLE utente (
    code INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE categoria (
    code INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    descrizione VARCHAR(100)
);

CREATE TABLE prodotto (	
    code INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    price DECIMAL(10,2) DEFAULT 0.00,
    categoria_code INT,
    FOREIGN KEY (categoria_code) REFERENCES categoria(code) ON DELETE SET NULL
);

CREATE TABLE ordine (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_utente INT NOT NULL,
    data_ordine DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    prezzo_totale DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_utente) REFERENCES utente(code) ON DELETE CASCADE
);


CREATE TABLE dettaglio_ordine (
    id_ordine INT NOT NULL,
    code_prodotto INT NOT NULL,
    quantita INT NOT NULL DEFAULT 1,
    prezzo_unitario DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (id_ordine, code_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES ordine(id) ON DELETE CASCADE,
    FOREIGN KEY (code_prodotto) REFERENCES prodotto(code) ON DELETE CASCADE
);