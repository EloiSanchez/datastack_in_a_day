{{
    config(
        post_hook='alter view {{ this }} add row access policy production.security_policies.employees_policy on (team)'
    )
}}

with

-- imports
exemployees as (
    select * from {{ ref('emp__exemployees') }}
),

employee_info as (
    select * from {{ ref('emp__employee_info') }}
),

-- operations
exemployees_days_on_contract as (
    select
        exemployees.id,
        exemployees.team,
        employee_info.first_name,
        employee_info.last_name,
        exemployees.end_date - exemployees.start_date as service_days
    from exemployees
    left join employee_info
        on exemployees.id = employee_info.id
)

-- final
select * from exemployees_days_on_contract