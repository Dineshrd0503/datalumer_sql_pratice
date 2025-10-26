-- Alibaba SQL Interview Question: Compressed Mode
-- -----------------------------------------------
-- Problem Statement:
-- Given a table containing item counts per order and the frequency of orders for each item count,
-- write a query to return the "mode" of order occurrences (item counts that appear the most frequently).
-- If there are multiple modes, output all such item counts sorted in ascending order.
--
-- Table Schema:
-- CREATE TABLE items_per_order (
--   item_count INTEGER,
--   order_occurrences INTEGER
-- );
--
-- Example Input:
-- | item_count | order_occurrences |
-- |------------|------------------|
-- |     1      |       500        |
-- |     2      |      1000        |
-- |     3      |       800        |
--
-- Example Output:
-- | mode |
-- |------|
-- |  2   |

SELECT
  item_count AS mode
FROM
  items_per_order
WHERE
  order_occurrences = (
    SELECT MAX(order_occurrences)
    FROM items_per_order
  )
ORDER BY
  item_count;
