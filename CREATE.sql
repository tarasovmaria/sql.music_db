--CREATION
--genres table
CREATE TABLE IF NOT EXISTS genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL 
);
--artists table
CREATE TABLE IF NOT EXISTS music_artists (
    artist_id SERIAL PRIMARY KEY,
    alias VARCHAR(60) UNIQUE NOT NULL 
); 
--intermediate genres & artists table
CREATE TABLE IF NOT EXISTS genres_artists (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES music_artists (artist_id),
    FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);
--albums table
CREATE TABLE IF NOT EXISTS albums (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(60) NOT NULL,
    release_year INTEGER NOT NULL 
);
--intermediate artists & albums table
CREATE TABLE IF NOT EXISTS artists_albums (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES music_artists (artist_id),
    FOREIGN KEY (album_id) REFERENCES albums (album_id)
);
--tracks table
CREATE TABLE IF NOT EXISTS tracks (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(60) NOT NULL,
    duration TIME NOT NULL,
    album_id INTEGER NOT NULL,
    FOREIGN KEY (album_id) REFERENCES albums (album_id)
);
--collections table
CREATE TABLE IF NOT EXISTS collections (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(60) NOT NULL,
    release_year INTEGER NOT NULL 
);
--intermediate tracks & collections table
CREATE TABLE IF NOT EXISTS tracks_collections (
    id SERIAL PRIMARY KEY,
    track_id INTEGER NOT NULL,
    collection_id INTEGER NOT NULL,
    FOREIGN KEY (track_id) REFERENCES tracks (track_id),
    FOREIGN KEY (collection_id) REFERENCES collections (collection_id)
);