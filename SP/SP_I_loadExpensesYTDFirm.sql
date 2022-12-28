USE [Dynasty_DW]
GO

/****** Object:  StoredProcedure [dbo].[SP_I_loadExpensesYTDFirm]    Script Date: 2/24/2020 5:36:51 AM ******/
DROP PROCEDURE [dbo].[SP_I_loadExpensesYTDFirm]
GO

/****** Object:  StoredProcedure [dbo].[SP_I_loadExpensesYTDFirm]    Script Date: 2/24/2020 5:36:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create Procedure [dbo].[SP_I_loadExpensesYTDFirm]
as
/*
 
			Exec SP_I_loadExpensesYTDFirm

*/
Begin
			
			Declare   
					 @GLMinstartdt date
					, @GLMaxenddt date
	
			select @GLminstartdt = min(Date) from vw_GeneralLedger GL WHERE Gl.ReportTypeCode = 'INC'
			
			select @GLmaxenddt = max(Date) from vw_GeneralLedger GL WHERE Gl.ReportTypeCode = 'INC'

------=============================================================================================================================================================
	
			Declare  @GLDates TABLE
			(
				GLSTARTDATE			DATE	,
				GLENDDATE			DATE	,
				Companyidnmb		INT		
			)


			Insert into @GLDates
			select 	distinct  
								DATEADD(yy, DATEDIFF(yy, 0, Date), 0) as startdate
							,	EOmonth(date)  as enddate 
							,   Companyidnmb
					
			from vw_GeneralLedger
			where  
					  
					Date>=@GLminstartdt 
				and Date<=@GLmaxenddt



	------=============================================================================================================================================================
		
			Delete  EXPD from Dynasty_DW..ExpensesMonthlyFirm_fact EXPD inner join Dynasty_DW..PeriodType_Dim Per on EXPD.PeriodTypeidnmb=Per.Idnmb
				Where Per.PeriodTypename='YTD'
			

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
					,GL.Companyidnmb
					,D.GLSTARTDATE
					,D.GLENDDATE
					,'DUMMY' --accountnumber
					,CASE WHEN SectionSubTypeName IN ('Employee Payroll', 'Healthcare/Benefits') THEN 'Payroll & Benefits' ELSE  SectionSubTypeName END--AccountName
					,SectionTypeName
					,sum(case when GL.Date>= DATEADD(yy, DATEDIFF(yy, 0, D.GLSTARTDATE), 0)  and Gl.[Date]<=D.[GLENDDATE] then  GL.ReportAmount else 0 end) as TotalExpensesAmount
		
			from vw_GeneralLedger GL
				cross apply --@GLDates D
							(
								select * from @GLDates where GL.Companyidnmb=Companyidnmb
							)D
			where SectionTypeName='Expenses' 
					and  ReportTypeCode='INC'
			
			 group by GL.companyidnmb
					 ,companyname
					 ,companybillingname
					,D.GLSTARTDATE
					,D.GLENDDATE
					,CASE WHEN SectionSubTypeName IN ('Employee Payroll', 'Healthcare/Benefits') THEN 'Payroll & Benefits' ELSE  SectionSubTypeName END --AccountName
					 ,SectionTypeName 

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
				select Distinct
				companyname
				,Isnull(companybillingname,Companyname)
				,GL.Companyidnmb
				,D.GLSTARTDATE
				,D.GLENDDATE
				,null
				--,Concat(left(QuarterPeriod,4)-1,right(QuarterPeriod,3)) as PreviousYearQuarterperiod
				,SUM(case when GL.Date>= DATEADD(yy, DATEDIFF(yy, 0, D.GLSTARTDATE), 0)  and Gl.[Date]<=D.[GLENDDATE] then  GL.ReportAmount else 0 end) AS TotalIncomeAmount
		
			 from vw_GeneralLedger Gl
			 cross apply --@GLDates D
							(
								select * from @GLDates where GL.Companyidnmb=Companyidnmb
							)D
			 where SectionTypeName='Income' 
			 and  ReportTypeCode='INC'
			 group by Gl.companyidnmb
					,companyname
					,companybillingname
					,D.GLSTARTDATE
					,D.GLENDDATE
				


			 
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
			
			select Distinct	 ET.CompanyName
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
					,(select Idnmb From Dynasty_dw..periodtype_dim where Periodtypename='YTD') 
			 from #TotalExpenses  ET Left outer join #TotalIncome IT on  ET.Companyidnmb=IT.Companyidnmb 
					AND ET.CompanyBillingName=IT.CompanyBillingName AND ET.MonthStartdate=IT.MonthStartdate   AND ET.MonthEnddate=IT.MonthEnddate  ------Dont Change it to PreviousyearQuarterPeriod
					
	------=============================================================================================================================================================================

					update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.004477096 where AccountName like '%Business Licensing, taxes%' --
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.00883115 where AccountName like '%Insurance%'--
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.012527336 where AccountName like '%Computer/Internet/Telephone%' --
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.002118408 where AccountName like '%Dues/Subscriptions%' --
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.007167474 where AccountName like '%Marketing/Gifts/Donations%'--
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.021645196 where AccountName like '%Professional Fees/Consulting%' --
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.042517609 where AccountName like '%Rent, utilities and RE taxes%'
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.135845958657962 where AccountName like '%Payroll & Benefits%' --
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.0055 where AccountName like '%General & Administrative%' --
						update ExpensesMonthlyFirm_fact set OperatingExpensesBenchmarkPct=0.0205 where AccountName like '%Travel & Entertainment%' --

END
GO


