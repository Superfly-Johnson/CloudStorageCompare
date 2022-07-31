#!/bin/sh
# POSIX

# initdb.sh
# Script to initialize the postgresql database
# Currently only works on debian.
# Where -u means user,
# -p means password,
# -d means database.
# This script is meant to be run as the postgresql superuser.

user=
password=
database=
utest=

while getopts "u:p:d:t?" o
do
	case "$o" in
		u) user=$OPTARG;;
		p) password=$OPTARG;;
		d) database=$OPTARG;;
		t) utest="true";;
		[?]) printf "Usage: $0 -u USER -p PASSWORD -d DATABASE \n"
	esac
done
shift $((OPTIND -1))

echo $utest
echo "Creating role ${user} with password..."
psql -c "CREATE ROLE ${user} WITH LOGIN PASSWORD '${password}';"
echo "Creating database ${database} with ${user} as owner..."
psql -c "CREATE DATABASE ${database} OWNER ${user};"
echo "Executing the database initiatilization script on database ${database}..."
psql -f init.sql -d ${database}
if [ $utest ] ;
   then
	   PGUSER=$user \
			 PGHOST=localhost \
			 PGPASSWORD=$password \
			 PGDATABASE=$database \
			 PGPORT=5432 \
			 nodejs "./tests/sql.js"
	   psql -c "DROP DATABASE ${database}"
fi


