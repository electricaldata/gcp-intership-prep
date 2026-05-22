Modeling Table:

-The first question should always be what is one row? 
For the example we have been working on is one time, thus each row should describe one purchased item.

-Second, what are we trying to predict? 
For this example we are trying to answer was this item returned? 

-Create a 1 0 binary outcome label to label whether an item was returned

-Then ask what information could help predict that? 
price, shipped_at - created_at difference, popularity(calculate how many products for each product and discover high and low traffick products, maybe people return it because its a bad product), time such as weekday and monthly.

Simple Day 5 features = columns already on the row
Advanced features = features that require another aggregation/CTE


Previous problems:
"Aggregate rows to answer a business question."

Problem 5:
"Keep rows and add useful columns for a model."


DATE_DIFF = creates duration feature
DATE_DIFF(end_date, start_date, unit)

EXTRACT = creates calendar feature
EXTRACT(MONTH FROM DATE(oi.created_at)) AS order_month
EXTRACT(DAYOFWEEK FROM DATE(oi.created_at)) AS order_day_of_week

CASE = creates label/category feature

DATE_TRUNC = bucket dates for summaries
DATE_TRUNC(DATE(created_at), MONTH)



## Main idea

Today was the first day where SQL started shifting from dashboard/business questions into modeling prep.

Previous SQL questions were mostly:

> Aggregate rows to answer a business question.

Today’s big shift was:

> Build one row per example that a model can learn from.

For the training feature table:

> one row = one purchased order item

That means I should not use `GROUP BY` unless I am intentionally creating an aggregated feature.

---

## Key intuition: training feature table

A training feature table is the table a machine learning model would train on.

It needs three types of columns:

### 1. IDs / tracking columns

These identify the row but are usually not the main learning signal.

Examples:

```sql
oi.id AS order_item_id
oi.order_id
oi.product_id


Today I learned that a modeling query is different from a KPI query.

A KPI query summarizes data.

A training feature query keeps individual examples and adds useful columns so a model can learn patterns.

Big takeaway: Day 5 was the first real **feature engineering mindset** day. You didn’t just practice date functions — you started learning how raw SQL becomes ML-ready data.