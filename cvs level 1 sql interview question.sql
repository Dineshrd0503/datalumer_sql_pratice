-- =============================================
-- CVS Health: Top 3 Most Profitable Drugs
-- Author: Rajasekhar Dinesh
-- Database: PostgreSQL
-- Description:
--   This query finds the top 3 most profitable drugs
--   from the pharmacy_sales table.
--   Profit = total_sales - cogs
-- =============================================

-- Drop table if it exists (for testing purpose)
DROP TABLE IF EXISTS pharmacy_sales;

-- Create the table
CREATE TABLE pharmacy_sales (
    product_id INTEGER,
    units_sold INTEGER,
    total_sales DECIMAL(12,2),
    cogs DECIMAL(12,2),
    manufacturer VARCHAR(100),
    drug VARCHAR(100)
);

-- Insert sample data
INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
(9, 37410, 293452.54, 208876.01, 'Eli Lilly', 'Zyprexa'),
(34, 94698, 600997.19, 521182.16, 'AstraZeneca', 'Surmontil'),
(61, 77023, 500101.61, 419174.97, 'Biogen', 'Varicose Relief'),
(136, 144814, 1084258.00, 1006447.73, 'Biogen', 'Burkhart');

-- =============================================
-- Query: Find Top 3 Most Profitable Drugs
-- =============================================

SELECT 
    drug,
    ROUND(total_sales - cogs, 2) AS total_profit
FROM 
    pharmacy_sales
ORDER BY 
    total_profit DESC
LIMIT 3;
