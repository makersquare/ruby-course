require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM song_genres;
      DELETE FROM songs;
      DELETE FROM albums;
      DELETE FROM genres;
      /* TODO: Clear rest of the tables (books, etc.) */
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
      /* TODO: Create song_genres table */
      CREATE TABLE song_genres(
        id SERIAL PRIMARY KEY,
        album_id INTEGER REFERENCES albums (id),
        genre INTEGER REFERENCES genres (id)
        );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE songs;
      DROP TABLE albums;
      DROP TABLE genres;
      /* TODO: Drop song_genres table */
      DROP TABLE song_genres;
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'
