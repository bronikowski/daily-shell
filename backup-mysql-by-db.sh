#!/bin/bash

USER='root'
PASSWORD=''
BACKUP='/tmp'

databases=`mysql --user=$USER --password=$PASSWORD -e 'SHOW DATABASES;' | grep -Ev '(mysql|Database|information_schema)'`
for db in $databases; do
	echo -n "Dumping $db..."
	mysqldump --user=$USER --password=$PASSWORD $db | bzip2 > $BACKUP/$db.bz2
	echo "done"
done
