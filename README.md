# devopsdays-raleigh

# Prerequisites
You'll want to install:

* A SQL Server browser GUI. We suggest Azure Data Studio, but SSMS works too.
* Docker. This was tested with v4.17.0

## Run the Docker Image

The docker-compose file will pull down and start a SQL Server container, along with the Liquibase container that includes the Liquibase runtime and its dependencies. From repo's root directory, execute:

`docker-compose up`

## Check connections and spin up the DB

Once the SQL Server is running, you will connect with the following info (also in the docker-compose file):

* username: sa
* password: DevOpsDaysP4ssword!
* server: localhost,1433
* trust server certificate: true

The DB Server should already have an initial DB, DevOpsDays, created via the Dockerfile => `sqlserver-entrypoint.sh` => `Instantiate.sql`. If it doesn't, run the script manually against the server.

## Run the Parent Changelog

A parent/master changelog (specified in liquibase.properties) will run child changelogs in the folder, `changelog/changelogs` in alphabetical order. The `liquibase.properties` file indicates which parent changelog file is being used, and we specify the properties file that the docker container is using. (Notice the volume mount part of the command!)

From this directory, execute:

For Linux:
`docker run --rm --net="host" -v ./changelog:/liquibase/changelog liquibase/liquibase --defaults-file=/liquibase/changelog/liquibase.properties update`

For Windows:
`docker run --rm --net="host" -v ${PWD}/changelog:/liquibase/changelog liquibase/liquibase --defaults-file=/liquibase/changelog/liquibase.properties update`

## Add another changelog

You can create your own custom changelog to experiment, but you can also use the examples provided of well-formed and ill-formed changelogs. 

Add these to the changelog folder and test the liquibase update command, the same as before for your OS.

## Push to GitHub and create a pull request
'git add .' -> 'git commit –m “demo”' -> 'git push –u origin my-branch-name'
Create the PR to merge into master and watch the validation flow in the “Actions” tab of the GitHub repository


# Something went wrong....
No worries. We've included a basic script to delete most of the tables (`Droptables.sql`) in the database, including the meta-tables for Liquibase. You can execute that against the database and try again to execute the changelogs.

## Known Issues and Caveats

* Upon compose, “Co-Initialize Security Failure”
    * This is a known bug with certain versions of Windows, WSL, and Docker https://github.com/microsoft/mssql-docker/issues/804
    * The most common solution is to downgrade to WSL1.03
        * `$Package = Get-AppxPackage MicrosoftCorporationII.WindowsSubsystemforLinux -AllUsers`
    	* `Remove-AppxPackage $Package -AllUsers`
    	* `Add-AppxPackage .\Microsoft.WSL_1.0.3.0_x64_ARM64.msixbundle`

* On Macs with M1 Silcon, various errors executing docker-compose
    * Check to make sure `docker-compose` is specifying `platform: linux/amd64` for the service
    * Ensure that you’ve enabled buildkit in advanced docker options if you’re using an older version
    * Ensure `Use Rosetta for x86/amd64 emulation on Apple Silicon` is checked
