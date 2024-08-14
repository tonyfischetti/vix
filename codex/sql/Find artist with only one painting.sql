-- sql, sqlite, count, as, group by, having, filter after group by

-- can't use WHERE. have to use HAVING

SELECT * FROM v_merged;

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


SELECT artist_name, COUNT(artist_name) AS CNT
  FROM v_merged
  GROUP BY artist_name
  HAVING CNT = 1;

-- ┌───────────────────────┬─────┐
-- │      artist_name      │ CNT │
-- ├───────────────────────┼─────┤
-- │ Basquiat, Jean-Michel │ 1   │
-- └───────────────────────┴─────┘

