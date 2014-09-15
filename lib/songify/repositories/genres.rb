require 'pg'

module Songify
  module Repositories
    class Genres

      def initialize
        @db = PG.connect(host: "localhost", dbname: "songify")  
        none = Songify::Genre.new('None')
        save_genre(none)
      end

      def save_genre(type)
        @db.exec(%q[ INSERT INTO genres ( genres )
          VALUES( $1 )
        ], [type.genre])
      end

      def build_genre(entry)
        genre = Songify::Genre.new(entry["genres"])
        genre.instance_variable_set :@id, entry["id"].to_i
        genre
      end

      def get_a_genre(id)
        genre = get_all_genres(id)
        genre[0]
      end

      def get_all_genres(id = nil)
        sql = ''
        if id
          sql = "WHERE id = #{id}"
        end
        genres = @db.exec("SELECT * FROM genres " + sql ).entries
        genre = genres.map{|x| build_genre(x)}
        genre
      end

      def update(id,name)
        @db.exec(%q[ 
          UPDATE genres 
          SET genres = ]+"'#{name}'"+ %q[
          WHERE id = ] + id.to_s
        )
      end

      def delete_a_genre(id)
        @db.exec(%q[DELETE FROM genres WHERE id = $1],[id])
      end


    end
  end
end
