USE [Dynasty_DW]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GrowthRates_Fact]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_GrowthRates

GO
/* 
		
			select * from vw_GrowthRates

*/
/****** Object:  View [dbo].[vw_GrowthRates]    Script Date: 9/18/2019 7:37:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 create view [vw_GrowthRates]
 as
				 select		GRF.[CompanyName]
							, [Companyidnmb]
							, Com.DIVISION
							, Com.City
							, Com.[State]
							, Com.[Status]
							, Com.PreviousFirm
							, Com.RM
							, [QuarterPeriod]
							, [StartDate]
							, [EndDate]
							, [AUA Beginning of Quarter]
							, [TotalAUABeginningOfQuarterGrowthPct-QoQ]
							, [TotalAssetsAmount]
							, [TotalAssetsGrowthPct-QoQ] 
							, [GrossRevenueAmount]
							, [GrossRevenueGrowthPct-QoQ]
							, [TotalEBACAmount]
							, [TotalEBACGrowthPct-QoQ]
							, [TotalNetIncomeAmount]
							, [TotalNetIncomeGrowthPct-QoQ]
							, [TotalBeforeEBITDAAmount]
							, [TotalBeforeEBITDAGrowthPct-QoQ]
							, [TotalExpensesAmount]
							, [TotalExpensesGrowthPct-QoQ]
							, [TotalEnterpriseAmount]
							, [TotalEnterpriseGrowthPct-QoQ]
					  from Dynasty_DW.dbo.GrowthRates_Fact GRF
						Left Join Dynasty_DW..Company_Dim Com on GRF.Companyidnmb=Com.Idnmb

GO




