{{ config(
    materialized='table'
) }}

with source_data as (
    select
       id PAYMENTS_id,
       order_id,
       upper(PAYMENT_METHOD) PAYMENT_METHOD,
       AMOUNT
    from {{ source('raw_data', 'RAW_PAYMENTS') }}
    
)

select *
from source_data