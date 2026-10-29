{{ config(
    materialized='incremental',
    incremental_strategy='append'
) }}

with source_data as (
    select
        event_id,
        user_id,
        event_name,
        event_timestamp,
        current_timestamp::timestamp_ntz as insert_timestamp
    from {{ source('raw_data', 'src_events') }}

   {% if is_incremental() %}
        -- Only insert events newer than the highest existing timestamp
      where event_timestamp > (select coalesce(max(event_timestamp), '1970-01-01'::timestamp_ntz) from {{ this }})
    {% endif %}
)

select *
from source_data