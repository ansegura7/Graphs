-- Total data
SELECT COUNT(*) AS [count]
  FROM [dbo].[covid_19];
GO

-- Countries with more reports
SELECT [country], COUNT(*) AS [count]
  FROM [dbo].[covid_19]
 GROUP BY [country]
 ORDER BY [count] DESC;
GO

-- Data after...
SELECT *
 FROM [dbo].[covid_19]
WHERE [datestamp] >= '2020-04-13 08:21';
GO