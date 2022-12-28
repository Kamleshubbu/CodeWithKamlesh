USE [Dynasty_DW]
GO


/****** Object:  Table [dbo].[NewHierarchy_Dim]    Script Date: 7/12/2019 1:45:58 PM ******/

/****** Object:  Table [dbo].[NewHierarchy_Dim]    Script Date: 7/12/2019 1:45:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[NewHierarchy_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table NewHierarchy_Dim...'

		CREATE TABLE [dbo].[NewHierarchy_Dim](
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
			[CreateDate] [datetime] CONSTRAINT [DF_NewHierarchy_Dim_CREATEDATE] DEFAULT (getdate()) NOT NULL,
			
		 CONSTRAINT [PK_NewHierarchy_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
		) ON [PRIMARY]
	END
ELSE
	BEGIN
		print 'Updating the structure of the NewHierarchy_Dim table...'

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'NewHierarchy_Dim' AND COLUMN_NAME = 'SubSubTypeIdnmb')
		Begin
				Alter table NewHierarchy_Dim add SubSubTypeIdnmb int null
				Print 'Added SubSubTypeIdnmb Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'NewHierarchy_Dim' AND COLUMN_NAME = 'SectionSubTypeOrder')
		Begin
				Alter table NewHierarchy_Dim add SectionSubTypeOrder int null
				Print 'Added SectionSubTypeOrder Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'NewHierarchy_Dim' AND COLUMN_NAME = 'SubSubTypeOrder')
		Begin
				Alter table NewHierarchy_Dim add SubSubTypeOrder int null
				Print 'Added SubSubTypeOrder Column'
		End



	END

GO

SET ANSI_PADDING OFF
GO

