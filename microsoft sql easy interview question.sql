/*
Problem Statement:
Write a query to identify the top 2 Power Users who sent the highest number of 
messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along 
with the total number of messages they sent. Output the results in descending order 
based on the count of the messages.

Assumptions:
- No two users have sent the same number of messages in August 2022.
- Using Microsoft SQL Server.
*/

-- Drop table if it exists
IF OBJECT_ID('messages', 'U') IS NOT NULL
    DROP TABLE messages;

-- Create table schema
CREATE TABLE messages (
    message_id   INT PRIMARY KEY,
    sender_id    INT,
    receiver_id  INT,
    content      VARCHAR(255),
    sent_date    DATETIME
);

-- Insert sample data
INSERT INTO messages (message_id, sender_id, receiver_id, content, sent_date) VALUES
(901, 3601, 4500, 'You up?', '2022-08-03 00:00:00'),
(902, 4500, 3601, 'Only if you''re buying', '2022-08-03 00:00:00'),
(743, 3601, 8752, 'Let''s take this offline', '2022-06-14 00:00:00'),
(922, 3601, 4500, 'Get on the call', '2022-08-10 00:00:00');

-- Solution Query
SELECT TOP 2
    sender_id,
    COUNT(*) AS message_count
FROM messages
WHERE sent_date >= '2022-08-01'
  AND sent_date <  '2022-09-01'
GROUP BY sender_id
ORDER BY message_count DESC;
