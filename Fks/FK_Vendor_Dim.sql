
USE Dynasty_DW
GO
-------------------------------------CompanyIDNmb---------------------------------------------------------
IF (NOT EXISTS(select * from sysobjects a where a.Id = object_id(N'FK_Vendor_Dim_CompanyIDNmb_Company_Dim')))
	BEGIN
		print 'Creating FK_Vendor_Dim_CompanyIDNmb_Company_Dim'
		ALTER TABLE [dbo].[Vendor_Dim] ADD 
			CONSTRAINT [FK_Vendor_Dim_CompanyIDNmb_Company_Dim] FOREIGN KEY 
			(
				[CompanyIDNmb]
			) 
			REFERENCES [dbo].[Company_Dim] 
			(
				[Idnmb]
			)
		print 'DONE Creating FK_Vendor_Dim_CompanyIDNmb_Company_Dim'
	END
ELSE
	BEGIN
		print 'FK_Vendor_Dim_CompanyIDNmb_Company_Dim Already exists'
	END


GO

