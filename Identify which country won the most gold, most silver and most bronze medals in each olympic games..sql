-- Identify which country won the most gold, most silver and most bronze medals in each olympic games.

WITH temp AS
	(SELECT SUBSTRING(games_country, 1, POSITION(' - ' in games_country) - 1) as games,
		   SUBSTRING(games_country, POSITION(' - ' in games_country) + 3) as country,
		   COALESCE(gold, 0) AS gold,
		   COALESCE(silver, 0) AS silver,
		   COALESCE(bronze, 0) AS bronze
	FROM crosstab('
		SELECT CONCAT(games, '' - '',  nr.region) AS games_country, medal, COUNT(1) AS total_medals
		FROM olympics_history oh
		JOIN olympics_history_noc_region nr on nr.noc = oh.noc
		WHERE medal <> ''NA''
		GROUP BY games, nr.region, medal
		ORDER BY games, nr.region, medal',
		'VALUES (''Bronze''), (''Gold''), (''Silver'')')
		AS RESULT(games_country varchar, bronze bigint, gold bigint, silver bigint)
	ORDER BY games_country)

SELECT  DISTINCT games,
--FIRST_VALUE(gold) OVER(PARTITION BY games ORDER BY gold DESC) AS gold,
--FIRST_VALUE(country) OVER(PARTITION BY games ORDER BY gold DESC) AS country,
CONCAT(
	FIRST_VALUE(gold) OVER(PARTITION BY games ORDER BY gold DESC),
	' - ',
	FIRST_VALUE(country) OVER(PARTITION BY games ORDER BY gold DESC)
	) AS gold,
CONCAT(
	FIRST_VALUE(silver) OVER(PARTITION BY games ORDER BY silver DESC),
	' - ',
	FIRST_VALUE(country) OVER(PARTITION BY games ORDER BY silver DESC)
	) AS silver,
CONCAT(
	FIRST_VALUE(bronze) OVER(PARTITION BY games ORDER BY bronze DESC),
	' - ',
	FIRST_VALUE(country) OVER(PARTITION BY games ORDER BY bronze DESC)
	) AS bronze
FROM temp
ORDER BY games;
--SELECT POSITION(' - ' in '1896 Summer - Australia');