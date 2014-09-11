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
        @db.exec(%q[
          DROP TABLE IF EXISTS genres
          ])
      end

      def save_genre(genre)
        @db.exec(%q[
          INSERT INTO genres(genre)
          VALUES ($1)
          RETURNING id;
          ], [genre])
        genre.instance_variable_set :@id, response.first['id'].to_i
      end
    end
  end
end