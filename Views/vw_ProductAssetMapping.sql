USE [Dynasty_DW]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ProductAssetmapping_Dim]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW dbo.vw_ProductAssetMapping

GO
/* 
		
			select * from vw_ProductAssetMapping


*/
create view [dbo].[vw_ProductAssetMapping]
as 
	select 
				  Pro.ProductTypeName as 'ProductType'
				, PRG.ProductGroupName as 'ProductGroup'
				, AST.AssetTypeName as 'AssetType'
	  from  Dynasty_DW.dbo.ProductAssetMapping_Dim PAM
		Inner Join Dynasty_DW..ProductType_Dim Pro on Pro.Idnmb=Pam.ProductTypeIDnmb
		Left  Join Dynasty_Dw..ProductGroup_Dim PRG on PRG.Idnmb=PAM.ProductGroupIdnmb
		LEFT  Join Dynasty_DW..AssetType_Dim AST on AST.Idnmb=PAM.AssetTypeIdnmb
		
	GO			


