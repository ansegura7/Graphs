USE [OVS_DEVOPS_WFS]
GO
DECLARE @cols NVARCHAR(MAX)

WITH cte_country AS (
	SELECT [country], [subregion], [flag]
	  FROM [dbo].[v_daily_covid19_data] AS cd
	 INNER JOIN
		   [dbo].[country_info] AS ci
		ON cd.[country] = ci.[name]
	 WHERE ci.[region] = 'Americas'
	   AND cd.[date] = CAST(GETDATE() AS date)
	   AND cd.[total_deaths] > 50
)
, cte_data AS (
	SELECT cd.[country], ci.[subregion], ci.[flag], cd.[date], cd.[total_deaths]
	  FROM [dbo].[v_daily_covid19_data] AS cd
	 INNER JOIN
		   cte_country AS ci
		ON cd.[country] = ci.[country]
	 WHERE cd.[date] >= '20200301'
)

SELECT *
  FROM cte_data AS x
 PIVOT (
    MAX([total_deaths])
    FOR [date] IN ([2020-03-01],[2020-03-02],[2020-03-03],[2020-03-04],[2020-03-05],[2020-03-06],[2020-03-07],[2020-03-08],[2020-03-09],[2020-03-10],[2020-03-11],[2020-03-12],[2020-03-13],[2020-03-14],[2020-03-15],[2020-03-16],[2020-03-17],[2020-03-18],[2020-03-19],[2020-03-20],[2020-03-21],[2020-03-22],[2020-03-23],[2020-03-24],[2020-03-25],[2020-03-26],[2020-03-27],[2020-03-28],[2020-03-29],[2020-03-30],[2020-03-31],[2020-04-01],[2020-04-02],[2020-04-03],[2020-04-04],[2020-04-05],[2020-04-06],[2020-04-07],[2020-04-08],[2020-04-09],[2020-04-10],[2020-04-11],[2020-04-12],[2020-04-13],[2020-04-14],[2020-04-15],[2020-04-16],[2020-04-17],[2020-04-18],[2020-04-19],[2020-04-20],[2020-04-21],[2020-04-22],[2020-04-23],[2020-04-24],[2020-04-25],[2020-04-26],[2020-04-27],[2020-04-28],[2020-04-29],[2020-04-30],[2020-05-01],[2020-05-02],[2020-05-03],[2020-05-04],[2020-05-05],[2020-05-06],[2020-05-07])
	) AS p
 ORDER BY [2020-05-07] DESC;
GO

--SELECT @cols = COALESCE (@cols + ',[' + CONVERT(NVARCHAR, [date], 23) + ']', '[' + CONVERT(NVARCHAR, [date], 23) + ']')
--  FROM (SELECT DISTINCT [date] FROM cte_data) AS pv  
-- ORDER BY [date];

--SELECT @cols;