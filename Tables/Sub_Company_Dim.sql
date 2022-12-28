USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[Sub_Company_Dim]    Script Date: 7/24/2019 5:11:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sub_Company_Dim]') AND type in (N'U'))
BEGIN
			CREATE TABLE [dbo].[Sub_Company_Dim](
				[Idnmb] [int] IDENTITY(1,1) NOT NULL,
				[SubCompanyCode] [varchar](50) NOT NULL,
				[SubCompanyName] [varchar](200) NOT NULL,
				[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
				[CompanyIDNmb] [int] NULL,
			 CONSTRAINT [PK_Sub_Company_Dim] PRIMARY KEY CLUSTERED 
			(
				[Idnmb] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY]
			END

Else
BEGIN
		print 'Updating the structure of the Sub_Company_Dim table...'
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Sub_Company_Dim' AND COLUMN_NAME = 'CompanyIDNmb')
		Begin
				Alter table Sub_Company_Dim add CompanyIDNmb int null
				Print 'Added CompanyIDNmb Column'
		End
		
		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' AND TC.CONSTRAINT_NAME = 'UQ_Sub_Company_Dim_SubCompanyCode_CompanyIDNmb' AND TC.TABLE_NAME = 'Sub_Company_Dim')
		BEGIN
			ALTER TABLE Sub_Company_Dim
			ADD CONSTRAINT UQ_Sub_Company_Dim_SubCompanyCode_CompanyIDNmb UNIQUE (SubCompanyCode,CompanyIDNmb)
			Print 'Unique Key SubCompanyCode and CompanyIDNmb Added'
		END
END

GO
SET ANSI_PADDING OFF
GO
