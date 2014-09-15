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
            id serial PRIMARY KEY,
            name text
          )
        ])
      end

      def get_a_genre_by_id(id)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE id = $1;
        ], [id])
        build_genre(result.first)
      end

      def get_a_genre_by_name(name)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE name = $1;
        ], [name])
        if result.entries.size > 0
          build_genre(result.first)
        else
          nil
        end
      end

      def get_all_genres
        result = @db.exec(%q[
          SELECT * FROM genres;
        ])
        result.map { |genre| build_genre(genre) }
      end

      def truncate_table
        @db.exec("TRUNCATE TABLE genres, songs")
      end

      def save_a_genre(genre)
        result = @db.exec(%q[
          INSERT INTO genres (name)
          VALUES ($1)
          returning id;
        ], [genre.name])
        genre.instance_variable_set("@id", result[0]["id"].to_i)
      end

      def delete_a_genre(id)
        @db.exec(%q[
          DELETE FROM genres WHERE id = $1;
        ], [id])
      end

      def build_genre(genre)
        x = Songify::Genre.new(genre["name"])
        x.instance_variable_set :@id, genre["id"].to_i
        x
      end
    end
  end
end