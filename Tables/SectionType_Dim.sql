USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[SectionType_Dim]    Script Date: 7/12/2019 1:47:02 PM ******/

/****** Object:  Table [dbo].[SectionType_Dim]    Script Date: 7/12/2019 1:47:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SectionType_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table SectionType_Dim...'

		CREATE TABLE [dbo].[SectionType_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[SectionTypeName] [varchar](50) NOT NULL,
			[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
		 CONSTRAINT [PK_SectionType_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		UNIQUE NONCLUSTERED 
		(
			[SectionTypeName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
	END
ELSE
	BEGIN
		print 'Updating the structure of the SectionType_Dim table...'
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SectionType_Dim' AND COLUMN_NAME = 'Order')
		Begin
				Alter table SectionType_Dim add [Order] int null
				Print 'Added Order Column'
		End

	END
GO

SET ANSI_PADDING OFF
GO


