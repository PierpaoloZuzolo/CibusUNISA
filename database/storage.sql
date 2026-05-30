DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;

DROP TABLE IF EXISTS dettaglio_ordine;
DROP TABLE IF EXISTS ordine;
DROP TABLE IF EXISTS prodotto;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS utente;

CREATE TABLE utente (
    codice INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL, 
    password VARCHAR(255) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    ruolo VARCHAR(20) NOT NULL DEFAULT 'cliente' 
);

CREATE TABLE categoria (
    codice INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descrizione VARCHAR(255)
);

CREATE TABLE prodotto (	
    codice INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione VARCHAR(255),
    prezzo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    categoria_codice INT,
    attivo BOOLEAN DEFAULT TRUE, 
    FOREIGN KEY (categoria_codice) REFERENCES categoria(codice) ON DELETE SET NULL
);

CREATE TABLE ordine (
    codice INT PRIMARY KEY AUTO_INCREMENT,
    data_ordine TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    indirizzo_consegna VARCHAR(255) NOT NULL, 
    metodo_pagamento VARCHAR(50) NOT NULL,
    utente_codice INT,
    FOREIGN KEY (utente_codice) REFERENCES utente(codice) ON DELETE CASCADE
);

CREATE TABLE dettaglio_ordine (
    codice_ordine INT,
    codice_prodotto INT,
    quantita INT NOT NULL DEFAULT 1,
    prezzo_unitario DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (codice_ordine, codice_prodotto),
    FOREIGN KEY (codice_ordine) REFERENCES ordine(codice) ON DELETE CASCADE,
    FOREIGN KEY (codice_prodotto) REFERENCES prodotto(codice)
);