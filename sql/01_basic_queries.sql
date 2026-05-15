
-- Problem 1
-- Get 10 rows from the orders table

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 10;


-- Problem 2
-- Count total orders

SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.orders`;


-- Problem 3
-- Count unique users

SELECT COUNT(DISTINCT user_id)
FROM `bigquery-public-data.thelook_ecommerce.orders`;


-- Problem 4
-- Show order counts by status

SELECT status, COUNt(*) as count_order
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
ORDER BY count_order DESC;


-- Problem 5
-- Find the 20 most recent orders

SELECT user_id, order_id, status, created_at
FROM `bigquery-public-data.thelook_ecommerce.orders`
ORDER BY created_at DESC
LIMIT 20;


