/* Project: FC 26 Market Analysis
   Task: Data Cleaning
   Author: Seif NourElDeen
*/

-- 1. Filtering and Table Creation
-- We filter out players with 0 value (Free Agents) and missing names.

CREATE OR REPLACE TABLE `fc26-capstone.fc26_data.players_clean` AS
SELECT
  *
FROM
  `fc26-capstone.fc26_data.players`
WHERE
  value_eur > 0
  AND value_eur IS NOT NULL
  AND short_name IS NOT NULL;

-- 2. Data Validation
-- Checking row counts to confirm how many rows were removed.

SELECT
  (SELECT COUNT(*) FROM `fc26-capstone.fc26_data.players`) AS original_count,
  (SELECT COUNT(*) FROM `fc26-capstone.fc26_data.players_clean`) AS clean_count;
