{% snapshot ord__orders_ts_snapshot %}

    {{
        config(
          target_schema='snapshots',
          strategy='timestamp',
          unique_key='id',
          updated_at='updated_at',
        )
    }}

    select * from {{ source('order_data', 'orders_timestamp') }}

{% endsnapshot %}