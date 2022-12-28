USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[BillType_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillType_Dim]') AND type in (N'U'))
BEGIN
		Print 'Creating BillType_Dim Table'
		
		CREATE TABLE [dbo].[BillType_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[BillTypeName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_BillType_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 
		) ON [PRIMARY]

		Print 'Created table BillType_Dim Successfully'
END
Else
	Begin
		
		Print 'Updated table BillType_Dim structure'
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_BillType_Dim_CreateDate]') AND type = 'D')
		BEGIN
		ALTER TABLE [dbo].[BillType_Dim] ADD  CONSTRAINT [DF_BillType_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END
	
		

	End
GO
