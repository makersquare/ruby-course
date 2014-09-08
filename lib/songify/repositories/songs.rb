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

      def build_song(entry)
        song = Songify::Song.new(entry["artist"],entry["title"],entry["album"],entry["length"].to_i)
        song.instance_variable_set :@id, entry["id"].to_i
        song
      end

      def drop_table
        @db.exec(%q[DROP TABLE songs])
        build_table
      end

      #song id, possibly artist?, album?
      def get_a_song(id)
        song = get_all_songs(id)
        song[0]
      end

      # does not need a paramater
      def get_all_songs(id = nil)
        sql = ''
        if id
          sql = "WHERE id = #{id}"
        end
        songs = @db.exec("SELECT * FROM songs " + sql ).entries
        song = songs.map{|x| build_song(x)}
        song
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
        @db.exec(%q[DELETE FROM songs WHERE id = $1],[id])
      end


    end
  end
end
