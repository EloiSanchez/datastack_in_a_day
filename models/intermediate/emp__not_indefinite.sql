{{
    config(
        post_hook='alter view {{ this }} add row access policy production.security_policies.employees_policy on (team)'
    )
}}

select * from {{ ref('emp__employees') }}
where end_date != '9999-12-30'

-- comment to test ci hehe