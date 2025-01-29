{{ config({ "materialized":'table',
 "transient":true,
 "alias":'Walmart_store_dim',
 "schema": 'SILVER'
})}}
WITH store_dim AS(
    SELECT
        DISTINCT D.STORE AS Store_id,
        D.DEPT AS Dept_id,
        S.TYPE AS Store_type,
        S.SIZE AS Store_size
    FROM
        {{source('source','DEPT_SOURCE')}} D
    JOIN
        {{source('source','STORES_SOURCE')}} S
    ON D.STORE = S.STORE
)
SELECT *
FROM store_dim