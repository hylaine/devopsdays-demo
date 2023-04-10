IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DevOpsDays')
    BEGIN
        CREATE DATABASE [DevOpsDays]  
    END
GO
USE [DevOpsDays]
GO

CREATE TABLE [DevOpsDays].[dbo].[Client] (
    [Id]                   INT           IDENTITY (1, 1) NOT NULL,
    [ClientName]           VARCHAR (100) NULL,
    [SalesforceCustomerId] INT           NULL,
    [CreatedDatetime]      DATETIME      NULL,
    [CreatedBy]            VARCHAR (50)  NULL,
    [LastUpdatedDatetime]  DATETIME      NULL,
    [LastUpdatedBy]        VARCHAR (50)  NULL,
    [DeleteFlag]           BIT           DEFAULT ((0)) NULL,
    [DeleteDatetime]       DATETIME      NULL,
    [ClientStatus]         VARCHAR (50)  NULL,
    [IndustryType]         NVARCHAR(100) NULL,
    [Market]               NVARCHAR(100) NULL
    CONSTRAINT [Pk_clients] PRIMARY KEY CLUSTERED ([Id] ASC)
);


CREATE TABLE [DevOpsDays].[dbo].[Project] (
    [Id]                    INT                                         IDENTITY (1, 1) NOT NULL,
    [ProjectName]           VARCHAR (100)                               NULL,
    [ProjectNumber]         VARCHAR (50)                                NULL,
    [ProjectDescription]    VARCHAR (5000)                              NULL,
    [ProjectStatus]         VARCHAR (40)                                NULL,
    [ProjectStatusSummary]  VARCHAR (MAX)                               NULL,
    [ProjectStartDate]      DATE                                        NULL,
    [ProjectEndDate]        DATE                                        NULL,
    [ClientId]              INT                                         NOT NULL,
    [DeleteFlag]            BIT                                         DEFAULT ((0)) NULL,
    [DeleteDatetime]        DATETIME                                    NULL,
    [ActiveFlag]            BIT                                         DEFAULT ((1)) NULL,
    [BillingType] VARCHAR(50) NULL, 
    CONSTRAINT [Pk_projects] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [Fk_projects_client_id] FOREIGN KEY ([ClientId]) REFERENCES [DevOpsDays].[dbo].[Client] ([Id])
)

DECLARE @serviceAdmin NVARCHAR = 'admin@devopsdays.com';

SET IDENTITY_INSERT [dbo].[Client] ON 
INSERT [dbo].[Client] ([Id], [ClientName], [SalesforceCustomerId],
		[CreatedDatetime], [CreatedBy], [LastUpdatedDatetime],
		[LastUpdatedBy], [DeleteFlag], [DeleteDatetime], [ClientStatus], [Market]) 
VALUES (1, N'Over the Hill Dairy', 1, GETUTCDATE(), @serviceAdmin, GETUTCDATE(), @serviceAdmin, 0, NULL, 'Active', N'Charlotte'),
		(2, N'Wawa', 2, GETUTCDATE(), @serviceAdmin, GETUTCDATE(),@serviceAdmin, 0, NULL, 'Inactive', N'Charlotte'),
		(3, N'Philadelphia Phillies', 3, GETUTCDATE(), @serviceAdmin, GETUTCDATE(), @serviceAdmin, 0, NULL, 'Pending', N'Charlotte'),
		(4, N'ACME Anvil Co.', 4, GETUTCDATE(), @serviceAdmin, GETUTCDATE(), @serviceAdmin, 0, NULL, 'Active', N'Raleigh'),
		(5, N'Glorfindel Consulting', 5, GETUTCDATE(), @serviceAdmin, GETUTCDATE(), @serviceAdmin, 0, NULL, 'Active', N'Atlanta'),
		(6, N'Worcestershire Speech Therapy Services', 6, GETUTCDATE(), @serviceAdmin, GETUTCDATE(), @serviceAdmin, 0, NULL, 'Active', N'Dallas-Fort Worth')
SET IDENTITY_INSERT [dbo].[Client] OFF

SET IDENTITY_INSERT [dbo].[Project] ON 
INSERT [dbo].[Project] ([Id], [ProjectNumber], [ProjectName],
	[ProjectDescription], [ProjectStatus], [ProjectStatusSummary], 
	[ProjectStartDate], [ProjectEndDate], [ClientId],
	[DeleteFlag],[DeleteDatetime], [ActiveFlag], [BillingType])
VALUES	(1, N'TH123', N'Ice Cream Product UI', 
            N'I am attempting to create a very long project status, long enough so that I may determine the character length needed for the test to wrap on the PDF export. By knowing how many characters there are on a single line on average, I can make a rough estimation on when I need to manually apply page breaks. This could be a potential work-around for PDFSharps shortcomings.', N'Active', N'<p>This is more of the historical text to see in a status.</p>', 
            DATEADD(month, -8, GETDATE()), DATEADD(month, -2, GETDATE()), 1, 
            0, NULL, 1, N'Time & Materials'),
		(2, N'WAWA456', N'Product Database', 
			N'Create relational database for Wawa products', N'Active', N'<p>project doing better - testing to see if project dashboard updates when in reporting status - draft mode.</p>', 
			GETDATE(), DATEADD(month, 2, GETDATE()), 2, 
			0, NULL, 1,N'Monthly'),
		(3, N'PHP789', N'Baseball Analytics', 
			N'Create system for statistical analysis', N'Closed', N'<p>Testing new Reporting Period start/end date.</p><ul><li>bullet 1</li><li>bullet 2</li></ul><ol><li>number 1</li><li>number 2</li></ol><p><s>Strikethrough testing</s></p><p><strong>Bold</strong></p><p><em>Itallic</em></p><p><span class="ql-size-large">Size</span></p>', 
			GETDATE(), DATEADD(month, 2, GETDATE()), 3, 
			0, NULL, 1,  N'Monthly'),
		(4, NULL, N'Anvil DB Migration', 
			N'Normalize DB of Anvil models and move to modern system', NULL, N'<p>Project kickoff successful.</p>', 
			DATEADD(month, -2, GETDATE()), DATEADD(month, 2, GETDATE()), 4, 
			0, NULL, 1, N'Time & Materials'),
		(5, NULL, N'Production Dashboard', 
			N'Create a dashboard.', NULL, N'<p>Project update successful.</p>',
			DATEADD(month, -2, GETDATE()), DATEADD(month, 2, GETDATE()), 5, 
			0, NULL, 1,  N'Fixed Price'),
		(6, NULL, N'Specific Pacific Overhaul', 
			N'Pacific NW region corporate infrastructure.', NULL, N'<p>Project wrap-up successful.</p>',     
			DATEADD(month, -2, GETDATE()), DATEADD(month, 2, GETDATE()), 6, 
			0, NULL, 1,  N'Monthly')		
SET IDENTITY_INSERT [dbo].[Project] OFF
