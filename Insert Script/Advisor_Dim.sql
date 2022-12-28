USE [Dynasty_DW]
GO

SET IDENTITY_INSERT [dbo].[Advisor_Dim] ON 

INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (1, N'D1000', N'Founder/Advisor',GetDate())
INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (2, N'D1001', N'Michael Henley',GetDate())
INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (3, N'D1002', N'Alison Brooks',GetDate())
INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (4, N'D1003', N'Steven Maconi',GetDate())
INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (5, N'D1004', N'Tracy McGuire',GetDate())
INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (6, N'D1005', N'Mark Jackson',GetDate())
INSERT [dbo].[Advisor_Dim] ([Idnmb], [AdvisorCode], [AdvisorName], [CreateDate]) VALUES (7, N'D2000', N'Corp',GetDate())
SET IDENTITY_INSERT [dbo].[Advisor_Dim] OFF
