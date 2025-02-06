-- List down total gold, silver and broze medals won by each country

SELECT country,
	   COALESCE(gold, 0) AS gold,
	   COALESCE(silver, 0) AS silver,
	   COALESCE(bronze, 0) AS bronze
FROM crosstab('
	SELECT nr.region AS country, medal, COUNT(1) AS total_medals
	FROM olympics_history oh
	JOIN olympics_history_noc_region nr on nr.noc = oh.noc
	WHERE medal <> ''NA''
	GROUP BY nr.region, medal
	ORDER BY nr.region, medal')
	AS RESULT(country varchar, bronze bigint, gold bigint, silver bigint)
ORDER BY gold DESC, silver DESC, bronze DESC;


