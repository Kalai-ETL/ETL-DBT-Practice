{% test no_empty_string(model, column_name) %}

SELECT *
FROM {{ model }}
WHERE COALESCE(TRIM({{ column_name }}),'') = ''
OR {{ column_name }} is null

{% endtest %}