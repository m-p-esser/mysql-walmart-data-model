[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fm-p-esser%2Fgithub-public-event-streaming&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

# MySQL Walmart Data Model

> 🚧 Warning
> 
> This Project is Work in Progress and subject to change


## What is this Project about

Training data modeling techniques using MySQL 

### Start MySQL from Docker container
```shell
docker run -d --name $MYSQL_CONTAINER_NAME -e MY_SQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -v $MYSQL_VOLUME
```

### Prepare CSV Files
```shell
python src/process_data.py
``` 

The IP of container changes. To find out the current IP adress, run the following Docker commands
```shell
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-name>
```

### Create Tables

```shell
mysql -h 172.17.0.2 -u root -p < scripts/create_tables.sql > logs/create_tables.log
```
### Load Data from CSV Files

```shell
mysql -h 172.17.0.2 -u root -p --local-infile=1 < scripts/ingest_data.sql > logs/ingest_data.log
```

Now log into MySQL shell to check tables
```shell
mysql -h 172.17.0.2 -u root -p
```
