-- Latest data by country sorted by total_deaths
SELECT *
  FROM [dbo].[covid_19] AS a
 WHERE a.[datestamp] = 
	(SELECT MAX(b.[datestamp])
	   FROM [dbo].[covid_19] AS b
	  WHERE b.country = a.country)
 ORDER BY total_deaths DESC;
