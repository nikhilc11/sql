-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
--  
-- Table: binary_tree
-- 
-- +------+--------+
-- | Node | Parent |
-- +------+--------+
-- | 1    | 2      |
-- | 3    | 2      |
-- | 6    | 8      |
-- | 9    | 8      |
-- | 2    | 5      |
-- | 8    | 5      |
-- | 5    | NULL   |
-- +------+--------+
--  
-- We are given a table, which is a Binary Search Tree consisting of two columns Node and Parent. 
-- 
-- We must write a query that returns the node type ordered by the value of nodes in ascending order. 
-- 
-- There are 3 types.
-- 
-- Root — if the node is a root
-- Leaf — if the node is a leaf
-- Inner — if the node is neither root nor leaf.
-- 
-----------------------------------------------------------------------------------------------------------------------
-- Solution Query 1
-----------------------------------------------------------------------------------------------------------------------

WITH
binary_tree_cte AS (
    SELECT 1 AS node, 2 AS parent
    UNION
    SELECT 3 AS node, 2 AS parent
    UNION
    SELECT 6 AS node, 8 AS parent
    UNION
    SELECT 9 AS node, 8 AS parent
    UNION
    SELECT 2 AS node, 5 AS parent
    UNION
    SELECT 8 AS node, 5 AS parent
    UNION
    SELECT 5 AS node, NULL AS parent
),
parent_cte AS (
	SELECT DISTINCT parent FROM binary_tree_cte WHERE parent IS NOT NULL
),
nodes_with_categories_cte AS (
    SELECT
        node,
        CASE WHEN parent is NULL THEN "ROOT"
            WHEN node IN (SELECT parent from parent_cte) THEN "INNER"
            ELSE "LEAF"
        END
    FROM
        binary_tree_cte
),
node_type_count_cte AS (
    SELECT
        node_type, sum(1) as node_count
    FROM
        nodes_with_categories_cte
    GROUP BY
        node_type
)
SELECT * FROM nodes_with_categories_cte
ORDER BY node asc
;

-----------------------------------------------------------------------------------------------------------------------
-- Solution Query 2
-----------------------------------------------------------------------------------------------------------------------

SELECT
	node_type, sum(1) as node_count
FROM
(
  SELECT
      node,
      CASE WHEN parent is NULL THEN "ROOT"
           WHEN node IN (SELECT distinct parent from (
    SELECT 1 AS node, 2 AS parent
    UNION ALL
    SELECT 3 AS node, 2 AS parent
    UNION ALL
    SELECT 6 AS node, 8 AS parent
    UNION ALL
    SELECT 9 AS node, 8 AS parent
    UNION ALL
    SELECT 2 AS node, 5 AS parent
    UNION ALL
    SELECT 8 AS node, 5 AS parent
    UNION ALL
    SELECT 5 AS node, NULL AS parent
  ) binary_tree) THEN "INNER"
           ELSE "LEAF"
      END AS node_type
  FROM
  (
    SELECT 1 AS node, 2 AS parent
    UNION ALL
    SELECT 3 AS node, 2 AS parent
    UNION ALL
    SELECT 6 AS node, 8 AS parent
    UNION ALL
    SELECT 9 AS node, 8 AS parent
    UNION ALL
    SELECT 2 AS node, 5 AS parent
    UNION ALL
    SELECT 8 AS node, 5 AS parent
    UNION ALL
    SELECT 5 AS node, NULL AS parent
  ) binary_tree
ORDER BY node asc
) nodes_with_categories
GROUP BY
    node_type
;

-----------------------------------------------------------------------------------------------------------------------