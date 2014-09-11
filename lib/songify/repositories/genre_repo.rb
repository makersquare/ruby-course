require 'pg'

module Songify
  module Repositories
    class Genre_Repo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'genres')
        build_table
      end

      def build_table
        @db.exec(%q[CREATE TABLE IF NOT EXISTS genres (
          genre_id serial,
          genre text);])
        
      end

      def drop_table
        @db.exec('DROP TABLE songs;')
        build_table
      end

      def build_genres(entries)
        entries.map do  |genre|
          this_genre = genre["genre"]
          genre = Songify::Genre.new(this_genre)
          genre
        end
      end

      def entries
        result = @db.exec(%q[SELECT * FROM genres])
        result = result.entries
      end

      
      def get_genre(id)
        genre = @db.exec(%q[SELECT * FROM genres
          WHERE id = ($1);], [id])
        build_genres(genre)[0]
      end

      
      def get_all_genres
        build_genres(entries)
      end

      def save_genre(genre)
        @db.exec(%q[INSERT INTO genres
          (title)
          VALUES ($1);],
          [genre.title])
      end

    
      def delete_genre(id)
        @db.exec(%q[DELETE FROM genres
          WHERE id = ($1);], [id])
      end


    end
  end
end