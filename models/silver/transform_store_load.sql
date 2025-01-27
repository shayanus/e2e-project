{{ config({ "materialized":'table',
 "transient":true,
 "alias":'Walmart_store_dim',
 "pre_hook": macros_copy_stores(),
 "schema": 'SILVER'
})}}
WITH store AS(
SELECT 
    Store AS Store,
    Type AS Type,
    Size AS Size,
    INSERT_DTS AS INSERT_DTS,
    UPDATE_DTS AS UPDATE_DTS,
    SOURCE_FILE_NAME AS SOURCE_FILE_NAME,
    SOURCE_FILE_ROW_NUMBER AS SOURCE_FILE_ROW_NUMBER
FROM {{source('source','STORES_SOURCE')}}
)
SELECT *
FROM store