USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[ProductAssetMapping_Dim]    Script Date: 9/5/2019 8:02:58 PM ******/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductAssetMapping_Dim]') AND type in (N'U'))
		BEGIN
				PRINT 'Creating table ProductAssetMapping_Dim'
			
				CREATE TABLE [dbo].[ProductAssetMapping_Dim](
					[Idnmb] [int] IDENTITY(1,1) NOT NULL,
					[ProductTypeIDnmb] INT NOT NULL,
					[ProductGroupIdnmb] INT NULL,
					[AssetTypeIdnmb] INT NULL,
					[CreateDate] [datetime] CONSTRAINT [DF_ProductAssetMapping_Dim_CREATEDATE]  DEFAULT (getdate()) NOT NULL,
					CONSTRAINT [PK_ProductAssetMapping_Dim] PRIMARY KEY CLUSTERED 
					(
						[IdNmb] ASC
					)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],

					) ON [PRIMARY]
				
				PRINT 'Created table ProductAssetMapping_Dim successfully .......'

		END
ELSE
		BEGIN
				
				PRINT 'Updating table ProductAssetMapping_Dim structure .......'
		
		END 
GO

