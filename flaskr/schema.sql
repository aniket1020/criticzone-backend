DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS reviews;

CREATE TABLE movies(
movie_id INTEGER PRIMARY KEY AUTOINCREMENT,
movie_name VARCHAR(100),
movie_wallpaper VARCHAR(1000),
movie_summary VARCHAR(1000),
movie_releaseDate DATE,
movie_genre VARCHAR(100),
movie_rating INTEGER
);

CREATE TABLE users(
user_id INTEGER PRIMARY KEY AUTOINCREMENT,
user_email VARCHAR(1000),
user_password VARCHAR(1000)
);

CREATE TABLE wishlist(
user_id INTEGER PRIMARY KEY,
movie_id INTEGER,
FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

CREATE TABLE reviews(
movie_id INTEGER PRIMARY KEY,
user_id INTEGER,
user_review VARCHAR(1000),
user_rating INTEGER,
FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
