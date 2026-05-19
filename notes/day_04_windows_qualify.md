Today I learned that window functions let me calculate across related rows without collapsing the rows like `GROUP BY` does. 

RAW TABLE: order_items

product   category   sale_price
-------   --------   ----------
Hat       Accessories     20
Hat       Accessories     30
Shoes     Footwear       100
Shoes     Footwear       120
Boots     Footwear       150

SELECT
  category,
  SUM(sale_price) AS revenue
FROM order_items
GROUP BY category;

category      revenue
-----------   -------
Accessories      50
Footwear        370

Many rows became fewer rows.
One row per category.


SELECT
  product,
  category,
  sale_price,
  SUM(sale_price) OVER (
    PARTITION BY category
  ) AS category_revenue
FROM order_items;


product   category      sale_price   category_revenue
-------   -----------   ----------   ----------------
Hat       Accessories        20              50
Hat       Accessories        30              50
Shoes     Footwear          100             370
Shoes     Footwear          120             370
Boots     Footwear          150             370

Rows stayed the same.
SQL added an analytical value beside each row.

GROUP BY = collapse rows
WINDOW FUNCTION = keep rows + add analysis


Examples of window functions I practiced:
RANK() OVER (...)
LAG(...) OVER (...)
AVG(...) OVER (...)

The OVER(...) part defines the window/context for the calculation.

CTEs

I learned that CTEs are not just for making queries look cleaner.

CTEs are useful because they let me create the correct intermediate grain before doing the next step.

Before writing a CTE, I should ask:
What should one row represent after this step?

Today I learned that QUALIFY filters after a window function is calculated.
QUALIFY RANK() OVER (...) <= 3 
Create the rank in the background.
Then only keep rows where the rank is 1, 2, or 3.

ORDER BY inside OVER() = affects the window calculation
ORDER BY at the end = affects the displayed result

I learned that LAG() looks backward one row based on the order I give it.
LAG(revenue) OVER (
  ORDER BY order_month
)
Sort rows by month.
For each row, grab the previous row's revenue.
I usually cannot reuse prev_month immediately in the same SELECT.

Two options:

Repeat the full LAG(...) OVER (...) expression.
Use another CTE so prev_month becomes a real column.

ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
For a 3-month moving average, this means:
current month + previous 2 months
AVG(revenue) OVER (
  ORDER BY order_month
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)

Say the grain in English first.
Then write SQL. PRACTICE THIS!!!