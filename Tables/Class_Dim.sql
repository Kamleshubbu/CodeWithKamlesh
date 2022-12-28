USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[Class_Dim]    Script Date: 7/12/2019 1:42:44 PM ******/

/****** Object:  Table [dbo].[Class_Dim]    Script Date: 7/12/2019 1:42:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Class_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table Class_Dim...'
		CREATE TABLE [dbo].[Class_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[ClassCode] [varchar](20) NOT NULL,
			[ClassName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
		 CONSTRAINT [PK_Class_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		UNIQUE NONCLUSTERED 
		(
			[ClassCode] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the Class_Dim table...'

	END
GO

SET ANSI_PADDING OFF
GO


