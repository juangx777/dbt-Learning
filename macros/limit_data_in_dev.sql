{% macro limit_data_in_dev(column_name) %}
    {% if target.name == 'dev' %}
        WHERE {{ column_name }} >= DATEADD(DAY, -3, CURRENT_TIMESTAMP)
    {% endif %}
{% endmacro %}