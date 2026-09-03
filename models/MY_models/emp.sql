{{
    config(
        materialized = 'incremental',
        unique_key = 'emp_id',
        incremental_strategy = 'merge',
        on_schema_change = 'append_new_columns'
    )
}}

WITH src AS (

    SELECT
        emp_id,
        emp_name,
        department,
        salary,
        designation,
        manager_id,
        updated_dt,email as email_id
    FROM {{ source('employee_source', 'EMPLOYEE') }}

    {% if is_incremental() %}

    WHERE updated_dt > (
        SELECT COALESCE(
            MAX(updated_dt),
            '1999-12-31 10:00:00'
        )
        FROM {{ this }}
    )

    {% endif %}

    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY emp_id
        ORDER BY updated_dt DESC
    ) = 1

)

SELECT *,current_timestamp() as created_dt
FROM src