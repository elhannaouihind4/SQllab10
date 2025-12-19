USE universite_dev;


SELECT 
    i.id_inscription,
    e.nom,
    e.prenom,
    c.nom_cours,
    i.note,
    i.date_inscription,
    i.statut
INTO OUTFILE '/var/lib/mysql-files/inscriptions_complet.csv'
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM INSCRIPTION i
JOIN ETUDIANT e ON i.id_etudiant = e.id_etudiant
JOIN COURS c ON i.id_cours = c.id_cours
ORDER BY i.date_inscription DESC;