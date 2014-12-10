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
      delete from album_genres cascade;
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
        album_id integer REFERENCES albums (id)
        on delete cascade
        on update cascade,
        title VARCHAR
      );
      CREATE TABLE genres(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      create table album_genres(
        id serial primary key,
        album_id integer references albums (id)
        on delete cascade
        on update cascade,
        genres_id integer references genres (id)
        on delete cascade
        on update cascade
      )
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE if exists albums cascade;
      DROP TABLE if exists songs cascade;
      DROP TABLE if exists genres cascade;
      drop table if exists album_genres cascade;
    SQL
  end
end

require_relative 'songify/album_repo'
require_relative 'songify/genre_repo'
require_relative 'songify/song_repo'

# db = Songify.create_db_connection("songify_dev")
# Songify.drop_tables(db)
# Songify.create_tables(db)