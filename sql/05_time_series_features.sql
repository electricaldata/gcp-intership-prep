-- Problem 1: Orders by weekday
SELECT
  EXTRACT(DAYOFWEEK FROM DATE(created_at)) as weekly_orders,
  COUNT(created_at) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY weekly_orders
ORDER BY weekly_orders;

-- Problem 2: Monthly orders and revenue

SELECT
  DATE_TRUNC(DATE(created_at), MONTH) AS months,
  SUM(sale_price) AS revenue,
  COUNT(DISTINCT order_id) AS monthly_orders
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY months
ORDER BY monthly_orders;


-- Problem 3: Return label

SELECT
  order_id,
  id AS order_item_id,
  product_id,
  sale_price,
  CASE
    WHEN returned_at IS NOT NULL THEN 1
    ELSE 0
  END AS was_returned
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 10;


-- Problem 4: Days to ship

SELECT
  product_id,
  order_id,
  created_at,
  shipped_at,
  DATE_DIFF(DATE(shipped_at), DATE(created_at), DAY) AS days_to_ship,
  CASE
    WHEN returned_at IS NOT NULL THEN 1
    ELSE 0
  END AS was_returned
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE shipped_at IS NOT NULL
LIMIT 100;



-- Problem 5: Training feature table

-- Goal: Build a SQL table that could be used to train a model to predict whether an order item gets returned.

-- Your output should keep the data at the order-item level:

-- one row = one purchased item

SELECT
  p.category,
  p.cost,
  oi.order_id,
  p.department,
  oi.product_id,
  oi.id AS order_item_id,
  oi.sale_price,
  p.retail_price,
  DATE_DIFF(DATE(oi.shipped_at), DATE(oi.created_at)) AS shipped_days,
  EXTRACT(MONTH FROM DATE(oi.created_at)) AS order_month,
  EXTRACT(DAYOFWEEK FROM DATE(oi.created_at)) AS order_day,

  CASE
    WHEN oi.returned_at IS NOT NULL THEN 1
    ELSE 0
  END AS returned_labels

FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id

WHERE oi.created_at IS NOT NULL,
  AND oi.shipped_at IS NOT NULL,
  AND oi.sale_price IS NOT NULL
  AND p.cost IS NOT NULL,
  AND p.retail_price

LIMIT 10;