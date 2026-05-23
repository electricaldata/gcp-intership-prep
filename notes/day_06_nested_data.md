# Day 6: ARRAY, STRUCT, and UNNEST

## Today I learned

ARRAY means:

STRUCT means:

ARRAY_AGG means:

UNNEST means:

## Main mental model

ARRAY_AGG turns rows into lists.

UNNEST turns lists into rows.

STRUCT lets me bundle multiple fields into one object.

## Grain reminders

Problem 4 grain:

Problem 5 grain:

Problem 7 grain:

## Mistakes / Roadblocks

1.

2.

3.

## How this connects to internship

Nested data matters because real cloud data can contain repeated records, events, line items, claim lines, or JSON-like structures.

## One sentence explanation

Relational tables are flat, but BigQuery can store repeated nested fields with arrays and structs; UNNEST flattens those repeated fields into rows.


ARRAY is a list.
STRUCT is an object/record.
ARRAY_AGG collects many rows into one list.
UNNEST explodes a list back into rows.
The most important thing is knowing the grain before and after the query.

My biggest Day 6 lesson:

ARRAY_AGG does not magically know what list I want.
The GROUP BY decides the final grain.

If I GROUP BY order_id, I get one row per order.
If I GROUP BY product_id, I get one row per product.
If I GROUP BY user_id, I get one row per user.

ARRAY_AGG then collects the lower-level rows inside that chosen group.
Before GROUP BY, ask:
“What do I want one row to be at the end?”



1.
numbers
----------------
[1, 2, 3, 4]

2. 
number
------
1
2
3
4

3. 
product_id | product_name | price
-----------|--------------|-------
1          | shirt        | 25.99
2          | shoes        | 89.99
3          | hat          | 19.99

4. 
order_id | product_ids
---------|--------------------
1001     | [25, 48, 91]
1002     | [13]
1003     | [44, 87, 102, 55]

5. 
order_id | items
---------|-----------------------------------------------------
1001     | [{product_id: 25, sale_price: 19.99},
         |  {product_id: 48, sale_price: 34.50}]

1002     | [{product_id: 13, sale_price: 59.99}]

6. 
order_id | item_count | order_revenue | items
---------|------------|---------------|-----------------------------------------
1001     | 2          | 54.49         | [{product_id: 25, sale_price: 19.99},
         |            |               |  {product_id: 48, sale_price: 34.50}]

1002     | 1          | 59.99         | [{product_id: 13, sale_price: 59.99}]

7.
-- before unnest
order_id | items
---------|--------------------------------------------------
1001     | [{product_id: 25, sale_price: 19.99},
         |  {product_id: 48, sale_price: 34.50}]

-- after unnest
order_id | product_id | sale_price
---------|------------|-----------
1001     | 25         | 19.99
1001     | 48         | 34.50
1002     | 13         | 59.99

8. 
order_id | items
---------|----------------------------------------------------------
1001     | [{product_id: 25,
         |   product_name: "Slim Fit Jeans",
         |   category: "Jeans",
         |   sale_price: 49.99},
         |
         |  {product_id: 48,
         |   product_name: "Cotton T-Shirt",
         |   category: "Tops",
         |   sale_price: 19.99}]

1002     | [{product_id: 13,
         |   product_name: "Running Shoes",
         |   category: "Shoes",
         |   sale_price: 89.99}]

If I GROUP BY order_id, I get one row per order.
If I GROUP BY product_id, I get one row per product.
ARRAY_AGG collects the lower-level rows inside that group.