require 'pg'

module Songify
  module Repos
    class Genres

      def initialize(db_name='songify_dev')
        @db = PG.connect(host: 'localhost', dbname: db_name)
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial,
            genre_name text
          );
        ])
      end

      def drop_table
        @db.exec("DROP TABLE IF EXISTS genres")
        build_table
      end

      def get_genre(genre_id)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE id = $1;
        ], [genre_id])

        build_genres(result.entries).first
      end

      def get_all_genres
        result = @db.exec('SELECT * FROM genres ORDER BY id ASC;')
        build_genres(result.entries)
      end

      def save_genre(genre)
        result = @db.exec(%q[
          INSERT INTO genres (genre_name)
          VALUES ($1)
          RETURNING id;
        ], [genre.genre_name])

        genre.id = result.entries.first["id"].to_i
      end

      def build_genres(entries)
        entries.map do |genre|
          x = Songify::Genre.new(genre["genre_name"])
          x.instance_variable_set :@id, genre["id"].to_i
          x
        end
      end
      
    end
  end
end