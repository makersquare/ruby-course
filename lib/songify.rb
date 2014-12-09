require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM albums cascade;
      DELETE FROM songs cascade;
      DELETE FROM genres cascade;
      delete from song_genres cascade;
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
      create table song_genres(
        id serial primary key,
        album_id integer references albums (id),
        genres_id integer references genres (id)
      )
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE if exists albums;
      DROP TABLE if exists songs;
      DROP TABLE if exists genres;
      drop table if exists song_genres;
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'
