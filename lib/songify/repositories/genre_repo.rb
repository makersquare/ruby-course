require 'pg'

module Songify
  module Repositories
    class Genre_Repo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[CREATE TABLE IF NOT EXISTS genres (
          id serial,
          title text);])
        
      end

      def drop_table
        @db.exec('DROP TABLE genres;')
        build_table
      end

      def build_genres(entries)
        entries.map do  |genre|
          id = genre["id"]
          this_genre = genre["title"]
          genre = Songify::Genre.new(this_genre)
          genre.instance_variable_set(:@id, id.to_i) 
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