-- sql, drop view, create view, as, join, merge, 

DROP VIEW IF EXISTS "v_merged";

CREATE VIEW IF NOT EXISTS v_merged AS
  SELECT CONCAT_WS(', ', last_name, first_name) AS artist_name,
         painting_name
    FROM artists
      INNER JOIN paintings USING (artist_id);

