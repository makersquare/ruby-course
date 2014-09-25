require 'pg'

module Songify
  module Repos
    class Genres

      def initialize(db_name)
        @db = PG.connect(host:'localhost',dbname: db_name)
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial UNIQUE,
            genre text UNIQUE
            )
          ])
        # @db.exec(%q[ALTER TABLE genres 
        #   ADD CONSTRAINT genres_names_key 
        #   UNIQUE (genre);])
      end

      def drop_table
        @db.exec(%q[DROP TABLE genres CASCADE])
        build_table
      end

      def save_a_genre(genre)
        # genre_list = self.get_all_genres.map {|gen_obj| gen_obj.genre }
        # if !(genre_list.include?(genre.genre))
        #   result = @db.exec(%q[
        #     INSERT INTO genres (genre)
        #     VALUES ($1)
        #     RETURNING id
        #     ], [genre.genre])
        #   genre.instance_variable_set :@id, result.entries.first["id"].to_i
        #   result = result.first['id'].to_i
        # else 
        #   result = self.get_a_genre_by_name(genre.genre).id
        # end
        # return result
        begin
          result = @db.exec(%q[
            INSERT INTO genres (genre)
            VALUES ($1)
            RETURNING id
            ], [genre.genre])
          genre.instance_variable_set :@id, result.entries.first["id"].to_i
          return genre.id
        rescue  PG::UniqueViolation
          return Songify.genres.get_a_genre_by_name(genre.genre).id
        end
      end

      def get_a_genre(id)
        result = @db.exec(%q[
          SELECT * FROM genres WHERE id = $1
          ], [id])
        build_genre(result.entries).first
      end

      def get_a_genre_by_name(name)
        name = name.downcase.capitalize
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