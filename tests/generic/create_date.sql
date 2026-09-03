{% test create_date(model, column_name) %}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} is null
AND {{ column_name }} <=  updated_dt

{% endtest %}