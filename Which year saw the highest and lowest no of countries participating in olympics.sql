-- Which year saw the highest and lowest no of countries participating in olympics
WITH t1 AS(
	SELECT oh.games, oh.noc, olh.region
	FROM olympics_history oh
	JOIN olympics_history_noc_region olh ON olh.noc = oh.noc
),

t2 AS(
SELECT games, COUNT(DISTINCT region) AS total_countries
FROM t1
GROUP BY games
ORDER BY games
)

--SELECT 
	--MAX(total_countries) AS highest_countries 
	--MIN(total_countries) AS lowest_countries
--FROM t2;

--SELECT 
--	CONCAT(games, ' - ',total_countries) AS highest_countries,
--FROM t2
--WHERE total_countries = (SELECT MAX(total_countries) FROM t2);

SELECT 
	(SELECT CONCAT(games, ' - ',total_countries)
	 FROM t2
	 WHERE total_countries = (SELECT MAX(total_countries) FROM t2)) AS highest_countries,

	 (SELECT CONCAT(games, ' - ',total_countries)
	 FROM t2
	 WHERE total_countries = (SELECT MIN(total_countries) FROM t2)) AS lowest_countries
	 