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
CREATE FUNCTION [dbo].[udf_GetDateFromID] 
(
	@DateIdNmb INT
)
RETURNS DATE
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnDate DATE

	SELECT @ReturnDate = Date FROM Date_Dim WHERE DateIDNmb = @DateIdNmb

	-- Return the result of the function
	RETURN @ReturnDate

END
GO

