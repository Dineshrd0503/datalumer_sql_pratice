/*
===============================================================================
SPOTIFY - CUMULATIVE SONG PLAYS UP TO AUG 4, 2022
===============================================================================

Problem Statement:
------------------
You're given two tables containing data on Spotify users' streaming activity: one
containing historical streaming counts (songs_history) and another weekly data
(songs_weekly). Your goal is to output the user ID, song ID, and cumulative count
of song plays up to August 4th, 2022, for each user and song.

Notes:
- Users or songs in songs_weekly may not appear in songs_history and vice versa.
- Only weekly plays up to and including August 4, 2022 should be counted.
- Output should be ordered by cumulative plays descending.

===============================================================================
Table Schemas:
===============================================================================

-- Historical play counts
CREATE TABLE songs_history (
    history_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    song_plays INT
);

-- Weekly streaming data (individual listens)
CREATE TABLE songs_weekly (
    user_id INT,
    song_id INT,
    listen_time DATETIME
);

===============================================================================
SINGLE SQL QUERY:
===============================================================================
*/

SELECT 
    user_id,
    song_id,
    SUM(song_plays) AS song_plays
FROM (
    SELECT
        user_id,
        song_id,
        song_plays
    FROM songs_history

    UNION ALL

    SELECT
        user_id,
        song_id,
        COUNT(*) AS song_plays
    FROM songs_weekly
    WHERE listen_time <= '2022-08-04 23:59:59'
    GROUP BY user_id, song_id
) AS combined
GROUP BY user_id, song_id
ORDER BY song_plays DESC;
