require 'pg'

module Songify
  module Repositories

    def self.adapter(dbname)
      @db = PG.connect(host: 'localhost', :dbname, dbname)
      build_tables
    end

    def build_tables
      @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id SERIAL,
            title TEXT,
            artist TEXT,
            album TEXT,
            year INT,
            genre TEXT,
            rating INT
          );
        ])
      @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id SERIAL,
            name TEXT
          )
        ])
    end

  end
end