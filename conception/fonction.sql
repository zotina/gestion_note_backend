CREATE OR REPLACE PROCEDURE generate_etudiant()
LANGUAGE plpgsql
AS
$$
DECLARE
    v_etudiant_id VARCHAR(50);
    v_current_etudiant_id INT := 1;
    v_etudiant_count INT := 1;
BEGIN
    FOR i IN 1..v_etudiant_count LOOP
        v_etudiant_id := CONCAT('ETU-', LPAD(v_current_etudiant_id::text, 5, '0'));
        INSERT INTO etudiants(id_etudiant, nom, prenom, date_naissance)
        VALUES (
            v_etudiant_id,
            CONCAT('Nom', LPAD(v_current_etudiant_id::text, 5, '0')),
            CONCAT('Prenom', LPAD(v_current_etudiant_id::text, 5, '0')),
            CURRENT_DATE - (random() * 365 * 20)::int
        );
        v_current_etudiant_id := v_current_etudiant_id + 1;
    END LOOP;
END;
$$;


CREATE OR REPLACE PROCEDURE generate_inscription()
LANGUAGE plpgsql
AS
$$
DECLARE
    v_inscription_id VARCHAR(50);
    v_current_inscription_id INT := 1;
    v_inscription_count INT := 1; -- Adjust this number as needed
    v_random_etudiant_id VARCHAR(50);
BEGIN
    FOR i IN 1..v_inscription_count LOOP
        -- Generate a unique inscription ID
        v_inscription_id := CONCAT('INS-', LPAD(v_current_inscription_id::text, 5, '0'));

        -- Select a random student from the etudiants table
        SELECT id_etudiant INTO v_random_etudiant_id
        FROM etudiants
        ORDER BY random()
        LIMIT 1;

        -- Insert a record into the inscriptions table
        INSERT INTO inscriptions(id_inscription, date_inscrition, id_etudiant)
        VALUES (
            v_inscription_id,
            CURRENT_DATE - (random() * 365 * 5)::int, -- Random date of inscription (within 5 years)
            v_random_etudiant_id
        );

        -- Increment the inscription ID
        v_current_inscription_id := v_current_inscription_id + 1;
    END LOOP;
END;
$$;


CREATE OR REPLACE PROCEDURE generate_inscription_semestre()
LANGUAGE plpgsql
AS
$$
DECLARE
    v_inscription_semestre_id VARCHAR(50);
    v_current_inscription_semestre_id INT := 1;
    v_inscription_count INT := 2; -- Adjust this number as needed
    v_random_inscription_id VARCHAR(50);
    v_random_semestre_id VARCHAR(50);
BEGIN
    FOR i IN 1..v_inscription_count LOOP
        -- Generate a unique inscription_semestre ID
        v_inscription_semestre_id := CONCAT('INS-', LPAD(v_current_inscription_semestre_id::text, 5, '0'));

        -- Select a random inscription ID from the inscriptions table
        SELECT id_inscription INTO v_random_inscription_id
        FROM inscriptions
        ORDER BY random()
        LIMIT 1;

        -- Select a random semester ID from the semestres table
        SELECT id_semestre INTO v_random_semestre_id
        FROM semestres
        ORDER BY random()
        LIMIT 1;

        -- Insert a record into the inscription_semestre table
        INSERT INTO inscription_semestre(id_inscription_semestre, id_semestre, id_inscription, session)
        VALUES (
            v_inscription_semestre_id,
            v_random_semestre_id,
            v_random_inscription_id,
            CURRENT_DATE - (random() * 365 * 5)::int -- Random session date within the last 5 years
        );

        -- Increment the inscription_semestre ID
        v_current_inscription_semestre_id := v_current_inscription_semestre_id + 1;
    END LOOP;
END;
$$;


CREATE OR REPLACE PROCEDURE generate_etudiant_test()
LANGUAGE plpgsql
AS
$$
DECLARE
    v_etudiant_test_id VARCHAR(50);
    v_current_etudiant_test_id INT := 1;
    v_random_date_examen DATE;
    v_random_note DECIMAL;
    v_etudiant RECORD;
    v_matiere RECORD;
BEGIN
    -- Boucler sur tous les étudiants
    FOR v_etudiant IN SELECT id_etudiant FROM etudiants LOOP
        -- Boucler sur toutes les matières
        FOR v_matiere IN SELECT id_matiere FROM matieres LOOP
            -- Générer une date aléatoire pour l'examen (dans les 2 dernières années)
            v_random_date_examen := CURRENT_DATE - (random() * 365 * 2)::int;

            -- Générer une note aléatoire (entre 0 et 20, arrondie à 1 décimale)
            v_random_note := ROUND((random() * 20)::numeric, 1);

            -- Générer l'ID unique pour etudiant_test
            v_etudiant_test_id := CONCAT('ET-', LPAD(v_current_etudiant_test_id::text, 5, '0'));

            -- Insérer les données dans la table etudiant_test
            INSERT INTO etudiant_test(id_etudiant_test, id_etudiant, date_examen, id_matiere, note)
            VALUES (
                v_etudiant_test_id,
                v_etudiant.id_etudiant,
                v_random_date_examen,
                v_matiere.id_matiere,
                v_random_note
            );

            -- Incrémenter l'ID de test
            v_current_etudiant_test_id := v_current_etudiant_test_id + 1;
        END LOOP;
    END LOOP;
END;
$$;

call generate_etudiant();
call generate_inscription();
call generate_inscription_semestre();
call generate_etudiant_test();
