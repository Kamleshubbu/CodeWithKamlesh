
USE Dynasty_DW
GO
-------------------------------------PeriodTypeidnmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_ExpensesMonthlyFirm_fact_PeriodTypeidnmb_Periodtype_Dim')))
	BEGIN
		print 'Creating FK_ExpensesMonthlyFirm_fact_PeriodTypeidnmb_Periodtype_Dim'
		ALTER TABLE [dbo].ExpensesMonthlyFirm_fact ADD 
			CONSTRAINT FK_ExpensesMonthlyFirm_fact_PeriodTypeidnmb_Periodtype_Dim FOREIGN KEY 
			(
				[PeriodtypeIDNmb]
			) 
			REFERENCES [dbo].[Periodtype_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_ExpensesMonthlyFirm_fact_PeriodTypeidnmb_Periodtype_Dim'
	END
ELSE
	BEGIN
		print 'FK_ExpensesMonthlyFirm_fact_PeriodTypeidnmb_Periodtype_Dim Already exists'
	END


GO

