
{% test assert_positive_column(model, column_name) %}

    select
        *
    from {{ model }}
    where {{ column_name }} <= 0

{% endtest %}