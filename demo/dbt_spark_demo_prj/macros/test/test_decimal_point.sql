{% test decimal_point(model, column_name) %}

    SELECT *
    FROM {{ model }}
    WHERE NOT REGEXP(LTRIM(RTRIM(CAST({{ column_name }} AS STRING))), '^\\d+\\.\\d{2}$')

    {% if execute and flags.WHICH == 'test' %}
        {{ log_test_failures(this.identifier) }}
    {% endif %}

{% endtest %}
