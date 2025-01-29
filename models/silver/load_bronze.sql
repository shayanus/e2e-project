{{ config({ 
    "materialized": 'ephemeral',
    "schema": 'BRONZE'
})}}

{% do macros_copy_dept() %}
{% do macros_copy_stores() %}
{% do macros_copy_fact() %}
