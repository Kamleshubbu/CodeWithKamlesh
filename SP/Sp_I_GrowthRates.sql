USE [Dynasty_DW]
GO

/****** Object:  StoredProcedure [dbo].[Sp_I_GrowthRates]    Script Date: 9/19/2019 8:07:59 PM ******/
DROP PROCEDURE [dbo].[Sp_I_GrowthRates]
GO

/****** Object:  StoredProcedure [dbo].[Sp_I_GrowthRates]    Script Date: 9/19/2019 8:07:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_I_GrowthRates]
as
/*

			Exec Sp_I_GrowthRates


*/
Begin
			
			
			Truncate table Dynasty_DW.dbo.GrowthRates_Fact
		
---===============================================================================================================================================

		--			Notes: Formula for Calculation of Percentage Columns are :  " (PresentQuarterAmount - PreviousQuarteramount) *100 /  PreviousQuarteramount  "
		--				   And this is done for Few Columns and New Columns Can be added to calculate for Yearly basis as well 		 

----==============================================================================================================================================
			
			Insert into Dynasty_DW.dbo.GrowthRates_Fact
			(
					CompanyName
					,Companyidnmb
					,QuarterPeriod
					,StartDate
					,EndDate
					,TotalAssetsAmount
					,[TotalAssetsGrowthPct-QoQ]
					,GrossRevenueAmount
					,[GrossRevenueGrowthPct-QoQ]
					,TotalEBACAmount
					,[TotalEBACGrowthPct-QoQ]
					,TotalNetIncomeAmount
					,[TotalNetIncomeGrowthPct-QoQ]
					,TotalBeforeEBITDAAmount
					,[TotalBeforeEBITDAGrowthPct-QoQ]
					,TotalExpensesAmount
					,[TotalExpensesGrowthPct-QoQ]
					,TotalEnterpriseAmount
					,[TotalEnterpriseGrowthPct-QoQ]
					,[AUA Beginning of Quarter]
					,[TotalAUABeginningOfQuarterGrowthPct-QoQ]
			)
			
				SELECT 
					X.companyName,
					X.COMPANYIDNMB
					, X.QuarterPeriod
					, X.STARTDATE
					, X.Enddate
					, X.TotalAssetsAmount
					--, X.LastQuarterTotalAssetsAmount
					, (TotalAssetsAmount - LastQuarterTotalAssetsAmount ) /NULLIF(LastQuarterTotalAssetsAmount,0) AS 'TotalAssetsGrowthPct-QoQ'
					, X.GrossRevenueamount
					--, X.LastQuarterGrossRevenueamount
					, (GrossRevenueamount - LastQuarterGrossRevenueamount ) /NULLIF(LastQuarterGrossRevenueamount,0) AS 'GrossRevenueGrowthPct-QoQ'
					, X.TotalEbacAmount
					--, X.LastQuarterTotalEbacamount
					, (TotalEbacamount - LastQuarterTotalEbacamount ) /NULLIF(LastQuarterTotalEbacamount,0) AS 'TotalEBACGrowthPct-QoQ' 
					, X.TotalNetIncomeAmount
					--, X.LastQuarterTotalNetIncomeAmount
					, (TotalNetIncomeAmount - LastQuarterTotalNetIncomeAmount ) /NULLIF(LastQuarterTotalNetIncomeAmount,0) AS 'TotalNetIncomeGrowthPct-QoQ'
					, X.TotalBeforeEBITDAAmount
					--, X.LastQuarterTotalBeforeEBITDAAmount
					, (TotalBeforeEBITDAAmount - LastQuarterTotalBeforeEBITDAAmount ) /NULLIF(LastQuarterTotalBeforeEBITDAAmount,0) AS 'TotalBeforeEBITDAGrowthPct-QoQ'
					, X.TotalExpensesAmount
					, (TotalExpensesAmount - LastQuarterTotalExpensesAmount ) / NULLif(LastQuarterTotalExpensesAmount,0) as 'TotalExpensesGrowthPct-QoQ'
				--	,GETDATE()
					, X.EnterpriseAmount
					, (EnterpriseAmount - LastQuarterTotalEnterpriseAmount ) / NULLif(LastQuarterTotalEnterpriseAmount,0) as 'TotalEnterpriseGrowthPct-QoQ'
					, X.[AUA Beginning of Quarter]
					, ([AUA Beginning of Quarter]- LastQuarterAUABeginningOfQuarter ) / NULLif(LastQuarterAUABeginningOfQuarter,0) as 'TotalAUABeginningOfQuarterGrowthPct-QoQ'
		    
				FROM(
							SELECT 
									  Companyname
									, COMPANYIDNMB
									, QuarterPeriod
									, Startdate
									, Enddate
									, null as TotalAssetsAmount
									, null as LastQuarterTotalAssetsAmount
									, GrossRevenueamount
									, LAG(GrossRevenueamount) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterGrossRevenueamount
									, TotalEbacamount
									, LAG(TotalEbacamount) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterTotalEbacamount
									, TotalNetIncomeAmount
									, LAG(TotalNetIncomeAmount) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterTotalNetIncomeAmount
									, TotalBeforeEBITDAAmount
									, LAG(TotalBeforeEBITDAAmount) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterTotalBeforeEBITDAAmount
									, TotalExpensesAmount
									, LAG(TotalExpensesAmount) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterTotalExpensesAmount
									, EnterpriseAmount
									, LAG(EnterpriseAmount) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterTotalEnterpriseAmount
									, [AUA Beginning of Quarter]
									, LAG([AUA Beginning of Quarter]) OVER (PARTITION BY COMPANYIDNMB  ORDER BY STARTDATE ASC) AS LastQuarterAUABeginningOfQuarter

								from vw_BillingFirm 
				
					)  X 


				

End


GO


