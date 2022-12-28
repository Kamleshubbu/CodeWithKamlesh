USE [Dynasty_DW]
GO

/****** Object:  StoredProcedure [dbo].[SP_R_GeneralLedgerReport]    Script Date: 7/17/2019 5:07:51 PM ******/
DROP PROCEDURE [dbo].[SP_R_GeneralLedgerReport]
GO

/****** Object:  StoredProcedure [dbo].[SP_R_GeneralLedgerReport]    Script Date: 7/17/2019 5:07:51 PM ******/
SET ANSI_NULLS ON
GO

Set NOCOUNT on
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[SP_R_GeneralLedgerReport]
@Date DATETIME ,
@CompanyName Varchar(100) 
as
/*
		Exec SP_R_GeneralLedgerReport
		@date='6/30/2019'
		,@companyName='Aaron Wealth Advisors, LLC'


*/
Begin
			---===================================== Declare A BaseData Table =================================
		SET NOCOUNT ON
		SET ARITHABORT ON
		SET ANSI_WARNINGS ON	


			Declare   @LastQtrStartDT DATE
					, @LastQtrEndDT DATE
					, @QtrStartDT DATE
					, @QtrEndDT DATE
					, @YTDStartDT DATE
					, @YTDEndDT DATE
					, @CountofSectiontype INT=Null 
					, @AsOfDate DATE
					, @DateIDNmb INT
					, @CompanyIdNmB INT
					, @Sql as nvarchar (max)
					, @QtrHeader Varchar(50)
					, @lastQtrHeader Varchar(50)
					, @YTDHeader Varchar(50)
---======================================Set the IDNMB of date and CompanyName ==================================================

			Set @DateIDNmb = (select DateIDNmb from Date_Dim where date=@Date)

			set @CompanyIdNmb = (Select Idnmb from Company_Dim where CompanyName=@CompanyName)
			
---=============================================================================================================================

			Declare @BaseData Table
			(
			Idnmb int Identity	(1,1),
			[Date]				datetime ,
			AccountNumber		varchar(200),
			AccountName			varchar(200)	,
			AdvisorFlag			bit	,
			ClosesInto			int	,
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
			
				SELECT @LastQtrStartDT = Strt_Dt  FROM [dbo].[udf_GetDates]([dbo].udf_GetDateFromID(@DateIDNmb) , 'Q' , -1)
				SELECT @LastQtrEndDT = End_Dt  FROM [dbo].[udf_GetDates]([dbo].udf_GetDateFromID(@DateIDNmb) , 'Q' , -1)
				SELECT @QtrStartDT = Strt_Dt  FROM [dbo].[udf_GetDates]([dbo].udf_GetDateFromID(@DateIDNmb) , 'Q' , 0)
				SELECT @QtrEndDT = End_Dt  FROM [dbo].[udf_GetDates]([dbo].udf_GetDateFromID(@DateIDNmb) , 'Q' , 0)
				SELECT @YTDStartDT = Strt_Dt  FROM [dbo].[udf_GetDates]([dbo].udf_GetDateFromID(@DateIDNmb) , 'FY' , 0)
				SELECT @YTDEndDT = End_Dt  FROM [dbo].[udf_GetDates]([dbo].udf_GetDateFromID(@DateIDNmb) , 'FY' , 0)
		
	
			---======================================Insert into BaseData table from the view Vw.GeneralLedger=======================
			
			Insert @BaseData
			select Gl.Date			,
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
					Inner Join Company_Dim C on Gl.CompanyName=C.CompanyName
			WHERE Gl.ReportTypeCode = 'INC'
					AND GL.Date <= [dbo].udf_GetDateFromID(@DateIDNmb)
					And C.Idnmb=@CompanyIdNmb
		
			----======================================== Select the @DateIDNmb and  Store the Value in @AsOfDate ================================================
		
			Set @AsOfDate= (Select dbo.udf_GetDateFromID(@DateIDNmb))
			
		---===================================---=========================================================================================================
		--DATEPART(QUARTER,@AsOfDate) + '-' + DATEPART(YYYY,@AsOfDate)
		set @QtrHeader= ( 'Q' + CAST(DATEPART(QUARTER,@AsOfDate) AS char(1))+' '+ CAST(DATEPART(YYYY,@AsOfDate) AS char(4)) ) 
		set @lastQtrHeader= ( 'Q' + CAST(DATEPART(QUARTER,@LastQtrStartDT) AS char(1))+' '+ CAST(DATEPART(YYYY,@LastQtrStartDT) AS char(4)) ) 
		set @YTDHeader= (CAST(DATEPART(YYYY,@YTDStartDT) AS char(4))+' '+ 'YTD'   ) 
			Print 'Qtrheader'
			Print @Qtrheader	
			Print 'lastQtrheader'
			Print @lastQtrHeader
			Print 'Ytdheader'
			Print @YTDheader
			----========================================Get the Distinct Count of number of total number of sectiontype (Income,Cost oF service, Expenses) ================================================


			Set  @CountofSectiontype = (select Count(distinct(SectionTypeName)) from vw_GeneralLedger where SectionTypeName is not null)
	

			----========================================Output the Table ================================================

			Create table #Reportdata 
			(
				TopUnderlineFLg int null				,
				DoubleUnderlineFlg int Null				,
				TotalFlg int null						,
				BoldFlg int null						,
				SectionTypeName Varchar(100) NUll		,
				SectionSubTypeName Varchar(100) NUll	,
				QuaterEndAmount Varchar(100) Null		,
				LastQuaterEndAmount Varchar(100) Null	,
				YearEndAmount Varchar(100) Null		,
				[Orderby] Float NUll
			)


			


	Insert #Reportdata  
			
			---======================Below Query is used to get the sum of section type (Income,Cost of service,Expenses) =====================

			select	
					  NULL	--TopUnderlineFLg
					, NULL	--DoubleUnderlineFlg
					, NULL	--TotalFlg		
					, NULL	--Boldflg
					, Gl.SectionTypeName	
					, Gl.SectionSubTypeName
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.ReportAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  Gl.ReportAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  Gl.ReportAmount Else 0 End)
					, GL.SectionTypeOrder 
			From @BaseData Gl
				       WHERE GL.SectionTypeName IS NOT NULL
			Group BY 
					 GL.SectionTypeOrder
					,Gl.SectionTypeName
					,Gl.SectionSubTypeName
					
			
	-----======================( Data Between EBAC AND EBITDA )Below Query is used to get the sum of All where section type is not there and only enteries Between EBAC AND EBITDA =====================
			UNion
			
			select			
					  NULL	--TopUnderlineFLg
					, NULL	--DoubleUnderlineFlg
					, NULL	--TotalFlg		
					, NULL  --Boldflg
					, Gl.SectionTypeName
					, Gl.SectionSubTypeName 
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.EBITDAAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  GL.EBITDAAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  GL.EBITDAAmount Else 0 End)
					, @CountofSectiontype+2
			From @BaseData Gl
									
			where
																	-----Added this clause Separetely Just to Diferentiate BEtween Data With Section and Without SectionWise  
					 Gl.BEForeEBITDA=1 							
			Group BY 
					  --Gl.SectionTypeOrder
					  Gl.SectionTypeName
					, Gl.SectionSubTypeName
					
	-------====================== ( Data Between  EBITDA and NetIncome) Below Query is used to get the sum of All where section type is not there and only enteries Between  EBITDA and NetIncome =====================			
	
			UNion
			select			
					  NULL	--TopUnderlineFLg
					, NULL	--DoubleUnderlineFlg
					, NULL	--TotalFlg		
					, NULL  --Boldflg
					, Gl.SectionTypeName
					, Gl.SectionSubTypeName 
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.NetIncomeAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  GL.NetIncomeAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  GL.NetIncomeAmount Else 0 End)
					, @CountofSectiontype+4
			From @BaseData Gl
									
			where 	
					 Gl.BEForeNetIncome=1 							-----Added this clause Separetely Just to Diferentiate BEtween Data With Section and Without SectionWise  
			Group BY 
					Gl.SectionTypeName
					,Gl.SectionSubTypeName
			

	--		----=============================================== Get the Total Income,Cost of Service, Expenses ====================================================================

			union
			Select 
					  1			--TopUnderlineFLg
					, NULL		--DoubleUnderlineFlg
					, 1			--TotalFlg
					, 1			--Boldflg
					, null
					,'Total' +' '+ Gl.SectionTypeName
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.ReportAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  GL.ReportAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  GL.ReportAmount Else 0 End)
					, 3.4
			From @BaseData Gl
					
					WHERE GL.SectionTypeName IS NOT NULL
			Group BY
					 Gl.SectionTypeOrder
					,Gl.SectionTypeName
			
	
	----		-----======================================================= Earnings Before Advisor Compensation Amount =========================================================
			
			Union
			Select 
					  1			--TopUnderlineFLg
					, 1			--DoubleUnderlineFlg
					, 1			--TotalFlg
					, 1			--Boldflg
					, null
					, 'Earnings Before Advisor Compensation' 
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.EBACAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  GL.EBACAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  GL.EBACAmount Else 0 End)
					, @CountofSectiontype -2
			From @BaseData Gl
					
			
	------		---======================================================= EBITDA Amount =========================================================

			Union
			Select
					  1			--TopUnderlineFLg
					, 1			 -- DoubleUnderlineFlg
					, 1			--TotalFlg
					, 1			--Boldflg
					, null
					, 'EBITDA'
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.EBITDAAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  GL.EBITDAAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  GL.EBITDAAmount Else 0 End) 
					,@CountofSectiontype + 3
			From @BaseData Gl
					
			 

	----		---======================================================= Net income Amount =========================================================
			Union
			Select 
					  1			--TopUnderlineFLg
					, 1			-- DoubleUnderlineFlg
					, 1			--TotalFlg
					, 1			--Boldflg
					, null
					, 'Net Income'
					, sum(Case When Gl.Date>=@QtrStartDT and Gl.Date<=@AsOfDate Then  Gl.NetIncomeAmount Else 0 End)
					, sum(Case When Gl.Date>=@LastQtrStartDT and Gl.Date<=@LastQtrEndDT Then  GL.NetIncomeAmount Else 0 End) 
					, sum(Case When Gl.Date>=@YTDStartDT and Gl.Date<=@AsOfDate Then  GL.NetIncomeAmount Else 0 End) 
					, @CountofSectiontype + 5
			From @BaseData Gl
					
			
			
			
	----		-----===========================================================Used For formatting The Dataset =========================================
		
			Insert into #Reportdata
			select Distinct null,null,null,1,null,R.SectionTypeName,null,null,null,R.Orderby-0.2    ---- Adding SectionType Rows
				from #Reportdata R where R.SectionTypeName is not null

			INsert into #Reportdata
			select null,null,null,null,null,null,null,null,null,R.Orderby+0.3               ----Adding Null Rows
				From #Reportdata R where R.TotalFlg=1

			
			INsert into #Reportdata
			select 	null,null,null,null,null,null,null,null,null,R.Orderby-0.3					--- Adding NUll Rows between EBITDA and INCOME
				From #Reportdata R where R.SectionSubTypeName in ('EBITDA','Net Income')	
				
			-----===================================== Final Query ==================================================================
		
		
			SET @Sql = ''  
			Set @Sql =   
						 '  
						 Select     TopUnderlineFLg 
									,  DoubleUnderlineFlg
									,  TotalFlg	
									,  Boldflg
									, SectionSubtypeName AS ''     ''  
									, ''$'' + (CONVERT(varchar, CAST(QuaterEndAmount AS money), 1)) '+' as '+'   [' +'Actual'+' '+ @QtrHeader +' ]  
									, '' ''	
									, ''$'' + (CONVERT(varchar, CAST(LastQuaterEndAmount AS money), 1)) '+' as '+'   [' +'Actual' +' '+ @lastQtrHeader +' ]  
									, '' ''
									, ''$'' + (CONVERT(varchar, CAST(YearEndAmount AS money), 1)) '+' as '+'   [' +'Actual'+' '+ @YTDHeader +' ]  
									, Orderby
								
						 FROM #Reportdata 
						 Order by  [Orderby]  
						'    
		
			EXECute  (@SQL)
		
End 
GO
	
	