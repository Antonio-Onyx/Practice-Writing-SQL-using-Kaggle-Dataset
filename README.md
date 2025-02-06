# Practice-Writing-SQL-using-Kaggle-Dataset
The porpose on this is practice my SQL skills 


### Query: Mention the total no of nations who participated in each olympics game
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
