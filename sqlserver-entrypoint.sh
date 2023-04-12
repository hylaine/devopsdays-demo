#!/bin/bash
# Run init-script with long timeout - and make it run in the background
#/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -l 60 -U SA -P "DevOpsDaysP4ssword!" -i /usr/src/app/Instantiate.sql
# Start SQL server
/opt/mssql/bin/sqlservr & sleep 75
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -l 60 -U SA -P "DevOpsDaysP4ssword!" -i /usr/src/app/Instantiate.sql
sleep infinity
