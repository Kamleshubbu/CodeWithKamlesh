USE Dynasty_DW
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Hierarchy_Dim]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_GeneralLedger

GO

/*

				Select * from Vw_generalledger Where sectiontypeName='Expenses'

*/
CREATE VIEW dbo.vw_GeneralLedger
AS

	SELECT D.Date
			, CAST(DATEPART(YYYY,cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(D.DateIDNmb)), 0) as date)) AS char(4))+' '+ 'Q' + CAST(DATEPART(QUARTER,cast(DATEADD(q, DATEDIFF(q, 0, Dynasty_DW.DBO.udf_GetDateFromID(D.DateIDNmb)), 0) as date)) AS char(1)) as 'QuarterPeriod'	
			, A.AccountNumber
			, A.AccountName
			, H.[Order] as 'AccountOrder'
			, A.AdvisorFlag
			, A.ClosesInto
			, A.TransactionType
			, C.CompanyCode
			, C.CompanyName
			, C.BillingName AS 'CompanyBillingName'
			, SC.SubCompanyCode
			, SC.SubCompanyName
			, AD.AdvisorCode
			, AD.AdvisorName
			, RT.ReportTypeCode
			, RT.ReportTypeName
			, ST.SectionTypeName
			, ST.[Order] as 'SectionTypeOrder'
			, SST.SectionSubTypeName
			, H.sectionSubTypeOrder as 'TypeOrder'
			, SSST.SubSubTypeName
			, H.SubSubTypeOrder
			, SST.BeforeEBITDA
			, SST.BeforeNetIncome
			, CL.ClassCode
			, CL.ClassName
			, V.VendorCode
			, V.VendorName
			, GL.Amount
			, GL.Amount*Isnull(H.ReportMultiplierNmb, 0) As ReportAmount
			, GL.Amount*Isnull(H.EBACMultiplierNmb, 0) As EBACAmount
			, GL.Amount*Isnull(H.EBITDAMultiplierNmb, 0) As EBITDAAmount
			, GL.Amount*Isnull(H.NetIncomeMulitplierNmb, 0) As NetIncomeAmount
			, C.Idnmb as 'Companyidnmb'
			, C.DIVISION
			, C.City
			, C.[State]
			, C.[Status]
			, C.PreviousFirm
			, C.RM
		FROM GeneralLedger_Fact GL
			JOIN Account_Dim A on GL.AccountIdNmb = A.Idnmb
			JOIN NewHierarchy_Dim H on H.Idnmb = dbo.udf_GetTopHierarchyID(A.AccountNumber)
			JOIN Company_Dim C on GL.CompanyIdNmb = C.Idnmb
			JOIN Sub_Company_Dim SC on GL.SubCompanyIdNmb = SC.Idnmb and SC.CompanyIDNmb=C.Idnmb
			LEFT JOIN Advisor_Dim AD on GL.AdvisorIDNmb = AD.Idnmb and Ad.CompanyIDNmb=C.Idnmb
			JOIN ReportType_Dim RT on A.ReportTypeIDNmb = RT.Idnmb
			LEFT OUTER JOIN SectionType_Dim ST on A.SectionTypeIDNmb = ST.Idnmb
			JOIN SectionSubType_Dim SST on A.SectionSubTypeIDNmb = SST.Idnmb
			JOIN Date_Dim D on GL.DateIdNmb = D.DateIDNmb
			Left join Class_Dim CL on Gl.ClassIDNmb=CL.Idnmb
			Left Join Vendor_Dim V on GL.VendorIDNmb=V.Idnmb and V.CompanyIDNmb=C.Idnmb
			Left Join Dynasty_DW..SubSubType_Dim SSST on A.SubSubTypeIdnmb=SSST.Idnmb


