
{{ config(
    materialized = 'table',
) }}

WITH date_spine AS (

    {{ dbt_utils.date_spine(
        datepart = "day",
        start_date = "cast('2025-01-01' as date)",
        end_date = "cast('2040-12-31' as date)"
    ) }}

)

SELECT
    DATE_DAY,
    TO_NUMBER(TO_CHAR(DATE_DAY, 'YYYYMMDD')) AS DATE_KEY,
    YEAR(DATE_DAY) AS YEAR,
    QUARTER(DATE_DAY) AS QUARTER,
    MONTH(DATE_DAY) AS MONTH,
    MONTHNAME(DATE_DAY) AS MONTH_NAME,
    DAY(DATE_DAY) AS DAY,
    DAYOFWEEKISO(DATE_DAY) AS DAY_OF_WEEK,
    DAYNAME(DATE_DAY) AS DAY_NAME,

    CASE
        WHEN DAYOFWEEKISO(DATE_DAY) IN (6, 7)
        THEN 'WEEKEND'
        ELSE 'WEEKDAY'
    END AS DAY_TYPE

FROM date_spine
