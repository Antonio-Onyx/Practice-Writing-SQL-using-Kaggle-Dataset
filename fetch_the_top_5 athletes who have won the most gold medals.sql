-- Fetch the top 5 athletes who have won the most gold medals.

SELECT name, team, COUNT(medal) AS total_gold_medals
FROM olympics_history
WHERE medal = 'Gold'
GROUP BY name, team
ORDER BY total_gold_medals DESC
LIMIT 5;