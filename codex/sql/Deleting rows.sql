-- sql, sqlite, insert, delete, like

-- fake data for illustration
INSERT INTO paintings (artist_id, painting_name, year_completed)
  VALUES (1, '100% FUN!!', 2024);


DELETE FROM paintings
  WHERE painting_name LIKE '%FUN%';

