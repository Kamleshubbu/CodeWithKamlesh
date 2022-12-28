USE Dynasty_DW
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Household_Dim]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_BillingAssets

GO
/* 
		
			select * from vw_BillingAssets

*/
CREATE VIEW vw_BillingAssets
AS
	
	select  Dynasty_DW.dbo.udf_GetDateFromID(BL.InvestedDateIdNmb) AS 'InvestedDate' 
			, INVACC.InvestmentAccountNumber
			, INVACC.InvestmentAccountName
			, COM.CompanyName
			, COM.BillingName as 'CompanyBillingName'
			, HOUSE.HouseholdName
			, INVADV.InvestmentAdvisorCode
			, INVADV.InvestmentAdvisorName
			, CUST.CustodianName
			, MANG.ManagerName
			, PROD.ProductTypeName
			, TYP.BillTypeName
			, CALC.CalculationTypeName
			, BL.BillableDays
			, BL.PeriodDays
			, CAST(DATEPART(YYYY,cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodStartDateIdNmb)), 0) as date)) AS char(4)) +' '+ 'Q' + CAST(DATEPART(QUARTER,cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodStartDateIdNmb)), 0) as date)) AS char(1)) as 'QuarterPeriod'	
			, Dynasty_DW.dbo.udf_GetDateFromID(BL.AsOfDateIdNmb) AS 'AsOfDate' 
			, Dynasty_DW.dbo.udf_GetDateFromID(BL.PeriodStartDateIdNmb) AS 'PeriodStartDate' 
			, Dynasty_DW.dbo.udf_GetDateFromID(BL.PeriodEndDateIdNmb) AS 'PeriodEndDate' 
			, INVACC2.InvestmentAccountNumber AS 'DebitedAccount'
			, BL.BillableAmount
			, BL.BillableHouseholdAmount
			, BL.ClientFeeAmount
			, BL.ClientFeePct
			, BL.AdvisorfeeAmount
			, BL.AdvisorFeePct
			, BL.ProgramfeeAmount
			, BL.Programfeepct
			, BL.ManagerFeeAmount
			, BL.ManagerFeePct
			, BL.FirmFeeAmount
			, BL.FirmFeePct
			, BL.BillingPeriod
			, BL.BillingDate
			, BL.BillingRun
			, BL.[Timestamp]
			, COM.Idnmb AS 'CompanyIdNmb'
			, COM.GLFLG AS 'GLFlg'
			, BSOURCE.BillingSourceName
			, BL.BillingGroupName
			, BL.BranchName
			, BL.CustomerRepCode
			, BL.AdvisorNum
			, BL.Product
			, BL.ProductTier
			, BL.AccounttotalAmount
			, BL.CustodyFeeAmount
			, BL.CustodyFeePct
			, BL.GroupAccounts
			, BL.BillingLevel
			, BL.FCDAFDistribute
			, BL.BillingMode
			, BL.AdvisorFeeExcludedAmount
			, BL.ClientFeeExcludedAmount
			, BL.FirmHouseholdAmount
			, BL.SponsorHouseholdAmount
			, BL.ManagerHouseholdAmount
			, BL.CustodyHouseholdAmount
			, BL.AdvisorHouseholdAmount
			, BL.ClientHouseholdAmount
			, BL.BillingHistory
			, BL.AccountId
			, BL.AccountDescription
			, BL.CustomerRepCodeDesc
			, BL.CustomServiceFeeAmount
			, BL.CustomServiceFeePct
			, BL.CustomServiceDistributeFeeAmount
			, BL.CustomServiceDistributeFeePct
			, BL.DerivedComponent
			, BL.BatchName
			, BL.PlatformFee
			, BL.PlatformFeePct
			, BL.SponsorFee
			, BL.SponsorFeePct
			, BL.ProductGroup
			, BL.AdvisoryRevenue
			, BL.COSAdvisory
			, BL.COSTAMP
			, Com.DIVISION
			, Com.City
			, Com.[State]
			, Com.[Status]
			, Com.PreviousFirm
			, Com.RM
			, PGRP.PRoductGroupName
			, AST.AssetTypeName
			, SRT.StrategyName
		FROM BillingAssets_Fact BL 
					
					INNER JOIN Dynasty_DW.dbo.Company_Dim COM ON BL.CompanyIdNmb=COM.Idnmb
					INNER JOIN Dynasty_DW.DBO.BillingSource_Dim BSOURCE ON BSOURCE.Idnmb=BL.BillingSourceIdNmb
					LEFT JOIN Dynasty_DW.DBO.Custodian_Dim CUST ON BL.CustodianIdNmb=CUST.Idnmb
					LEFT JOIN Dynasty_DW.DBO.InvestmentAccount_Dim INVACC ON BL.InvestmentAccountIdNmb=INVACC.IDNMB
					LEFT JOIN Dynasty_DW.DBO.InvestmentAccount_Dim INVACC2 ON BL.DebitedAccount=INVACC2.Idnmb
					LEFT JOIN Dynasty_DW.DBO.Household_Dim HOUSE ON BL.HouseholdIdNmb=HOUSE.idnmb AND HOUSE.CompanyIDNmb=COM.Idnmb
					LEFT JOIN Dynasty_DW.DBO.InvestmentAdvisor_Dim INVADV ON BL.InvestmentAdvisorIdNmb=INVADV.IDNMB AND INVADV.CompanyIDNmb=COM.Idnmb 
					LEFT JOIN Dynasty_DW.DBO.Manager_Dim MANG ON BL.ManagerIDNmb=MANG.Idnmb
					LEFT JOIN Dynasty_DW.DBO.ProductType_Dim PROD ON BL.ProductTypeIdNmb=PROD.Idnmb
					LEFT JOIN Dynasty_DW.dbo.BillType_Dim TYP ON BL.BillTypeIDNmb=TYP.Idnmb
					LEFT JOIN Dynasty_DW.DBO.CalculationType_Dim CALC ON BL.CalculationTypeIdNmb=CALC.Idnmb
					LEFT JOIN Dynasty_DW.DBO.ProductGroup_Dim PGRP on BL.PRoductGroupIdnmb=PGRP.IDNMB
					LEFT JOIN Dynasty_DW..AssetType_Dim AST on BL.AssetTypeIdnmb=AST.IDNMB
					LEFT JOin Dynasty_DW..Strategy_Dim SRT on Bl.Strategyidnmb=SRT.Idnmb
