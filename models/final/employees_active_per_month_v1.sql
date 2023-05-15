with

-- filtered imports
employees as (
    select 
        LAST_DAY(start_date) as start_date,
        case
            when end_date = '9999-12-30' then date('2023-12-31', 'YYYY-MM-DD')
            else LAST_DAY(end_date)
        end as end_date
    from {{ ref('emp__employees') }}
),

dates as (
    select
        year, 
        month, 
        min(date_day) as first_day, 
        max(date_day) as last_day 
    from {{ ref('date__datedim') }} 
    group by year, month
),

date_check as (
    select
        year,
        month,
        case
            when 
                dates.first_day between employees.start_date and employees.end_date 
                    or
                dates.last_day between employees.start_date and employees.end_date
            then 1
            else 0
        end as active
    from employees
    cross join dates
)

select
    year,
    month,
    sum(active
    ) as active_employees
from date_check
group by year, month