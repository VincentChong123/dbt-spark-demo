/*drop database to validate new database created by dbt run*/
{% macro drop_database(database_name) %}
    {% set sql %}
        DROP DATABASE IF EXISTS {{ database_name }} CASCADE;
    {% endset %}
    {{ run_query(sql) }}
{% endmacro %}`