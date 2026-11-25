{{ config(
    materialized='view',
    schema='curated'
) }}

select
c.cust_id,
c.cust_name,
c.COUNTRY,
o.order_id,
ORDER_DATE,
order_status,
p.PAYMENT_METHOD,
p.AMOUNT,
{{add_audit_columns()}}

from {{ref('stg_orders')}} o 
join {{ref("customer")}} c on o.cust_id=c.cust_id
join {{ref("stg_payment")}} p on o.order_id=p.order_id
