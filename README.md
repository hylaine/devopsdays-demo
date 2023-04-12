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

Run `instantiate.sql` against the DB server to create the initial DB, required for Liquibase to target it.

## Run the Parent Changelog

A parent/master changelog (specified in liquibase.properties) will run child changelogs in the folder, `changelogs` in alphabetical order. From this directory, execute:
`./Liquibase/liquibase update --defaultsFile="liquibase.properties" --log-file=logs/liquibase-update.log`

If you have just one changelog in this folder, it will execute.

## Add another changelog

You can create your own custom changelog to experiment, but you can also use the examples provided of well-formed and ill-formed changelogs. 

Add these to the changelog folder and test the liquibase update command, the same as before.

## Something went wrong....
No worries. We've included a basic script to delete most of the tables in the database, including the meta-tables for Liquibase. You can execute that and try again.