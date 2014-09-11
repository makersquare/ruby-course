require 'pg'

module Songify
  module Repos
    class Genres

      def initialize
        @db = PG.connect(host:'localhost',dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial,
            genre text)
          ])
      end

      def drop_table
        @db.exec(%q[DROP TABLE genres])
        build_table
      end

      def save_a_genre(genre)
        if !(Songify.genres.get_all_genres.include?(genre))
          result = @db.exec(%q[
            INSERT INTO genres (genre)
            VALUES ($1)
            RETURNING id
            ], [genre.genre])
        else 
          result = Songify.genres.get_a_genre_by_name(genre.genre)
        end
        genre.instance_variable_set :@id, result.entries.first["id"].to_i
        return genre.id
      end

      def get_a_genre(id)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE id = $1
          ], [id])
        build_genre(result.entries).first
      end

      def get_a_genre_by_name(name)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE genre = $1
          ], [name])
        build_genre(result.entries).first
      end

      def get_all_genres
        result = @db.exec('SELECT * FROM genres')
        build_genre(result.entries)
      end

      def delete_a_genre(id)
        result = @db.exec(%q[
          DELETE FROM genres WHERE id = $1
          RETURNING *
          ], [id])
        build_genre(result.entries).first
      end

      def delete_all
        @db.exec("DELETE FROM genres")
      end

      def build_genre(entries)
        entries.map do |genre_hash|
          x = Songify::Genre.new(genre:genre_hash["genre"])
          x.instance_variable_set :@id, genre_hash["id"].to_i
          x
        end
      end

    end
  end
end