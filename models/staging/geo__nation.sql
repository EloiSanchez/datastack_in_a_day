select
    n_nationkey as nationkey,
    n_regionkey as regionkey,
    n_name as name,
    n_comment as comment
from {{ source('geo_data', 'nation') }}
-- final test for CI