USE [OVS_DEVOPS_WFS]
GO

-- Validate consistency on new data
-- [total_cases] = [total_deaths] + [active_cases] + [total_recovered]
SELECT [country],[datestamp],[total_cases],[total_deaths],[active_cases],[serious_critical],[total_tests],[total_recovered],
	   ([total_cases] - [total_deaths] - [active_cases]) AS [total_recovered2],
	   ABS([total_recovered] - ([total_cases] - [total_deaths] - [active_cases])) AS [diff]
  FROM [dbo].[covid19_data]
 WHERE [active_cases] <> -1 AND [total_recovered] <> -1
   AND [total_cases] <> ([total_deaths] + [active_cases] + [total_recovered])
 ORDER BY [diff] DESC;
GO

-- Validate consistency in gaps between days
SELECT *
  FROM [dbo].[v_daily_covid19_data]
 WHERE [diff_total_cases] < 0
    OR [diff_total_deaths] < 0
	OR [diff_total_recovered] < 0;
GO
