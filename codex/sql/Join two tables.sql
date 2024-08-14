-- sql, sqlite, join, merge, select, from, using, on, concat

SELECT CONCAT_WS(', ', last_name, first_name) AS artist_name,
       painting_name
  FROM artists
    INNER JOIN paintings USING (artist_id);

-- or

SELECT CONCAT_WS(', ', last_name, first_name) AS artist_name,
       painting_name
  FROM artists
    INNER JOIN paintings ON (artists.artist_id = paintings.artist_id);

-- ┌───────────────────────┬─────────────────────────┐
-- │      artist_name      │      painting_name      │
-- ├───────────────────────┼─────────────────────────┤
-- │ Man Ray               │ Orquesta Sinfonica      │
-- │ Man Ray               │ La Fortune              │
-- │ Sage, Kay             │ Tommorow is Never       │
-- │ Sage, Kay             │ The Answer is No        │
-- │ Sage, Kay             │ No Passing              │
-- │ Basquiat, Jean-Michel │ Bird on Money           │
-- │ Mondrian, Piet        │ Place de la Concorde    │
-- │ Mondrian, Piet        │ Composition No. 10      │
-- │ Magritte, Rene        │ The Human Condition     │
-- │ Magritte, Rene        │ The Treachery of Images │
-- │ Magritte, Rene        │ The Son of Man          │
-- └───────────────────────┴─────────────────────────┘
