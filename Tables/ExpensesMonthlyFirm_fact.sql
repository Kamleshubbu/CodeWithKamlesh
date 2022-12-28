USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[ExpensesMonthlyFirm_fact]    Script Date: 7/12/2019 1:42:44 PM ******/

/****** Object:  Table [dbo].[ExpensesMonthlyFirm_fact]    Script Date: 7/12/2019 1:42:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ExpensesMonthlyFirm_fact]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table ExpensesMonthlyFirm_fact...'
		CREATE TABLE [dbo].[ExpensesMonthlyFirm_fact](
			
			[Companyname] [varchar](200) NOT NULL,
			[CompanyBillingName] [varchar](200) NOT NULL,
			[Companyidnmb] int not null,
			[QuarterPeriod] [varchar](20) NOT NULL,
			[MonthStartDate]		Datetime null,
			[MonthEndDate]			Datetime null,
			[SectionTypeName] [varchar](200) NOT NULL,
			[AccountNumber] [varchar](250) NULL,
			[AccountName] [varchar](200)  NULL,
			[TotalExpensesAmount] FLOAT NULL,
			[TotalIncomeAmount] FLOAT NULL,
			[OperatingExpensesPct] FLOAT NULL,
			[OperatingExpensesBenchmarkPct] FLOAT NULL,
			[MinPct] FLOAT NULL,
			[MaxPct] FLOAT NULL,
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[CreateDate] [datetime]  CONSTRAINT "DF_ExpensesMonthlyFirm_fact_CreateDate" DEFAULT (getdate()) NOT NULL,
		 CONSTRAINT [PK_ExpensesMonthlyFirm_fact] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY])
		

	END
ELSE
	BEGIN
		print 'Updating the structure of the ExpensesMonthlyFirm_fact table...'


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ExpensesMonthlyFirm_fact' AND COLUMN_NAME = 'PeriodTypeIdnmb')
				Begin
						Alter table ExpensesMonthlyFirm_fact add PeriodTypeIdnmb INT null
						Print 'Added PeriodTypeIdnmb Column'
				End

	END
GO

SET ANSI_PADDING OFF
GO


