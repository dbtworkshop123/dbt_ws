select *
from {{ ref('stg_payment') }}
where AMOUNT <= 0