USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[CalculationType_Dim]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CalculationType_Dim]') AND type in (N'U'))
BEGIN
		PRINT 'CREATING TABLE CalculationType_Dim '
		CREATE TABLE [dbo].[CalculationType_Dim](
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
			[CalculationTypeName] [varchar](200) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_CalculationType_Dim] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		CONSTRAINT [UQ_CalculationType_Dim_CalculationTypeName] UNIQUE NONCLUSTERED 
		(
			[CalculationTypeName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		PRINT 'CREATED TABLE CalculationType_Dim SUCCESSFULLY'
END
ELSE
	BEGIN
		PRINT 'UPDATING TABLE CalculationType_Dim STRUCTURE'

		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_Calculation_Dim_CreateDate]') AND type = 'D')
		BEGIN
		ALTER TABLE [dbo].[CalculationType_Dim] ADD  CONSTRAINT [DF_Calculation_Dim_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		IF NOT EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC WHERE TC.CONSTRAINT_TYPE = 'UNIQUE' AND TC.CONSTRAINT_NAME = 'UQ_CalculationType_Dim_CalculationTypeName' AND TC.TABLE_NAME = 'CalculationType_Dim')
		BEGIN
			ALTER TABLE CalculationType_Dim
			ADD CONSTRAINT UQ_CalculationType_Dim_CalculationTypeName UNIQUE (CalculationTypeName)
			Print 'Unique Key CalculationTypeName  Added'
		END

	END
GO
