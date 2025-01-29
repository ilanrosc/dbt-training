select 
CUSTOMERID
, SEGMENT
, COUNTRY
, sum(ORDER_PROFIT) as PROFIT
from {{ ref('stg_orders') }}
group by 1,2,3