require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM albums;
      DELETE FROM songs;
      DELETE FROM genres;
      DELETE FROM song_genres;
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
        album_id integer REFERENCES albums (id),
        title VARCHAR
      );
      CREATE TABLE IF NOT EXISTS genres(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS song_genres(
        id        SERIAL PRIMARY KEY,
        song_id   INTEGER REFERENCES songs(id),
        genre_id  INTEGER REFERENCES genres(id),
        album_id  INTEGER REFERENCES albums(id)
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE albums CASCADE;
      DROP TABLE songs CASCADE;
      DROP TABLE genres CASCADE;
      DROP TABLE song_genres CASCADE;
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'
