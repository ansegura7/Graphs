-- Total stored data
SELECT COUNT(*) AS [count]
     , MAX([datestamp]) AS [last_record]
  FROM [dbo].[covid19_data];
GO

-- Today Totals
SELECT SUM([total_cases]) AS [total_cases], SUM([total_deaths]) AS [total_deaths]
     , SUM([active_cases]) AS [active_cases], SUM([total_tests]) AS [total_tests]
  FROM [dbo].[v_daily_covid19_data]
 WHERE [date] = CAST(GETDATE() AS date);
GO

-- Countries with more cases
SELECT a.*
  FROM [dbo].[v_current_covid19_data] AS a
 WHERE [total_cases] = (SELECT MAX([total_cases])
					      FROM [dbo].[v_current_covid19_data]);
GO

-- Countries with more deaths
SELECT a.*
  FROM [dbo].[v_current_covid19_data] AS a
 WHERE [total_deaths] = (SELECT MAX([total_deaths])
					      FROM [dbo].[v_current_covid19_data]);
GO

-- Countries with more recovered people
SELECT a.*
  FROM [dbo].[v_current_covid19_data] AS a
 WHERE [total_recovered] = (SELECT MAX([total_recovered])
					          FROM [dbo].[v_current_covid19_data]);
GO

-- Countries with more deaths per one millon population
SELECT a.*
  FROM [dbo].[v_current_covid19_data] AS a
 WHERE [deaths_1m_pop] = (SELECT MAX([deaths_1m_pop])
					        FROM [dbo].[v_current_covid19_data]
						   WHERE [total_cases] > 1000);
GO

-- Countries with the highest death rate
SELECT a.*, (CAST((1.0 * [total_deaths] / [total_cases]) AS float) * 100) AS [perc_death]
  FROM [dbo].[v_current_covid19_data] AS a
 WHERE (CAST((1.0 * a.[total_deaths] / a.[total_cases]) AS float) * 100) = 
	(SELECT MAX(CAST((1.0 * [total_deaths] / [total_cases]) AS float) * 100)
	   FROM [dbo].[v_current_covid19_data] AS b
	  WHERE [total_cases] > 1000);
GO

-- Countries with the highest infection-tests rate
SELECT a.*, (CAST((1.0 * [total_cases] / [total_tests]) AS float) * 100) AS [perc_infection]
  FROM [dbo].[v_current_covid19_data] AS a
 WHERE (CAST((1.0 * a.[total_cases] / a.[total_tests]) AS float) * 100) = 
	(SELECT MAX(CAST((1.0 * [total_cases] / [total_tests]) AS float) * 100)
	   FROM [dbo].[v_current_covid19_data] AS b
	  WHERE [total_tests] > 0 AND [total_deaths] > 500)
	AND[total_tests] > 0;
GO

SELECT [datestamp], COUNT(*) AS [count]
  FROM [covid19_data]
 GROUP BY [datestamp]
 ORDER BY [datestamp] DESC;
GO
