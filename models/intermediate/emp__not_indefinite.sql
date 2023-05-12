    select * from {{ ref('emp__employees') }}
    where end_date != '9999-12-30'