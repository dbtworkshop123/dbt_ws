{{ config(
    materialized='view',
    schema='curated'
) }}

select
* from {{ref('snap_raw_employee')}}