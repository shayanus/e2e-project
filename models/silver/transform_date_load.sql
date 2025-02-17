{{ config({ "materialized":'table',
 "transient":true,
 "alias":'Walmart_date_dim',
 "schema": 'SILVER'
})}}
WITH date_dim AS (
        SELECT
            DISTINCT Date as Store_date,
            ISHOLIDAY
        FROM {{source('source','DEPT_SOURCE')}}
    UNION
        SELECT 
            DISTINCT Date as Store_date,
            ISHOLIDAY
        FROM {{source('source','FACT_SOURCE')}}
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY Store_date ASC) AS Date_id, 
    Store_date, 
    ISHOLIDAY,
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS
FROM date_dim