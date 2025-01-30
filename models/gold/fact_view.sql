{{ config({ "materialized":'table',
 "transient":true,
 "alias":'Walmart_fact_dim',
 "schema": 'GOLD'
})}}

WITH view AS (
    SELECT
        Date_id,
        Store_id,
        Dept_id,
        Store_Weekly_sales,
        Fuel_price,
        Store_temperature,
        unemployment,
        CPI,
        Markdown1,
        markdown2,
        markdown3,
        markdown4,
        markdown5,
        INSERT_DTS,
        UPDATE_DTS,
        DBT_VALID_FROM AS VRSN_STRT_DTS,
        COALESCE(DBT_VALID_TO, '9999-12-31 00:00:00.000') AS VRSN_END_DTS
    FROM
        {{ref('fact_snapshot')}}
)
SELECT
    *
FROM
    view