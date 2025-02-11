-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
--  
-- Table: Employee
-- 
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.
--  
-- 
-- Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.
-- 
-- The result format is in the following example.
-- 
--  
-- 
-- Example 1:
-- 
-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Example 2:
-- 
-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | null                   |
-- +------------------------+
-- 
-----------------------------------------------------------------------------------------------------------------------
-- Solution Query
-----------------------------------------------------------------------------------------------------------------------
-- Requested for Database Function
-- Solved with SQL For now 
-----------------------------------------------------------------------------------------------------------------------


WITH
nth_value_cte AS (SELECT 10)
SELECT SecondHighestSalary FROM
(
    SELECT salary AS SecondHighestSalary FROM 
    (
        select salary, dense_rank() OVER (ORDER BY salary DESC) as r FROM 
        (
            SELECT salary FROM employee 
        ) as base_table
    ) as sub_query
    where r = (SELECT * from nth_value_cte)
) sal_table
UNION ALL
SELECT null
LIMIT 1
;

-----------------------------------------------------------------------------------------------------------------------