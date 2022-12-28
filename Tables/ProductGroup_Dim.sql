USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[ProductGroup_Dim]    Script Date: 9/5/2019 8:02:58 PM ******/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductGroup_Dim]') AND type in (N'U'))
		BEGIN
				PRINT 'Creating table ProductGroup_Dim'
			
				CREATE TABLE [dbo].[ProductGroup_Dim](
					[Idnmb] [int] IDENTITY(1,1) NOT NULL,
					[ProductGroupName] [varchar](200) NOT NULL,
					[CreateDate] [datetime] CONSTRAINT [DF_ProductGroup_Dim_CREATEDATE]  DEFAULT (getdate()) NOT NULL,
					CONSTRAINT [PK_ProductGroup_Dim] PRIMARY KEY CLUSTERED 
					(
						[IdNmb] ASC
					)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],

					) ON [PRIMARY]
				
				PRINT 'Created table ProductGroup_Dim successfully .......'

		END
ELSE
		BEGIN
				
				PRINT 'Updating table ProductGroup_Dim structure .......'
		
		END 
GO

