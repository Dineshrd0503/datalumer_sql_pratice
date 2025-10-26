-- Microsoft SQL Interview Question: Supercloud Customer (DataLemur)
-- Problem Statement:
-- A “Supercloud customer” is defined as a customer who has purchased at least one product 
-- in every product category available in the products table.
-- Write a query to return the customer_ids of all Supercloud customers.

-- Table Schemas:
-- customer_contracts(customer_id, product_id, amount)
-- products(product_id, product_category, product_name)

SELECT
  c.customer_id
FROM
  customer_contracts c
  JOIN products p ON c.product_id = p.product_id
GROUP BY
  c.customer_id
HAVING
  COUNT(DISTINCT p.product_category) = (
    SELECT COUNT(DISTINCT product_category) FROM products
  );
