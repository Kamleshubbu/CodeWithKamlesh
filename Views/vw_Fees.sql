USE Dynasty_DW
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Household_Dim]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_fees

GO
/* 
		
			select * from vw_fees
			
*/
CREATE VIEW vw_fees
AS
			select	
					  HOUSE.HouseholdName
					, COM.CompanyName
					, COM.BillingName AS 'CompanyBillingName'
					, COM.DIVISION
					, Com.City
					, Com.[State]
					, Com.[Status]
					, Com.PreviousFirm
					, Com.RM
					, CAST(DATEPART(YYYY,cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodStartDateIdNmb)), 0) as date)) AS char(4))+' '+ 'Q' + CAST(DATEPART(QUARTER,cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodStartDateIdNmb)), 0) as date)) AS char(1))  as 'QuarterPeriod'	
					, cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodStartDateIdNmb)), 0) as date) AS 'PeriodStartDate'
					, cast(Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodEndDateIdNmb) as date) as 'PeriodEndDate'
					, sum(BL.BillableAmount) as 'BillableValueAmount'
					, sum(BL.AdvisorfeeAmount)  as 'AdvisorfeeAmount'
					, avg(BL.AdvisorFeePct) as 'AdvisorfeeAmountPct'
					--, avg(BL.AdvisorFeePct) * 100 AS 'AdvisorFeeBPS'    -----OLD Logic
					, ((Sum(AdvisorfeeAmount)*4)/NULLIF(Sum(Bl.BillableAmount),'0')) * 10000    AS AdvisorFeeBPS      ----Added on 9th March 2020 

					from BillingAssets_Fact Bl
						INNER JOIN Dynasty_DW.DBO.Company_Dim COM ON BL.CompanyIdNmb=COM.Idnmb
						INNER JOIN Dynasty_DW.DBO.Household_Dim HOUSE ON BL.HouseholdIdNmb=HOUSE.Idnmb AND HOUSE.CompanyIDNmb=COM.Idnmb	
					group by
							HOUSE.HouseholdName
						   , Com.CompanyName
						   , com.BillingName
						   , COM.DIVISION
						   , Com.City
						   , Com.[State]
						   , Com.[Status]
						   , Com.PreviousFirm
						   , Com.RM
						   , DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodStartDateIdNmb)), 0)
						   , cast(Dynasty_DW.DBO.udf_GetDateFromID(BL.PeriodEndDateIdNmb) as date)
					