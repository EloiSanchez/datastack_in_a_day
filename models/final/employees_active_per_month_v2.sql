with

-- filtered imports
employees as (
    select 
        id,
        LAST_DAY(start_date) as start_date,
        case
            when end_date = '9999-12-30' then date('2023-12-31', 'YYYY-MM-DD')
            else LAST_DAY(end_date)
        end as end_date
    from {{ ref('emp__employees') }}
),

r_employees
    (id, start_date, end_date, count_date)
    AS (
        SELECT id, start_date, end_date, start_date
        FROM employees

        UNION ALL

        SELECT
            employees.id, 
            employees.start_date, 
            employees.end_date,
            dateadd(month, 1, r_employees.count_date)
        FROM r_employees
        LEFT JOIN employees
            ON 1 = 1
                AND employees.id = r_employees.id
                where dateadd(month, 1, count_date) <= employees.end_date
    )

select 
    year(count_date) as year,
    month(count_date) as month,
    count(*) as active_employees
from r_employees group by year, month