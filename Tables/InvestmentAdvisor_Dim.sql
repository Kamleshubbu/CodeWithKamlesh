USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[InvestmentAdvisor_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InvestmentAdvisor_Dim]') AND type in (N'U'))
BEGIN
		
		Print 'Creating table InvestmentAdvisor_Dim '
		
		CREATE TABLE [dbo].[InvestmentAdvisor_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[InvestmentAdvisorCode] [varchar](20) NOT NULL,
			[InvestmentAdvisorName] [varchar](200) NOT NULL,
			[CompanyIDNmb] [int] NOT NULL,
			[CreateDate] [datetime] NOT NULL ,
		 CONSTRAINT [PK_InvestmentAdvisor_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 CONSTRAINT [UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb] UNIQUE NONCLUSTERED 
		(
			[InvestmentAdvisorCode] ASC,
			[CompanyIDNmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		Print 'Created table InvestmentAdvisor_Dim Successfully'
END
Else
	Begin
		Print 'Updating table INvestmentAdvisor_dim Structure '
			
			IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_Investmentment_Advisor_Dim_CreateDate]') AND type = 'D')
			BEGIN
			ALTER TABLE [dbo].[InvestmentAdvisor_Dim] ADD  CONSTRAINT [DF_Investmentment_Advisor_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
			END

			IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' 
			AND TC.CONSTRAINT_NAME = 'UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb' AND TC.TABLE_NAME = 'InvestmentAdvisor_Dim')
			BEGIN
			ALTER TABLE InvestmentAdvisor_Dim
			ADD CONSTRAINT UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb UNIQUE (InvestmentAdvisorCode,CompanyIDNmb)
			Print 'Unique Key InvestmentAdvisorCode and CompanyIDNmb  Added'
		END
	End

GO
