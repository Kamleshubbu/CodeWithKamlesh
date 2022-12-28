USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[Household_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Household_Dim]') AND type in (N'U'))
	BEGIN
			Print 'Creating Table Household_Dim'
			CREATE TABLE [dbo].[Household_Dim](
				[Idnmb] [int] IDENTITY(1,1) NOT NULL,
				[HouseholdName] [varchar](200) NOT NULL,
				[CompanyIDNmb] [int] NOT NULL,
				[CreateDate] [datetime] NOT NULL,
			 CONSTRAINT [PK_Household_Dim] PRIMARY KEY CLUSTERED 
			(
				[Idnmb] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
			 CONSTRAINT [UQ_Household_Dim_HouseholdName_Companyidnmb] UNIQUE NONCLUSTERED 
			(
				[HouseholdName] ASC,
				[CompanyIDNmb] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]

			
			
			Print 'Created table household_Dim successfully'
END
Else
	Begin
		Print 'Updating table household_dim structure.'

		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_Household_Dim_CreateDate]') AND type = 'D')
		BEGIN
		ALTER TABLE [dbo].[Household_Dim] ADD  CONSTRAINT [DF_Household_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' AND TC.CONSTRAINT_NAME = 'UQ_Household_Dim_HouseholdName_Companyidnmb' AND TC.TABLE_NAME = 'household_dim')
		BEGIN
			ALTER TABLE household_dim
			ADD CONSTRAINT UQ_Household_Dim_HouseholdName_Companyidnmb UNIQUE (HouseholdName,CompanyIDNmb)
			Print 'Unique Key HouseholdName and CompanyIDNmb  Added'
		END
	End
GO
