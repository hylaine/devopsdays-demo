USE [DevOpsDays]
GO
TRUNCATE TABLE dbo.Project
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE NAME = 'Fk_projects_client_id' AND TYPE = 'F')
	ALTER TABLE dbo.Project DROP CONSTRAINT Fk_projects_client_id;
TRUNCATE TABLE dbo.Client
GO
DROP TABLE dbo.Project
DROP TABLE dbo.Client
DROP TABLE dbo.ClientBackup