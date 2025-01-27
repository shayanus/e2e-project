
-- {% macro macros_copy_dept() %} 

-- delete from {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.DEPT_SOURCE;

-- COPY INTO {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.DEPT_SOURCE 
-- FROM 
-- (
-- SELECT
--     $1 AS Store,
--     $2 AS Dept,
--     $3 AS Date,
--     $4 AS Weekly_Sales,
--     $5 AS IsHoliday,
--     CURRENT_TIMESTAMP() AS INSERT_DTS,
--     CURRENT_TIMESTAMP() AS UPDATE_DTS,
--     metadata$filename AS SOURCE_FILE_NAME,
--     metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
-- FROM @{{ var('stage_name') }}department.csv
-- )
-- FILE_FORMAT = {{var ('file_format_csv') }}
-- PURGE={{ var('purge_status') }}
-- ;

-- {% endmacro %}


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
PURGE={{ var('purge_status') }}
;


{% endmacro %}