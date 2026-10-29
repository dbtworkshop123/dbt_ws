{{ 
    config(materialized='view') 
}}
select
    STATUS,
    {{ add_audit_columns() }},
    {{ pivot_status_counts('STATUS', ['completed', 'returned', 'return_pending','shipped','placed']) }}
from  {{ source('raw_data', 'RAW_ORDERS') }} 
group by all