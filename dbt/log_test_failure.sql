-- macros/log_test_failures.sql
{% macro log_test_failures(test_name) %}
  {% set relation = api.Relation.create(
    database=target.database,
    schema='dbt_test_failures',
    identifier=test_name
  ) %}
  
  {% set query %}
    SELECT id, amount 
    FROM {{ relation }}
  {% endset %}
  
  {% set results = run_query(query) %}
  {% if results and results.rows %}
    {% do log("FAILED RECORDS:", info=true) %}
    {% for row in results.rows %}
      {% do log("ID: " ~ row[0] ~ " | Amount: " ~ row[1], info=true) %}
    {% endfor %}
  {% endif %}
{% endmacro %}