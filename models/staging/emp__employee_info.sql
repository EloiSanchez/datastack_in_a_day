select
    id,
    first_name,
    last_name
from {{ source('employee_data', 'employee_info') }}