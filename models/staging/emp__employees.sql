{{
    config(
        post_hook='alter view {{ this }} add row access policy production.security_policies.employees_policy on (team)'
    )
}}

select
    id,
    date1 as start_date,
    date2 as end_date,
    team
from {{ source('employee_data', 'employees') }}