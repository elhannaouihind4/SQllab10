#!/bin/bash
# Dump complet
mysqldump -u root -p"$MYSQL_PWD" --single-transaction universite_dev > dump.sql
# Import en prod
mysql -u root -p"$MYSQL_PWD" universite_prod < dump.sql
# Sauvegarde CSV des inscriptions
mysql -u root -p"$MYSQL_PWD" -e "
  SELECT * INTO OUTFILE '/tmp/ins.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' FROM universite_dev.INSCRIPTION;
"
echo "Migration et export CSV terminés."