DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;

CREATE TABLE artists(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  logo TEXT
);

CREATE TABLE albums(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  artwork TEXT,
  genre VARCHAR(255),
  stock INT,
  cost INT,
  sale INT,
  sold INT,
  artist_id INT REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE sales(
  id SERIAL PRIMARY KEY,
  sold INT,
  artist_id INT REFERENCES artists(id) ON DELETE CASCADE,
  album_id INT REFERENCES albums(id) ON DELETE CASCADE
)
