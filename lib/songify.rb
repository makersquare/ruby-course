require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM songs;
      DELETE FROM album_genres;
      DELETE FROM albums;
      DELETE FROM genres;    
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE if not exists albums(
        id SERIAL PRIMARY KEY,
        title VARCHAR
      );
      CREATE TABLE if not exists songs(
        id SERIAL PRIMARY KEY,
        album_id integer REFERENCES albums (id),
        title VARCHAR
      );
      CREATE TABLE if not exists genres(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE if not exists album_genres(
        id SERIAL PRIMARY KEY,
        album_id integer REFERENCES albums (id),
        genre_id integer REFERENCES genres (id)
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE songs;
      DROP TABLE album_genres;
      DROP TABLE genres;
      DROP TABLE albums;    
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'
