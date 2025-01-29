{{ config({ "materialized":'table',
 "transient":true,
 "alias":'Walmart_fact_dim',
 "pre_hook": macros_copy_fact(),
 "schema": 'SILVER'
})}}
WITH fact AS (
    WITH storetable AS (
        SELECT 
            date.Date_id AS date_id,
            date.store_date,
            dept.store,
            dept.dept AS dept_id,
            dept.weekly_sales as Store_Weekly_sales
        FROM 
            {{source('source','DEPT_SOURCE')}} dept 
        LEFT JOIN 
            {{ref('transform_date_load')}} date
        ON date.STORE_DATE = dept.date
    )
    SELECT 
        st.Date_id,
        st.store as Store_id,
        st.Dept_id,
        st.Store_Weekly_sales,
        f.Fuel_price,
        f.temperature as Store_temperature,
        f.unemployment,
        f.CPI,
        f.Markdown1,
        f.markdown2,
        f.markdown3,
        f.markdown4,
        f.markdown5,
        CURRENT_TIMESTAMP() AS INSERT_DTS,
        CURRENT_TIMESTAMP() AS UPDATE_DTS
    FROM 
        storetable st 
    JOIN 
        {{source('source','FACT_SOURCE')}} f
    ON st.store = f.store AND st.store_date = f.date
)
SELECT *
FROM fact