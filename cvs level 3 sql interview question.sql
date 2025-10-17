-- =========================================================
--  CVS Health - Pharmacy Sales Dashboard Query
--  Goal: Calculate total drug sales (rounded to nearest million)
--  Format: "$36 million"
--  Sort: Descending by total sales, then alphabetically by manufacturer
-- =========================================================

SELECT
  manufacturer,
  CONCAT('$', ROUND(SUM(total_sales) / 1000000), ' million') AS sale
FROM
  pharmacy_sales
GROUP BY
  manufacturer
ORDER BY
  SUM(total_sales) DESC, manufacturer;
