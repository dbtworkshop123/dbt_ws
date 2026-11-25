{{ 
    config(materialized='view',
    schema='curated') 
}}


select a.* ,
{{add_audit_columns()}}
from
 {{ref('stg_customer')}}  a
 left join {{ref("country")}} b on a.COUNTRY=b.country_name