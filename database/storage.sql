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
    ruolo VARCHAR(20) NOT NULL DEFAULT 'cliente' 
);

CREATE TABLE categoria (
    codice INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione VARCHAR(255)
);

CREATE TABLE prodotto (	
    codice INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione VARCHAR(255),
    prezzo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (categoria_codice) REFERENCES categoria(codice) ON DELETE SET NULL
);

CREATE TABLE ordine (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_utente INT NOT NULL,
    data_ordine DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    prezzo_totale DECIMAL(10,2) NOT NULL,
    indirizzo_spedizione VARCHAR(255) NOT NULL, 
    metodo_pagamento VARCHAR(50) NOT NULL,      
    FOREIGN KEY (id_utente) REFERENCES utente(codice) ON DELETE CASCADE
);

CREATE TABLE dettaglio_ordine (
    id_ordine INT NOT NULL,
    code_prodotto INT NOT NULL,
    quantita INT NOT NULL DEFAULT 1,
    prezzo_unitario DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (id_ordine, code_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES ordine(id) ON DELETE CASCADE,    
    FOREIGN KEY (code_prodotto) REFERENCES prodotto(code) 
);