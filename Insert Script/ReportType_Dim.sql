USE [Dynasty_DW]
GO
DELETE FROM [dbo].[ReportType_Dim]
GO
SET IDENTITY_INSERT [dbo].[ReportType_Dim] ON 

INSERT [dbo].[ReportType_Dim] ([Idnmb], [ReportTypeCode], [ReportTypeName], [CreateDate]) VALUES (1, N'INC', N'Income Statement', GetDate())
INSERT [dbo].[ReportType_Dim] ([Idnmb], [ReportTypeCode], [ReportTypeName], [CreateDate]) VALUES (2, N'BAL', N'Balance Statement', GetDate())
SET IDENTITY_INSERT [dbo].[ReportType_Dim] OFF
