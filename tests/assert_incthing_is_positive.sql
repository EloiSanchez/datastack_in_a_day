{{
    config(
        store_failures = true
    )
}}

select
    *
from {{ ref('inc__incremental_model') }}
where slowly_transformed <= 0