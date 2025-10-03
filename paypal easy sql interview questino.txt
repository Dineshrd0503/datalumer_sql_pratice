/*
Problem Statement:
Given a transactions table with deposits and withdrawals, write a query to 
calculate the final balance for each account. A 'Deposit' adds to the balance, 
while any other transaction type deducts from the balance.

Table: transactions
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| transaction_id  | int     |
| account_id      | int     |
| transaction_type| varchar |  -- ('Deposit', 'Withdrawal')
| amount          | int     |
+-----------------+---------+

Sample Input:
transaction_id | account_id | transaction_type | amount
--------------------------------------------------------
1              | 1001       | Deposit          | 500
2              | 1001       | Withdrawal       | 200
3              | 1002       | Deposit          | 1000
4              | 1002       | Withdrawal       | 300
5              | 1001       | Deposit          | 100

Expected Output:
account_id | final_balance
--------------------------
1001       | 400
1002       | 700
*/

-- Drop table if it already exists
DROP TABLE IF EXISTS transactions;

-- Create table schema
CREATE TABLE transactions (
    transaction_id   INT PRIMARY KEY,
    account_id       INT,
    transaction_type VARCHAR(20),
    amount           INT
);

-- Insert sample data
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount) VALUES
(1, 1001, 'Deposit', 500),
(2, 1001, 'Withdrawal', 200),
(3, 1002, 'Deposit', 1000),
(4, 1002, 'Withdrawal', 300),
(5, 1001, 'Deposit', 100);

-- Solution Query
SELECT 
    account_id,
    SUM(CASE WHEN transaction_type = 'Deposit' 
             THEN amount 
             ELSE -amount 
        END) AS final_balance
FROM transactions
GROUP BY account_id;
