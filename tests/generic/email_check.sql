{% test email_check(model, column_name) %}

SELECT *
FROM {{ model }}
WHERE  {{ column_name }} is null
OR NOT (
       {{ column_name }} RLIKE '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
   )

{% endtest %}