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

      # def update_a_song(id,artist=nil,title=nil,album=nil,length=nil)
      #   newinfo = [['artist',artist],['title',title],['album',album],['length',length]]
      #   info = newinfo.select{|x,y| !y.nil?}
      #   info


      #   # newinfo={'id'=> id, 'artist'=> artist, 'title'=> title, 'album'=> album, 'length'=> length}
      #   # sql =  newinfo.select{|x,y| "#{x} = #{y}" if !y.nil?}
      #   # updates =  sql.join(' AND ')

      #   @db.exec(%q[ 
      #     UPDATE songs 
      #     SET ] + updates +  %q[
      #     WHERE USER ID = ] + "#{id}"
      #   )
        
      # end


      #parameter needed, song id.
      def delete_a_song(id)
        @db.exec(%q[DELETE FROM songs WHERE id = ] + "#{id}")
      end


    end
  end
end
