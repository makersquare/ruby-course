require 'pg'

module Songify
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname, user: "ruby", password: "rubyRailsJS")
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM albumgenres CASCADE;
      DELETE FROM genres CASCADE;
      DELETE FROM songs CASCADE;
      DELETE FROM albums CASCADE;
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
      CREATE TABLE albumgenres(
        id SERIAL PRIMARY KEY,
        album_id integer REFERENCES albums (id),
        genre_id integer REFERENCES genres (id)
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE albumgenres CASCADE;
      DROP TABLE albums CASCADE;
      DROP TABLE songs CASCADE;
      DROP TABLE genres CASCADE;
      /* TODO: Drop song_genres table */
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'
