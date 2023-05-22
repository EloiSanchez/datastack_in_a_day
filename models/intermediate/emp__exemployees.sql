{{
    config(
        post_hook=[
                "{{ create_rla_employees(model.database, model.schema) }}",
                "alter view {{ this }} add row access policy {{ model.database }}.{{ model.schema }}.rla_employees on (team)"
            ]
    )
}}

with 

not_indefinite_employees as (
    select * from {{ ref("emp__not_indefinite") }}
    )

select 
    *
from not_indefinite_employees
where end_date <= current_date()
