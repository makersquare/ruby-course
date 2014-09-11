require 'pg'

module Songify
  module Repositories
    class Genres

      def initialize
        @db = PG.connect(host: "localhost", dbname: "songify")  
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS genres(
            id serial,
            genres text
          )
        ])
      end

      def drop_table
        @db.exec(%q[DROP TABLE genres])
        build_table
      end

      def save_genre(type)
        @db.exec(%q[ INSERT INTO genres( genres )
          VALUES( $1 )
        ], [type.genre])
      end

      def build_genre(type)
        song = Songify::Genre.new(type["genre"])
        song.instance_variable_set :@id, type["id"].to_i
        song
      end



      #song id, possibly artist?, album?
      def get_a_genre(id)
        song = get_all_genres(id)
        song[0]
      end

      # does not need a paramater
      def get_all_genres(id = nil)
        sql = ''
        if id
          sql = "WHERE id = #{id}"
        end
        genres = @db.exec("SELECT * FROM genres " + sql ).entries
        genre = genres.map{|x| build_genre(x)}
        genre
      end



      # def update_all(id,artist=nil,title=nil,album=nil,length=nil)
      #   updates =[['artist',artist],['title',title],['album',album],['length',length]]
      #   updates.each do |x,y|
      #     update(id,x,y) if y
      #   end
      # end

      # def update(id,piece,artist)
      #   @db.exec(%q[ 
      #     UPDATE songs 
      #     SET ] + piece + ' = ' +"'#{artist}'"+ %q[
      #     WHERE id = ] + id.to_s
      #   )
      # end


      #parameter needed, song id.
      def delete_a_genre(id)
        @db.exec(%q[DELETE FROM genre WHERE id = $1],[id])
      end


    end
  end
end
