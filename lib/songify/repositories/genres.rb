require 'pg'

module Songify
  module Repositories
    class Genres

      # def initialize
      #   @db = PG.connect(host: 'localhost', db: 'genres')
      #   build_table
      # end

      # Builds genres table.
      # def build_table
      #   @db.exec(%q[
      #     CREATE TABLE IF NOT EXISTS genres(
      #       id SERIAL,
      #       name TEXT
      #     )
      #   ])
      # end

      # Build for testing.
      def drop_and_rebuild_table
        @db.exec(%q[
          DROP TABLE IF EXISTS genres;
        ])
      end

      # Builds genre entry. Helper Method.
      def build_genre(entry)
        x = Songify::Song.new(
          entry["name"]
        )
        x.instance_variable_set :@id, entry["id"].to_i
        x
      end

      def add_genre(genre)
        save = @db.exec(%q[
          INSERT INTO genres (name)
          VALUES ($1)
          RETURNING id;
        ], [genre.id])
        genre.instance_variable_set :@id, save.entries.first["id"].to_i
      end

      def delete_genre(genre)
        delete = @db.exec(%q[
          D
        ])

    end
  end
end