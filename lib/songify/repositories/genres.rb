require 'pg'
module Songify
  module Repositories
    class Genres
      def initialize(db_name)
        @db = PG.connect(host: 'localhost', dbname: db_name)
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial primary key,
            name text
            )
          ])
      end

      def truncate_table 
        @db.exec("TRUNCATE TABLE genres, songs")
      end

      def save_a_genre(genre_object)
        result = @db.exec(%q[
          INSERT INTO genres (name)
          VALUES ($1)
          RETURNING id;
        ], [genre_object.name])
        genre_object.instance_variable_set("@id", result[0]["id"].to_i)
      end

      def get_a_genre_by_id(genre_id)
        result = @db.exec('SELECT * FROM genres WHERE id = $1', [genre_id])
        build_genre_object(result.entries.first)
      end

      def delete_a_genre(genre_object)
        result = @db.exec('DELETE FROM genres WHERE id = $1', [genre_object])
      end

      def get_a_genre_by_name(genre_name)
        result = @db.exec('SELECT * FROM genres WHERE name = $1', [genre_name])
        build_genre_object(result.entries.first)
      end


      def get_all_genres
        result = @db.exec('SELECT * FROM genres')
        result.entries.map do |genre|
          build_genre_object(genre)
        end
      end

      def build_genre_object(entries)
        x = Songify::Genre.new(entries['name'])
        x.instance_variable_set :@id, entries['id'].to_i
        x
      end
    end
  end
end