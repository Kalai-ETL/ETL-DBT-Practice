{{
    config(
        materialized = 'table',
        transient = false,
        on_schema_change = 'add_new_columns'
    )
}}

SELECT
    emp_id,
    emp_name,
    department,
    salary,
    designation,Manager_id,
    updated_dt
FROM {{ source('employee_source', 'EMPLOYEE') }}