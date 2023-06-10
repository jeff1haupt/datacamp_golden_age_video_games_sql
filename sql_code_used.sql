-- Select all information for the top ten best-selling games
-- Order the results from best-selling game down to tenth best-selling
SELECT * FROM game_sales ORDER BY games_sold desc LIMIT 10;

-- Join games_sales and reviews
-- Select a count of the number of games where both critic_score and user_score are null
SELECT COUNT(*)
FROM game_sales gs 
LEFT JOIN reviews r 
ON gs.game = r.game
WHERE critic_score IS NULL AND user_score IS NULL;
 
-- Select release year and average critic score for each year, rounded and aliased
-- Join the game_sales and reviews tables
-- Group by release year
-- Order the data from highest to lowest avg_critic_score and limit to 10 results
SELECT gs.year, ROUND(AVG(r.critic_score),2) AS avg_critic_score 
FROM game_sales gs 
JOIN reviews r 
ON gs.game = r.game 
GROUP BY year
ORDER BY avg_critic_score desc 
LIMIT 10;

-- Paste your query from the previous task; update it to add a count of games released in each year called num_games
-- Update the query so that it only returns years that have more than four eviewed games
SELECT gs.year, 
    ROUND(AVG(r.critic_score),2) AS avg_critic_score, 
    COUNT(*) AS num_games
FROM game_sales gs 
JOIN reviews r 
ON gs.game = r.game 
GROUP BY year
HAVING COUNT(*) > 4
ORDER BY avg_critic_score desc 
LIMIT 10;

-- Select the year and avg_critic_score for those years that dropped off the list of critic favorites 
-- Order the results from highest to lowest avg_critic_score
SELECT t.year, t.avg_critic_score 
FROM top_critic_years t 
WHERE NOT t.year IN (SELECT year FROM top_critic_years_more_than_four_games);

-- Select year, an average of user_score, and a count of games released in a given year, aliased and rounded
-- Include only years with more than four reviewed games; group data by year
-- Order data by avg_user_score, and limit to ten results
SELECT gs.year, 
    ROUND(AVG(r.user_score),2) AS avg_user_score, 
    COUNT(*) AS num_games
FROM game_sales gs 
JOIN reviews r 
ON gs.game = r.game 
GROUP BY year
HAVING COUNT(*) > 4
ORDER BY avg_user_score desc 
LIMIT 10;

-- Select the year results that appear on both tables
SELECT c.year FROM top_critic_years_more_than_four_games c
INNER JOIN top_user_years_more_than_four_games u 
ON c.year = u.year;

-- Select year and sum of games_sold, aliased as total_games_sold; order results by total_games_sold descending
-- Filter game_sales based on whether each year is in the list returned in the previous task
SELECT year, SUM(games_sold) AS total_games_sold
FROM game_sales
GROUP BY year
HAVING year IN 
  (SELECT c.year 
   FROM top_critic_years_more_than_four_games c
   INNER JOIN top_user_years_more_than_four_games u 
   ON c.year = u.year)
ORDER BY total_games_sold desc;


