select
    c_custkey as custkey,
    c_mktsegment as mktsegment,
    c_name as name,
    c_acctbal as acctbal,
    c_address as address,
    c_nationkey as nationkey,
    c_phone as phone,
    c_comment as comment
from {{ source('customer_data', 'customer') }}