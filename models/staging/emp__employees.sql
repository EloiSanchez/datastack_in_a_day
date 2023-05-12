select
    id,
    date1 as start_date,
    date2 as end_date,
    team
from {{ source('employee_data', 'employees') }}