/* Project: FC 26 Market Analysis
   Task: Data Analysis Queries
   Author: Seif NourElDeen
*/

-- 1. Value Score Algorithm
-- Identifies "Hidden Gems": players with high ratings but low market cost.
SELECT
  short_name,
  overall,
  value_eur,
  league_name,
  player_positions,
  ROUND((overall / value_eur) * 1000000, 2) AS value_score
FROM
  `fc26-capstone.fc26_data.players_clean`
WHERE
  overall > 80
  AND value_eur > 0
ORDER BY
  value_score DESC
LIMIT 15;

-- 2. League Market Trends
-- Compares average price across major leagues to identify "Popularity Tax".
SELECT
  league_name,
  COUNT(*) AS number_of_players,
  ROUND(AVG(overall), 1) AS avg_rating,
  ROUND(AVG(value_eur), 0) AS avg_price
FROM
  `fc26-capstone.fc26_data.players_clean`
WHERE
  overall > 75
GROUP BY
  league_name
ORDER BY
  avg_price DESC;

-- 3. Position Bias Analysis
-- Calculates "Cost Per Point" to see which positions are overpriced (e.g. Strikers vs GK).
SELECT
  player_positions AS position,
  COUNT(*) AS player_count,
  ROUND(AVG(overall), 1) AS avg_rating,
  ROUND(AVG(value_eur), 0) AS avg_price,
  ROUND(AVG(value_eur) / AVG(overall), 0) AS cost_per_point
FROM
  `fc26-capstone.fc26_data.players_clean`
WHERE
  overall > 82
GROUP BY
  position
HAVING
  player_count > 20
ORDER BY
  cost_per_point DESC
LIMIT 10;

-- 4. Deep Dive Profiling (For Tableau Dashboard)
-- Extracts specific Face Card stats (Pace, Shooting, etc.) for the top 20 value players.
SELECT
  short_name,
  player_positions,
  league_name,
  overall,
  value_eur,
  pace,
  shooting,
  passing,
  dribbling,
  defending,
  physic,
  ROUND((overall / value_eur) * 1000000, 2) AS value_score
FROM
  `fc26-capstone.fc26_data.players_clean`
WHERE
  overall > 82
  AND value_eur > 0
  AND player_positions NOT LIKE '%GK%' -- Exclude Goalkeepers for stat profiling
ORDER BY
  value_score DESC
LIMIT 20;
