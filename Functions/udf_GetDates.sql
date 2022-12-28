USE [Dynasty_DW]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_GetDates]    Script Date: 05/13/2019 09:31:08 ******/
DROP FUNCTION [dbo].[udf_GetDates]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_GetDates]
(
	@AsOnMnth	DATETIME,
	@Type		VARCHAR(25), -- FY , M , Q
	@Inc		INT
)
RETURNS @Dates TABLE
(
	Strt_Dt			DATETIME,
	END_Dt			DATETIME,
	DayBefore_DT	DATETIME
)
/*
	Select * From dbo.udf_GetDates('14-APR-2011','FY' , 0)
	Select * From dbo.udf_GetDates('14-APR-2011','M' , 0)
	Select * From dbo.udf_GetDates('2018-06-30','1Y1M' , -1)
		Select * From dbo.udf_GetDates('14-APR-2011','LQ' , 0)
			Select * From dbo.udf_GetDates('14-APR-2011','Q' , 0)

*/
As
BEGIN

	DECLARE @Strt_Dt DATETIME 
		  , @End_Dt DATETIME
	
	
	IF @Type = 'FY'
	BEGIN
		SET @AsOnMnth = DATEADD(YY , @Inc , @AsOnMnth)	
		DECLARE @Year VARCHAR(10) 
		Set @Year = CONVERT(VARCHAR,YEAR(@AsOnMnth))
		 								
		SELECT @Strt_Dt = CONVERT(DATETIME , '01-Jan-' + @Year) , @End_Dt = CONVERT(DATETIME , '31-Dec-' + @Year)
	END
	
	
	IF @Type = 'M'
	BEGIN
		Set @AsOnMnth = DATEADD(M , @Inc , @AsOnMnth)

		Select  @Strt_Dt = DATEADD(M , 1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,-1, @AsOnMnth),112) + '01')), 
				@End_Dt	 = DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,1,@AsOnMnth) , 112) + '01'))
	END
	
	IF @Type = 'Q'
	BEGIN
		DECLARE @Qtr INT
		DECLARE @F_Date	DATETIME
		DECLARE @Date	DATETIME

		Set @qtr	= DATEPART(Q,DATEADD(M,3*@Inc,@AsOnMnth))
		Set @F_Date = DATEADD(M,3*@Inc,@AsOnMnth)

		Set @Date =	     Case	When @qtr = 1 Then LEFT(Convert(Varchar(6),@F_Date,112),4)+'0101'
								When @qtr = 2 Then LEFT(Convert(Varchar(6),@F_Date,112),4)+'0401'
								When @qtr = 3 Then LEFT(Convert(Varchar(6),@F_Date,112),4)+'0701'
						 Else	 LEFT(Convert(Varchar(6),@F_Date,112),4)+'1001' End

		Select  @Strt_Dt = CONVERT(Datetime , @Date) ,@End_Dt	 = DATEADD(D , -1 , DATEADD(M,3,@Date))						 
						 
	END	
	
	IF @Type = 'LQ'
	BEGIN
		
		if (@AsOnMnth = DATEADD(Quarter,DATEDIFF(Quarter, '19000101', @AsOnMnth), '19000331'))
			begin
				set @End_Dt = @AsOnMnth
			end
		else
			begin
				set @End_Dt = DATEADD(Quarter,DATEDIFF(Quarter, '19000101', @AsOnMnth) - 1, '19000331')
			end
			
		set @Strt_Dt = Dateadd(D,1,Dateadd(m,-3,@End_Dt))
	
	END
	
	
	IF @Type = 'YTD'
	BEGIN
		
		set @Strt_Dt = cast(datepart(yyyy,@AsOnMnth) as varchar(4)) + '-01' +'-01'
		set	@End_Dt  = @AsOnMnth
	
	END
	

	IF @Type = '1Y'
	BEGIN
		
		set @Strt_Dt = DateAdd(D,1,DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,1, (dateadd(yy,-1,@AsOnMnth))  ) , 112) + '01')))
		set	@End_Dt  = @AsOnMnth
	
	END
	
	IF @Type = '1Y1M'
	BEGIN
		
		set @Strt_Dt = DateAdd(D,1,DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,0, (dateadd(yy,-1,@AsOnMnth))  ) , 112) + '01')))
		set	@End_Dt  = @AsOnMnth
	
	END


	IF @Type = '2Y'
	BEGIN
		
		set @Strt_Dt = DateAdd(D,1,DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,1, (dateadd(yy,-2,@AsOnMnth))  ) , 112) + '01')))
		set	@End_Dt  = @AsOnMnth
	
	END


	IF @Type = '3Y'
	BEGIN
		
		set @Strt_Dt = DateAdd(D,1,DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,1, (dateadd(yy,-3,@AsOnMnth))  ) , 112) + '01')))
		set	@End_Dt  = @AsOnMnth
	
	END


	IF @Type = '5Y'
	BEGIN
		
		set @Strt_Dt = DateAdd(D,1,DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,1, (dateadd(yy,-5,@AsOnMnth))  ) , 112) + '01')))
		set	@End_Dt  = @AsOnMnth
	
	END


	IF @Type = '10Y'
	BEGIN
		
		set @Strt_Dt = DateAdd(D,1,DATEADD(D , -1,CONVERT(Datetime,CONVERT(Varchar(6), DATEADD(M,1, (dateadd(yy,-10,@AsOnMnth))  ) , 112) + '01')))
		set	@End_Dt  = @AsOnMnth
	
	END



	
	INSERT @Dates 
	SELECT @Strt_Dt,@End_Dt,DATEADD(day,-1,@Strt_Dt)
	Return
	
	
END
GO
