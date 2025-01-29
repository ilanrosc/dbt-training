select
-- from raw orders
    {{ dbt_utils.generate_surrogate_key(['o.ORDERID', 'o.CUSTOMERID', 'o.PRODUCTID']) }} as sk_orders
	, o.ORDERID
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
    ,{{ markup('ORDERSELLINGPRICE', 'ORDERCOSTPRICE') }} as markup
    , d.delivery_team
FROM {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c on o.CUSTOMERID = c.CUSTOMERID
left join {{ ref('raw_product') }} as p on o.PRODUCTID = p.PRODUCTID
left join {{ ref('delivery_team') }} as d on o.SHIPMODE = d.shipmode

-- {{limit_data_in_dev('o.ORDERDATE')}}