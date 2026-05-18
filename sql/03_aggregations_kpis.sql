-- ============================================================
-- Day 3: Aggregations and KPIs
-- ============================================================

`bigquery-public-data.thelook_ecommerce.order_items`
`bigquery-public-data.thelook_ecommerce.products`

-- ============================================================
-- Problem 1:
-- Daily revenue
-- ============================================================

SELECT SUM(sale_price) as revenue, DATE(created_at) as order_date

FROM `bigquery-public-data.thelook_ecommerce.order_items`

GROUP BY order_date

ORDER BY order_date;


-- ============================================================
-- Problem 2:
-- Average order value
-- ============================================================

WITH orders AS (

  SELECT order_id, SUM(sale_price) AS order_total
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  GROUP BY order_id
)

SELECT AVG(order_total) as AOV
FROM orders;


-- ============================================================
-- Problem 3:
-- Revenue, orders, and AOV by month
-- ============================================================

WITH orders

AS (

  SELECT
  order_id, 
  SUM(sale_price) AS order_total,
  DATE_TRUNC(DATE(created_at), MONTH) as order_month

  FROM `bigquery-public-data.thelook_ecommerce.order_items`

  GROUP BY order_id, order_month

)

SELECT order_month, 
SUM(order_total) AS revenue, 
AVG(order_total) AS AOV, 
COUNT(order_id) AS orders

FROM orders

GROUP BY order_month

ORDER BY order_month
;


-- ============================================================
-- Problem 4:
-- Categories with at least 1,000 order items
-- ============================================================

SELECT p.category, COUNT(oi.id) AS items

FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi

JOIN `bigquery-public-data.thelook_ecommerce.products` AS p

ON oi.product_id = p.id

GROUP BY p.category

HAVING items >= 1000

ORDER BY items DESC;


-- ============================================================
-- Extra KPI 1:
-- Total revenue
-- ============================================================

SELECT SUM(sale_price) as revenue

FROM `bigquery-public-data.thelook_ecommerce.order_items`
;


-- ============================================================
-- Extra KPI 2:
-- Top product categories
-- ============================================================

SELECT p.category, SUM(oi.sale_price) AS revenue

FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi 

JOIN `bigquery-public-data.thelook_ecommerce.products` AS p

ON p.id = oi.product_id

GROUP BY p.category

ORDER BY revenue DESC
;