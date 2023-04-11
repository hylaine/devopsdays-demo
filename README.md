# devopsdays-raleigh

## Run the Docker Image

The docker-compose file will pull down and start a SQL Server container. From this directory, execute:

`docker-compose up`

## Check connections and spin up the DB

Once the SQL Server is running, you'll still need to create the database. Connect with the following info (also in the docker-compose file):

* username: sa
* password: DevOpsDaysP4ssword!
* server: localhost
* trust server certificate: true

Run `instantiate.sql` against the database.

## Run the Changesets

Each changelog has to be executed separately. From this directory, execute:
`./Liquibase/liquibase update --defaultsFile="liquibase.properties" --changeLogFile="devopsdayschangelog-1.json" --log-file=logs/liquibase-update.log`

Once this command is complete, you can target the next changelog:
`./Liquibase/liquibase update --defaultsFile="liquibase.properties" --changeLogFile="devopsdayschangelog-2.json" --log-file=logs/liquibase-update.log`