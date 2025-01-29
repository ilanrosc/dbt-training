select
-- from raw orders
	  o.ORDERID
	, o.ORDERDATE
	, o.SHIPDATE
	, o.SHIPMODE
    , o.ORDERSELLINGPRICE - o.ORDERCOSTPRICE as ORDER_PROFIT
    , o.ORDERCOSTPRICE
    , o.ORDERSELLINGPRICE
    , o.PRODUCTID
    , o.CUSTOMERID
-- from raw customers
    , c.CUSTOMERNAME
    , c.SEGMENT
    , c.COUNTRY
-- from raw product
    , p.CATEGORY
    , p.PRODUCTNAME
    , p.SUBCATEGORY
FROM {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c on o.CUSTOMERID = c.CUSTOMERID
left join {{ ref('raw_product') }} as p on o.PRODUCTID = p.PRODUCTID
