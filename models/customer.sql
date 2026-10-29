{{ 
    config(materialized='view') 
    }}


select * from
 {{ref('stg_customer')}}  a
 left join {{ref("country")}} b on a.COUNTRY=b.country_name
''