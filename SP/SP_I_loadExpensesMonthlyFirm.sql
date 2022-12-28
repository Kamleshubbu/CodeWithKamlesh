Use [Dynasty_DW]
Go

Drop Procedure SP_I_loadExpensesMonthlyFirm
Go


Create Procedure SP_I_loadExpensesMonthlyFirm
as
/*
 
			Exec SP_I_loadExpensesMonthlyFirm

*/
Begin


			Truncate table Dynasty_dw..ExpensesMonthlyFirm_fact

	------=============================================================================================================================================================

			Create Table #TotalExpenses
			(
				  companyname			Varchar(200) not null
				, companybillingname	Varchar(200)  null
				, companyidnmb			Int
				, MonthStartdate		Datetime null
				, MonthEnddate			Datetime null
				, accountnumber			Varchar(200)  null
				, AccountName			Varchar(200)  null
				, SectionTypeName		Varchar(200)  null
				, TotalExpensesAmount   FLOAT

			)

			INSERT INTO #TotalExpenses
			select	 companyname
					,Isnull(companybillingname,Companyname)
					,companyidnmb
					,DATEADD(month, DATEDIFF(month, 0, Date), 0)
					,EOMONTH(date)
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
					 ,DATEADD(month, DATEDIFF(month, 0, Date), 0)
					,EOMONTH(date)
					,CASE WHEN SectionSubTypeName IN ('Employee Payroll', 'Healthcare/Benefits') THEN 'Payroll & Benefits' ELSE  SectionSubTypeName END --AccountName
					 ,SectionTypeName 
			 order by companyidnmb,companyname,companybillingname,DATEADD(month, DATEDIFF(month, 0, Date), 0)
					,EOMONTH(date) desc
			
	------=============================================================================================================================================================
	
			Create Table #TotalIncome
			(
				  companyname			Varchar(200) not null
				, companybillingname	Varchar(200) not null
				, companyidnmb			Int
				, MonthStartdate		Datetime null
				, MonthEnddate			Datetime null
				, PreviousYearQuarterperiod  Varchar(200)  null
				, TotalIncomeAmount		 FLOAT

			)
		
			Insert into #TotalIncome	
				select 
				companyname
				,Isnull(companybillingname,Companyname)
				, companyidnmb
				,DATEADD(month, DATEDIFF(month, 0, Date), 0)
				,EOMONTH(date)
				,Concat(left(QuarterPeriod,4)-1,right(QuarterPeriod,3)) as PreviousYearQuarterperiod
				,SUM(ReportAmount) AS TotalIncomeAmount
		
			 from vw_GeneralLedger 
			 where SectionTypeName='Income' 
			 and  ReportTypeCode='INC'
			 group by companyidnmb
					,companyname
					,companybillingname
					,DATEADD(month, DATEDIFF(month, 0, Date), 0)
					,EOMONTH(date)
					,QuarterPeriod
			 order by companyidnmb,companyname,companybillingname

			 
------=================================================================Final Insert Query ============================================================================================

			insert into ExpensesMonthlyFirm_fact
			(
					Companyname
					, CompanyBillingName
					, Companyidnmb
					, QuarterPeriod
					, MonthStartDate
					, MonthEndDate
					, SectionTypeName
					, AccountNumber
					, AccountName
					, TotalExpensesAmount
					, TotalIncomeAmount
					, OperatingExpensesPct
					, OperatingExpensesBenchmarkPct
					, MinPct
					, MaxPct
					, CreateDate
					, PeriodTypeIdnmb
			)
			
			select	 ET.CompanyName
					,ET.CompanyBillingName
					,ET.Companyidnmb
				    ,CAST(DATEPART(YYYY,ET.MonthEnddate) AS char(4)) +' '+ 'Q' + CAST(DATEPART(QUARTER,ET.MonthEnddate) AS char(1)) as [Quarter]					
					,ET.MonthStartdate
					,ET.MonthEnddate
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
					,(select Idnmb From Dynasty_dw..periodtype_dim where Periodtypename='Monthly') 
			 from #TotalExpenses  ET Left outer join #TotalIncome IT on  ET.Companyidnmb=IT.Companyidnmb 
					AND ET.CompanyBillingName=IT.CompanyBillingName AND ET.MonthStartdate=IT.MonthStartdate   AND ET.MonthEnddate=IT.MonthEnddate ------Dont Change it to PreviousyearQuarterPeriod

	------=============================================================================================================================================================================

					--update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.004477096 where AccountName like '%Business Licensing, taxes%' --
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.00883115 where AccountName like '%Insurance%'--
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.012527336 where AccountName like '%Computer/Internet/Telephone%' --
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.002118408 where AccountName like '%Dues/Subscriptions%' --
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.007167474 where AccountName like '%Marketing/Gifts/Donations%'--
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.021645196 where AccountName like '%Professional Fees/Consulting%' --
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.042517609 where AccountName like '%Rent, utilities and RE taxes%'
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.135845958657962 where AccountName like '%Payroll & Benefits%' --
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.0055 where AccountName like '%General & Administrative%' --
					--	update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.0205 where AccountName like '%Travel & Entertainment%' --

	------====================================================================================Load YTD Data For Each Expense=========================================================================================

			Exec SP_I_loadExpensesYTDFirm

END