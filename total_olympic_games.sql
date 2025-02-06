-- How many olympics games have been held?

with t1 AS
	(SELECT DISTINCT year, season
	FROM olympics_history
	)

SELECT COUNT(*) AS total_olympic_games
FROM t1;