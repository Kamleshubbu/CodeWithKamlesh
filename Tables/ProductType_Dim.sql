USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[ProductType_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductType_Dim]') AND type in (N'U'))
BEGIN
		Print 'Creating table ProductType_Dim'
		
		CREATE TABLE [dbo].[ProductType_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[ProductTypeName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_ProductType_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 CONSTRAINT [UQ_ProductType_Dim_ProductName] UNIQUE NONCLUSTERED 
		(
			[ProductTypeName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		Print 'Created table ProductType_Dim Successfully'
END
Else
	Begin
		Print 'Updating table ProductType_Dim structure'
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_ProductType_Dim_CreateDate]') AND type = 'D')
		BEGIN
		ALTER TABLE [dbo].[ProductType_Dim] ADD  CONSTRAINT [DF_ProductType_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		

	End 
GO
