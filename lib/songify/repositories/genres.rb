require 'pg'

module Songify
  module Repo
    class Genres

      def initialize(db_name)
        @db = PG.connect(host: 'localhost', dbname: db_name)

        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
           id SERIAL UNIQUE,
           name TEXT)
          ])
      end

      def drop_table
        @db.exec("DROP TABLE IF EXISTS genres cascade")
        build_table
      end

      def build_genre(data)
        x = Songify::Genre.new(data["name"])
        x.instance_variable_set :@id, data["id"].to_i
        x
      end

      def save_genre(genre)
        result = @db.exec(%q[
          INSERT INTO genres (name) VALUES ($1) RETURNING id;], [genre.name]) 
        genre.id = result.entries.first["id"].to_i
      end

      def get_all_genres
       result = @db.exec("SELECT * from genres;")
        final_result = result.map {|g| build_genre(g)}
        final_result ###why has this turned into a hash and not an array
      end

      def get_genre(id)
       result = @db.exec(%q[SELECT * from genres WHERE id = $1;], [id])
        build_genre(result.first)
      end

    end
  end
end