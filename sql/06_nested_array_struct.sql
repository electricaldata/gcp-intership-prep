--Create a simple Array
-- Grain one row total. The column itself contains multiple values.

SELECT 
[1,2,3,4] AS numbers;

-- What is the row count? 
--3

-- what is inside the numbers column? 
--3 ints 

-- This is flat 

--UNNEST a simple array
SELECT
  numbers,
FROM UNNEST([1, 2, 3, 4]) AS individual_numbers;

--Grain is one row per number

--create an array of structs
--list of product objects

SELECT
  *
FROM UNNEST([
  STRUCT(101 AS product_id, 'pepper' AS product_name, 10 AS price),
  STRUCT(102 AS product_id, 'avocado' AS product_name, 20 AS price),
  STRUCT(102 AS product_id, 'banana' AS product_name, 3 AS price)
]);


-- Aggregate into an array.
SELECT
  order_id,
  ARRAY_AGG(product_id LIMIT 5) AS product_ids
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY oi.order_id
LIMIT 20;


--Make an order-level nested product list.
SELECT
  order_id,
  ARRAY_AGG(
    STRUCT(
      product_id,
      sale_price
    )
  ) AS items
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY order_id
LIMIT 10;

-- Most important query today ^^^

--add item count and total revenue
SELECT
  order_id,
  COUNT(*) AS item_count,
  ROUND(SUM(sale_price), 2) AS order_revenue,
  ARRAY_AGG(
    STRUCT(
      product_id,
      sale_price
    )
  ) AS items
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY order_id
LIMIT 20;


--UNNEST your nested results
WITH order_summary AS (
  SELECT
    order_id,
    ARRAY_AGG(
      STRUCT(
        product_id AS product_id,
        sale_price AS sale_price
      )
    ) AS items
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  GROUP BY order_id
)

SELECT
  order_summary.order_id,
  item.product_id AS product_id,
  item.sale_price AS sale_price
FROM order_summary
CROSS JOIN UNNEST(order_summary.items) AS item
LIMIT 50;


--nested products with product names
SELECT
  oi.order_id,
  ARRAY_AGG(
    STRUCT(
      oi.product_id AS product_id,
      p.name AS product_name,
      p.category AS category,
      oi.sale_price AS sale_price
    )
  ) AS items
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
GROUP BY oi.order_id
LIMIT 10;