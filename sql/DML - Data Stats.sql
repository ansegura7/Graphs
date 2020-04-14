-- Total data
SELECT COUNT(*) AS [count]
  FROM [dbo].[covid19_data];
GO

-- Countries with more reports
SELECT [country], COUNT(*) AS [count]
  FROM [dbo].[covid19_data]
 GROUP BY [country]
 ORDER BY [count] DESC;
GO

-- Data after...
SELECT *
  FROM [dbo].[covid19_data]
 WHERE [datestamp] >= '2020-04-13 18:30'
 ORDER BY [datestamp] DESC;
GO