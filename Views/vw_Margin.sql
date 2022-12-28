USE [Dynasty_DW]
GO
IF   EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[vw_billingFirm]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW vw_Margin
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/* 
		
			select * from vw_Margin


*/
create view [dbo].[vw_Margin]
as 
	select    BL.[CompanyName]
			, [CompanyIdNmb]
			, Com.DIVISION
			, Com.City
			, Com.[State]
			, Com.[Status]
			, Com.PreviousFirm
			, Com.RM
			, [QuarterPeriod]
			, [StartDate]
			, [EndDate]
			, [GrossRevenueAmount]
			, [TotalEBACAmount]
			, [TotalBeforeEBITDAAmount]
			, LAG(QuarterPeriod) over (partition by Companyidnmb order by startdate ASC) as PreviousQuarter
			, [EBACMARGIN]
			, [EBACMarginBenchmark]
			, LAG(EBACMARGIN) over (partition by Companyidnmb order by startdate ASC) as PreviousQuarterEBACMargin
			, [AdvisorCompMargin]
			, [AdvisorCompMarginBenchmark]
			, LAG(AdvisorCompMargin) over (partition by Companyidnmb order by startdate ASC) as PreviousQuarterAdvisorCompMargin
	  from  Dynasty_DW.dbo.vw_BillingFirm BL
			Left Join Dynasty_DW..Company_Dim COM on BL.CompanyIdNmb=Com.Idnmb
	GO			


