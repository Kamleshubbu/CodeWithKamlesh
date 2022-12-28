USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[InvestmentAccount_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InvestmentAccount_Dim]') AND type in (N'U'))
BEGIN
		Print 'Creating Table InvestmentAccount_Dim'
		
		CREATE TABLE [dbo].[InvestmentAccount_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[InvestmentAccountNumber] [varchar](20) NOT NULL,
			[InvestmentAccountName] [varchar](200) NOT NULL,
			[StartDate] [date] NULL,
			[ClosedDate] [date] NULL,
			--[CustodianIdNmb] [int] NOT NULL,
			--[CalculationTypeIdNmb] [int] NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_InvestmentAccount_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 CONSTRAINT [UQ_InvestmentAccount_Dim_InvestmentAccountNumber] UNIQUE NONCLUSTERED 
		(
			[InvestmentAccountNumber] ASC
		
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
		Print 'Created Table InvestmentAccount_Dim successfully'
END
Else
	Begin
		Print 'Updating table InvestmentAccount_Dim structure'

		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_InvestmentAccount_Dim_CreateDate]') AND type = 'D')
		BEGIN
		ALTER TABLE [dbo].[InvestmentAccount_Dim] ADD  CONSTRAINT [DF_InvestmentAccount_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		
	END

GO
