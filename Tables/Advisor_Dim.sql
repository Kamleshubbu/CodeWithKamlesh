USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[Advisor_Dim]    Script Date: 7/12/2019 1:42:27 PM ******/

/****** Object:  Table [dbo].[Advisor_Dim]    Script Date: 7/12/2019 1:42:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Advisor_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table Advisor_Dim...'
		CREATE TABLE [dbo].[Advisor_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[AdvisorCode] [varchar](100) NOT NULL,
			[AdvisorName] [varchar](100) NOT NULL,
			[CompanyIDNmb] int null,
			[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
		 CONSTRAINT [PK_Advisor_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the Advisor_Dim table...'

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Advisor_Dim' AND COLUMN_NAME = 'CompanyIDNmb')
		Begin
				Alter table Advisor_Dim add CompanyIDNmb int null
				Print 'Added CompanyIDNmb Column'
		End

		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' AND TC.CONSTRAINT_NAME = 'UQ_AdvisorCode_CompanyIDNmb' AND TC.TABLE_NAME = 'Advisor_Dim')
		BEGIN
			ALTER TABLE Advisor_Dim
			ADD CONSTRAINT UQ_AdvisorCode_CompanyIDNmb UNIQUE (ADvisorCode,CompanyIDNmb)
			Print 'Unique Key AdvisorCode and CompanyIDNmb  Added'
		END

	END

GO

SET ANSI_PADDING OFF
GO


