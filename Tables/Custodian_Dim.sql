USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[Custodian_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Custodian_Dim]') AND type in (N'U'))
BEGIN
		PRINT 'Creating table Custodian_Dim table'
		
		CREATE TABLE [dbo].[Custodian_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[CustodianName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_Custodian_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		  CONSTRAINT [UQ_Custodian_Dim_CustodianName] UNIQUE NONCLUSTERED 
		(
			[CustodianName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
		PRINT 'Created table Custodian_Dim table Successfully'
END
Else
	Begin
		print 'Updating table Custodian_Dim structure'
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_Custodian_Dim_CreateDate]') AND type = 'D')
		BEGIN
			ALTER TABLE [dbo].[Custodian_Dim] ADD  CONSTRAINT [DF_Custodian_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		
		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' AND TC.CONSTRAINT_NAME = 'UQ_Custodian_Dim_CustodianName' AND TC.TABLE_NAME = 'Custodian_Dim')
		BEGIN
			ALTER TABLE Custodian_Dim
			ADD CONSTRAINT UQ_Custodian_Dim_CustodianName UNIQUE (CustodianName)
			Print 'Unique Key CustodianName  Added'
		END
	END
GO
