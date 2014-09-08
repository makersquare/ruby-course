require 'pg'

module Songify
  module Repositories
    class Songs
      #create db with table called songs

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            title text,
            artist text,
            album text
            )
          ])
      end

      #drop a table method   adfadsfasdfasdf

      def drop_table
        @db.exec( "DROP TABLE songs")
        build_table
      end

      #parameter could be song id
      def get_a_song(song_id)
        #get the db response object for song
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;
          ], [song_id] )
        build_a_song(result.entries)
        #pass it to the build_song
      end

      def build_a_song(entries)
        entries.map do |song|
          x = Songify::Song.new(song["title"],["artist"],["album"])
          x.instance_variable_set :@id, song["id"].to_i
          x
        end
      end


      #no parameter needed
      def get_all_songs
        result = @db.exec(%q[
          SELECT * FROM songs;
          ])
        build_a_song(result.entries)
      end

      def save_a_song(*song)
        #prevent a duplicate entry?
        #retrieve all songs with matching artist, album, and song
        #build_song and if that array is not empty
        #
        #from the song array, subtract the son

        song.each do |song|
         result = @db.exec(%q[
            INSERT INTO songs (title, artist, album)
            VALUES ($1, $2, $3)
            RETURNING id;
            ], [song.title, song.artist, song.album])
          song.instance_variable_set :@id, result.entries.first["id"].to_i 
        end
          
      end
      #parameter could be song id
      def delete_a_song(song_id)
        @db.exec(%q[
          DELETE FROM songs
          WHERE id = $1;
          ], [song_id])
      end

    end
  end
end