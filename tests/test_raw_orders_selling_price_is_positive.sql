select ORDERID
, sum(ORDERSELLINGPRICE) as total_sp
from {{ ref('raw_orders') }}
group by 1
having total_sp < 0