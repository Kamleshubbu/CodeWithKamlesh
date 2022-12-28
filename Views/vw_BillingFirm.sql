USE Dynasty_DW
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[billingfirm_fact]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_billingfirm

GO
/* 
		
			select * from vw_BillingFirm


*/
create view [dbo].[vw_BillingFirm]
as 
	select BL.[CompanyName]
      ,[CompanyIdNmb]
      ,[QuarterPeriod]
	  ,[StartDate]
      ,[EndDate]
	  ,[AUA Beginning of Quarter]
	  ,[AUA End of Quarter]
      ,[AdvisoryAssetsAmount]
	  ,[ReportingAssetsAmount]
      ,[TotalAssetsAmount]
      ,[AverageAssetsAmount]
      ,[RevenueAmount]
      ,[ICRevenueAmount]
      ,[AdvisoryRevenueAmount]
      ,[BrokerageRevenueAmount]
      ,[OtherRevenueAmount]
      ,[GrossRevenueAmount]
      ,[RecuringRevenuePct]
      ,[TotalCostOfServiceAmount]
      ,[TotalExpensesAmount]
      ,[TotalBeforeEBITDAAmount]
      ,[TotalBeforeNetIncomeAmount]
      ,[TotalEBACAmount]
      ,[TotalEBITDAAmount]
      ,[FirmValueAmount]
      ,[TotalNetIncomeAmount]
	  ,[TotalEBACAmount]/ nullif([GrossRevenueAmount],0) as EBACMARGIN       ---- GrossRevenueAmount is actually TotalIncome
	  , 0.60 as EBACMarginBenchmark
	  ,[TotalBeforeEBITDAAmount]/ nullif([GrossRevenueAmount],0) as AdvisorCompMargin
	  , 0.40 as AdvisorCompMarginBenchmark
	  ,([AdvisoryRevenueAmount]/ nullif([advisoryassetsamount],0))*4*10000 as ROA
	  , 82 as ROABENCHMARK
	  , [EBACTTM]
	  ,	[TotalBeforeEBITDAAmountTTM]
	  ,	[GrossRevenueAmountTTM]
	  , [TotalExpensesAmountTTM]
	  , [EBACYTD]
	  , [TotalBeforeEBITDAAmountYTD]
	  , [GrossRevenueAmountYTD]
	  , [TotalExpensesAmountYTD]
	  , (([TotalEBACAmount]*4) - (GrossRevenueAmount*4*0.35)) * 7 as EnterpriseAmount
	  , COM.DIVISION
	  , Com.City
	  , Com.[State]
	  , Com.[Status]
	  , Com.PreviousFirm
	  , Com.RM
	  , Bl.EnterpriseAmountTTM
	  from  Dynasty_DW.dbo.billingfirm_fact BL
		Left JOin Dynasty_DW..Company_Dim COM on COM.Idnmb=BL.CompanyIdNmb
	GO			


