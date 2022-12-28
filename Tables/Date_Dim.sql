USE [Dynasty_DW]
GO

/****** Object:  Table [dbo].[Date_Dim]    Script Date: 6/28/2019 8:46:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Date_Dim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Creating table Date_Dim...'

		CREATE TABLE [dbo].[Date_Dim](
			[DateIDNmb] [int] IDENTITY(1,1) NOT NULL,
			[Date] [datetime] NOT NULL,
			[Month] [int] NOT NULL,
			[Year] [int] NOT NULL,
			[Quarter] [int] NOT NULL,
			[Week] [int] NOT NULL,
			[DayofWeek] [int] NOT NULL,
			[DayOfQuarter] [int] NOT NULL,
			[DayofYear] [int] NOT NULL,
			[IsMonthEnd] [bit] NOT NULL,
			[ISQuarterEnd] [bit] NOT NULL,
			[ISYearEnd] [bit] NOT NULL,
			[CreateDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_Date_Dim] PRIMARY KEY CLUSTERED 
		(
			[DateIDNmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		UNIQUE NONCLUSTERED 
		(
			[Date] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE
	BEGIN
		print 'Updating the structure of the Date_Dim table...'

	END

GO

SET ANSI_PADDING OFF
GO



