USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[Vendor_Dim]    Script Date: 7/12/2019 1:47:38 PM ******/


/****** Object:  Table [dbo].[Vendor_Dim]    Script Date: 7/12/2019 1:47:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Vendor_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table Vendor_Dim...'

		CREATE TABLE [dbo].[Vendor_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[VendorCode] [varchar](20) NOT NULL,
			[VendorName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
			[CompanyIDNmb] int  not null,
		 CONSTRAINT [PK_Vendor_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		Constraint UQ_VendorCode_CompanyIDNmb UNIQUE NONCLUSTERED 
		(
			[VendorCode] ASC,
			[Companyidnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the Vendor_Dim table...'
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Vendor_Dim' AND COLUMN_NAME = 'CompanyIDNmb')
		Begin
				Alter table Vendor_Dim add CompanyIDNmb int not null
				Print 'Added CompanyIDNmb Column'
		End
		
		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' AND TC.CONSTRAINT_NAME = 'UQ_VendorCode_CompanyIDNmb' AND TC.TABLE_NAME = 'Vendor_Dim')
		BEGIN
			ALTER TABLE Vendor_Dim
			ADD CONSTRAINT UQ_VendorCode_CompanyIDNmb UNIQUE (VendorCode,CompanyIDNmb)
			Print 'Unique Key VendorCode and CompanyIDNmb Added'
		END



	END


GO

SET ANSI_PADDING OFF
GO


