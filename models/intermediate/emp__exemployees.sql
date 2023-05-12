with 

not_indefinite_employees as (
    select * from {{ ref("emp__not_indefinite") }}
    )

select 
    *
from not_indefinite_employees
where end_date <= current_date()
