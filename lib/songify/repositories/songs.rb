require 'pg'

module Songify
  module Repositories
    class Songs

      def initialize
        @db = PG.connect(host: "localhost", dbname: "songify")  
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            artist text,
            title text,
            album text,
            length int 
          )
        ])
      end

      def drop_table
        @db.exec(%q[DROP TABLE songs])
        build_table
      end

      #song id, possibly artist?, album?
      def get_a_song(id)
        get_all_songs(id)[0]
      end

      # does not need a paramater
      def get_all_songs(id = nil)
        sql = ''
        if id
          sql = "WHERE id = #{id}"
        end
        songs = @db.exec("SELECT * FROM songs " + sql ).entries
      end

      #paramaters, song object
      def save_a_song(song)
        @db.exec(%q[ INSERT INTO songs( artist, title, album, length)
          VALUES( $1, $2, $3, $4)
        ], [song.artist, song.title, song.album, song.length])
        
      end

      def update_all(id,artist=nil,title=nil,album=nil,length=nil)
        updates =[['artist',artist],['title',title],['album',album],['length',length]]
        updates.each do |x,y|
          update(id,x,y) if y
        end
      end

      def update(id,piece,artist)
        @db.exec(%q[ 
          UPDATE songs 
          SET ] + piece + ' = ' +"'#{artist}'"+ %q[
          WHERE id = ] + id.to_s
        )
      end


      #parameter needed, song id.
      def delete_a_song(id)
        @db.exec(%q[DELETE FROM songs WHERE id = ] + "#{id}")
      end


    end
  end
end
