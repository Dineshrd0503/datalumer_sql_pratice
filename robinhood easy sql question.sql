/*
Problem Statement:
Assume you're given the tables containing completed trade orders and user details 
in a Robinhood trading system.

Write a query to retrieve the top three cities that have the highest number of 
completed trade orders listed in descending order. 
Output the city name and the corresponding number of completed trade orders.

Tables:
---------
1) trades:
    - order_id (integer)
    - user_id (integer)
    - quantity (integer)
    - status (string: 'Completed', 'Cancelled')
    - date (timestamp)
    - price (decimal(5,2))

2) users:
    - user_id (integer)
    - city (string)
    - email (string)
    - signup_date (datetime)
*/

/* Drop tables if they already exist */
DROP TABLE IF EXISTS trades;
DROP TABLE IF EXISTS users;

/* Create users table */
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    city VARCHAR(100),
    email VARCHAR(255),
    signup_date DATETIME
);

/* Create trades table */
CREATE TABLE trades (
    order_id INT PRIMARY KEY,
    user_id INT,
    quantity INT,
    status VARCHAR(20),
    date DATETIME,
    price DECIMAL(5,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

/* Insert sample data into users */
INSERT INTO users (user_id, city, email, signup_date) VALUES
(111, 'San Francisco', 'rrok10@gmail.com', '2021-08-03 12:00:00'),
(148, 'Boston', 'sailor9820@gmail.com', '2021-08-20 12:00:00'),
(178, 'San Francisco', 'harrypotterfan182@gmail.com', '2022-01-05 12:00:00'),
(265, 'Denver', 'shadower_@hotmail.com', '2022-02-26 12:00:00'),
(300, 'San Francisco', 'houstoncowboy1122@hotmail.com', '2022-06-30 12:00:00');

/* Insert sample data into trades */
INSERT INTO trades (order_id, user_id, quantity, status, date, price) VALUES
(100101, 111, 10, 'Cancelled', '2022-08-17 12:00:00', 9.80),
(100102, 111, 10, 'Completed', '2022-08-17 12:00:00', 10.00),
(100259, 148, 35, 'Completed', '2022-08-25 12:00:00', 5.10),
(100264, 148, 40, 'Completed', '2022-08-26 12:00:00', 4.80),
(100305, 300, 15, 'Completed', '2022-09-05 12:00:00', 10.00),
(100400, 178, 32, 'Completed', '2022-09-17 12:00:00', 12.00),
(100565, 265, 2, 'Completed', '2022-09-27 12:00:00', 8.70);

/* ------------------ Solution Query ------------------ */

/* For MySQL / PostgreSQL */
SELECT 
    u.city,
    COUNT(*) AS total_orders
FROM users u
JOIN trades t
    ON u.user_id = t.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3;

/* For SQL Server (MSSQL) */
SELECT TOP 3
    u.city,
    COUNT(*) AS total_orders
FROM users u
JOIN trades t
    ON u.user_id = t.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC;
