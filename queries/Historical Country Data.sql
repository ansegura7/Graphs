-- Historical data by countries
SELECT *
  FROM [dbo].[covid_19]
 WHERE [country] IN ('UK', 'UAE')
 ORDER BY [country], [datestamp] DESC;
