require 'pg'

module Songify
  module Repositories

    def self.adapter=(dbname)
      @db = PG.connect(host: 'localhost', dbname: dbname)
    end

    def self.adapter
      @db
    end

    def self.build_tables
      @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
                id SERIAL UNIQUE,
                name TEXT
          );
          CREATE TABLE IF NOT EXISTS songs(
            id SERIAL UNIQUE,
            title TEXT,
            artist TEXT,
            album TEXT,
            year INT,
            genre_id INT REFERENCES genres (id),
            rating INT
          );
        ])
    end

    def self.drop_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS songs;
          DROP TABLE IF EXISTS genres;
        ])
      end

  end
end