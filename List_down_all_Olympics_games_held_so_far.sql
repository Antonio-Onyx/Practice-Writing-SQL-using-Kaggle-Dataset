-- List down all Olympics games held so far
SELECT DISTINCT(year), season, city
FROM olympics_history
ORDER BY year;