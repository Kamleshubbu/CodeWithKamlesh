USE [Dynasty_DW]
GO



/****** Object:  Table [dbo].[Account_Dim]    Script Date: 7/12/2019 1:41:13 PM ******/

/****** Object:  Table [dbo].[Account_Dim]    Script Date: 7/12/2019 1:41:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Account_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table Account_Dim...'
		CREATE TABLE [dbo].[Account_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[AccountNumber] [varchar](20) NOT NULL,
			[AccountName] [varchar](200) NOT NULL,
			[ReportTypeIDNmb] [int] NOT NULL,
			[ClosesInto] [int] NULL DEFAULT ((340000)),
			[SectionTypeIDNmb] [int] NULL,
			[SectionSubTypeIDNmb] [int] NOT NULL,
			[TransactionType] [varchar](10) NULL,
			[Type1] [varchar](100) NULL,
			[AdvisorFlag] [bit] NULL DEFAULT ((1)),
			[LocationFlag] [bit] NULL DEFAULT ((1)),
			[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
		 CONSTRAINT [PK_Account_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		UNIQUE NONCLUSTERED 
		(
			[AccountNumber] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the Account_Dim table...'

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Account_Dim' AND COLUMN_NAME = 'SubSubTypeIdnmb')
		Begin
				Alter table Account_Dim add SubSubTypeIdnmb int null
				Print 'Added SubSubTypeIdnmb Column'
		End


	END
GO

SET ANSI_PADDING OFF
GO

