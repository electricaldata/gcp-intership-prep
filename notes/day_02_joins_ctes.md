What is a CTE? 
Common table expression

Mental model 

WITH something AS (

    temporary query

) 

SELECT * 
FROM something

CTE basically say to create a temp table then use it below it.
CTE allows to manage giant SQL querries. CTEs allow us to break problems into steps, name temporary results, and organize logic cleanly.

If a CTE does not output a column,
later queries cannot access it.


What problem does a JOIN solve?
You can access data from other tables and combine only on specific columns that you want. 

Why do normalized databases use multiple tables instead of one giant table?
Easier to manage, extract and inject data. It's cleaner and explanable. 

Why must GROUP BY be used with COUNT/SUM/AVG?
Because SQL needs to know what group by what.

Why are aliases useful?
Im not sure what this question is asking. 

What is the difference between:
order_items.id
vs
order_items.product_id ?

One is the product_id and not unique in the table and the other is order number which is unique in the table. 

