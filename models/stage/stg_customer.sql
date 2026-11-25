{{ 
    config(
        materialized='view',
        pre_hook="create or replace table RAW_TRAN.stage.test(id number)"
    ) 
}}

select 
    ID as cust_id,
    concat_ws(' ', FIRST_NAME, LAST_NAME) as cust_name,
    ADDRESS,
    STATE,
    ZIP,
    COUNTRY,
    upper(EMAIL) as email,
    PHONE,
    current_timestamp::timestamp_ntz as insert_timestamp
from {{ source('raw_data', 'RAW_CUSTOMERS') }}