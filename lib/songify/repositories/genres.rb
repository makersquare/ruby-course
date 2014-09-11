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
            id serial UNIQUE,
            genre text
            )
          ])
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE IF EXISTS genres CASCADE
          ])
        build_table
      end

      def build_genre(data)
        s = Songify::Genre.new(data["name"])
        s.instance_variable_set :@id, data['id'].to_i
      end

      def save_genre(genre)
        response = @db.exec(%q[
          INSERT INTO genres(genre)
          VALUES ($1)
          RETURNING id;
          ], [genre])
        genre.instance_variable_set :@id, response.first['id'].to_i
      end

      def show_all_genres
        requested_genres = @db.exec(%q[
          SELECT * FROM genres
          ])
        requested_genres.map { |g| build_genre(g) }
      end
    end
  end
end