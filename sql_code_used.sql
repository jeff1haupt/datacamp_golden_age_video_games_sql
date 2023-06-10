-- Select all information for the top ten best-selling games
-- Order the results from best-selling game down to tenth best-selling
SELECT * FROM game_sales ORDER BY games_sold desc LIMIT 10;

-- Join games_sales and reviews
-- Select a count of the number of games where both critic_score and user_score are null
SELECT COUNT(*)
FROM game_sales gs 
LEFT JOIN reviews r 
ON gs.game = r.game
WHERE critic_score IS NULL AND user_score IS NULL
 


