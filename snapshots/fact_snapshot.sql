{% snapshot fact_snapshot %}
{{
    config(
      target_database='PC_DBT_DB',
      target_schema='snapshots',
      unique_key=['Date_id', 'Store_id', 'Dept_id'],
      strategy='check',
      check_cols=['DATE_ID', 'Store_id', 'Dept_id', 'Store_Weekly_sales', 'Fuel_price', 'Store_temperature', 
                  'unemployment', 'CPI', 'Markdown1', 'Markdown2', 'Markdown3', 'Markdown4', 'Markdown4'],
    )
}}
select * from {{ source('xfm', 'Walmart_fact_dim') }}
{% endsnapshot %}