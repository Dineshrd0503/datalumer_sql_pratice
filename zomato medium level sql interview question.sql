/*
===============================================================================
ZOMATO ORDER CORRECTION - SWAP ERROR FIX
===============================================================================

Problem Statement:
------------------
Zomato encountered an issue where each item's order was swapped with the item 
in the subsequent row due to a delivery driver instructions error. As a data 
analyst, correct this swapping error and return the proper pairing of order ID 
and item.

Key Rules:
- If the last item has an odd order ID, it should remain unchanged.
- For example, if the last item is Order ID 7 Tandoori Chicken, it stays as Order ID 7.
- Return the correct pairs of order IDs and items.
- Output columns: corrected_order_id (original order_id), item (corrected)

Example Input:
order_id | item
---------|------------
1        | Chow Mein
2        | Pizza
3        | Pad Thai
4        | Butter Chicken
5        | Eggrolls
6        | Burger
7        | Tandoori Chicken

Example Output:
corrected_order_id | item
-------------------|------------
1                  | Pizza
2                  | Chow Mein
3                  | Butter Chicken
4                  | Pad Thai
5                  | Burger
6                  | Eggrolls
7                  | Tandoori Chicken

===============================================================================
Table Schema:
===============================================================================

-- Orders table with swapped items
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    item VARCHAR(255) NOT NULL
);

-- Sample data insertion (for testing)
INSERT INTO orders (order_id, item) VALUES
(1, 'Chow Mein'),
(2, 'Pizza'),
(3, 'Pad Thai'),
(4, 'Butter Chicken'),
(5, 'Eggrolls'),
(6, 'Burger'),
(7, 'Tandoori Chicken');

===============================================================================
POSTGRESQL QUERY SOLUTION:
===============================================================================
*/

SELECT 
    order_id AS corrected_order_id,
    CASE 
        -- For the last odd order_id, keep the original item (no swap)
        WHEN order_id % 2 = 1 AND order_id = (SELECT MAX(order_id) FROM orders) THEN item
        -- For odd order_ids (except last), get the next item's original (swapped to this row)
        WHEN order_id % 2 = 1 THEN LEAD(item) OVER (ORDER BY order_id)
        -- For even order_ids, get the previous item's original (swapped away from this row)
        ELSE LAG(item) OVER (ORDER BY order_id)
    END AS item
FROM orders
ORDER BY order_id;
