USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[SubSubType_Dim]    Script Date: 7/12/2019 1:46:42 PM ******/

/****** Object:  Table [dbo].[SubSubType_Dim]    Script Date: 7/12/2019 1:46:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SubSubType_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table SubSubType_Dim...'
		CREATE TABLE [dbo].[SubSubType_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[SubSubTypeName] [varchar](100) NOT NULL,
			[SubSubTypeOrder]  INT  NULL,
			[CreateDate] [datetime] CONSTRAINT [DF_SubSubType_Dim_CREATEDATE] DEFAULT (getdate()) NOT NULL,
		 CONSTRAINT [PK_SubSubType_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		UNIQUE NONCLUSTERED 
		(
			[SubSubTypeName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the SubSubType_Dim table...'
		
		

		
	END
GO

SET ANSI_PADDING OFF
GO


