USE [Dynasty_DW]
GO

/****** Object:  Index [NC_BillingAssets_Fact]    Script Date: 8/22/2019 9:01:23 PM ******/
DROP INDEX [NC_BillingAssets_Fact] ON [dbo].[BillingAssets_Fact]
GO

/****** Object:  Index [NC_BillingAssets_Fact]    Script Date: 8/22/2019 9:01:23 PM ******/
CREATE NONCLUSTERED INDEX [NC_BillingAssets_Fact] ON [dbo].[BillingAssets_Fact]
(
	[CompanyIdNmb] ASC,
	[CustodianIdNmb] ASC,
	[HouseholdIdNmb] ASC,
	[InvestmentAccountIdNmb] ASC,
	[InvestedDateIdNmb] ASC
)
INCLUDE ( 	[InvestmentAdvisorIdNmb],
	[ManagerIDNmb],
	[ProductIdNmb],
	[TypeIDNmb]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


