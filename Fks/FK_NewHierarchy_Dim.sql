
USE [Dynasty_DW]
GO
-------------------------------------ReportTypeIDNmb---------------------------------------------------------


IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_NewHierarchy_Dim_ReportTypeIDNmb_ReportType_Dim')))
	BEGIN
		print 'FK_NewHierarchy_Dim_ReportTypeIDNmb_ReportType_Dim'

		ALTER TABLE [dbo].[NewHierarchy_Dim]  
		WITH CHECK ADD  CONSTRAINT [FK_NewHierarchy_Dim_ReportTypeIDNmb_ReportType_Dim] FOREIGN KEY
		(
				[ReportTypeIDNmb]
		)
		REFERENCES [dbo].[ReportType_Dim] 
		(
				[Idnmb]
		)

		print 'FK_NewHierarchy_Dim_ReportTypeIDNmb_ReportType_Dim Created Successfully'
End
ELSE
	BEGIN
		print 'FK_NewHierarchy_Dim_ReportTypeIDNmb_ReportType_Dim Already exists'
	END

GO
----------------------------------------------------------------------SectionSubtypeidNmb---------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_NewHierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim')))
	BEGIN
		print 'Creating FK_NewHierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim'
			ALTER TABLE [dbo].[NewHierarchy_Dim] 
			WITH CHECK ADD  CONSTRAINT [FK_NewHierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim] FOREIGN KEY
			(
					[SectionSubTypeIDNmb]
			)
			REFERENCES [dbo].[SectionSubType_Dim]
			(
					[Idnmb]
			)
			print 'FK_NewHierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim Created Successfully'
	End 

ELSE
	BEGIN
		print 'FK_NewHierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim Already exists'
	END

GO

----------------------------------------------------------------------SUbSubTypeidnmb---------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_NewHierarchy_Dim_SUbSubTypeidnmb_SubSubType_Dim')))
	BEGIN
		print 'Creating FK_NewHierarchy_Dim_SUbSubTypeidnmb_SubSubType_Dim'
			ALTER TABLE [dbo].[NewHierarchy_Dim] 
			WITH CHECK ADD  CONSTRAINT FK_NewHierarchy_Dim_SUbSubTypeidnmb_SubSubType_Dim FOREIGN KEY
			(
					[SUbSubTypeidnmb]
			)
			REFERENCES [dbo].[SubSubType_Dim]
			(
					[Idnmb]
			)
			print 'FK_NewHierarchy_Dim_SUbSubTypeidnmb_SubSubType_Dim Created Successfully'
	End 

ELSE
	BEGIN
		print 'FK_NewHierarchy_Dim_SUbSubTypeidnmb_SubSubType_Dim Already exists'
	END

GO




