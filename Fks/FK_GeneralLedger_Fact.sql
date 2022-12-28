Use [Dynasty_DW]
Go
-------------------------------------------------------Accountidnmb--------------------------------------------------

IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_GeneralLedger_Fact_AccountIdNmb_Account_Dim')))
	BEGIN
		    print 'Creating FK_GeneralLedger_Fact_AccountIdNmb_Account_Dim ...'

			ALTER TABLE [dbo].[GeneralLedger_Fact]  
			WITH CHECK ADD  CONSTRAINT [FK_GeneralLedger_Fact_AccountIdNmb_Account_Dim] FOREIGN KEY
			(
					[AccountIdNmb]
			)
			REFERENCES [dbo].[Account_Dim] 
			(
					[Idnmb]
			)
			    print 'Created FK_GeneralLedger_Fact_AccountIdNmb_Account_Dim Successfully'
	End
	ELSE
	BEGIN
		print 'FK_GeneralLedger_Fact_AccountIdNmb_Account_Dim  Already exists'
	END

GO
-------------------------------------------------------AdvisorIDnmb--------------------------------------------------

IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_GeneralLedger_Fact_AdvisorIDNmb_Advisor_Dim')))
	BEGIN
			print 'Creating FK_GeneralLedger_Fact_AdvisorIDNmb_Advisor_Dim ...'
			ALTER TABLE [dbo].[GeneralLedger_Fact] 
			WITH CHECK ADD  CONSTRAINT [FK_GeneralLedger_Fact_AdvisorIDNmb_Advisor_Dim] FOREIGN KEY
			(
					[AdvisorIDNmb]
			)
			REFERENCES [dbo].[Advisor_Dim] 
			(
					[Idnmb]
			)
						print 'Created FK_GeneralLedger_Fact_AdvisorIDNmb_Advisor_Dim Successfully'
	End
	ELSE
			BEGIN
				print 'FK_GeneralLedger_Fact_AdvisorIDNmb_Advisor_Dim  Already exists'
			END
GO
-----------------------------------------------------------CompanyIdnmb-----------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_GeneralLedger_Fact_CompanyIdNmb_Company_Dim')))
	BEGIN
					print 'Creating FK_GeneralLedger_Fact_CompanyIdNmb_Company_Dim ...'
					ALTER TABLE [dbo].[GeneralLedger_Fact] 
					WITH CHECK ADD  CONSTRAINT [FK_GeneralLedger_Fact_CompanyIdNmb_Company_Dim] FOREIGN KEY
					(
							[CompanyIdNmb]
					)
					REFERENCES [dbo].[Company_Dim]
					(
							[Idnmb]
					)
					print 'Created FK_GeneralLedger_Fact_CompanyIdNmb_Company_Dim Successfully'
	End
	ELSE
			BEGIN
				print 'FK_GeneralLedger_Fact_CompanyIdNmb_Company_Dim  Already exists'
			END
GO
-----------------------------------------------------------DateIdnmb-----------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_GeneralLedger_Fact_DateIdNmb_Date_Dim')))
	BEGIN
					print 'Creating FK_GeneralLedger_Fact_DateIdNmb_Date_Dim ...'
					ALTER TABLE [dbo].[GeneralLedger_Fact]  WITH CHECK ADD  CONSTRAINT [FK_GeneralLedger_Fact_DateIdNmb_Date_Dim] FOREIGN KEY
					(
							[DateIdNmB]
					)
					REFERENCES [dbo].[Date_Dim] 
					(
							[DateIDNmb]
					)
					print 'Created FK_GeneralLedger_Fact_DateIdNmb_Date_Dim Successfully'
	End
	ELSE
			BEGIN
				print 'FK_GeneralLedger_Fact_DateIdNmb_Date_Dim  Already exists'
			END
GO

-----------------------------------------------------------SubCompanyIdnmb-----------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_GeneralLedger_Fact_SubCompanyIdnmb_Sub_Company_Dim')))
	BEGIN
					print 'Creating FK_GeneralLedger_Fact_SubCompanyIdnmb_Sub_Company_Dim ...'
					ALTER TABLE [dbo].[GeneralLedger_Fact]  WITH CHECK ADD  CONSTRAINT [FK_GeneralLedger_Fact_SubCompanyIdnmb_Sub_Company_Dim] FOREIGN KEY
					(
							[SubCompanyIdnmb]
					)
					REFERENCES [dbo].[Sub_Company_Dim] 
					(
							[IDNmb]
					)
					print 'Created FK_GeneralLedger_Fact_SubCompanyIdnmb_Sub_Company_Dim Successfully'
	End
	ELSE
			BEGIN
				print 'FK_GeneralLedger_Fact_SubCompanyIdnmb_Sub_Company_Dim  Already exists'
			END
GO

