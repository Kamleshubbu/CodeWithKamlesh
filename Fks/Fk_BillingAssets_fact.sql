USE Dynasty_DW
GO
-------------------------------------InvestedDateIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_InvestedDateIdNmb_Date_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_InvestedDateIdNmb_Date_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_InvestedDateIdNmb_Date_Dim FOREIGN KEY 
			(
				[InvestedDateIdNmb]
			) 
			REFERENCES [dbo].[Date_Dim] 
			(
				[DateIdnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_InvestedDateIdNmb_Date_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_InvestedDateIdNmb_Date_Dim Already exists'
	END


GO

-------------------------------------AsOfDateIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_AsOfDateIdNmb_Date_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_AsOfDateIdNmb_Date_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_AsOfDateIdNmb_Date_Dim FOREIGN KEY 
			(
				[AsOfDateIdNmb]
			) 
			REFERENCES [dbo].[Date_Dim] 
			(
				[DateIdnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_AsOfDateIdNmb_Date_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_AsOfDateIdNmb_Date_Dim Already exists'
	END


GO


-------------------------------------Companyidnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_Companyidnmb_Company_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_AsOfDateIdNmb_Date_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_Companyidnmb_Company_Dim FOREIGN KEY 
			(
					Companyidnmb
			) 
			REFERENCES [dbo].[Company_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_Companyidnmb_Company_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_Companyidnmb_Company_Dim Already exists'
	END


GO

-------------------------------------InvestmentAccountIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_InvestmentAccountIdNmb_InvestmentAccount_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_InvestmentAccountIdNmb_InvestmentAccount_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_InvestmentAccountIdNmb_InvestmentAccount_Dim FOREIGN KEY 
			(
				[InvestmentAccountIdNmb]
			) 
			REFERENCES [dbo].[InvestmentAccount_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_InvestmentAccountIdNmb_InvestmentAccount_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_InvestmentAccountIdNmb_InvestmentAccount_Dim Already exists'
	END


GO

-------------------------------------HouseholdIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_HouseholdIdNmb_Household_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_HouseholdIdNmb_Household_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_HouseholdIdNmb_Household_Dim FOREIGN KEY 
			(
				[HouseholdIdNmb]
			) 
			REFERENCES [dbo].[Household_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_HouseholdIdNmb_Household_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_HouseholdIdNmb_Household_Dim Already exists'
	END


GO


-------------------------------------InvestmentAdvisorIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_InvestmentAdvisorIdNmb_InvestmentAdvisor_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_InvestmentAdvisorIdNmb_InvestmentAdvisor_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_InvestmentAdvisorIdNmb_InvestmentAdvisor_Dim FOREIGN KEY 
			(
				[InvestmentAdvisorIdNmb]
			) 
			REFERENCES [dbo].[InvestmentAdvisor_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_InvestmentAdvisorIdNmb_InvestmentAdvisor_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_InvestmentAdvisorIdNmb_InvestmentAdvisor_Dim Already exists'
	END


GO

-------------------------------------BIllTypeIDNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_BIllTypeIDNmb_BillType_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_BIllTypeIDNmb_BillType_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_BIllTypeIDNmb_BillType_Dim FOREIGN KEY 
			(
				BillTypeIDNmb
			) 
			REFERENCES [dbo].[BIllType_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_BIllTypeIDNmb_BillType_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_BIllTypeIDNmb_BillType_Dim Already exists'
	END


GO

-------------------------------------Calculationtypeidnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_Calculationtypeidnmb_CalculationType_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_Calculationtypeidnmb_CalculationType_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_Calculationtypeidnmb_CalculationType_Dim FOREIGN KEY 
			(
				Calculationtypeidnmb
			) 
			REFERENCES [dbo].[CalculationType_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_Calculationtypeidnmb_CalculationType_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_Calculationtypeidnmb_CalculationType_Dim Already exists'
	END


GO

-------------------------------------CustodianIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_CustodianIdNmb_Custodian_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_CustodianIdNmb_Custodian_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_CustodianIdNmb_Custodian_Dim FOREIGN KEY 
			(
				custodianIdnmb
			) 
			REFERENCES [dbo].[Custodian_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_CustodianIdNmb_Custodian_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_CustodianIdNmb_Custodian_Dim Already exists'
	END

-------------------------------------BILLINGSOURCEIDNMB---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_BILLINGSOURCEIDNMB_BillingSource_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_BILLINGSOURCEIDNMB_BillingSource_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_BILLINGSOURCEIDNMB_BillingSource_Dim FOREIGN KEY 
			(
				BillingSourceIdnmb
			) 
			REFERENCES [dbo].[BillingSource_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_BILLINGSOURCEIDNMB_BillingSource_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_BILLINGSOURCEIDNMB_BillingSource_Dim Already exists'
	END



-------------------------------------Manageridnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_Manageridnmb_Manager_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_Manageridnmb_Manager_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_Manageridnmb_Manager_Dim FOREIGN KEY 
			(
				Manageridnmb
			) 
			REFERENCES [dbo].[Manager_dim]
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_Manageridnmb_Manager_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_Manageridnmb_Manager_Dim Already exists'
	END


-------------------------------------ProductTypeidnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_ProductTypeidnmb_ProductType_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_ProductTypeidnmb_ProductType_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_ProductTypeidnmb_ProductType_Dim FOREIGN KEY 
			(
				ProductTypeidnmb
			) 
			REFERENCES [dbo].[ProductType_dim]
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_ProductTypeidnmb_ProductType_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_ProductTypeidnmb_ProductType_Dim Already exists'
	END

	-------------------------------------ProductGroupidnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_ProductGroupidnmb_ProductGroup_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_ProductGroupidnmb_ProductGroup_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_ProductGroupidnmb_ProductGroup_Dim FOREIGN KEY 
			(
				ProductGroupidnmb
			) 
			REFERENCES [dbo].[ProductGroup_Dim]
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_ProductGroupidnmb_ProductGroup_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_ProductGroupidnmb_ProductGroup_Dim Already exists'
	END

-------------------------------------AssetTypeidnmb---------------------------------------------------------


IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_AssetTypeidnmb_AssetType_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_AssetTypeidnmb_AssetType_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_AssetTypeidnmb_AssetType_Dim FOREIGN KEY 
			(
				Assettypeidnmb
			) 
			REFERENCES [dbo].[AssetType_Dim]
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_AssetTypeidnmb_AssetType_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_ProductGroupidnmb_ProductGroup_Dim Already exists'
	END


-------------------------------------PeriodstartDateIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_PeriodstartDateIdNmb_Date_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_PeriodstartDateIdNmb_Date_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_PeriodstartDateIdNmb_Date_Dim FOREIGN KEY 
			(
				[PeriodstartDateIdNmb]
			) 
			REFERENCES [dbo].[Date_Dim] 
			(
				[DateIdnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_PeriodstartDateIdNmb_Date_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_PeriodstartDateIdNmb_Date_Dim Already exists'
	END


-------------------------------------PeriodEndDateIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_PeriodEndDateIdNmb_Date_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_PeriodEndDateIdNmb_Date_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_PeriodEndDateIdNmb_Date_Dim FOREIGN KEY 
			(
				[PeriodEndDateIdNmb]
			) 
			REFERENCES [dbo].[Date_Dim] 
			(
				[DateIdnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_PeriodEndDateIdNmb_Date_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_PeriodEndDateIdNmb_Date_Dim Already exists'
	END


	-------------------------------------StrategyIdnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_billingAssets_Fact_StrategyIdnmb_Strategy_Dim')))
	BEGIN
		print 'Creating FK_billingAssets_Fact_StrategyIdnmb_Strategy_Dim'
		ALTER TABLE [dbo].[BillingAssets_Fact] ADD 
			CONSTRAINT FK_billingAssets_Fact_StrategyIdnmb_Strategy_Dim FOREIGN KEY 
			(
				Strategyidnmb
			) 
			REFERENCES [dbo].[Strategy_Dim]
			(
				[Idnmb]
			)
		print 'DONE Creating FK_billingAssets_Fact_StrategyIdnmb_Strategy_Dim'
	END
ELSE
	BEGIN
		print 'FK_billingAssets_Fact_StrategyIdnmb_Strategy_Dim Already exists'
	END



GO





GO







