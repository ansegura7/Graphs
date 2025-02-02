USE [OVS_DEVOPS_WFS]
GO
-- Validate countries data
SELECT a.[country], a.[n]
  FROM (
	SELECT [country], COUNT(*) AS [n]
	  FROM [OVS_DEVOPS_WFS].[dbo].[covid19_data]
	 GROUP BY [country]) AS a
 WHERE [country] NOT IN (SELECT [name]
						   FROM [dbo].[country_info]);
GO

-- Validate consistency on new data
-- [total_cases] = [total_deaths] + [active_cases] + [total_recovered]
SELECT [country],[datestamp],[total_cases],[total_deaths],[active_cases],[serious_critical],[total_tests],[total_recovered],
-- UPDATE a SET [total_recovered] = 
	   ([total_cases] - [total_deaths] - [active_cases]) AS [total_recovered2],
	   ABS([total_recovered] - ([total_cases] - [total_deaths] - [active_cases])) AS [diff]
  FROM [dbo].[covid19_data] AS a
 WHERE [active_cases] <> -1 AND [total_recovered] <> -1 --AND [country] = 'Spain'
   AND [total_cases] <> ([total_deaths] + [active_cases] + [total_recovered])
 ORDER BY [diff] DESC;
GO

-- Validate consistency in gaps between days
SELECT *
  FROM [dbo].[v_daily_covid19_data]
 WHERE [diff_total_cases] < 0
    OR [diff_total_deaths] < 0
	--OR [diff_total_recovered] < 0
 ORDER BY [country], [date];
GO
