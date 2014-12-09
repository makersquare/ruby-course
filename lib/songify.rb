require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM album_genres;
      DELETE FROM songs;
      DELETE FROM albums;
      DELETE FROM genres;
      
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS albums(
        id SERIAL PRIMARY KEY,
        title VARCHAR
      );
      CREATE TABLE IF NOT EXISTS songs(
        id SERIAL PRIMARY KEY,
        album_id integer REFERENCES albums (id)
        on delete cascade
        on update cascade,
        title VARCHAR
      );
      CREATE TABLE IF NOT EXISTS genres(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS album_genres(
        id SERIAL PRIMARY KEY,
        album_id integer REFERENCES albums
        on delete cascade
        on update cascade,
        genre_id integer REFERENCES genres
      );
      /* TODO: Create song_genres table */
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE albums;
      DROP TABLE songs;
      DROP TABLE genres;
      DROP TABLE album_genres;
      /* TODO: Drop song_genres table */
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'
