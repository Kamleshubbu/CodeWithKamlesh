USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[ExpensesFirm_Fact]    Script Date: 7/12/2019 1:42:44 PM ******/

/****** Object:  Table [dbo].[ExpensesFirm_Fact]    Script Date: 7/12/2019 1:42:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ExpensesFirm_Fact]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table ExpensesFirm_Fact...'
		CREATE TABLE [dbo].[ExpensesFirm_Fact](
			
			[Companyname] [varchar](200) NOT NULL,
			[CompanyBillingName] [varchar](200) NOT NULL,
			[Companyidnmb] int not null,
			[QuarterPeriod] [varchar](20) NOT NULL,
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
			[CreateDate] [datetime]  CONSTRAINT "DF_ExpensesFirm_fact_CreateDate" DEFAULT (getdate()) NOT NULL,
		 CONSTRAINT [PK_ExpensesFirm_Fact] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY])
		

	END
ELSE
	BEGIN
		print 'Updating the structure of the ExpensesFirm_Fact table...'

	END
GO

SET ANSI_PADDING OFF
GO


