`bigquery-public-data.thelook_ecommerce.orders`
`bigquery-public-data.thelook_ecommerce.order_items`


-- Day 2: Joins and CTEs
-- File: sql/02_joins_ctes.sql


-- Problem 1
-- Join orders to order items

SELECT *

FROM `bigquery-public-data.thelook_ecommerce.orders` as orders
JOIN `bigquery-public-data.thelook_ecommerce.order_items` as items
  ON orders.order_id = items.order_id
LIMIT 50;


-- Problem 2
-- Find total revenue by order status

SELECT status, SUM(sale_price) as revenue

FROM `bigquery-public-data.thelook_ecommerce.orders`as o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` as oi
  ON o.order_id = oi.order_id
GROUP BY status
ORDER BY revenue DESC;


-- Problem 3
-- Use a CTE to calculate user-level order counts
WITH user_orders AS (

  SELECT user_id, COUNT(*) AS order_count

  FROM `bigquery-public-data.thelook_ecommerce.orders`

  GROUP BY user_id

)

SELECT user_id, order_count

FROM user_orders

ORDER BY order_count DESC

LIMIT 20;


-- Problem 4
-- Join products and calculate revenue by category

SELECT category, SUM(sale_price) as revenue

FROM `bigquery-public-data.thelook_ecommerce.order_items` as oi
JOIN `bigquery-public-data.thelook_ecommerce.products` as p
  ON oi.product_id = p.id
GROUP BY category
ORDER BY revenue DESC;


-- Business question:
-- Which product categories generate the most revenue?
WITH product_category AS (
  SELECT category, sale_price 
  FROM `bigquery-public-data.thelook_ecommerce.products` as p
  JOIN `bigquery-public-data.thelook_ecommerce.order_items` as oi
  ON p.id = oi.product_id
  GROUP BY category
)

SELECT category, SUM(sale_price) AS revenue
FROM product_category
GROUP BY category
ORDER BY revenue DESC;
