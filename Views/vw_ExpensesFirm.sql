USE [Dynasty_DW]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ExpensesFirm_fact]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_ExpensesFirm

GO
/* 
		
			select * from vw_ExpensesFirm

*/
/****** Object:  View [dbo].[vw_ExpensesFirm]    Script Date: 9/18/2019 7:37:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 create view [vw_ExpensesFirm]
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
				  , [SectionTypeName]
				  , [AccountNumber]
				  , [AccountName]
				  , [TotalExpensesAmount]
				  , [TotalIncomeAmount]
				  , [OperatingExpensesPct]
				  , [OperatingExpensesBenchmarkPct]
				  , [MinPct]
				  , [Maxpct]

	  from Dynasty_DW.dbo.expensesfirm_fact Expf
			Left Join Company_Dim Com on Com.idnmb=Expf.Companyidnmb
GO


