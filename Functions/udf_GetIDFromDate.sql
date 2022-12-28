USE Dynasty_DW

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[udf_GetIDFromDate] 
(
	@Date DATETIME
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnDateIdNmb INT

	SELECT @ReturnDateIdNmb = DateIdNmb FROM Date_Dim WHERE Cast(Date as Date) = Cast(@Date as Date)

	-- Return the result of the function
	RETURN @ReturnDateIdNmb

END
GO

