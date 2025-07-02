/*drop table to validate new table created by dbt run*/
{% macro show_table() %}
    {% set sql %}
        SHOW TABLES
    {% endset %}

    {% set results = run_query(sql) %}
    {% for row in results.rows %}
        {{ log("TABLE: " ~ row, info=True) }}
    {% endfor %}
    -- TODO: log no table found
{% endmacro %}