-- sql, sqlite, create table, drop table, exists, strict, check, primary key, foreign key, length, insert, commit, begin, transaction, pragma, references

PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS "artists";
DROP TABLE IF EXISTS "paintings";


CREATE TABLE IF NOT EXISTS artists (
  artist_id         INTEGER   PRIMARY KEY,                 -- NOT NULL is implied
  first_name        TEXT,
  last_name         TEXT      NOT NULL,
  born_on           INTEGER   CHECK(born_on > 1870)
) STRICT;


CREATE TABLE paintings (
  painting_id       INTEGER   PRIMARY KEY,
  artist_id         INTEGER   REFERENCES artists,
  painting_name     TEXT      CHECK(LENGTH(painting_name) > 1),
  year_completed    INTEGER   CHECK(year_completed > 1800)
) STRICT;

-- or

CREATE TABLE paintings (
  ...
  artist_id         INTEGER,
  ...
  FOREIGN KEY (artist_id) REFERENCES artists
) STRICT;


INSERT INTO artists (first_name, last_name, born_on)
  VALUES ('Kay',        'Sage',     1898),
         ('Piet',       'Mondrian', 1872),
         ('Rene',       'Magritte', 1898),
         ('',           'Man Ray',  1890),
         ('Jean-Michel','Basquiat', 1960);


INSERT INTO paintings (artist_id, painting_name, year_completed)
  VALUES (4, 'Orquesta Sinfonica',      1916),
         (4, 'La Fortune',              1938),
         (1, 'Tommorow is Never',       1955),
         (1, 'The Answer is No',        1958),
         (1, 'No Passing',              1954),
         (5, 'Bird on Money',           1981),
         (2, 'Place de la Concorde',    1943),
         (2, 'Composition No. 10',      1942),
         (3, 'The Human Condition',     1935),
         (3, 'The Treachery of Images', 1948),
         (3, 'The Son of Man',          1964);

COMMIT;
