{% snapshot snap_raw_employee_check %}

{{
    config(
        unique_key='EMPID',
        strategy='check',
        check_cols='all'
    )
}}
-- check_cols=['ENAME', 'ADDRESS', 'CITY', 'STATE', 'COUNTRY'],
select
    EMPID,
    ENAME,
    ADDRESS,
    CITY,
    STATE,
    COUNTRY
from {{ source('raw_data', 'raw_employee') }}

{% endsnapshot %}