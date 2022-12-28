USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[SectionSubType_Dim]    Script Date: 7/12/2019 1:46:42 PM ******/

/****** Object:  Table [dbo].[SectionSubType_Dim]    Script Date: 7/12/2019 1:46:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SectionSubType_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table SectionSubType_Dim...'
		CREATE TABLE [dbo].[SectionSubType_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[SectionSubTypeName] [varchar](100) NOT NULL,
			[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
		 CONSTRAINT [PK_SectionSubType_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		UNIQUE NONCLUSTERED 
		(
			[SectionSubTypeName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the SectionSubType_Dim table...'
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SectionSubType_Dim' AND COLUMN_NAME = 'BeforeEBITDA')
		Begin
				Alter table SectionSubType_Dim add BeforeEBITDA int null
				Print 'Added BeforeEBITDA Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SectionSubType_Dim' AND COLUMN_NAME = 'BeforeNetIncome')
		Begin
				Alter table SectionSubType_Dim add BeforeNetIncome int null
				Print 'Added BeforeNetIncome Column'
		End

		

		
	END
GO

SET ANSI_PADDING OFF
GO


