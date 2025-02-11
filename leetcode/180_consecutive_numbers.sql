-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
--  
-- Table: Logs
-- 
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- In SQL, id is the primary key for this table.
-- id is an autoincrement column starting from 1.
--  
-- 
-- Find all numbers that appear at least three times consecutively.
-- 
-- Return the result table in any order.
-- 
-- The result format is in the following example.
-- 
--  
-- 
-- Example 1:
-- 
-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.
-- -- 
-----------------------------------------------------------------------------------------------------------------------
-- Solution Query
-----------------------------------------------------------------------------------------------------------------------

SELECT 
    DISTINCT num AS ConsecutiveNums 
FROM 
(
    SELECT 
        id, 
        num, 
        LAG(num, 1, 0) OVER (ORDER BY id) AS prev_num, 
        LEAD(num, 1, 0) OVER (ORDER BY id) AS next_num,
        LAG(id, 1, 0) OVER (ORDER BY id) AS prev_id, 
        LEAD(id, 1, 0) OVER (ORDER BY id) AS next_id
    FROM 
        logs
) AS sub_query
WHERE 
    num = prev_num 
AND 
    num = next_num
AND
    id = prev_id + 1
AND
    id = next_id - 1
;

-----------------------------------------------------------------------------------------------------------------------