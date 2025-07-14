-- macros/test_all_columns_non_null.sql
{% macro test_all_columns_non_null(model) %}

  {%- set columns = adapter.get_columns_in_relation(model) -%}
  {%- set column_names = columns | map(attribute='name') | list -%}

  {% if not column_names %}
    {{ exceptions.warn("Warning: No columns found for model " ~ model.name ~ ". Skipping non-null check.") }}
    select 1 where 1=0 -- Return an empty set to make the test pass trivially if no columns
  {% else %}
    select
      {% for column_name in column_names %}
        -- For better debugging, return the rows where a null is found
        case when {{ adapter.quote(column_name) }} is null then '{{ column_name }}' else null end
        {% if not loop.last %}, {% endif %}
      {% endfor %}
    from {{ model }}
    where
      {% for column_name in column_names %}
        {{ adapter.quote(column_name) }} is null
        {% if not loop.last %} or {% endif %}
      {% endfor %}
  {% endif %}

{% endmacro %}