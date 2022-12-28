USE [Dynasty_DW]
GO


/****** Object:  Table [dbo].[Hierarchy_Dim]    Script Date: 7/12/2019 1:45:58 PM ******/

/****** Object:  Table [dbo].[Hierarchy_Dim]    Script Date: 7/12/2019 1:45:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Hierarchy_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table Hierarchy_Dim...'

		CREATE TABLE [dbo].[Hierarchy_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[AccountStartNumber] [varchar](20) NOT NULL,
			[AccountEndNumber] [varchar](20) NOT NULL,
			[ReportTypeIDNmb] [int] NOT NULL,
			[SectionTypeIDNmb] [int] NULL,
			[SectionSubTypeIDNmb] [int] NOT NULL,
			[Order] [int] NOT NULL,
			[Balance] [int] NULL,
			[ReportMultiplierNmb] [int] NOT NULL DEFAULT ((0)),
			[EBACMultiplierNmb] [int] NOT NULL DEFAULT ((0)),
			[EBITDAMultiplierNmb] [int] NOT NULL DEFAULT ((0)),
			[NetIncomeMulitplierNmb] [int] NOT NULL DEFAULT ((0)),
			[CreateDate] [datetime] CONSTRAINT [DF_Hierarchy_Dim_CREATEDATE] DEFAULT (getdate()) NOT NULL,
			
		 CONSTRAINT [PK_Hierarchy_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
		) ON [PRIMARY]
	END
ELSE
	BEGIN
		print 'Updating the structure of the Hierarchy_Dim table...'

	END

GO

SET ANSI_PADDING OFF
GO

