-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
--  
-- Table: Products
-- 
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key (combination of columns with unique values) of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
--  
-- 
-- Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
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
-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+
-- Output: 
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+
-- 
-----------------------------------------------------------------------------------------------------------------------
-- Solution Query 1
-----------------------------------------------------------------------------------------------------------------------

WITH
cte_product_data_lt_dt AS (
    SELECT 
        product_id, new_price 
    FROM 
    (
        SELECT 
            product_id, 
            change_date, 
            new_price,
            MAX(change_date) OVER (PARTITION BY product_id) as max_change_date
        FROM 
            products 
        WHERE 
            change_date <= "2019-08-16"
    ) base_table
    WHERE
        change_date = max_change_date
),
cte_product_data_gt_dt AS (
    SELECT 
        DISTINCT product_id, 
        10 AS new_price
    FROM 
        products 
    WHERE 
        change_date > "2019-08-16" 
    AND
        product_id NOT IN (SELECT distinct product_id FROM cte_product_data_lt_dt)
)
SELECT
    product_id, new_price AS price
FROM
    cte_product_data_lt_dt
UNION ALL
SELECT
    product_id, new_price AS price
FROM
    cte_product_data_gt_dt
;

-----------------------------------------------------------------------------------------------------------------------
-- Solution Query 2
-----------------------------------------------------------------------------------------------------------------------

WITH
cte_existing_products AS (
    SELECT 
        product_id, 
        MAX(change_date) as max_change_date
    FROM 
        products 
    WHERE 
        change_date <= "2019-08-16"
    GROUP BY
    product_id
)
SELECT
    p.product_id,
    COALESCE(new_price, 10) as price
FROM
    (SELECT distinct product_id from products) p 
left join 
    cte_existing_products ep 
ON 
    p.product_id = ep.product_id
left join
    products p2
ON
    ep.product_id = p2.product_id
AND
    ep.max_change_date = p2.change_date
;

-----------------------------------------------------------------------------------------------------------------------
-- Solution Query 3
-----------------------------------------------------------------------------------------------------------------------

WITH
cte_products AS (
    SELECT * FROM products
),
cte_existing_products AS (
    SELECT 
        p.product_id, 
        cd.max_change_date
    FROM 
        (SELECT distinct product_id from cte_products) p 
    LEFT JOIN
    (
    SELECT 
        product_id, 
        MAX(change_date) as max_change_date
    FROM
        cte_products
    WHERE 
        change_date <= "2019-08-16"
    GROUP BY
        product_id
    ) cd
    ON
        p.product_id = cd.product_id
)
SELECT
    ep.product_id,
    COALESCE(p.new_price, 10) as price
FROM
    cte_existing_products ep 
left join 
    cte_products p
ON
    ep.product_id = p.product_id
AND
    ep.max_change_date = p.change_date
;

-----------------------------------------------------------------------------------------------------------------------