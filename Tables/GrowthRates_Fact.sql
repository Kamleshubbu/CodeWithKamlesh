USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[GrowthRates_Fact]    Script Date: 7/12/2019 1:42:44 PM ******/

/****** Object:  Table [dbo].[GrowthRates_Fact]    Script Date: 7/12/2019 1:42:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GrowthRates_Fact]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table GrowthRates_Fact...'
		CREATE TABLE [dbo].[GrowthRates_Fact](
			
			[CompanyName] [varchar](200) NOT NULL,
			[Companyidnmb] int not null,
			[QuarterPeriod] [varchar](20) NOT NULL,
			[StartDate] DATE NOT NULL,
			[EndDate] DATE NOT NULL,
			[TotalAssetsAmount] FLOAT NULL,
			[TotalAssetsGrowthPct-QoQ] FLOAT NULL,
			[GrossRevenueAmount] FLOAT NULL,
			[GrossRevenueGrowthPct-QoQ] FLOAT NULL,
			[TotalEBACAmount] FLOAT NULL,
			[TotalEBACGrowthPct-QoQ] FLOAT NULL,
			[TotalNetIncomeAmount] FLOAT NULL,
			[TotalNetIncomeGrowthPct-QoQ] FLOAT NULL,
			[TotalBeforeEBITDAAmount] FLOAT NULL,
			[TotalBeforeEBITDAGrowthPct-QoQ] FLOAT NULL,
			[TotalExpensesAmount] FLOAT NULL,
			[TotalExpensesGrowthPct-QoQ] FLOAT NULL,
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_GrowthRates_Fact_CreateDate] DEFAULT getdate(),
		 CONSTRAINT [PK_GrowthRates_Fact] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY])
		

	END
ELSE
	BEGIN
		print 'Updating the structure of the GrowthRates_Fact table...'

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GrowthRates_Fact' AND COLUMN_NAME = 'TotalEnterpriseAmount')
				Begin
						Alter table GrowthRates_Fact add TotalEnterpriseAmount FLOAT null
						Print 'Added TotalEnterpriseAmount Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GrowthRates_Fact' AND COLUMN_NAME = 'TotalEnterpriseGrowthPct-QoQ')
				Begin
						Alter table GrowthRates_Fact add [TotalEnterpriseGrowthPct-QoQ] FLOAT null
						Print 'Added TotalEnterpriseGrowthPct-QoQ Column'
				End


				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GrowthRates_Fact' AND COLUMN_NAME = 'AUA Beginning of Quarter')
				Begin
						Alter table GrowthRates_Fact add [AUA Beginning of Quarter] FLOAT null
						Print 'Added [AUA Beginning of Quarter] Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'GrowthRates_Fact' AND COLUMN_NAME = 'TotalAUABeginningOfQuarterGrowthPct-QoQ')
				Begin
						Alter table GrowthRates_Fact add [TotalAUABeginningOfQuarterGrowthPct-QoQ] FLOAT null
						Print 'Added TotalAUABeginningOfQuarterGrowthPct-QoQ Column'
				End

	END
GO

SET ANSI_PADDING OFF
GO


