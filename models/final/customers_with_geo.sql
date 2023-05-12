{{ config(schema='customers') }}

with 


-- imports
customers as (
    select * from {{ ref('cust__customers') }}
),

regions as (
    select * from {{ ref('geo__region') }}
),

nations as (
    select * from {{ ref('geo__nation') }}
),

-- operations
customers_with_geo as (
    select
        regions.name as region,
        nations.name as nation,
        customers.* EXCLUDE nationkey
    from customers
    left join nations
        on nations.nationkey = customers.nationkey
    left join regions
        on nations.regionkey = regions.regionkey
)

-- final
select * from customers_with_geo