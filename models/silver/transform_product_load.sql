{{ config({ "materialized":'table',
 "transient":true,
 "alias":'DEPT_SOURCE_TRANSFORM',
 "pre_hook": macros_copy_csv(),
 "schema": 'SILVER'
})}}
WITH transform AS(
SELECT 
    Store AS Store,
    Dept AS Dept,
    Date AS Date,
    Weekly_Sales AS Weekly_Sales,
    IsHoliday AS IsHoliday,
    INSERT_DTS AS INSERT_DTS,
    UPDATE_DTS AS UPDATE_DTS,
    SOURCE_FILE_NAME AS SOURCE_FILE_NAME,
    SOURCE_FILE_ROW_NUMBER AS SOURCE_FILE_ROW_NUMBER
FROM {{source('source','DEPT_SOURCE')}}
)
SELECT *
FROM transform