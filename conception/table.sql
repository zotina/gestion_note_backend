DROP DATABASE gestion_note;
CREATE DATABASE gestion_note;
\c gestion_note;

-- Création de la table matieres
CREATE SEQUENCE seq_matiere_id START 1 INCREMENT 1;

-- Création de la table semestres
CREATE SEQUENCE seq_semestre_id START 1 INCREMENT 1;

CREATE TABLE semestres(
   id_semestre VARCHAR(50) DEFAULT CONCAT('SEM-', LPAD(nextval('seq_semestre_id')::text, 5, '0')),
   libelle VARCHAR(50),
   PRIMARY KEY(id_semestre)
);

CREATE TABLE matieres(
   id_matiere VARCHAR(50) DEFAULT CONCAT('MAT-', LPAD(nextval('seq_matiere_id')::text, 5, '0')),
   libelle VARCHAR(50),
   intitule VARCHAR(50),
   credit INTEGER,
   id_semestre VARCHAR(50) NOT NULL,
   FOREIGN KEY(id_semestre) REFERENCES semestres(id_semestre),
   PRIMARY KEY(id_matiere),
   UNIQUE(libelle)
);

-- Création de la table etudiants
CREATE SEQUENCE seq_etudiant_id START 1 INCREMENT 1;

CREATE TABLE etudiants(
   id_etudiant VARCHAR(50) DEFAULT CONCAT('ETU-', LPAD(nextval('seq_etudiant_id')::text, 5, '0')),
   nom VARCHAR(100),
   prenom VARCHAR(50),
   date_naissance DATE,
   PRIMARY KEY(id_etudiant)
);

-- Création de la table inscriptions
CREATE SEQUENCE seq_inscription_id START 1 INCREMENT 1;

CREATE TABLE inscriptions(
   id_inscription VARCHAR(50) DEFAULT CONCAT('INS-', LPAD(nextval('seq_inscription_id')::text, 5, '0')),
   date_inscrition DATE,
   id_etudiant VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_inscription),
   FOREIGN KEY(id_etudiant) REFERENCES etudiants(id_etudiant)
);

-- Création de la table inscription-semestre
CREATE SEQUENCE seq_inscription_semestre START 1 INCREMENT 1;

CREATE TABLE inscription_semestre(
   id_inscription_semestre VARCHAR(50) DEFAULT CONCAT('INS-', LPAD(nextval('seq_inscription_semestre')::text, 5, '0')),
   id_semestre VARCHAR(50),
   id_inscription VARCHAR(50),
   session DATE,
   PRIMARY KEY(id_inscription_semestre),
   FOREIGN KEY(id_semestre) REFERENCES semestres(id_semestre),
   FOREIGN KEY(id_inscription) REFERENCES inscriptions(id_inscription)
);

-- Création de la table etudiant-test
CREATE SEQUENCE seq_etudiant_test START 1 INCREMENT 1;

CREATE TABLE   (
   id_etudiant_test VARCHAR(50) DEFAULT CONCAT('ET-', LPAD(nextval('seq_etudiant_test')::text, 5, '0')),
   id_etudiant VARCHAR(50) NOT NULL,
   date_examen DATE,
   id_matiere VARCHAR(50) NOT NULL,
   note DECIMAL NOT NULL DEFAULT 0,
   PRIMARY KEY(id_etudiant_test),
   FOREIGN KEY(id_etudiant) REFERENCES etudiants(id_etudiant),
   FOREIGN KEY(id_matiere) REFERENCES matieres(id_matiere)
);
