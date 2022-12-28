USE Dynasty_DW

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Drop Function [udf_GetTopHierarchyID]
Go
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[udf_GetTopHierarchyID] 
(
	@AccountNumber INT
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnHierarchyIdNmb INT

	--SELECT TOP 1 @ReturnHierarchyIdNmb = IdNmb 
	--	FROM [Hierarchy_Dim] 
	--	WHERE @AccountNumber BETWEEN [AccountStartNumber] AND [AccountEndNumber]
	--	ORDER BY [Order]


	SELECT TOP 1 @ReturnHierarchyIdNmb = IdNmb 
		FROM [NewHierarchy_Dim] 
		WHERE @AccountNumber BETWEEN [AccountStartNumber] AND [AccountEndNumber]
		ORDER BY [Order]

	
	-- Return the result of the function
	RETURN @ReturnHierarchyIdNmb

END
GO

