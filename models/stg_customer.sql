{{ 
    config(materialized='table') 
    }}

select 
ID cust_id,
concat_ws(' ', FIRST_NAME, LAST_NAME) cust_name,
ADDRESS,
STATE,
ZIP,
COUNTRY,
upper(EMAIL) email,
PHONE,
current_timestamp::timestamp_ntz as insert_timestamp
from 
{{source('raw_data','RAW_CUSTOMERS')}}