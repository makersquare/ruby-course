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
          CREATE TABLE IF NOT EXISTS genres (
            id serial UNIQUE,
            genre text
            )
        ])
      end

      def save_genre(genre)
        result = @db.exec(%q[
          INSERT INTO genres (genre)
          VALUES ($1)
          RETURNING id;
        ], [genre.genre])
          
        genre.instance_variable_set :@id, result.first['id'].to_i
      end

      def get_genre_by_id(id)
        result = @db.exec(%q[
            SELECT * FROM genres 
            WHERE id = $1;
          ], [id])

        build_genre(result.first)
      end

      def get_id_by_genre(genre)
        result = @db.exec(%q[
          SELECT * FROM genres 
          WHERE genre = $1;
        ], [genre.genre])

        build_genre(result.first)
      end

      def get_all_genres
        result = @db.exec('SELECT * FROM genres;')
        result.map { |r| build_genre(r)}
      end

      def drop_and_rebuild_table
        @db.exec("DROP TABLE genres")
        build_table
      end

      def drop_table
        @db.exec("DROP TABLE genres")
      end

      def build_genre(data)
        x = Songify::Genre.new(data['genre'])
        x.instance_variable_set :@id, data['id'].to_i
        x
      end

    end
  end
end
