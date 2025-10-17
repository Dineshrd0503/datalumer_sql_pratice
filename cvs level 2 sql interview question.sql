-- =====================================================
-- CVS Health: Pharmacy Analytics (Part 2)
-- Author: Rajasekhar Dinesh
-- Database: MySQL
-- Description:
--   This query identifies manufacturers whose drugs
--   resulted in losses for CVS Health and calculates:
--     1. Total number of loss-making drugs per manufacturer
--     2. Total amount of losses (absolute value)
-- =====================================================

-- Drop table if it already exists
DROP TABLE IF EXISTS pharmacy_sales;

-- Create the pharmacy_sales table
CREATE TABLE pharmacy_sales (
    product_id INT,
    units_sold INT,
    total_sales DECIMAL(12,2),
    cogs DECIMAL(12,2),
    manufacturer VARCHAR(100),
    drug VARCHAR(100)
);

-- Insert sample data
INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
(156, 89514, 3130097.00, 3427421.73, 'Biogen', 'Acyclovir'),
(25, 222331, 2753546.00, 2974975.36, 'AbbVie', 'Lamivudine and Zidovudine'),
(50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb TA Complete Kit'),
(98, 110746, 813188.82, 140422.87, 'Biogen', 'Medi-Chord');

-- =====================================================
-- Query: Find Manufacturers with Loss-Making Drugs
-- =====================================================

SELECT 
    manufacturer,
    COUNT(*) AS drug_count,
    ROUND(SUM(ABS(total_sales - cogs)), 2) AS total_loss
FROM 
    pharmacy_sales
WHERE 
    total_sales < cogs  -- Filter only loss-making drugs
GROUP BY 
    manufacturer
ORDER BY 
    total_loss DESC;
-- =====================================================
-- CVS Health: Pharmacy Analytics (Part 2)
-- Author: Rajasekhar Dinesh
-- Database: MySQL
-- Description:
--   This query identifies manufacturers whose drugs
--   resulted in losses for CVS Health and calculates:
--     1. Total number of loss-making drugs per manufacturer
--     2. Total amount of losses (absolute value)
-- =====================================================

-- Drop table if it already exists
DROP TABLE IF EXISTS pharmacy_sales;

-- Create the pharmacy_sales table
CREATE TABLE pharmacy_sales (
    product_id INT,
    units_sold INT,
    total_sales DECIMAL(12,2),
    cogs DECIMAL(12,2),
    manufacturer VARCHAR(100),
    drug VARCHAR(100)
);

-- Insert sample data
INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
(156, 89514, 3130097.00, 3427421.73, 'Biogen', 'Acyclovir'),
(25, 222331, 2753546.00, 2974975.36, 'AbbVie', 'Lamivudine and Zidovudine'),
(50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb TA Complete Kit'),
(98, 110746, 813188.82, 140422.87, 'Biogen', 'Medi-Chord');

-- =====================================================
-- Query: Find Manufacturers with Loss-Making Drugs
-- =====================================================

SELECT 
    manufacturer,
    COUNT(*) AS drug_count,
    ROUND(SUM(ABS(total_sales - cogs)), 2) AS total_loss
FROM 
    pharmacy_sales
WHERE 
    total_sales < cogs  -- Filter only loss-making drugs
GROUP BY 
    manufacturer
ORDER BY 
    total_loss DESC;
