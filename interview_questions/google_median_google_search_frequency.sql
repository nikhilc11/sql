-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
-- Google's marketing team is making a Superbowl commercial and needs a simple statistic to put on their TV ad: 
-- the median number of searches a person made last year.
-- 
-- However, at Google scale, querying the 2 trillion searches is too costly. 
-- Luckily, you have access to the summary table which tells you the number of searches made last year and how many 
-- Google users fall into that bucket.
-- 
-- Write a query to report the median of searches made by a user. Round the median to one decimal point.
-- 
-- search_frequency Table:
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | searches	 | integer |
-- | num_users	 | integer |
-- +-------------+---------+
-- 
-- Example Input:
-- +----------+-----------+
-- | searches |	num_users |
-- +----------+-----------+
-- | 1        | 2         |
-- | 2        | 2         |
-- | 3        | 3         |
-- | 4        | 1         |
-- +----------+-----------+
-- 
-- Example Output:
-- 
-- +--------+
-- | median |
-- +--------+
-- | 2.5    |
-- +--------+

-- By expanding the search_frequency table, we get [1, 1, 2, 2, 3, 3, 3, 4] which has a median of 2.5 searches per user.
-- 
-- The dataset you are querying against may have different input & output - this is just an example!
-- 
-----------------------------------------------------------------------------------------------------------------------
-- Solution
-----------------------------------------------------------------------------------------------------------------------

WITH
search_frequency_cte AS (
    SELECT * FROM search_frequency
),
cummu_user_cnt_cte AS (
  SELECT
    searches, 
    num_users, 
    total_user_count_from_seaerches,
    total_user_count_until_seaerches,
    LAG(total_user_count_until_seaerches,  1, 0) OVER (ORDER BY searches asc) AS lag_total_user_count_until_seaerches
  FROM
  (
    SELECT 
      searches, 
      num_users, 
      sum(num_users) OVER (ORDER BY searches asc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_user_count_until_seaerches,
      sum(num_users) OVER (ORDER BY searches asc ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS total_user_count_from_seaerches
    FROM 
      search_frequency_cte
  ) in_tab_1
),
total_user_cnt_cte AS (
  SELECT
    total_users,
    CASE WHEN (total_users % 2 = 0 ) THEN CAST(total_users/2 AS INTEGER)     ELSE CAST((total_users+1)/2 AS INTEGER) END AS lower_bound,
    CASE WHEN (total_users % 2 = 0 ) THEN (CAST(total_users/2 AS INTEGER)+1) ELSE CAST((total_users+1)/2 AS INTEGER) END AS upper_bound
  FROM 
  (
    SELECT 
      sum(num_users) as total_users
    FROM
      search_frequency_cte
  ) in_tab_2
),
calculate_median_segment_cte AS (
  SELECT
      searches, 
      num_users, 
      total_user_count_from_seaerches, 
      total_user_count_until_seaerches,
      lag_total_user_count_until_seaerches,
      total_users,
      lower_bound,
      upper_bound,
      CASE WHEN (total_user_count_until_seaerches >= lower_bound AND lag_total_user_count_until_seaerches < lower_bound) THEN searches ELSE 0 END as lb_searches,
      CASE WHEN (total_user_count_until_seaerches >= upper_bound AND lag_total_user_count_until_seaerches < upper_bound) THEN searches ELSE 0 END as ub_searches
  FROM cummu_user_cnt_cte CROSS JOIN total_user_cnt_cte
)
-- SELECT * FROM calculate_median_segment_cte
SELECT ROUND((SUM(lb_searches) + SUM(ub_searches)) / 2.0, 2) AS median FROM calculate_median_segment_cte
;

-----------------------------------------------------------------------------------------------------------------------