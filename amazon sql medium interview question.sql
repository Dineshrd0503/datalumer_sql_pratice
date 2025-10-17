/*
---------------------------------------------------------
 Problem Statement:
---------------------------------------------------------
Given a table `product_spend` containing data about Amazon 
customers and their spending on products in different categories, 
write a query to identify the top two highest-grossing products 
within each category for the year 2022.

Output should include:
  - category
  - product
  - total_spend (sum of all spends for that product in 2022)
---------------------------------------------------------
 Schema:
---------------------------------------------------------
product_spend (
  category           VARCHAR(100),
  product            VARCHAR(100),
  user_id            INT,
  spend              DECIMAL(10,2),
  transaction_date   TIMESTAMP
);

---------------------------------------------------------
 Example Input:
---------------------------------------------------------
category      | product           | user_id | spend  | transaction_date
--------------|------------------ |---------|--------|--------------------
appliance     | refrigerator      | 165     | 246.00 | 2021-12-26 12:00:00
appliance     | refrigerator      | 123     | 299.99 | 2022-03-02 12:00:00
appliance     | washing machine   | 123     | 219.80 | 2022-03-02 12:00:00
electronics   | vacuum            | 178     | 152.00 | 2022-04-05 12:00:00
electronics   | wireless headset  | 156     | 249.90 | 2022-07-08 12:00:00
electronics   | vacuum            | 145     | 189.00 | 2022-07-15 12:00:00

---------------------------------------------------------
 Expected Output:
---------------------------------------------------------
category      | product           | total_spend
--------------|------------------ |-------------
appliance     | refrigerator      | 299.99
appliance     | washing machine   | 219.80
electronics   | vacuum            | 341.00
electronics   | wireless headset  | 249.90

---------------------------------------------------------
 SQL Solution:
---------------------------------------------------------
*/

-- Step 1: Aggregate total spend per (category, product)
WITH total_spend AS (
  SELECT
    category,
    product,
    SUM(spend) AS total_spend
  FROM product_spend
  WHERE YEAR(transaction_date) = 2022
  GROUP BY category, product
),

-- Step 2: Rank products within each category by total_spend
ranked_products AS (
  SELECT
    category,
    product,
    total_spend,
    ROW_NUMBER() OVER(
      PARTITION BY category
      ORDER BY total_spend DESC
    ) AS rn
  FROM total_spend
)

-- Step 3: Pick only the top 2 per category
SELECT
  category,
  product,
  total_spend
FROM ranked_products
WHERE rn <= 2
ORDER BY category, total_spend DESC;

/*
---------------------------------------------------------
 Output Preview:
---------------------------------------------------------
category      | product           | total_spend
--------------|------------------ |-------------
appliance     | refrigerator      | 299.99
appliance     | washing machine   | 219.80 
electronics   | vacuum            | 341.00
electronics   | wireless headset  | 249.90
---------------------------------------------------------
*/
