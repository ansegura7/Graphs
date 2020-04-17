-- Latest data by country sorted by total_deaths
SELECT ROW_NUMBER() OVER(ORDER BY total_deaths DESC) AS row_number, a.country, a.total_cases, a.total_deaths, a.total_recovered, 
	   a.active_cases, a.serious_critical, a.tot_cases_1m_pop, a.deaths_1m_pop, a.total_tests, a.tests_1m_pop, a.datestamp
  FROM [dbo].[covid19_data] AS a
 WHERE a.[datestamp] = 
	(SELECT MAX(b.[datestamp])
	   FROM [dbo].[covid19_data] AS b
	  WHERE b.country = a.country);
GO
