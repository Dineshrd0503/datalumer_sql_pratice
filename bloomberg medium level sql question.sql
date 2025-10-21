/*
===============================================================================
BLOOMBERG STOCK ANALYSIS – HIGHEST AND LOWEST OPEN PRICES BY MONTH
===============================================================================

Problem Statement:
------------------
You are a Data Analyst at Bloomberg with access to historical stock data for 
FAANG companies. The goal is to find, for each stock (ticker symbol):

1. The month and year ('Mon-YYYY') where the stock had its **highest opening price**.
2. The month and year ('Mon-YYYY') where the stock had its **lowest opening price**.

Return:
--------
ticker | highest_mth | highest_open | lowest_mth | lowest_open

The results should be sorted by ticker symbol.

===============================================================================
TABLE SCHEMA:
===============================================================================

CREATE TABLE stock_prices (
    date        TIMESTAMP,
    ticker      VARCHAR(10),
    open        DECIMAL(10, 2),
    high        DECIMAL(10, 2),
    low         DECIMAL(10, 2),
    close       DECIMAL(10, 2)
);

Example Data:
--------------
 date                | ticker |  open  |  high  |  low   | close
---------------------+--------+--------+--------+--------+--------
 2023-01-31 00:00:00 | AAPL   | 142.28 | 142.70 | 144.34 | 144.29
 2023-02-28 00:00:00 | AAPL   | 146.83 | 147.05 | 149.08 | 147.41
 2023-03-31 00:00:00 | AAPL   | 161.91 | 162.44 | 165.00 | 164.90
 2023-04-30 00:00:00 | AAPL   | 167.88 | 168.49 | 169.85 | 169.68
 2023-05-31 00:00:00 | AAPL   | 176.76 | 177.33 | 179.35 | 177.25

Expected Output:
----------------
 ticker | highest_mth | highest_open | lowest_mth | lowest_open
 --------+--------------+---------------+--------------+-------------
 AAPL   | May-2023     | 176.76        | Jan-2023     | 142.28

===============================================================================
POSTGRESQL QUERY SOLUTION:
===============================================================================
*/

WITH highest_open AS (
    SELECT
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS highest_mth,
        open AS highest_open,
        ROW_NUMBER() OVER (
            PARTITION BY ticker
            ORDER BY open DESC
        ) AS rn_high
    FROM stock_prices
),
lowest_open AS (
    SELECT
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS lowest_mth,
        open AS lowest_open,
        ROW_NUMBER() OVER (
            PARTITION BY ticker
            ORDER BY open ASC
        ) AS rn_low
    FROM stock_prices
)
SELECT
    h.ticker,
    h.highest_mth,
    h.highest_open,
    l.lowest_mth,
    l.lowest_open
FROM highest_open h
JOIN lowest_open l
  ON h.ticker = l.ticker
WHERE h.rn_high = 1
  AND l.rn_low = 1
ORDER BY h.ticker;
