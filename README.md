# MySQL Walmart Sample Database

## What is this Project about

Training data modeling techniques using MySQL 

## Load Data from 
IP of container changes

mysql -h 172.17.0.2 -u root -p --local-infile=1 < scripts/ingest_data.sql > logs/ingest_data.log
mysql -h 172.17.0.2 -u root -p < scripts/create_tables.sql > logs/create_tables.log
mysql -h 172.17.0.2 -u root -p