-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
--  
-- Table: Customer
-- 
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | customer_id | int     |
-- | product_key | int     |
-- +-------------+---------+
-- This table may contain duplicates rows. 
-- customer_id is not NULL.
-- product_key is a foreign key (reference column) to Product table.
--  
-- 
-- Table: Product
-- 
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_key | int     |
-- +-------------+---------+
-- product_key is the primary key (column with unique values) for this table.
--  
-- 
-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.
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
-- Customer table:
-- +-------------+-------------+
-- | customer_id | product_key |
-- +-------------+-------------+
-- | 1           | 5           |
-- | 2           | 6           |
-- | 3           | 5           |
-- | 3           | 6           |
-- | 1           | 6           |
-- +-------------+-------------+
-- Product table:
-- +-------------+
-- | product_key |
-- +-------------+
-- | 5           |
-- | 6           |
-- +-------------+
-- Output: 
-- +-------------+
-- | customer_id |
-- +-------------+
-- | 1           |
-- | 3           |
-- +-------------+
-- Explanation: 
-- The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.
-- 
-----------------------------------------------------------------------------------------------------------------------
-- Solution Query
-----------------------------------------------------------------------------------------------------------------------

SELECT customer_id FROM (select customer_id, product_key, sum(1) as rec_cnt FROM customer GROUP BY customer_id, product_key) as in_agg
GROUP BY customer_id having sum(1) = (
    SELECT count(product_key) as product_cnt FROM (SELECT product_key, sum(1) as rec_cnt FROM product GROUP BY product_key) as in_agg
);

-----------------------------------------------------------------------------------------------------------------------