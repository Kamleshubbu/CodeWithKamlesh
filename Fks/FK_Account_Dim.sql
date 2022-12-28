
USE Dynasty_DW
GO
-------------------------------------ReportType---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_Account_Dim_ReportTypeIDNmb_ReportType_Dim')))
	BEGIN
		print 'Creating FK_Account_Dim_ReportTypeIDNmb_ReportType_Dim'
		ALTER TABLE [dbo].[Account_Dim] ADD 
			CONSTRAINT [FK_Account_Dim_ReportTypeIDNmb_ReportType_Dim] FOREIGN KEY 
			(
				[ReportTypeIDNmb]
			) 
			REFERENCES [dbo].[ReportType_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_Account_Dim_ReportTypeIDNmb_ReportType_Dim'
	END
ELSE
	BEGIN
		print 'FK_Account_Dim_ReportTypeIDNmb_ReportType_Dim Already exists'
	END


GO


-------------------------------------Section Type---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_Account_Dim_SectionSubTypeIDNmb_SectionSubType_Dim')))
	BEGIN
		print 'Creating FK_Account_Dim_SectionSubTypeIDNmb_SectionSubType_Dim'
		ALTER TABLE [dbo].[Account_Dim] ADD 
			CONSTRAINT [FK_Account_Dim_SectionSubTypeIDNmb_SectionSubType_Dim] FOREIGN KEY 
			(
				[SectionSubTypeIDNmb]
			) 
			REFERENCES [dbo].[SectionSubType_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_Account_Dim_SectionSubTypeIDNmb_SectionSubType_Dim'
	END
ELSE
	BEGIN
		print 'FK_Account_Dim_SectionSubTypeIDNmb_SectionSubType_Dim Already exists'
	END


GO

-------------------------------------Section Type---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_Account_Dim_SubSubTypeIDNmb_SubSubType_Dim')))
	BEGIN
		print 'Creating FK_Account_Dim_SubSubTypeIDNmb_SubSubType_Dim'
		ALTER TABLE [dbo].[Account_Dim] ADD 
			CONSTRAINT FK_Account_Dim_SubSubTypeIDNmb_SubSubType_Dim FOREIGN KEY 
			(
				[SubSubTypeIDNmb]
			) 
			REFERENCES [dbo].[SubSubType_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_Account_Dim_SubSubTypeIDNmb_SubSubType_Dim'
	END
ELSE
	BEGIN
		print 'FK_Account_Dim_SubSubTypeIDNmb_SubSubType_Dim Already exists'
	END


GO

