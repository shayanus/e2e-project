{% macro macros_copy_dept() %} 

delete from {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.DEPT_SOURCE;

COPY INTO {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.DEPT_SOURCE 
FROM 
(
SELECT
    $1 AS Store,
    $2 AS Dept,
    $3 AS Date,
    $4 AS Weekly_Sales,
    $5 AS IsHoliday,
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS,
    metadata$filename AS SOURCE_FILE_NAME,
    metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
FROM @{{ var('stage_name') }}department.csv
)
FILE_FORMAT = {{var ('file_format_csv') }}
FORCE = TRUE
PURGE={{ var('purge_status') }}
;

{% endmacro %}



{% macro macros_copy_stores() %} 

delete from {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.STORES_SOURCE;

COPY INTO {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.STORES_SOURCE 
FROM 
(
SELECT
    $1 AS Store,
    $2 AS Type,
    $3 AS Size,
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS,
    metadata$filename AS SOURCE_FILE_NAME,
    metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
FROM @{{ var('stage_name') }}stores.csv
)
FILE_FORMAT = {{var ('file_format_csv') }}
FORCE = TRUE
PURGE={{ var('purge_status') }}
;


{% endmacro %}



{% macro macros_copy_fact() %} 

delete from {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.FACT_SOURCE;

COPY INTO {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.FACT_SOURCE 
FROM 
(
SELECT
    $1 AS Store,
    $2 AS Date,
    $3 AS Temperature,
    $4 AS Fuel_Price,
    CASE WHEN $5 = 'NA' THEN NULL ELSE $5 END AS MarkDown1,
    CASE WHEN $6 = 'NA' THEN NULL ELSE $6 END AS MarkDown2,
    CASE WHEN $7 = 'NA' THEN NULL ELSE $7 END AS MarkDown3,
    CASE WHEN $8 = 'NA' THEN NULL ELSE $8 END AS MarkDown4,
    CASE WHEN $9 = 'NA' THEN NULL ELSE $9 END AS MarkDown5,
    CASE WHEN $10 = 'NA' THEN NULL ELSE $10 END AS CPI,
    CASE WHEN $11 = 'NA' THEN NULL ELSE $11 END AS Unemployment,
    $12 AS IsHoliday,
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS,
    metadata$filename AS SOURCE_FILE_NAME,
    metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
FROM @{{ var('stage_name') }}fact.csv
)
FILE_FORMAT = {{var ('file_format_csv') }}
FORCE = TRUE
PURGE={{ var('purge_status') }}
;

{% endmacro %}