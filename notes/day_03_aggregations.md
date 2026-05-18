Today I practiced using SQL aggregations to turn raw ecommerce rows into business KPIs like daily revenue, average order value, monthly revenue, monthly orders, and top product categories.



- `SUM()` adds values across rows.
- `AVG()` averages values across rows.
- `COUNT(*)` counts rows.
- `COUNT(DISTINCT column)` counts unique values.
- `GROUP BY` controls the level of detail in the output.
- `HAVING` filters after aggregation.
- `ORDER BY ... DESC` sorts highest to lowest.
- `DATE(created_at)` converts a timestamp into a date.
- `DATE_TRUNC(DATE(created_at), MONTH)` groups dates into month buckets.

Grain means:

> What does one row in the output represent?


Examples:

- Daily revenue: one row = one day.
- AOV(average order value) CTE: one row = one order.
- Monthly KPIs: one row = one month.
- Category revenue: one row = one category.

I kept getting stuck when I mixed different grains together, like selecting `product_id` while grouping only by `category`, or selecting `order_id` when the final output was supposed to be monthly.


DATE_TRUNC(DATE(created_at), MONTH)
Take the timestamp, convert it to a date, then bucket it by month.