{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}


select
    previous.id,
    previous.numeric_value / 123 as slowly_transformed,
    UPPER(previous.varchar_value) as modified_str,
    previous.added_at
from {{ ref('inc__incremental_data') }} as previous

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where previous.added_at > (select max(this.added_at) from {{ this }} as this) 
{% endif %}