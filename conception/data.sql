-- Insertion des semestres
INSERT INTO semestres (libelle) VALUES
('SEMESTRE 1'),
('SEMESTRE 2');

-- Insertion des matières (UE) avec leur semestre associé
INSERT INTO matieres (libelle, intitule, credit, id_semestre) VALUES
-- Matières du Semestre 1
('MTH102', 'Analyse mathématique', 6, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 1')),
('INF107', 'Informatique de Base', 4, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 1')),
('ORG101', 'Techniques de communication', 4, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 1')),
('INF101', 'Programmation procédurale', 7, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 1')),
('MTH101', 'Arithmetique et nombres', 4, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 1')),
('INF104', 'HTML et Introduction au Web', 5, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 1')),
-- Matières du Semestre 2
('INF105', 'Maintenance matériel et logiciel', 4, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 2')),
('INF102', 'Bases de données relationnelles', 5, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 2')),
('MTH103', 'Calcul Vectoriel et Matriciel', 6, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 2')),
('INF103', 'Bases administration système', 5, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 2')),
('INF106', 'Compléments de programmation', 6, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 2')),
('MTH105', 'Probabilité et Statistique', 4, (SELECT id_semestre FROM semestres WHERE libelle = 'SEMESTRE 2'));

