USE [Dynasty_DW]
GO


/****** Object:  Table [dbo].[GeneralLedger_Fact]    Script Date: 7/12/2019 1:45:10 PM ******/


/****** Object:  Table [dbo].[GeneralLedger_Fact]    Script Date: 7/12/2019 1:45:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GeneralLedger_Fact]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table GeneralLedger_Fact...'

		CREATE TABLE [dbo].[GeneralLedger_Fact](
			[DateIdNmb] [int] NOT NULL,
			[AccountIdNmb] [int] NOT NULL,
			[Amount] [float] NOT NULL,
			[CompanyIdNmb] [int] NOT NULL,
			[SubCompanyIdNmb] [int] NOT NULL,
			[VendorIDNmb] [int] NULL,
			[AdvisorIDNmb] [int] NULL,
			[ClassIDNmb] [int] NULL,
			[CreateDate] [datetime] NOT NULL ,
			[Idnmb] [int] IDENTITY(1,1) NOT NULL
			
			
		 CONSTRAINT [PK_GeneralLedger_Fact] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY] 
	END
ELSE
	BEGIN
		print 'Updating the structure of the GeneralLedger_Fact table...'

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GeneralLedger_Fact' AND COLUMN_NAME = 'CreateDate')
		Begin
				ALTER TABLE [dbo].[GeneralLedger_Fact] ADD  DEFAULT (getdate()) FOR [CreateDate]
				Print 'Added Default  Constraint'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GeneralLedger_Fact' AND COLUMN_NAME = 'Document')
		Begin
				ALTER TABLE [dbo].[GeneralLedger_Fact] ADD  Document text null
				Print 'Added Document  Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GeneralLedger_Fact' AND COLUMN_NAME = 'TransactionNmb')
		Begin
				ALTER TABLE [dbo].[GeneralLedger_Fact] ADD  TransactionNmb int null
				Print 'Added TransactionNmb  Column'
		End


	END

GO



