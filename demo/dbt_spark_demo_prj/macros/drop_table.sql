/*drop table to validate new table created by dbt run*/
{% macro drop_table(table_name) %}
    {% set sql %}
        DROP TABLE IF EXISTS {{ table_name }}
    {% endset %}
    {{ run_query(sql) }}
{% endmacro %}`