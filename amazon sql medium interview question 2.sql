/* 
Amazon SQL Interview Question - User Shopping Sprees
Source: DataLemur - "Amazon Shopping Spree" [web:69][web:84]

In an effort to identify high-value customers, Amazon asked for your help to obtain
data about users who go on shopping sprees.

A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

Table: transactions
---------------------------------
user_id           INTEGER
amount            FLOAT
transaction_date  TIMESTAMP

Task:
Write a SQL query to list the user IDs who have gone on at least 1 shopping spree
(3 or more consecutive days with purchases), in ascending order of user_id.
*/

/* ================== SOLUTION (PostgreSQL) ================== */

SELECT DISTINCT t1.user_id
FROM transactions t1
JOIN transactions t2
  ON t1.user_id = t2.user_id
 AND DATE(t1.transaction_date) + INTERVAL '1 day' = DATE(t2.transaction_date)
JOIN transactions t3
  ON t1.user_id = t3.user_id
 AND DATE(t2.transaction_date) + INTERVAL '1 day' = DATE(t3.transaction_date)
ORDER BY t1.user_id;
