-- Mention the total no of nations who participated in each olympics game
WITH t1 AS(
	SELECT oh.games, oh.noc, olh.region
	FROM olympics_history oh
	JOIN olympics_history_noc_region olh ON olh.noc = oh.noc
)

SELECT games, COUNT(DISTINCT region) AS total_countries
FROM t1
GROUP BY games
ORDER BY games;

