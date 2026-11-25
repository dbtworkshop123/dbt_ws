{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

with source_data as (
    select
       id order_id,
       USER_ID cust_id,
       ORDER_DATE::date ORDER_DATE,
       upper(STATUS) order_status
    from {{ source('raw_data', 'RAW_ORDERS') }}

    {% if is_incremental() %}
        -- Only process rows updated since the last run
       where ORDER_DATE > (select coalesce(max(ORDER_DATE), '1970-01-01'::timestamp_ntz) from {{ this }})
   {% endif %}
)

select *
from source_data