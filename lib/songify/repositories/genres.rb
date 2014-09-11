require 'pg'

module Songify
  module Repositories
    class Genres
      def initialize(dbname)
        @db = PG.connect(host: 'localhost', dbname: dbname)
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial,
            genre text
          )
        ])
      end

      def drop_table
        @db.exec("DROP TABLE genres")
        build_table
      end
    end
  end
end