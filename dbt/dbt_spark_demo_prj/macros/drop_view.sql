
/*drop table to validate new table created by dbt run*/
{% macro drop_view(view_name) %}
    {% set sql %}
        DROP VIEW IF EXISTS {{ view_name }}
    {% endset %}
    {{ run_query(sql) }}
{% endmacro %}