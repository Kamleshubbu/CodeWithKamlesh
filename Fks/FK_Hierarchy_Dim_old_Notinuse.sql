
USE [Dynasty_DW]
GO
-------------------------------------ReportTypeIDNmb---------------------------------------------------------


IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_Hierarchy_Dim_ReportTypeIDNmb_ReportType_Dim')))
	BEGIN
		print 'FK_Hierarchy_Dim_ReportTypeIDNmb_ReportType_Dim'

		ALTER TABLE [dbo].[Hierarchy_Dim]  
		WITH CHECK ADD  CONSTRAINT [FK_Hierarchy_Dim_ReportTypeIDNmb_ReportType_Dim] FOREIGN KEY
		(
				[ReportTypeIDNmb]
		)
		REFERENCES [dbo].[ReportType_Dim] 
		(
				[Idnmb]
		)

		print 'FK_Hierarchy_Dim_ReportTypeIDNmb_ReportType_Dim Created Successfully'
End
ELSE
	BEGIN
		print 'FK_Hierarchy_Dim_ReportTypeIDNmb_ReportType_Dim Already exists'
	END

GO
----------------------------------------------------------------------SectionSubtypeidNmb---------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_Hierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim')))
	BEGIN
		print 'Creating FK_Hierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim'
			ALTER TABLE [dbo].[Hierarchy_Dim] 
			WITH CHECK ADD  CONSTRAINT [FK_Hierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim] FOREIGN KEY
			(
					[SectionSubTypeIDNmb]
			)
			REFERENCES [dbo].[SectionSubType_Dim]
			(
					[Idnmb]
			)
			print 'FK_Hierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim Created Successfully'
	End 

ELSE
	BEGIN
		print 'FK_Hierarchy_Dim_SectionSubTypeIDNmb_SectionSubType_Dim Already exists'
	END

GO




