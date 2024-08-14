-- sql, like, glob, escape, distinct, insert, wildcards

SELECT first_name, last_name FROM artists;

-- ┌─────────────┬───────────┐
-- │ first_name  │ last_name │
-- ├─────────────┼───────────┤
-- │ Kay         │ Sage      │
-- │ Piet        │ Mondrian  │
-- │ Rene        │ Magritte  │
-- │             │ Man Ray   │
-- │ Jean-Michel │ Basquiat  │
-- └─────────────┴───────────┘

SELECT first_name, last_name
  FROM artists
  WHERE first_name LIKE '____';   -- _ matches one character

SELECT first_name, last_name
  FROM artists
  WHERE first_name GLOB '????';   -- ? matches one character

-- ┌────────────┬───────────┐
-- │ first_name │ last_name │
-- ├────────────┼───────────┤
-- │ Piet       │ Mondrian  │
-- │ Rene       │ Magritte  │
-- └────────────┴───────────┘

SELECT DISTINCT artist_name FROM v_merged;

-- ┌───────────────────────┐
-- │      artist_name      │
-- ├───────────────────────┤
-- │ Man Ray               │
-- │ Sage, Kay             │
-- │ Basquiat, Jean-Michel │
-- │ Mondrian, Piet        │
-- │ Magritte, Rene        │
-- └───────────────────────┘

SELECT DISTINCT (artist_name)
  FROM v_merged
  WHERE artist_name LIKE '%ay';

SELECT DISTINCT (artist_name)
  FROM v_merged
  WHERE artist_name GLOB '*ay';

-- ┌─────────────┐
-- │ artist_name │
-- ├─────────────┤
-- │ Man Ray     │
-- │ Sage, Kay   │
-- └─────────────┘


-- fake data to demonstrate escaping
INSERT INTO paintings (artist_id, painting_name, year_completed)
  VALUES (1, '100% FUN!!', 2024);

SELECT painting_name
  FROM paintings
  WHERE painting_name LIKE '100\%%' escape '\';


-- ┌───────────────┐
-- │ painting_name │
-- ├───────────────┤
-- │ 100% FUN!!    │
-- └───────────────┘



