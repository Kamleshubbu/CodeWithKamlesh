USE [Dynasty_DW]
GO

SET IDENTITY_INSERT [dbo].[Company_Dim] ON 

INSERT [dbo].[Company_Dim] ([Idnmb], [CompanyCode], [CompanyName], [CreateDate], [DataLockDate]) VALUES (1, NULL, N'Brandywine Oak Private Wealth LLC', GetDate(), NULL)
SET IDENTITY_INSERT [dbo].[Company_Dim] OFF
