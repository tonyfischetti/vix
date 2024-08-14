-- sql, sqlite, subquery

-- select all paintings done by Kay Sage

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

