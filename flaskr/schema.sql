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
user_id INTEGER,
movie_id INTEGER,
FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

CREATE TABLE reviews(
user_id INTEGER,
movie_id INTEGER,
user_review VARCHAR(1000),
user_rating INTEGER,
FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

insert into movies (movie_id,movie_name, movie_wallpaper, movie_summary, movie_releaseDate, movie_genre, movie_rating)
values
(1,'John Wick','https://static2.srcdn.com/wordpress/wp-content/uploads/2019/11/john-wick-2-header-1.jpg','John Wick is an American neo-noir action-thriller media franchise created by screenwriter Derek Kolstad and owned by Summit Entertainment. Keanu Reeves plays John Wick, a retired hitman seeking vengeance for the killing of the dog given to him by his recently deceased wife, and for stealing his car.','2016-05-05','Action',5),
(2,'John Wick 2','https://cdn.onebauer.media/one/empire-images/reviews_films/5898af57ccd4a51d075e10e6/john-wick-2.jpg?quality=50&width=1800&ratio=16-9&resizeStyle=aspectfill&format=jpg','John Wick: Chapter 2 is a 2017 American neo-noir action-thriller film directed by Chad Stahelski and written by Derek Kolstad. It is the second installment in the John Wick film series, and the sequel to the 2014 film John Wick. It stars Keanu Reeves, Common, Laurence Fishburne, Riccardo Scamarcio, Ruby Rose, John Leguizamo, and Ian McShane.','2016-05-05','Action',5),
(3,'John Wick 3','https://assets1.ignimgs.com/2019/07/29/1280-john-wick-3-blu-ray-1564369036236.jpg?width=1280','John Wick: Chapter 3 is an upcoming American neo-noir action thriller film directed by Chad Stahelski and written by Derek Kolstad, Chris Collins, Marc Abrams and Shay Hatten. The film is the third installment in the John Wick film series following John Wick and John Wick: Chapter 2.','2016-05-05','Action',5),
(4,'The Matrix','https://doublefeature.fm/images/covers/the-matrix.jpg','The Matrix is a 1999 American science fiction action film written and directed by the Wachowskis, and produced by Joel Silver. It stars Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving, and Joe Pantoliano and is the first installment in the Matrix franchise.','2016-05-05','Action',5),
(5,'The Matrix 2','https://image.tmdb.org/t/p/original/8xEVAe84zlL9rkfYT6dZXero4KK.jpg','The Matrix Reloaded is a 2003 American science fiction action film written and directed by the Wachowskis, and produced by Joel Silver. It is a sequel to The Matrix, and the second installment in The Matrix film franchise. Reloaded premiered on May 7, 2003, in Westwood, Los Angeles, California, and had its worldwide release by Warner Bros','2016-05-05','Action',5),
(6,'The Matrix 3','https://3.bp.blogspot.com/-fm8kIbgS5qg/UsLl8UAcbMI/AAAAAAAABVg/whK8p5otEzs/s1600/The+Matrix+Revolutions+(2003).jpg','The Matrix Revolutions is a 2003 American science fiction action film written and directed by the Wachowskis, and produced by Joel Silver. It was the third installment of The Matrix film franchise, released six months following The Matrix Reloaded. The film was released simultaneously in 108 territories on November 5, 2003','2016-05-05','Action',5);

insert into users values
(1,'aniket@critic.com','ABCD'),
(2,'harshit@critic.com','ABCD'),
(3,'swapnil@critic.com','ABCD'),
(4,'shivam@critic.com','ABCD');

insert into wishlist values
(1,1),(1,2),(1,3),
(2,3),(2,4),(2,5);

insert into reviews values
(1,1,'Very Nice',5),
(1,2,'Very Nice',5),
(1,3,'Very Nice',5);