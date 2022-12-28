USE [Dynasty_DW]
GO
DELETE FROM [dbo].[SectionType_Dim]
GO
SET IDENTITY_INSERT [dbo].[SectionType_Dim] ON 

INSERT [dbo].[SectionType_Dim] ([Idnmb], [SectionTypeName], [CreateDate]) VALUES (1, N'Income',GetDate())
INSERT [dbo].[SectionType_Dim] ([Idnmb], [SectionTypeName], [CreateDate]) VALUES (2, N'Cost of Service',GetDate())
INSERT [dbo].[SectionType_Dim] ([Idnmb], [SectionTypeName], [CreateDate]) VALUES (3, N'Expenses',GetDate())
SET IDENTITY_INSERT [dbo].[SectionType_Dim] OFF
