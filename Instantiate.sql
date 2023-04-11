IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DevOpsDays')
    BEGIN
        CREATE DATABASE [DevOpsDays]  
    END