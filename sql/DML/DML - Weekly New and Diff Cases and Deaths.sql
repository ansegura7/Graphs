USE [OVS_DEVOPS_WFS]
GO
SELECT [date], [total_cases], [total_deaths], [new_total_cases], [new_total_deaths],
       ISNULL(([new_total_cases] - LAG([new_total_cases], 1) OVER (ORDER BY [date])), 0) AS [diff_total_cases],
	   ISNULL(([new_total_deaths] - LAG([new_total_deaths], 1) OVER (ORDER BY [date])), 0) AS [diff_total_deaths]
  FROM (
	SELECT [date], [total_cases], [total_deaths],
		   ISNULL(([total_cases] - LAG([total_cases], 1) OVER (ORDER BY [date])), 0) AS [new_total_cases],
		   ISNULL(([total_deaths] - LAG([total_deaths], 1) OVER (ORDER BY [date])), 0) AS [new_total_deaths]
	  FROM (
			SELECT td.[date], [total_cases], [total_deaths]
			  FROM [dbo].[v_daily_covid19_data] AS td
			 INNER JOIN
				   [dbo].[dim_date] AS dd
				ON td.[date] = dd.[date]
			 WHERE [country] = 'Colombia'
			   AND [day_of_week] = 7) AS t) AS tt
 ORDER BY [date];
GO