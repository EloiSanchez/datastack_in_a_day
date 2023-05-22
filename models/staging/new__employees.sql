{{
    config(
        post_hook=[
                "{{ dbt_snow_mask.create_masking_policy('models') }}",
                "{{ dbt_snow_mask.apply_masking_policy('models') }}"
            ]
    )
}}

select
    id,
    date1 as start_date,
    date2 as end_date,
    team
from {{ source('employee_data', 'employees') }}