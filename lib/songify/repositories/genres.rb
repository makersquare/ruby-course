#genres repo goes here

require 'pg'
require 'pry-byebug'

module Songify
  module Repositories
    class Genres

      def initialize(dbname='songify_dev')
        @db = PG.connect(host: 'localhost', dbname: dbname)
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial primary key,
            genre text
            )
          ])
      end

      def drop_table
        @db.exec("DROP TABLE genres CASCADE;")
        build_table
      end

      def get_a_genre(genre_id)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE id = $1;
          ], [genre_id])
        build_a_genre(result.entries)
      end

      def id_by_genre(genre_name)
        result = @db.exec(%q[
          SELECT id FROM genres WHERE genre = $1;
          ], [genre_name])
        
        p 'test'
        result.entries.first["id"]
      end

      def build_a_genre(entries)
        entries.map do |genre|
          x = Songify::Genre.new(genre["genre"])
          x.instance_variable_set :@id, genre["id"].to_i
          x
        end
      end

      def save_a_genre(*genre)
        genre.each do |genre1|
          result = @db.exec(%q[
            INSERT INTO genres (genre)
            VALUES ($1)
            RETURNING id;
            ], [genre1.genre])
          genre1.instance_variable_set :@id, result.entries.first["id"].to_i
        end
      end

      def get_all_genres
        result = @db.exec('SELECT * FROM genres;')
        build_a_genre(result.entries)
      end

      def delete_all
        @db.exec(%q[
          DELETE FROM genres;
          ])
      end

      def delete_a_genre(genre_id)
        @db.exec(%q[
          DELETE FROM genres
          WHERE id = $1;
          ], [genre_id])
      end
    end
  end
end