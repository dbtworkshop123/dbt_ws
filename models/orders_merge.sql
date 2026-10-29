{{ config(
    materialized='incremental',
    unique_key='pit_ky',
    incremental_strategy='merge'
) }}

with source_data as (
    select
        order_id||trx_dt as pit_ky,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        current_timestamp::timestamp_ntz as insert_timestamp
    from {{ source('raw_data', 'src_orders') }}

    {% if is_incremental() %}
        -- Only process rows updated since the last run
       where updated_at > (select coalesce(max(updated_at), '1970-01-01'::timestamp_ntz) from {{ this }})
   {% endif %}
)

select *
from source_data