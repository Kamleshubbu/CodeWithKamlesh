USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[Manager_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Manager_Dim]') AND type in (N'U'))
BEGIN
	Print 'Creating table MAnager_dim table'
		CREATE TABLE [dbo].[Manager_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[ManagerName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_Manager_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 CONSTRAINT [UQ_Manager_Dim_ManagerName] UNIQUE NONCLUSTERED 
		(
			[ManagerName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		Print 'Created table MAnager_dim table successfully'
END
Else
	Begin
		Print 'Updating table Manager_dim structure'
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_Manager_Dim_CreateDate]') AND type = 'D')
		BEGIN
		ALTER TABLE [dbo].[Manager_Dim] ADD  CONSTRAINT [DF_Manager_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE'
		AND TC.CONSTRAINT_NAME = 'UQ_Manager_Dim_ManagerName' AND TC.TABLE_NAME = 'Manager_dim')
		BEGIN
			ALTER TABLE Manager_dim
			ADD CONSTRAINT UQ_Manager_Dim_ManagerName UNIQUE (ManagerName)
			Print 'Unique Key ManagerName  Added'
		END

	End
GO
