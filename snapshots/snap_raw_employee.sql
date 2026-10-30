{% snapshot snap_raw_employee %}

{{
    config(
        unique_key='EMPID',
        strategy='timestamp',
        updated_at='CREATED_DATE'
      
    )
}}

--  dbt_valid_to_current= "to_date('9999-12-31')"
-- hard_deletes='ignore/invalidate/new_record'  & invalidate_hard_deletes=true

select
    EMPID,
    ENAME,
    ADDRESS,
    CITY,
    STATE,
    COUNTRY,
    CREATED_DATE
from {{ source('raw_data', 'raw_employee') }}

{% endsnapshot %}