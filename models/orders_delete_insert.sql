{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='delete+insert'
) }}

with source_data as (
    select
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        current_timestamp::timestamp_ntz as insert_timestamp
    from {{ source('raw_data', 'src_orders') }}

   {% if is_incremental() %}
        -- Only pull new/changed records
      where updated_at > (select coalesce(max(updated_at), '1970-01-01'::timestamp_ntz) from {{ this }})
    {% endif %}
)

select *
from source_data