SELECT 
    e.id_etudiant,
    e.nom,
    e.prenom,
    s.libelle AS semestre,
    m.libelle AS matiere,
    m.credit,
    et.note,
    et.date_examen
FROM etudiants e
JOIN inscriptions i ON e.id_etudiant = i.id_etudiant
JOIN inscription_semestre ins ON i.id_inscription = ins.id_inscription
JOIN semestres s ON ins.id_semestre = s.id_semestre
JOIN etudiant_test et ON e.id_etudiant = et.id_etudiant
JOIN matieres m ON et.id_matiere = m.id_matiere AND m.id_semestre = s.id_semestre
ORDER BY 
    e.nom,
    e.prenom,
    s.libelle,
    m.libelle;


SELECT 
    e.id_etudiant,
    e.nom,
    e.prenom,
    s.libelle AS semestre,
    ROUND(AVG(et.note), 2) AS moyenne_semestre,
    SUM(m.credit) AS total_credits,
    ROUND(SUM(et.note * m.credit) / SUM(m.credit), 2) AS moyenne_ponderee
FROM etudiants e
JOIN inscriptions i ON e.id_etudiant = i.id_etudiant
JOIN inscription_semestre ins ON i.id_inscription = ins.id_inscription
JOIN semestres s ON ins.id_semestre = s.id_semestre
JOIN etudiant_test et ON e.id_etudiant = et.id_etudiant
JOIN matieres m ON et.id_matiere = m.id_matiere AND m.id_semestre = s.id_semestre
GROUP BY 
    e.id_etudiant,
    e.nom,
    e.prenom,
    s.libelle
ORDER BY 
    e.nom,
    e.prenom,
    s.libelle;




-- Création de la vue pour afficher les résultats des étudiants
CREATE OR REPLACE VIEW v_releve_notes AS
SELECT
    e.nom AS nom_etudiant,
    e.prenom AS prenom_etudiant,
    e.date_naissance,
    s.libelle AS semestre,
    m.libelle AS code_ue,
    m.intitule,
    m.credit,
    et.note AS note_sur_20,
    CASE
        WHEN et.note >=16 THEN 'TB'
        WHEN et.note >= 13 THEN 'AB'
        WHEN et.note >= 10 THEN 'P'
        WHEN et.note >= 8 AND et.note < 10 THEN 'Comp'
        ELSE 'Comp.'
    END AS resultat,
    to_char(et.date_examen, 'MM/YYYY') AS session
FROM
    etudiants e
JOIN inscriptions i ON e.id_etudiant = i.id_etudiant
JOIN inscription_semestre isem ON i.id_inscription = isem.id_inscription
JOIN semestres s ON s.id_semestre = isem.id_semestre
JOIN matieres m ON m.id_semestre = s.id_semestre
JOIN etudiant_test et ON et.id_etudiant = e.id_etudiant AND et.id_matiere = m.id_matiere
ORDER BY
    s.libelle,e.nom;