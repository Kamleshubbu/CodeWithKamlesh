USE [Dynasty_DW]
GO


----================================================   UQ_BillingSource_Dim_BillingSourceName ============================================================

ALTER TABLE [dbo].[BillingSource_Dim] DROP CONSTRAINT [UQ_BillingSource_Dim_BillingSourceName]
GO

Print 'Creating [UQ_BillingSource_Dim_BillingSourceName] Unique key '
ALTER TABLE [dbo].[BillingSource_Dim] ADD  CONSTRAINT [UQ_BillingSource_Dim_BillingSourceName] UNIQUE NONCLUSTERED 
(
	[BillingSourceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---================================================   UQ_CalculationType_Dim_CalculationTypeName  ============================================================

ALTER TABLE [dbo].[CalculationType_Dim] DROP CONSTRAINT [UQ_CalculationType_Dim_CalculationTypeName]
GO

Print 'Creating UQ_CalculationType_Dim_CalculationTypeName Unique key '
ALTER TABLE [dbo].[CalculationType_Dim] ADD  CONSTRAINT [UQ_CalculationType_Dim_CalculationTypeName] UNIQUE NONCLUSTERED 
(
	[CalculationTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   UQ_Custodian_Dim_CustodianName  ==========================================================================

ALTER TABLE [dbo].[Custodian_Dim] DROP CONSTRAINT [UQ_Custodian_Dim_CustodianName]
GO


Print 'Creating UQ_Custodian_Dim_CustodianName Unique key '
ALTER TABLE [dbo].[Custodian_Dim] ADD  CONSTRAINT [UQ_Custodian_Dim_CustodianName] UNIQUE NONCLUSTERED 
(
	[CustodianName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   UQ_Household_Dim_HouseholdName_Companyidnmb  ==========================================================================

ALTER TABLE [dbo].[Household_Dim] DROP CONSTRAINT [UQ_Household_Dim_HouseholdName_Companyidnmb]
GO

Print 'Creating UQ_Household_Dim_HouseholdName_Companyidnmb Unique key '
ALTER TABLE [dbo].[Household_Dim] ADD  CONSTRAINT [UQ_Household_Dim_HouseholdName_Companyidnmb] UNIQUE NONCLUSTERED 
(
	[HouseholdName] ASC,
	[CompanyIDNmb] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   [UQ_InvestmentAccount_Dim_InvestmentAccountNumber]]  ==========================================================================

ALTER TABLE [dbo].[InvestmentAccount_Dim] DROP CONSTRAINT [UQ_InvestmentAccount_Dim_InvestmentAccountNumber]
GO

Print 'Creating [UQ_InvestmentAccount_Dim_InvestmentAccountNumber] Unique key '
ALTER TABLE [dbo].[InvestmentAccount_Dim] ADD  CONSTRAINT [UQ_InvestmentAccount_Dim_InvestmentAccountNumber] UNIQUE NONCLUSTERED 
(
	[InvestmentAccountNumber] ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb_InvestmentadvisorName  ======================================================


ALTER TABLE [dbo].[InvestmentAdvisor_Dim] DROP CONSTRAINT [UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb_InvestmentadvisorName]
GO

Print 'Creating UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb_InvestmentadvisorName Unique key '
ALTER TABLE [dbo].[InvestmentAdvisor_Dim] ADD  CONSTRAINT [UQ_InvestmentAdvisor_Dim_InvestmentAdvisorCode_Companyidnmb_InvestmentadvisorName] UNIQUE NONCLUSTERED 
(
	[InvestmentAdvisorCode] ASC,
	[CompanyIDNmb] ASC,
	[InvestmentAdvisorName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   UQ_Manager_Dim_ManagerName  =======================================================================================================

ALTER TABLE [dbo].[Manager_Dim] DROP CONSTRAINT UQ_Manager_Dim_ManagerName
GO

Print 'Creating UQ_Manager_Dim_ManagerName Unique key '
ALTER TABLE [dbo].[Manager_Dim] ADD  CONSTRAINT [UQ_Manager_Dim_ManagerName] UNIQUE NONCLUSTERED 
(
	[ManagerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---===================================================   UQ_ProductType_Dim_ProductTypeName  =======================================================================================================

ALTER TABLE [dbo].[Producttype_Dim] DROP CONSTRAINT UQ_ProductType_Dim_ProductTypeName
GO

Print 'Creating UQ_ProductType_Dim_ProductTypeName Unique key '
ALTER TABLE [dbo].[ProductType_Dim] ADD  CONSTRAINT UQ_ProductType_Dim_ProductTypeName UNIQUE NONCLUSTERED 
(
	[ProductTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   UQ_BillType_Dim_BillTypeName  =================================================================================


ALTER TABLE [dbo].[BillType_Dim] DROP CONSTRAINT UQ_BillType_Dim_BillTypeName
GO

Print 'Creating UQ_BillType_Dim_BillTypeName Unique key '
ALTER TABLE [dbo].[BillType_Dim] ADD  CONSTRAINT UQ_BillType_Dim_BillTypeName UNIQUE NONCLUSTERED 
(
	[BillTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---===================================================   UQ_ProductGroup_Dim_ProductGroupName  =================================================================================


ALTER TABLE [dbo].[ProductGroup_Dim] DROP CONSTRAINT [UQ_ProductGroup_Dim_ProductGroupName]
GO

Print 'Creating UQ_ProductGroup_Dim_ProductGroupName Unique key '
ALTER TABLE [dbo].[ProductGroup_Dim] ADD  CONSTRAINT [UQ_ProductGroup_Dim_ProductGroupName] UNIQUE NONCLUSTERED 
(
	[ProductGroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---===================================================   UQ_AssetType_Dim_AssetTypeName  =================================================================================


ALTER TABLE [dbo].[AssetType_Dim] DROP CONSTRAINT [UQ_AssetType_Dim_AssetTypeName]
GO

Print 'Creating UQ_AssetType_Dim_AssetTypeName Unique key '
ALTER TABLE [dbo].[AssetType_Dim] ADD  CONSTRAINT [UQ_AssetType_Dim_AssetTypeName] UNIQUE NONCLUSTERED 
(
	[AssetTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---===================================================   UQ_Strategy_Dim_StrategyName  =================================================================================


ALTER TABLE [dbo].[Strategy_Dim] DROP CONSTRAINT UQ_Strategy_Dim_StrategyName
GO

Print 'Creating UQ_Strategy_Dim_StrategyName Unique key '
ALTER TABLE [dbo].[Strategy_Dim] ADD  CONSTRAINT UQ_Strategy_Dim_StrategyName UNIQUE NONCLUSTERED 
(
	[StrategyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---===================================================   UQ_PeriodType_Dim_PeriodtypeName  =================================================================================


ALTER TABLE [dbo].[PeriodType_Dim] DROP CONSTRAINT UQ_PeriodType_Dim_PeriodtypeName
GO

Print 'Creating UQ_PeriodType_Dim_PeriodtypeName Unique key '
ALTER TABLE [dbo].[PeriodType_Dim] ADD  CONSTRAINT UQ_PeriodType_Dim_PeriodtypeName UNIQUE NONCLUSTERED 
(
	[PeriodTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

