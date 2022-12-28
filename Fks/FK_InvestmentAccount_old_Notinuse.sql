
USE Dynasty_DW
GO
-------------------------------------CustodianIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_InvestmentAccount_Dim_CustodianIdNmb_Custodian_Dim')))
	BEGIN
		print 'Creating FK_InvestmentAccount_Dim_CustodianIdNmb_Custodian_Dim'
		ALTER TABLE [dbo].[InvestmentAccount_Dim] ADD 
			CONSTRAINT FK_InvestmentAccount_Dim_CustodianIdNmb_Custodian_Dim FOREIGN KEY 
			(
				[CustodianIdNmb]
			) 
			REFERENCES [dbo].[Custodian_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_InvestmentAccount_Dim_CustodianIdNmb_Custodian_Dim'
	END
ELSE
	BEGIN
		print 'FK_InvestmentAccount_Dim_CustodianIdNmb_Custodian_Dim Already exists'
	END

-------------------------------------CalculationTypeIdNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_InvestmentAccount_Dim_CalculationTypeIdNmb_CalculationType_Dim')))
	BEGIN
		print 'Creating FK_InvestmentAccount_Dim_CalculationTypeIdNmb_CalculationType_Dim'
		ALTER TABLE [dbo].[InvestmentAccount_Dim] ADD 
			CONSTRAINT FK_InvestmentAccount_Dim_CalculationTypeIdNmb_CalculationType_Dim FOREIGN KEY 
			(
				CalculationTypeIdNmb
			) 
			REFERENCES [dbo].[CalculationType_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_InvestmentAccount_Dim_CalculationTypeIdNmb_CalculationType_Dim'
	END
ELSE
	BEGIN
		print 'FK_InvestmentAccount_Dim_CalculationTypeIdNmb_CalculationType_Dim Already exists'
	END
GO

