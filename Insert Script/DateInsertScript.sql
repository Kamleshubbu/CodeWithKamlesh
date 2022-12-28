Use Dynasty_DW

--Truncate table [Date_Dim]
GO

DECLARE @StartDT DATETIME, @EndDT DATETIME

SELECT @StartDT='1985-01-01' 
      ,@EndDT = '2000-12-30'

;WITH MYCTE1 AS 
( 
	SELECT CAST(@StartDT AS DATETIME) DateValue 
	UNION ALL 
	SELECT DateValue + 1 FROM mycte1 WHERE DateValue + 1 < = @EndDT
)

INSERT INTO [Date_Dim]
(
   [Date],
   [Month],
   [Year],
   [Quarter],
   [Week],
   [DayofWeek],
   [DayOfQuarter],
   [DayofYear],
   ISMONTHEND,
   ISQuarterEND,
   ISYearEND,
   CreateDate
)
SELECT Cast(DateValue As DATE) As dates
      ,Month(DateValue) AS [Month]
	  ,Year(DateValue) AS [Year]
	  ,DATEPART(QUARTER, (DateValue))  AS [QUARTER]
	  ,DATEPART(wk, Cast(DateValue As DATE)) AS [Week]
	  ,DATEPART(dw,DateValue) AS [DayofWeek]
	  ,Datediff(day,dateadd(quarter,datediff(quarter,0,DateValue),0),DateValue) + 1 as DayofQuarter
	  ,datepart(dayofyear,DateValue) AS [DayofYear] 
	  ,CASE WHEN day(DATEADD(day,1,DateValue)) = 1 THEN 1 ELSE 0 END AS ISMONTHEND
	  ,Case when SUBSTRING(Cast(Cast(DateValue As DATE) as varchar(10)),6,10) in('06-30','09-30','12-31','03-31') then 1 else 0 End AS ISQuarterEND
	  ,Case when SUBSTRING(Cast(Cast(DateValue As DATE) as varchar(10)),6,10)= '12-31' then 1 else 0 End AS ISYearEND
	  ,getdate()
FROM mycte1 
OPTION (MAXRECURSION 0) 


--Select * from [Date] Order by DateIDNmb

