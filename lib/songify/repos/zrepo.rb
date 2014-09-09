require 'pg'

module Songify
  module Repos

    def self.db
      @db = PG.connect(host: 'localhost', dbname: 'songify-dev')
    end

    def self.create_tables
      query = <<-SQL
        CREATE TABLE songs (
          id SERIAL PRIMARY KEY,
          song_name TEXT,
          artist TEXT,
          album TEXT         
        );
      SQL
      Repos.db.exec(query)
    end

    def self.drop_tables
      query = <<-SQL
        DROP TABLE IF EXISTS songs CASCADE;
      SQL
      Repos.db.exec(query)
    end
  end
end
