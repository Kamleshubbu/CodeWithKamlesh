USE [Dynasty_DW]
GO

/****** Object:  StoredProcedure [dbo].[Sp_R_BillingAssetsReport]    Script Date: 8/26/2019 1:02:07 PM ******/
DROP PROCEDURE [dbo].Sp_R_BillingAssetsReport
GO

/****** Object:  StoredProcedure [dbo].[Sp_R_BillingAssetsReport]    Script Date: 8/26/2019 1:02:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Sp_R_BillingAssetsReport]
as
/*

		EXEC [Sp_R_BillingAssetsReport]
		

*/
Begin
		---************************************************************* Truncate BillingFirm_Fact Reporting table ****************************************************************************
	

				Truncate table dynasty_dw..BillingFirm_Fact


		---************************************************************* Declare Variables ****************************************************************************

			Declare   @CompanyIdNmB INT
					, @GLMinstartdt date
					, @GLMaxenddt date
					, @BAMINStartDate DATE
					, @BAMAXEndDate DATE

		---************************************************************* Declare a Base Table ****************************************************************************	
					
			Declare @BaseData Table
			(
			Idnmb				int Identity(1,1),
			Companyidnmb		Int				,
			GLDate				datetime		,
			AccountNumber		varchar(200)	,
			AccountName			varchar(200)	,
			AdvisorFlag			bit				,
			ClosesInto			int				,
			TransactionType		varchar(200)	,
			CompanyCode			varchar(200)	,
			CompanyName			varchar(200)	,
			SubCompanyCode		varchar(200)	,
			SubCompanyName		varchar(200)	,
			AdvisorCode			varchar(200)	,
			AdvisorName			varchar(200)	,
			ReportTypeCode		varchar(200)	,
			ReportTypeName		varchar(200)	,
			SectionTypeName	    varchar(200)	,
			SectionTypeOrder    Int NULL		,	
			SectionSubTypeName	varchar(200)	,
			BeforeEBITDA		Int	NULL		,
			BeforeNetIncome		Int	NULL		,
			ClassCode			varchar(200)	,
			ClassName			varchar(200)	,
			VendorCode			varchar(200)	,
			VendorName			varchar(200)	,
			Amount				Numeric(26,2)	,
			ReportAmount		Numeric(26,2)	,
			EBACAmount			Numeric(26,2)	,
			EBITDAAmount		Numeric(26,2)	,
			NetIncomeAmount		Numeric(26,2)	
			)
			

			
		---**********************************************************   Insert into BaseData table from the view Vw.GeneralLedger ******************************************************************************************
			
			Insert into @BaseData
			select GL.COMPANYIDNMB	,
			Gl.Date					,
			GL.AccountNumber		,
			GL.AccountName			,
			GL.AdvisorFlag			,
			GL.ClosesInto			,
			GL.TransactionType		,
			GL.CompanyCode			,
			GL.CompanyName			,
			GL.SubCompanyCode		,
			GL.SubCompanyName		,
			GL.AdvisorCode			,
			GL.AdvisorName			,
			GL.ReportTypeCode		,
			GL.ReportTypeName		,
			GL.SectionTypeName		,
			Gl.SectionTypeOrder		,
			GL.SectionSubTypeName	,
			GL.BeforeEBITDA			,
			GL.BeforeNetIncome		,
			GL.ClassCode			,
			GL.ClassName			,
			GL.VendorCode			,
			GL.VendorName			,
			GL.Amount				,	
			GL.ReportAmount			,
			GL.EBACAmount			,
			GL.EBITDAAmount			,
			GL.NetIncomeAmount	
	
			from vw_GeneralLedger GL 		
			WHERE Gl.ReportTypeCode = 'INC'
					

			
			
			---************************************************************* Get the minimum and maximum dates for that CompanyName ****************************************************************************	
			
			select @GLminstartdt = min(GLDate) from @BaseData
			
			select @GLmaxenddt = max(GLDate) from @BaseData
	
			
			----************************************************************* Get the Quarter Startdate and Quarter Enddate for that CompanyName and store into @GLDates table ****************************************************************************	
			
			Declare  @GLDates TABLE
			(
				GLSTARTDATE			DATE	,
				GLENDDATE			DATE	,
				Companyidnmb		INT		
			)

			INSERT INTO @GLDates
			select 	distinct  
								DATEADD(q, DATEDIFF(q, 0, GLDate), 0) as startdate
							,	DATEADD(d, -1, DATEADD(q, DATEDIFF(q, 0, GLDate) + 1, 0))  as enddate 
							,   Companyidnmb
					
			from @BaseData 
			where  
					GLDate>=@GLminstartdt 
				and GLDate<=@GLmaxenddt

	
			----************************************************************* Create #tempdata table ****************************************************************************	

			DECLARE  @GLReportData TABLE
			(
					 COMPANYIDNMB				 INT
				   , Startdate					 DATE
				   , EndDate					 DATE
				   , IncomeAdvisory				 NUMERIC(26,2)
				   , IncomeBrokerage			 NUMERIC(26,2)
				   , IncomeOther				 NUMERIC(26,2)
				   , TotalIncome				 NUMERIC(26,2)
				   , TotalCostofservice			 NUMERIC(26,2)
				   , TotalExpenses				 NUMERIC(26,2)
				   , TotalEBAC					 NUMERIC(26,2)	
				   , TotalBeforeEBITDA			 NUMERIC(26,2)
				   , TotalEBITDA			     NUMERIC(26,2)
				   , TotalBeforeNetIncome		 NUMERIC(26,2)
				   , TotalNetincome				 NUMERIC(26,2)
				   , EBACTTM					 NUMERIC(26,2)
				   , TotalBeforeEBITDATTM		 NUMERIC(26,2)
				   , TotalIncomeTTM				 NUMERIC(26,2)
				   , TotalExpensesTTM		     NUMERIC(26,2)
				   , EBACYTD					 NUMERIC(26,2)
				   , TotalBeforeEBITDAYTD		 NUMERIC(26,2)
				   , TotalIncomeYTD				 NUMERIC(26,2)
				   , TotalExpensesYTD		     NUMERIC(26,2)
				   , SectionTypeName			 VARCHAR(100)
				   , SectionSubTypeName			 VARCHAR(100)
			)
			
			----************************************************************* Insert the data from the Basedata table ****************************************************************************	
			
			Insert into @GLReportData
			SELECT 	
					 BD.Companyidnmb	
					,  D.GLSTARTDATE as 'StartDate'
					, D.GLENDDATE as 'EndDate'
					, CASE WHEN BD.SectionTypeName='INCOME' AND SectionSubTypeName='ADVISORY' THEN SUM(case when BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END	AS [Income Advisory]
					, CASE WHEN BD.SectionTypeName='INCOME' AND SectionSubTypeName='Brokerage' THEN SUM(case when  BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END	AS [Income Brokerage]
					, CASE WHEN BD.SectionTypeName='INCOME' AND SectionSubTypeName='other' THEN SUM(case when  BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END	AS [Income other]
					, CASE WHEN BD.SectionTypeName='INCOME' THEN SUM(case when BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END AS INCOME
					, CASE WHEN BD.SectionTypeName='COST OF SERVICE' THEN SUM(case when  BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END	as [Cost of service]
					, CASE WHEN BD.SectionTypeName='EXPENSES' THEN SUM(case when   BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END [Expenses]
					, SUM(case  when   BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.EBACAmount else 0 end) AS TOTALEBAC
					, CASE WHEN BD.BeforeEBITDA=1 THEN SUM(case when  BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.EBITDAAmount else 0 end) ELSE 0 END [TOTAL BEFORE EBITDA]
					, SUM(case when   BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.EBITDAAmount else 0 end) AS TOTALEbitda
					, CASE WHEN BD.BeforeNetIncome=1 THEN SUM(case when  BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.NetIncomeAmount else 0 end) ELSE 0 END [TOTAL BEFORE NETINCOME]
					, SUM(case when BD.GLDate>=d.GLSTARTDATE and BD.[GLDate]<=D.[GLENDDATE] then  BD.NetIncomeAmount else 0 end) AS TotalNetIncome
					, sum(CASE WHEN BD.GLDate>Dateadd(YEAR, -1, D.GLENDDATE) and BD.[GLDate]<=D.[GLENDDATE] Then Bd.EBACAmount else 0 END ) as EBACTTM
					, CASE WHEN BD.BeforeEBITDA=1 THEN SUM(case when  BD.GLDate>Dateadd(Year, -1, D.GLENDDATE) and BD.[GLDate]<=D.[GLENDDATE] then  BD.EBITDAAmount else 0 end) ELSE 0 END [TOTAL BEFORE EBITDA TTM]
					, CASE WHEN BD.SectionTypeName='INCOME' THEN SUM(case when BD.GLDate>Dateadd(YEAR, -1, D.GLENDDATE) and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END AS INCOMETTM
					, CASE WHEN BD.SectionTypeName='EXPENSES' THEN SUM(case when BD.GLDate>Dateadd(YEAR, -1, D.GLENDDATE) and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END AS EXPENSESTTM
					, sum(CASE WHEN BD.GLDate>=DATEADD(yy, DATEDIFF(yy, 0, D.GLSTARTDATE), 0)  and BD.[GLDate]<=D.[GLENDDATE] Then Bd.EBACAmount else 0 END ) as EBACYTD
					, CASE WHEN BD.BeforeEBITDA=1 THEN SUM(case when  BD.GLDate>= DATEADD(yy, DATEDIFF(yy, 0, D.GLSTARTDATE), 0)  and BD.[GLDate]<=D.[GLENDDATE] then  BD.EBITDAAmount else 0 end) ELSE 0 END [TOTAL BEFORE EBITDA YTD]
					, CASE WHEN BD.SectionTypeName='INCOME' THEN SUM(case when BD.GLDate>= DATEADD(yy, DATEDIFF(yy, 0, D.GLSTARTDATE), 0)  and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END AS INCOMEYTD
					, CASE WHEN BD.SectionTypeName='EXPENSES' THEN SUM(case when BD.GLDate>= DATEADD(yy, DATEDIFF(yy, 0, D.GLSTARTDATE), 0)  and BD.[GLDate]<=D.[GLENDDATE] then  BD.ReportAmount else 0 end) ELSE 0 END AS EXPENSESYTD
					, BD.SectionTypeName
					, BD.SectionSubTypeName		 
					
				
					FROM @BaseData BD
							cross apply --@GLDates D
							(
								select * from @GLDates where bd.Companyidnmb=Companyidnmb
							)D
					GROUP BY 
								 BD.Companyidnmb
								, BD.SectionTypeName
								, BD.SectionSubTypeName
								, BD.BeforeEBITDA
								, BD.BeforeNetIncome
								, D.GLSTARTDATE
								, D.GLENDDATE		
								

			----************************************************************* Final Select Query ****************************************************************************	
			DECLARE  @GLData TABLE
			(
					 Companyidnmb				 INT
				   , Quarterperiod				 VARCHAR(100)
				   , Startdate					 DATE
				   , EndDate					 DATE
				   , IncomeAdvisory				 NUMERIC(26,2)
				   , IncomeBrokerage			 NUMERIC(26,2)
				   , IncomeOther				 NUMERIC(26,2)
				   , TotalIncome				 NUMERIC(26,2)
				   , RecurringRevenuePct		 FLOAT
				   , TotalCostofservice			 NUMERIC(26,2)
				   , TotalExpenses				 NUMERIC(26,2)
				   , TotalEBAC					 NUMERIC(26,2)	
				   , TotalBeforeEBITDA			 NUMERIC(26,2)
				   , TotalEBITDA			     NUMERIC(26,2)
				   , TotalBeforeNetIncome		 NUMERIC(26,2)
				   , TotalNetincome				 NUMERIC(26,2)
				   , EBACTTM					 NUMERIC(26,2)
				   , TotalBeforeEBITDATTM		 NUMERIC(26,2)
				   , TotalIncomeTTM				 NUMERIC(26,2)
				   , TotalExpensesTTM		     NUMERIC(26,2)
				   , EBACYTD					 NUMERIC(26,2)
				   , TotalBeforeEBITDAYTD		 NUMERIC(26,2)
				   , TotalIncomeYTD				 NUMERIC(26,2)
				   , TotalExpensesYTD		     NUMERIC(26,2)
				   
			)
				
				
			INSERT	into @GLData
					SELECT  
							 
							 COMPANYIDNMB as 'CompanyIdNmb'
							,  CAST(DATEPART(YYYY,StartDate) AS char(4)) +' '+ 'Q' + CAST(DATEPART(QUARTER,StartDate) AS char(1)) as [Quarter]	
							, cast (startdate as date) as 'StartDate'
							, cast(enddate as date) as 'EndDate'
							, SUM(IncomeAdvisory) as 'IncomeAdvisory'
							, SUM(IncomeBrokerage) as 'IncomeBrokerage'
							, SUM(IncomeOther) as 'IncomeOther'
							, SUM(TotalIncome) as 'TotalIncome'
							, (sum(IncomeAdvisory)/Nullif(sum(TotalIncome),0)*100) AS 'RecurringRevenuePct'
							, SUM(TotalCostofservice) as 'TotalCostOfService'
							, SUM(TotalExpenses) as 'TotalExpenses'
							, SUM(TOTALEBAC) as 'TotalEBAC'
							, SUM(TOTALBEFOREEBITDA) as 'TotalBeforeEBITDA'
							, SUM(TotalEBITDA) as 'TotalEBITDA'
							, SUM(TOTALBEFORENETINCOME) as 'TotalBeforeNetIncome'
							, SUM(TotalNetincome) as 'TotalNetIncome'
							, SUM(Ebacttm) as 'EbacTTM'
							, SUM(TotalBeforeEBITDATTM) as 'TotalBeforeEBITDATTM'
							, SUM(TotalIncomeTTM) as 'TotalIncomeTTM'
							, SUM(TotalExpensesTTM) as 'TotalExpensesTTM'
							, SUM(EBACYTD) as 'EBACYTD'
							, SUM(TotalBeforeEBITDAYTD) as 'TotalBeforeEBITDAYTD'
							, SUM(TotalIncomeYTD) as 'TotalIncomeYTD'
							, SUM(TotalExpensesYTD) as 'TotalExpensesYTD'
					
					FROM @GLReportData
					group by 
							 COMPANYIDNMB
							, startdate
							, enddate

--			----************************************************************* START BILLING ASSETS CALCULATION ****************************************************************************	
		
				DECLARE  @BABasedata TABLE
				(
				CompanyIdNmb				INT				,
				InvestedDate				date			,
				InvestmentAccountNumber		varchar(100) null,
				InvestmentAccountName		varchar(100) null,
				CompanyName					varchar(100) null,
				CompanyBillingName			varchar(100) null,
				HouseholdName				varchar(100) null,
				InvestmentAdvisorCode		varchar(100) null,
				InvestmentAdvisorName		varchar(100) null,
				CustodianName				varchar(100) null,
				ManagerName					varchar(100) null,
				ProductName					varchar(100) null,
				TypeName					varchar(100) null,
				CalculationTypeName			varchar(100) null,
				BillableDays				int,
				PeriodDays					int,
				AsOfDate					date,
				PeriodStartDate				date,
				PeriodEndDate				date,
				DebitedAccount				varchar(100) null,
				BillableAmount				float,
				BillableHouseholdAmount		float,
				ClientFeeAmount				float,
				ClientFeePct				float,
				AdvisorfeeAmount			float,
				AdvisorFeePct				float,
				ProgramfeeAmount			float,
				Programfeepct				float,
				ManagerFeeAmount			float,
				ManagerFeePct				float,
				FirmFeeAmount				float,
				FirmFeePct					float,
				BillingPeriod				varchar(100) null,
				BillingDate					varchar(100) null,
				BillingRun					varchar(100) null,
				[Timestamp]					varchar(100) null
				) 
				

				Insert INTO @BABasedata
				select 
					Companyidnmb
				,	InvestedDate
				,	InvestmentAccountNumber
				,	InvestmentAccountName
				,	CompanyName
				,	CompanyBillingName
				,	HouseholdName
				,	InvestmentAdvisorCode
				,	InvestmentAdvisorName
				,	CustodianName
				,	ManagerName
				,	ProductName
				,	TypeName
				,	CalculationTypeName
				,	BillableDays
				,	PeriodDays
				,	AsOfDate
				,	PeriodStartDate
				,	PeriodEndDate
				,	DebitedAccount
				,	BillableAmount
				,	BillableHouseholdAmount
				,	ClientFeeAmount
				,	ClientFeePct
				,	AdvisorfeeAmount
				,	AdvisorFeePct
				,	ProgramfeeAmount
				,	Programfeepct
				,	ManagerFeeAmount
				,	ManagerFeePct
				,	FirmFeeAmount
				,	FirmFeePct
				,	BillingPeriod
				,	BillingDate
				,	BillingRun
				,	[Timestamp]
					
				from vw_billingassets BA
					where BA.GLFlg=1

				

--		----************************************************************* DECLARE @BAdATES TABLE TO STORE THE DATES FOR BILLINGASSETS ****************************************************************************	
				
				
				Declare  @BADates TABLE
				(
						  BAStartdate					 DATETIME
						, BAEndDate						 DATETIME	
						, companyidnmb					 INT
				)						
				
--		---************************************************************* Get the minimum and maximum BILLINGASSETS dates for that CompanyName ****************************************************************************	

				SELECT @BAMINStartDate= MIN(PeriodStartDate) FROM @BABasedata
				
				SELECT @BAMaxEndDate = MAX(PeriodEndDate) FROM @BABasedata
				
--		---************************************************************* INSERT THE DATES INTO @BADATES TABLE ONLY DISTINCT QUARTER START,END DATES  VALUES ****************************************************************************	
		
				INSERT INTO @BADates
				(
						  BAStartdate
						, BAEndDate
						, companyidnmb
				)
				Select distinct  DATEADD(q, DATEDIFF(q, 0, PeriodStartDate), 0) as startdate
								, DATEADD(d, -1, DATEADD(q, DATEDIFF(q, 0, PeriodEndDate) + 1, 0))  as enddate 
								, CompanyIdNmb
				from @BABasedata 
				where  
							PeriodStartDate>=@BAMinStartDate 
						and PeriodEndDate<=@BAMaxEndDate
				
					
--		---************************************************************* DECLARE THE @BADATA TO STORE THE VALUES FROM THE BILLINGASSETS ****************************************************************************	
						
				DECLARE  @BADATA TABLE
				(
					COMPANYIDNMB			INT
				  , QUARTERPERIOD			VARCHAR(100)
		    	  , STARTDATE				DATE
				  , ENDDATE					DATE
				  , AUABeginningOfQuarter	FLOAT
				  , AUAEndOfQuarter			FLOAT
			      , ASSETADVISORY			FLOAT
				  , AssetsReporting			FLOAT
				  , TotalAssets				FLOAT
				  , AverageAssets			FLOAT
				  , Revenueamount			FLOAT
				  , ICRevenueamount			FLOAT
				)

--	 ---*************************************************************INSERT INTO @BADATA TABLE ****************************************************************************	

				Insert into @BADATA
				(
					
					 COMPANYIDNMB
					, QUARTERPERIOD
					, Startdate					 
					, EndDate					 
					, AUABeginningOfQuarter
					, ASSETADVISORY
					, AssetsReporting			
					, TotalAssets	
					, AverageAssets			
				    , Revenueamount			
				    , ICRevenueamount			

				)
				select 
						 BA.CompanyIdNmB as 'CompanyIdNmb'
						, CAST(DATEPART(YYYY,BAStartdate) AS char(4)) +' '+ 'Q' + CAST(DATEPART(QUARTER,D.BAStartdate) AS char(1))  as [QuarterPeriod]	
						, D.BAStartdate as 'StartDate'
						, D.BAEndDate as 'EndDate'
						, Sum(case when periodstartdate>=D.BAStartdate and PeriodEndDate<=D.BAEndDate and (CAST(DATEPART(YYYY,ISNULL(BASTARTDATE,D.BAStartdate)) AS char(4)) +' - '+ 'Q' + CAST(DATEPART(QUARTER,ISNULL(BASTARTDATE,D.BAStartdate)) AS char(1)) + ' - ' +DATENAME(month,BASTARTDATE))=BillingRun then BillableAmount else 0 end) as 'AUA BEGINNING'
						, Sum(case when periodstartdate>=D.BAStartdate and PeriodEndDate<=D.BAEndDate and TypeName not in ('REBILL','REBATE','Adjustment') and ProductName not in ('REPORTING ONLY','REPORTING ONLY V2')  then BillableAmount else 0 end) as 'AssetAdvisory'
						, Sum(case when periodstartdate>=D.BAStartdate and PeriodEndDate<=D.BAEndDate and TypeName not in ('REBILL','REBATE','Adjustment') and ProductName in ('REPORTING ONLY','REPORTING ONLY V2')  then BillableAmount else 0 end) as 'AssetsReporting'
						, null as 'TotalAssets'
						, SUM(CASE WHEN periodstartdate>=Dateadd(Month, -12, D.BASTARTDATE) and PeriodEndDate<=D.BASTARTDATE and TypeName not in ('REBILL','REBATE','Adjustment') and ProductName not in ('REPORTING ONLY','REPORTING ONLY V2') THEN (BILLABLEAMOUNT)/12 else 0  END) as Average
						, null as 'Revenueamount'
						, null as 'ICRevenueamount'
						from @BABasedata BA
					
							Cross apply --@BADates D
							(
									select * from @BADates where BA.CompanyIdNmb=CompanyIdNmb
							)D
					group by 
									  BA.CompanyIdNmb									
									, D.BAStartdate
									, D.BAEndDate 



--		-----************************************************************* FINAL SELECT QUERY OF BOTH THE  TABLES @BADATA AND @gLDATA WITH FULL JOIN ****************************************************************************	
				
				insert into Dynasty_DW..BillingFirm_Fact
				(
						CompanyName
						,CompanyIdNmb
						,QuarterPeriod
						,StartDate
						,EndDate
						,[AUA Beginning of Quarter]
						,[AUA End of Quarter]
						,AdvisoryAssetsAmount
						,ReportingAssetsAmount
						,TotalAssetsAmount
						,AverageAssetsAmount
						,RevenueAmount
						,ICRevenueAmount
						,AdvisoryRevenueAmount
						,BrokerageRevenueAmount
						,OtherRevenueAmount
						,GrossRevenueAmount
						,RecuringRevenuePct
						,TotalCostOfServiceAmount
						,TotalExpensesAmount
						,TotalBeforeEBITDAAmount
						,TotalBeforeNetIncomeAmount
						,TotalEBACAmount
						,TotalEBITDAAmount
						,FirmValueAmount
						,TotalNetIncomeAmount
					--	,CreateDate
						,EBACTTM
						,TotalBeforeEBITDAAmountTTM
						,GrossRevenueAmountTTM
						,TotalExpensesAmountTTM
						,EBACYTD
						,TotalBeforeEBITDAAmountYTD
						,GrossRevenueAmountYTD
						,TotalExpensesAmountYTD
				)
				select 
						  Isnull(COM.BillingName,com.CompanyName) as 'CompanyBillingName'
						, ISNULL(BA.Companyidnmb,GL.Companyidnmb) AS	'CompanyIdNmb'
						, CAST(DATEPART(YYYY,ISNULL(BA.STARTDATE,GL.STARTDATE)) AS char(4)) +' '+ 'Q' + CAST(DATEPART(QUARTER,ISNULL(BA.STARTDATE,GL.STARTDATE)) AS char(1)) as [QuarterPeriod]
						, ISNULL(BA.STARTDATE,GL.STARTDATE) as 'StartDate'
						, ISNULL(BA.ENDDATE,GL.EndDate) as 'EndDate'
						, CASE WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2019-12-31' THEN '626868929.37'  
							   WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2020-03-31' THEN '674071317.96'	
							   ELSE SUM(BA.AUABeginningOfQuarter) End AS 'AUA Beginning of Quarter'
						--, SUM(BA.AUABeginningOfQuarter) AS 'AUA Beginning of Quarter'
						, CASE WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2019-12-31' THEN '674071317.96' 
							   WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2019-09-30' THEN '626868929.37'
							   Else LEAD(sum(BA.AUABeginningOfQuarter)) over (partition by ISNULL(BA.Companyidnmb,GL.Companyidnmb) order by BA.Companyidnmb ASC) End AS 'AUA End Of Quarter'
						--, LEAD(sum(BA.AUABeginningOfQuarter)) over (partition by ISNULL(BA.Companyidnmb,GL.Companyidnmb) order by BA.Companyidnmb ASC) AS 'AUA End Of Quarter'
						, CASE WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2019-12-31' THEN '626868929.37'  
							   WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2020-03-31' THEN '674071317.96'	
							   ELSE SUM(BA.ASSETADVISORY) END as 'AssetAdvisory'
						--, SUM(BA.ASSETADVISORY) END as 'AssetAdvisory'
						, SUM(BA.AssetsReporting) as 'AssetsReporting'
						, CASE WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2019-12-31' THEN '626868929.37'  
							   WHEN ISNULL(BA.Companyidnmb,GL.Companyidnmb)=8 AND ISNULL(BA.ENDDATE,GL.EndDate)='2020-03-31' THEN '674071317.96'	
							   ELSE SUM(BA.ASSETADVISORY) + Sum(Ba.AssetsReporting) END as 'TotalAssets'
						--, SUM(BA.ASSETADVISORY) + Sum(Ba.AssetsReporting) as 'TotalAssets'
						, SUM(BA.AverageAssets) as 'AverageAssets'
						, null as 'Revenueamount'
						, null as 'ICRevenueamount'
						, sum(GL.IncomeAdvisory)	as 'IncomeAdvisory'	
						, sum(GL.IncomeBrokerage)	as 'IncomeBrokerage'
						, sum(GL.IncomeOther) as 'IncomeOther'
						, sum(TotalIncome)	as 'TotalIncome'		
						, sum(RecurringRevenuePct) as 'RecurringRevenuePct' 
						, sum(TotalCostofservice)	as 'TotalCostOfService'
						, sum(TotalExpenses)		as 'TotalExpenses'
						, sum(TotalBeforeEBITDA)	as 'TotalBeforeEBITDA'
						, sum(TotalBeforeNetIncome)	as 'TotalBeforeNetIncome'
						, sum(TotalEBAC)			as 'TotalEBAC'
						, sum(TotalEBITDA)			as 'TotalEBITDA'
						, null as 'Firmvalue'
						, sum(TotalNetincome)		as 'TotalNetIncome'
					--	, getdate()
						, SUM(EBACTTM)				AS 'Ebacttm'		
						, SUM(TotalBeforeEBITDATTM)	AS 'TotalBeforeEBITDATTM'	
						, SUM(TotalIncomeTTM)		AS 'TotalIncomeTTM'
						, SUM(TotalExpensesTTM)		AS 'TotalExpensesTTM'	
						, SUM(EBACYTD)				AS 'EbacYTD'		
						, SUM(TotalBeforeEBITDAYTD)	AS 'TotalBeforeEBITDAYTD'	
						, SUM(TotalIncomeYTD)		AS 'TotalIncomeYTD'
						, SUM(TotalExpensesYTD)		AS 'TotalExpensesYTD'
						
						  from @BADATA BA   
								 full join @GLData GL on BA.COMPANYIDNMB=GL.CompanyIdNmb and BA.STARTDATE=GL.StartDate and BA.enddate=GL.EndDate
								 LEFT JOIN Company_Dim COM ON  COM.Idnmb=ISNULL(GL.COMPANYIDNMB,BA.COMPANYIDNMB)
						group by
								  COM.BillingName 
								, com.CompanyName	
								, BA.Companyidnmb
								, GL.Companyidnmb
								, BA.STARTDATE
								, GL.STARTDATE
								, BA.ENDDATE
								, GL.EndDate
						order by CompanyName
								, BillingName
								, CompanyIdNmb
								, Startdate
								, enddate		

   ------**************************************************************************************Load Expensesfirm_Fact and Growthrates_fact table with updated values *********************************************************************************************************
					
					Exec Dynasty_DW..Sp_I_loadExpensesFirm

					Exec Dynasty_DW..Sp_I_GrowthRates
END

GO


