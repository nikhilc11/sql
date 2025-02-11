-----------------------------------------------------------------------------------------------------------------------
-- Problem Statement
-----------------------------------------------------------------------------------------------------------------------
-- Generate Date Dim using SQL
-----------------------------------------------------------------------------------------------------------------------
WITH day_list_cte AS (
    SELECT 1 AS day
    UNION ALL
    SELECT 2 AS day
    UNION ALL
    SELECT 3 AS day
    UNION ALL
    SELECT 4 AS day
    UNION ALL
    SELECT 5 AS day
    UNION ALL
    SELECT 6 AS day
    UNION ALL
    SELECT 7 AS day
    UNION ALL
    SELECT 8 AS day
    UNION ALL
    SELECT 9 AS day
    UNION ALL
    SELECT 10 AS day
    UNION ALL
    SELECT 11 AS day
    UNION ALL
    SELECT 12 AS day
    UNION ALL
    SELECT 13 AS day
    UNION ALL
    SELECT 14 AS day
    UNION ALL
    SELECT 15 AS day
    UNION ALL
    SELECT 16 AS day
    UNION ALL
    SELECT 17 AS day
    UNION ALL
    SELECT 18 AS day
    UNION ALL
    SELECT 19 AS day
    UNION ALL
    SELECT 20 AS day
    UNION ALL
    SELECT 21 AS day
    UNION ALL
    SELECT 22 AS day
    UNION ALL
    SELECT 23 AS day
    UNION ALL
    SELECT 24 AS day
    UNION ALL
    SELECT 25 AS day
    UNION ALL
    SELECT 26 AS day
    UNION ALL
    SELECT 27 AS day
    UNION ALL
    SELECT 28 AS day
    UNION ALL
    SELECT 29 AS day
    UNION ALL
    SELECT 30 AS day
    UNION ALL
    SELECT 31 AS day
),
month_list_cte AS (
    SELECT 1 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 2 AS month,  29 AS max_no_of_days, true  AS affected_by_leap_year
    UNION ALL
    SELECT 3 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 4 AS month,  30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 5 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 6 AS month,  30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 7 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 8 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 9 AS month,  30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 10 AS month, 31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 11 AS month, 30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 12 AS month, 31 AS max_no_of_days, false AS affected_by_leap_year
),
year_list_cte AS (
    SELECT 1970 AS year
    UNION ALL
    SELECT 1971 AS year
    UNION ALL
    SELECT 1972 AS year
    UNION ALL
    SELECT 1973 AS year
    UNION ALL
    SELECT 1974 AS year
    UNION ALL
    SELECT 1975 AS year
    UNION ALL
    SELECT 1976 AS year
    UNION ALL
    SELECT 1977 AS year
    UNION ALL
    SELECT 1978 AS year
    UNION ALL
    SELECT 1979 AS year
    UNION ALL
    SELECT 1980 AS year
    UNION ALL
    SELECT 1981 AS year
    UNION ALL
    SELECT 1982 AS year
    UNION ALL
    SELECT 1983 AS year
    UNION ALL
    SELECT 1984 AS year
    UNION ALL
    SELECT 1985 AS year
    UNION ALL
    SELECT 1986 AS year
    UNION ALL
    SELECT 1987 AS year
    UNION ALL
    SELECT 1988 AS year
    UNION ALL
    SELECT 1989 AS year
    UNION ALL
    SELECT 1990 AS year
    UNION ALL
    SELECT 1991 AS year
    UNION ALL
    SELECT 1992 AS year
    UNION ALL
    SELECT 1993 AS year
    UNION ALL
    SELECT 1994 AS year
    UNION ALL
    SELECT 1995 AS year
    UNION ALL
    SELECT 1996 AS year
    UNION ALL
    SELECT 1997 AS year
    UNION ALL
    SELECT 1998 AS year
    UNION ALL
    SELECT 1999 AS year
    UNION ALL
    SELECT 2000 AS year
    UNION ALL
    SELECT 2001 AS year
    UNION ALL
    SELECT 2002 AS year
    UNION ALL
    SELECT 2003 AS year
    UNION ALL
    SELECT 2004 AS year
    UNION ALL
    SELECT 2005 AS year
    UNION ALL
    SELECT 2006 AS year
    UNION ALL
    SELECT 2007 AS year
    UNION ALL
    SELECT 2008 AS year
    UNION ALL
    SELECT 2009 AS year
    UNION ALL
    SELECT 2010 AS year
    UNION ALL
    SELECT 2011 AS year
    UNION ALL
    SELECT 2012 AS year
    UNION ALL
    SELECT 2013 AS year
    UNION ALL
    SELECT 2014 AS year
    UNION ALL
    SELECT 2015 AS year
    UNION ALL
    SELECT 2016 AS year
    UNION ALL
    SELECT 2017 AS year
    UNION ALL
    SELECT 2018 AS year
    UNION ALL
    SELECT 2019 AS year
    UNION ALL
    SELECT 2020 AS year
    UNION ALL
    SELECT 2021 AS year
    UNION ALL
    SELECT 2022 AS year
    UNION ALL
    SELECT 2023 AS year
    UNION ALL
    SELECT 2024 AS year
    UNION ALL
    SELECT 2025 AS year
    UNION ALL
    SELECT 2026 AS year
    UNION ALL
    SELECT 2027 AS year
    UNION ALL
    SELECT 2028 AS year
    UNION ALL
    SELECT 2029 AS year
),
year_list_with_leap_flag_cte AS (
    SELECT year, year%4 = 0 AS leap_flag from year_list_cte
),
geenrate_date_dim_keys_cte AS (
    SELECT 
        CONCAT(LPAD(CAST(day AS CHAR), 2, 0), LPAD(CAST(month AS CHAR), 2, 0), year) as date_key, day, month, year
    FROM 
        day_list_cte 
    JOIN 
        month_list_cte 
    ON 
        day <= max_no_of_days
    CROSS JOIN
        year_list_with_leap_flag_cte
    WHERE
        CASE WHEN (NOT(leap_flag) AND affected_by_leap_year AND day = 29) THEN false ELSE true END
)
SELECT year, month, min(date_key), max(date_key)
FROM geenrate_date_dim_keys_cte
GROUP BY year, month
ORDER BY year, month

-----------------------------------------------------------------------------------------------------------------------

WITH day_list_cte AS (
    SELECT 01 AS day
    UNION ALL
    SELECT 02 AS day
    UNION ALL
    SELECT 03 AS day
    UNION ALL
    SELECT 04 AS day
    UNION ALL
    SELECT 05 AS day
    UNION ALL
    SELECT 06 AS day
    UNION ALL
    SELECT 07 AS day
    UNION ALL
    SELECT 08 AS day
    UNION ALL
    SELECT 09 AS day
    UNION ALL
    SELECT 10 AS day
    UNION ALL
    SELECT 11 AS day
    UNION ALL
    SELECT 12 AS day
    UNION ALL
    SELECT 13 AS day
    UNION ALL
    SELECT 14 AS day
    UNION ALL
    SELECT 15 AS day
    UNION ALL
    SELECT 16 AS day
    UNION ALL
    SELECT 17 AS day
    UNION ALL
    SELECT 18 AS day
    UNION ALL
    SELECT 19 AS day
    UNION ALL
    SELECT 20 AS day
    UNION ALL
    SELECT 21 AS day
    UNION ALL
    SELECT 22 AS day
    UNION ALL
    SELECT 23 AS day
    UNION ALL
    SELECT 24 AS day
    UNION ALL
    SELECT 25 AS day
    UNION ALL
    SELECT 26 AS day
    UNION ALL
    SELECT 27 AS day
    UNION ALL
    SELECT 28 AS day
    UNION ALL
    SELECT 29 AS day
    UNION ALL
    SELECT 30 AS day
    UNION ALL
    SELECT 31 AS day
),
month_list_cte AS (
    SELECT 01 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 02 AS month,  29 AS max_no_of_days, true  AS affected_by_leap_year
    UNION ALL
    SELECT 03 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 04 AS month,  30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 05 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 06 AS month,  30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 07 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 08 AS month,  31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 09 AS month,  30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 10 AS month, 31 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 11 AS month, 30 AS max_no_of_days, false AS affected_by_leap_year
    UNION ALL
    SELECT 12 AS month, 31 AS max_no_of_days, false AS affected_by_leap_year
),
year_list_cte AS (
    SELECT 2020 AS year
    UNION ALL
    SELECT 2021 AS year
    UNION ALL
    SELECT 2022 AS year
    UNION ALL
    SELECT 2023 AS year
    UNION ALL
    SELECT 2024 AS year
),
year_list_with_leap_flag_cte AS (
    SELECT year, year%4 = 0 AS leap_flag from year_list_cte
),
geenrate_date_dim_keys_cte AS (
    SELECT 
        CONCAT(LPAD(CAST(day AS CHAR), 2, 0), LPAD(CAST(month AS CHAR), 2, 0), year) as date_key, day, month, year
    FROM 
        day_list_cte 
    JOIN 
        month_list_cte 
    ON 
        day <= max_no_of_days
    CROSS JOIN
        year_list_with_leap_flag_cte
    WHERE
        CASE WHEN (NOT(leap_flag) AND affected_by_leap_year AND day = 29) THEN false ELSE true END
)
SELECT year, month, min(date_key), max(date_key)
FROM geenrate_date_dim_keys_cte
GROUP BY year, month
ORDER BY year, month

-----------------------------------------------------------------------------------------------------------------------
