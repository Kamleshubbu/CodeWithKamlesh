USE [Dynasty_DW]
GO
DELETE FROM [dbo].[Sub_Company_Dim]
GO
SET IDENTITY_INSERT [dbo].[Sub_Company_Dim] ON 

INSERT [dbo].[Sub_Company_Dim] ([Idnmb], [SubCompanyCode], [SubCompanyName], [CreateDate]) VALUES (1, N'E001', N'Brandywine Oak Private Wealth LLC',GetDate())
SET IDENTITY_INSERT [dbo].[Sub_Company_Dim] OFF
