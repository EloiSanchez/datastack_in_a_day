{% snapshot ord__orders_check_snapshot %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='id',
          check_cols=['status'],
        )
    }}

    select * from {{ source('order_data', 'orders_check') }}

{% endsnapshot %}