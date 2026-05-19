`bigquery-public-data.thelook_ecommerce.order_items`
`bigquery-public-data.thelook_ecommerce.products`


-- Rank products by revenue inside each category.

WITH products AS (
  SELECT
    p.name AS product_name,
    SUM(oi.sale_price) AS revenue,
    p.category
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  GROUP BY p.category, product_name
)

SELECT
  revenue,
  category,
  product_name,
  RANK() OVER (
    PARTITION BY category
    ORDER BY revenue DESC
  ) AS revenue_rank
FROM products
ORDER BY category, renevue_rank;



--Get the top 3 products per category.

WITH products AS (
  SELECT
    p.name AS product_name,
    SUM(oi.sale_price) AS revenue,
    p.category
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  GROUP BY p.category, product_name
)

SELECT
  category,
  revenue,
  product_name
FROM products
QUALIFY RANK() OVER (
  PARTITION BY category
  ORDER BY revenue DESC
) <= 3
ORDER BY category, revenue DESC;


-- Calculate monthly revenue and previous month revenue.
WITH monthly_revenue AS (
  SELECT
    SUM(sale_price) AS revenue,
    DATE_TRUNC(DATE(created_at), MONTH) as monthly_sales
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  GROUP BY monthly_sales
),

monthly_with_prev AS (
    SELECT
        revenue,
        monthly_sales,
        LAG(revenue) OVER (
            ORDER BY monthly_sales
        ) AS prev_month,
    FROM monthly_revenue
)
SELECT revenue, monthly_sales, prev_month, (reveneu - prev_month) AS month_change
FROM monthly_with_prev
ORDER BY monthly_sales;


-- Calculate 3-month moving average revenue.

WITH monthly_sales AS (
  SELECT
    SUM(sale_price) AS revenue,
    DATE_TRUNC(DATE(created_at), MONTH) AS order_month
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  GROUP BY monthly_sales
)

SELECT
  revenue,
  order_month,
  AVG(revenue) OVER (
    ORDER BY monthly_sales
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ) AS running_avg
FROM monthly_sales
ORDER BY monthly_sales;