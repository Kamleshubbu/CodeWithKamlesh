USE [Dynasty_DW]
GO

/****** Object:  StoredProcedure [dbo].[Sp_I_loadExpensesFirm]    Script Date: 9/18/2019 8:28:30 AM ******/
DROP PROCEDURE [dbo].[Sp_I_loadExpensesFirm]
GO

/****** Object:  StoredProcedure [dbo].[Sp_I_loadExpensesFirm]    Script Date: 9/18/2019 8:28:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_I_loadExpensesFirm]
as 
	/*

			exec Sp_I_loadExpensesFirm
		
	*/

begin

		------=============================================================================================================================================================	
	----	Notes: Formula  for Calculation for OperatingExpensesPct is : (section type)"Expenses" -> "Account Name" (All)  /  GrossRevenueAmount(of 12 months Futute Date )

			------=============================================================================================================================================================	

			truncate table dynasty_dw.dbo.Expensesfirm_fact
	------=============================================================================================================================================================		
			Create Table #TotalExpenses
			(
				  companyname			Varchar(200) not null
				, companybillingname	Varchar(200)  null
				, companyidnmb			Int
				, Quarterperiod			Varchar(200)  null
				, accountnumber			Varchar(200)  null
				, AccountName			Varchar(200)  null
				, SectionTypeName		Varchar(200)  null
				, TotalExpensesAmount   FLOAT

			)

			INSERT INTO #TotalExpenses
			select	 companyname
					,Isnull(companybillingname,Companyname)
					,companyidnmb
					,Quarterperiod
					,'DUMMY' --accountnumber
					,CASE WHEN SectionSubTypeName IN ('Employee Payroll', 'Healthcare/Benefits') THEN 'Payroll & Benefits' ELSE  SectionSubTypeName END--AccountName
					,SectionTypeName
					,sum(ReportAmount) as TotalExpensesAmount
		
			from vw_GeneralLedger GL
			where SectionTypeName='Expenses' 
					and  ReportTypeCode='INC'
			
			 group by companyidnmb
					 ,companyname
					 ,companybillingname
					 ,Quarterperiod
					,CASE WHEN SectionSubTypeName IN ('Employee Payroll', 'Healthcare/Benefits') THEN 'Payroll & Benefits' ELSE  SectionSubTypeName END --AccountName
					 ,SectionTypeName 
			 order by companyidnmb,companyname,companybillingname,Quarterperiod desc
			
	------=============================================================================================================================================================
	
			Create Table #TotalIncome
			(
				  companyname			Varchar(200) not null
				, companybillingname	Varchar(200) not null
				, companyidnmb			Int
				, Quarterperiod			Varchar(200)  null
				, PreviousYearQuarterperiod  Varchar(200)  null
				, TotalIncomeAmount		 FLOAT

			)
		
			Insert into #TotalIncome	
				select 
				companyname
				,Isnull(companybillingname,Companyname)
				, companyidnmb
				,QuarterPeriod
				,Concat(left(QuarterPeriod,4)-1,right(QuarterPeriod,3)) as PreviousYearQuarterperiod
				,SUM(ReportAmount) AS TotalIncomeAmount
		
			 from vw_GeneralLedger 
			 where SectionTypeName='Income' 
			 and  ReportTypeCode='INC'
			 group by companyidnmb
					,companyname
					,companybillingname
					,QuarterPeriod
			 order by companyidnmb,companyname,companybillingname

			 
------=================================================================Final Insert Query ============================================================================================

			insert into Expensesfirm_fact
			select	 ET.CompanyName
					,ET.CompanyBillingName
					,ET.Companyidnmb
					,ET.QuarterPeriod
					,ET.SectionTypeName
					,ET.accountnumber
					,ET.AccountName
					,ET.TotalExpensesAmount
					,IT.Totalincomeamount
					,(ET.TotalExpensesAmount/NULLIF(IT.TotalIncomeAmount,0))
					,null	--as OperatingExpensesBenchmarkPct
					,0		--as [MinPct]
					,0.20		-- [Maxpct]
					,getdate() 
			 from #TotalExpenses  ET Left outer join #TotalIncome IT on  ET.Companyidnmb=IT.Companyidnmb 
					AND ET.CompanyBillingName=IT.CompanyBillingName AND ET.QuarterPeriod=IT.Quarterperiod    ------Dont Change it to PreviousyearQuarterPeriod


------================================================================= Benchmark Value update according to dashboard excel files   ============================================================================================

						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.004477096 where AccountName like '%Business Licensing, taxes%' --
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.00883115 where AccountName like '%Insurance%'--
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.012527336 where AccountName like '%Computer/Internet/Telephone%' --
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.002118408 where AccountName like '%Dues/Subscriptions%' --
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.007167474 where AccountName like '%Marketing/Gifts/Donations%'--
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.021645196 where AccountName like '%Professional Fees/Consulting%' --
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.042517609 where AccountName like '%Rent, utilities and RE taxes%'
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.135845958657962 where AccountName like '%Payroll & Benefits%' --
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.0055 where AccountName like '%General & Administrative%' --
						update ExpensesFirm_Fact set OperatingExpensesBenchmarkPct=0.0205 where AccountName like '%Travel & Entertainment%' --

						

			
end 
GO


