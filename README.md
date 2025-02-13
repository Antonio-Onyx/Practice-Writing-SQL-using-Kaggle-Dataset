# Practice-Writing-SQL-using-Kaggle-Dataset
The porpose on this is practice my SQL skills. This the [link](https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results) of the dataset.


### Query 1: Mention the total no of nations who participated in each olympics game
```SQL
WITH t1 AS(
	SELECT oh.games, oh.noc, olh.region
	FROM olympics_history oh
	JOIN olympics_history_noc_region olh ON olh.noc = oh.noc
)

SELECT games, COUNT(DISTINCT region) AS total_countries
FROM t1
GROUP BY games
ORDER BY games;
```

| games        | total_contries |
|--------------|----------------|
| 1896 Summer  |       12       |
| 1900 Summer  |       31       |
| 1904 Summer  |       14       |
| 1906 Summer  |       20       |

### Query 2: Which year saw the highest and lowest no of countries participating in olympics
```SQL
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

SELECT 
	(SELECT CONCAT(games, ' - ',total_countries)
	 FROM t2
	 WHERE total_countries = (SELECT MAX(total_countries) FROM t2)) AS highest_countries,

	 (SELECT CONCAT(games, ' - ',total_countries)
	 FROM t2
	 WHERE total_countries = (SELECT MIN(total_countries) FROM t2)) AS lowest_countries
```

| highest_countries | lowest_countries |
|-------------------|------------------|
| 2016 Summer - 204 | 1896 Summer - 12 |
