require 'pg'

module Songify
  module Repositories
    class Genres

      # Builds genre entry. Helper Method.
      def build_genre(entry)
        x = Songify::Genre.new(
          entry["name"]
        )
        x.instance_variable_set :@id, entry["id"].to_i
        x
      end

      def add_genre(genre)
        save = Songify::Repositories.adapter.exec(%q[
          INSERT INTO genres (name)
          VALUES ($1)
          RETURNING id;
        ], [genre.name])
        genre.instance_variable_set :@id, save.entries.first["id"].to_i
      end

      def get_genre(id)
        get = Songify::Repositories.adapter.exec(%q[
          SELECT * FROM genres WHERE id = $1;
        ], [id])
        # build_genre(get)
      end

      def get_all_genres
        all = Songify::Repositories.adapter.exec(%q[
          SELECT * FROM genres;
        ])
        all.map { |genre| build_genre(genre) }
      end

      def delete_genre(id)
        delete = Songify::Repositories.adapter.exec(%q[
          DELETE FROM genres WHERE id = $1;
        ], [id])
      end

    end
  end
end