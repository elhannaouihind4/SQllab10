USE universite_dev;

-- Table ETUDIANT
CREATE TABLE ETUDIANT (
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_inscription DATE DEFAULT (CURRENT_DATE),
    promotion VARCHAR(20)
);

-- Table COURS
CREATE TABLE COURS (
    id_cours INT PRIMARY KEY AUTO_INCREMENT,
    nom_cours VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    departement VARCHAR(50)
);

-- Table INSCRIPTION
CREATE TABLE INSCRIPTION (
    id_inscription INT PRIMARY KEY AUTO_INCREMENT,
    id_etudiant INT,
    id_cours INT,
    date_inscription DATE DEFAULT (CURRENT_DATE),
    note DECIMAL(4,2),
    statut ENUM('actif', 'termine', 'abandon') DEFAULT 'actif',
    FOREIGN KEY (id_etudiant) REFERENCES ETUDIANT(id_etudiant) ON DELETE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES COURS(id_cours) ON DELETE CASCADE
);

-- Insertion des étudiants
INSERT INTO ETUDIANT (nom, prenom, email, promotion) VALUES
('Dupont', 'Jean', 'jean.dupont@email.com', '2025'),
('Martin', 'Marie', 'marie.martin@email.com', '2024'),
('Bernard', 'Pierre', 'pierre.bernard@email.com', '2025'),
('Dubois', 'Sophie', 'sophie.dubois@email.com', '2024'),
('Lefevre', 'Thomas', 'thomas.lefevre@email.com', '2025');

-- Insertion des cours
INSERT INTO COURS (nom_cours, credits, departement) VALUES
('Mathématiques Avancées', 5, 'Sciences'),
('Base de Données', 6, 'Informatique'),
('Physique Quantique', 4, 'Physique'),
('Algorithmique', 5, 'Informatique'),
('Statistiques', 4, 'Mathématiques');

-- Insertion des inscriptions
INSERT INTO INSCRIPTION (id_etudiant, id_cours, note, date_inscription) VALUES
(1, 1, 15.5, '2025-01-15'),
(1, 2, 18.0, '2025-01-16'),
(2, 1, 12.5, '2025-01-10'),
(3, 3, 16.5, '2025-02-01'),
(4, 2, 14.0, '2025-01-20'),
(5, 4, 17.5, '2025-02-05'),
(2, 3, 13.0, '2025-02-10');

-- Création d'une vue
CREATE VIEW vue_notes_moyennes AS
SELECT e.nom, e.prenom, AVG(i.note) as moyenne
FROM ETUDIANT e
JOIN INSCRIPTION i ON e.id_etudiant = i.id_etudiant
GROUP BY e.id_etudiant;

-- Création d'un trigger
DELIMITER $$
CREATE TRIGGER before_insert_etudiant
BEFORE INSERT ON ETUDIANT
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email invalide';
    END IF;
END$$
DELIMITER ;

-- Vérification
SELECT 'ETUDIANT' as TableName, COUNT(*) as Count FROM ETUDIANT
UNION ALL
SELECT 'COURS', COUNT(*) FROM COURS
UNION ALL
SELECT 'INSCRIPTION', COUNT(*) FROM INSCRIPTION;