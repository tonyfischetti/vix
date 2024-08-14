-- sql, update, subquery, using subquery in WHERE

-- say we just found out that all kay sage paintings were completed
-- one year before previously thought

SELECT *
  FROM paintings
  WHERE artist_id = (
    SELECT artist_id
    FROM artists
    WHERE last_name = 'Sage');


-- ┌─────────────┬───────────┬───────────────────┬────────────────┐
-- │ painting_id │ artist_id │   painting_name   │ year_completed │
-- ├─────────────┼───────────┼───────────────────┼────────────────┤
-- │ 3           │ 1         │ Tommorow is Never │ 1955           │
-- │ 4           │ 1         │ The Answer is No  │ 1958           │
-- │ 5           │ 1         │ No Passing        │ 1954           │
-- └─────────────┴───────────┴───────────────────┴────────────────┘


UPDATE paintings
  SET year_completed = year_completed - 1
  WHERE artist_id = (
    SELECT artist_id
    FROM artists
    WHERE last_name = 'Sage');


SELECT * FROM paintings WHERE artist_id=1;

-- ┌─────────────┬───────────┬───────────────────┬────────────────┐
-- │ painting_id │ artist_id │   painting_name   │ year_completed │
-- ├─────────────┼───────────┼───────────────────┼────────────────┤
-- │ 3           │ 1         │ Tommorow is Never │ 1954           │
-- │ 4           │ 1         │ The Answer is No  │ 1957           │
-- │ 5           │ 1         │ No Passing        │ 1953           │
-- └─────────────┴───────────┴───────────────────┴────────────────┘

