/*
====================================================================================
Problem Statement:
====================================================================================
Given a table of tweet data over a specified time period, calculate the 3-day rolling
average of tweets for each user.

A rolling average (also known as a moving average) is a time-series technique that
calculates the average of a value over a specified window of time—in this case,
the current day and the previous two days.

====================================================================================
Schema:
====================================================================================
Table: tweets
---------------------------------------------------------------
| Column Name | Data Type | Description                     |
---------------------------------------------------------------
| user_id     | INT        | Unique ID of the user           |
| tweet_date  | TIMESTAMP  | Date of the tweet activity      |
| tweet_count | INT        | Number of tweets made that day  |
---------------------------------------------------------------
*/

-- Drop table if it exists
DROP TABLE IF EXISTS tweets;

-- Create table
CREATE TABLE tweets (
  user_id INT,
  tweet_date TIMESTAMP,
  tweet_count INT
);

-- Insert sample data
INSERT INTO tweets (user_id, tweet_date, tweet_count) VALUES
(111, '2022-06-01 00:00:00', 2),
(111, '2022-06-02 00:00:00', 1),
(111, '2022-06-03 00:00:00', 3),
(111, '2022-06-04 00:00:00', 4),
(111, '2022-06-05 00:00:00', 5),
(222, '2022-06-01 00:00:00', 5),
(222, '2022-06-02 00:00:00', 6),
(222, '2022-06-03 00:00:00', 4),
(222, '2022-06-04 00:00:00', 3),
(222, '2022-06-05 00:00:00', 7);

-- ==================================================================================
-- Query: Calculate 3-day rolling average of tweets per user
-- ==================================================================================

SELECT
  user_id,
  tweet_date,
  ROUND(
    AVG(tweet_count) OVER (
      PARTITION BY user_id
      ORDER BY tweet_date
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2
  ) AS rolling_avg_3d
FROM tweets
ORDER BY user_id, tweet_date;

/*
====================================================================================
Explanation:
====================================================================================
1️⃣ PARTITION BY user_id
    → Ensures calculation is done separately for each user.

2️⃣ ORDER BY tweet_date
    → Orders rows by date for each user.

3️⃣ ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    → Defines a window of 3 rows: current day + previous 2 days.

4️⃣ AVG(tweet_count)
    → Calculates average tweet_count over the window.

5️⃣ ROUND(..., 2)
    → Rounds to 2 decimal places.

====================================================================================
Expected Output (Example):
====================================================================================
| user_id | tweet_date           | rolling_avg_3d |
---------------------------------------------------
| 111     | 2022-06-01 00:00:00  | 2.00 |
| 111     | 2022-06-02 00:00:00  | 1.50 |
| 111     | 2022-06-03 00:00:00  | 2.00 |
| 111     | 2022-06-04 00:00:00  | 2.67 |
| 111     | 2022-06-05 00:00:00  | 4.00 |
| 222     | 2022-06-01 00:00:00  | 5.00 |
| 222     | 2022-06-02 00:00:00  | 5.50 |
| 222     | 2022-06-03 00:00:00  | 5.00 |
| 222     | 2022-06-04 00:00:00  | 4.33 |
| 222     | 2022-06-05 00:00:00  | 4.67 |
====================================================================================
*/
