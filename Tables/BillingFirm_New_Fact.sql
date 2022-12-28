USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[BillingFirm_New_Fact]    Script Date: 8/27/2019 6:57:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingFirm_New_Fact]') AND type in (N'U'))
BEGIN
			PRINT 'Creating table BillingFirm_New_Fact...'
			CREATE TABLE [dbo].[BillingFirm_New_Fact](
				[CompanyName] [varchar](200) NOT NULL,
				[CompanyIdNmb] [int] NOT NULL,
				[QuarterPeriod] [varchar](20) NOT NULL,
				[StartDate] [date] NOT NULL,
				[EndDate] [date] NOT NULL,
				[Year]	  [INT] NOT NULL,
				[Month]	  [varchar](50) NOT NULL,
				[AUA Beginning of Quarter] [float] NULL,
				[AUA End of Quarter] [float] NULL,
				[AdvisoryAssetsAmount] [float] NULL,
				[ReportingAssetsAmount] [float] NULL,
				[TotalAssetsAmount] [float] NULL,
				[AverageAssetsAmount] [float] NULL,
				[RevenueAmount] [float] NULL,
				[ICRevenueAmount] [float] NULL,
				[AdvisoryRevenueAmount] [float] NULL,
				[BrokerageRevenueAmount] [float] NULL,
				[OtherRevenueAmount] [float] NULL,
				[GrossRevenueAmount] [float] NULL,
				[RecuringRevenuePct] [float] NULL,
				[TotalCostOfServiceAmount] [float] NULL,
				[TotalExpensesAmount] [float] NULL,
				[TotalBeforeEBITDAAmount] [float] NULL,
				[TotalBeforeNetIncomeAmount] [float] NULL,
				[TotalEBACAmount] [float] NULL,
				[TotalEBITDAAmount] [float] NULL,
				[FirmValueAmount] [float] NULL,
				[TotalNetIncomeAmount] [float] NULL,
				[EBACTTM] [FLOAT] NULL,
				[TotalBeforeEBITDAAmountTTM] [FLOAT] NULL,
				[GrossRevenueAmountTTM] [FLOAT] NULL,
				[TotalExpensesAmountTTM] [FLOAT] NULL,
				[CreateDate] [datetime]  CONSTRAINT [DF_BillingFirm_New_Fact_CREATEDATE] DEFAULT(GETDATE()) NOT NULL,
				
				[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			 CONSTRAINT [PK_BillingFirm_New_Fact] PRIMARY KEY CLUSTERED 
			(
				[Idnmb] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY]
PRINT 'Created table BillingFirm_New_Fact successfully...'
END
ELSE 
	BEGIN
				PRINT 'Updating Structure of BillingFirm_New_Fact...'

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'EBACTTM')
				Begin
						Alter table BillingFirm_New_Fact add EBACTTM FLOAT null
						Print 'Added EBACTTM Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'TotalBeforeEBITDAAmountTTM')
				Begin
						Alter table BillingFirm_New_Fact add TotalBeforeEBITDAAmountTTM FLOAT null
						Print 'Added TotalBeforeEBITDAAmountTTM Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'GrossRevenueAmountTTM')
				Begin
						Alter table BillingFirm_New_Fact add GrossRevenueAmountTTM FLOAT null
						Print 'Added GrossRevenueAmountTTM Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'TotalExpensesAmountTTM')
				Begin
						Alter table BillingFirm_New_Fact add TotalExpensesAmountTTM FLOAT null
						Print 'Added TotalExpensesAmountTTM Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'EBACYTD')
				Begin
						Alter table BillingFirm_New_Fact add EBACYTD FLOAT null
						Print 'Added EBACYTD Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'TotalBeforeEBITDAAmountYTD')
				Begin
						Alter table BillingFirm_New_Fact add TotalBeforeEBITDAAmountYTD FLOAT null
						Print 'Added TotalBeforeEBITDAAmountYTD Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'GrossRevenueAmountYTD')
				Begin
						Alter table BillingFirm_New_Fact add GrossRevenueAmountYTD FLOAT null
						Print 'Added GrossRevenueAmountYTD Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'TotalExpensesAmountYTD')
				Begin
						Alter table BillingFirm_New_Fact add TotalExpensesAmountYTD FLOAT null
						Print 'Added TotalExpensesAmountYTD Column'
				End

				IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingFirm_New_Fact' AND COLUMN_NAME = 'EnterpriseAmountTTM')
				Begin
						Alter table BillingFirm_New_Fact add EnterpriseAmountTTM FLOAT null
						Print 'Added EnterpriseAmountTTM Column'
				End


	END