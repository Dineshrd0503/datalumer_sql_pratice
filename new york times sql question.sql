/*
Problem Statement:
Write a SQL query to count views from the viewership table, categorizing them as:
- laptop_views: Count of views where device_type = 'laptop'.
- mobile_view: Count of views where device_type = 'phone' or 'tablet'.
Return a single row with two columns: laptop_views and mobile_view.

Table Schema:
- viewership (device_type: VARCHAR(50))

Constraints:
- device_type may contain 'laptop', 'phone', 'tablet', or other values (e.g., 'desktop').
- Case sensitivity may vary (e.g., 'Laptop', 'PHONE').
- Table may be empty or have NULL values.
- No explicit row count limit provided.

Sample Data and Expected Output:
Input:
device_type
-----------
laptop
Phone
tablet
Laptop
phone
desktop
NULL

Output:
laptop_views | mobile_view
-------------|------------
2            | 3

Explanation:
- laptop_views: Counts rows where device_type is 'laptop' or 'Laptop' (case-insensitive).
- mobile_view: Counts rows where device_type is 'phone', 'Phone', 'tablet', or 'Tablet'.
- 'desktop' and NULL are ignored.

Performance Recommendation:
- Create an index on device_type for large tables:
  CREATE INDEX idx_device_type ON viewership(device_type);
*/

-- Create the viewership table
CREATE TABLE viewership (
    device_type VARCHAR(50)
);

-- Insert sample rows
INSERT INTO viewership (device_type) VALUES
    ('laptop'),
    ('Phone'),   -- Case variation
    ('tablet'),
    ('Laptop'),  -- Case variation
    ('phone'),
    ('desktop'), -- Invalid device_type
    (NULL);      -- NULL value

-- Corrected Query
SELECT
    COUNT(CASE WHEN LOWER(device_type) = 'laptop' THEN 1 ELSE NULL END) AS laptop_views,
    COUNT(CASE WHEN LOWER(device_type) IN ('phone', 'tablet') THEN 1 ELSE NULL END) AS mobile_view
FROM
    viewership;

-- Expected Output:
/*
laptop_views | mobile_view
-------------|------------
2            | 3
*/
