USE [Dynasty_DW]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ExpensesMonthlyFirm_fact]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_ExpensesYTDFirm

GO
/* 
		
			select * from vw_ExpensesYTDFirm

*/
/****** Object:  View [dbo].[vw_ExpensesYTDFirm]    Script Date: 9/18/2019 7:37:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 create view [vw_ExpensesYTDFirm]
 as
		 select     Expf.[Companyname]
				  , Expf.[CompanyBillingName]
				  , Expf.[Companyidnmb]
				  , Com.DIVISION
				  , Com.City
				  , Com.[State]
				  , Com.[Status]
				  , Com.PreviousFirm
				  , Com.RM
				  , [QuarterPeriod]
				  , MonthStartDate
				  , MonthEnddate
				  , [SectionTypeName]
				  , [AccountNumber]
				  , [AccountName]
				  , [TotalExpensesAmount]
				  , [TotalIncomeAmount]
				  , [OperatingExpensesPct]
				  , [OperatingExpensesBenchmarkPct]
				  , [MinPct]
				  , [Maxpct]
				  , PeriodTypeName
				  

	  from Dynasty_DW.dbo.ExpensesMonthlyFirm_fact Expf
			Left Join Company_Dim Com on Com.idnmb=Expf.Companyidnmb
			Left join PeriodType_Dim PT on Pt.Idnmb=Expf.PeriodTypeIdnmb
	  Where PeriodTypeName='YTD'
GO


