require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM albums_genres;
      DELETE FROM songs;
      DELETE FROM genres;
      DELETE FROM albums;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE albums(
        id SERIAL PRIMARY KEY,
        title VARCHAR
      );
      CREATE TABLE songs(
        id SERIAL PRIMARY KEY,
        album_id integer REFERENCES albums (id),
        title VARCHAR
      );
      CREATE TABLE genres(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE albums_genres(
        id SERIAL PRIMARY KEY,
        genre_id integer REFERENCES genres (id),
        album_id integer REFERENCES albums (id)
      );
      CREATE TABLE songs_genres(
        id SERIAL PRIMARY KEY,
        song_id integer REFERENCES songs (id),
        genre_id integer REFERENCES genres (id)
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE songs;
      DROP TABLE genres;
      DROP TABLE albums;
      DROP TABLE albums_genres;
      DROP TABLE song_genres;
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'

