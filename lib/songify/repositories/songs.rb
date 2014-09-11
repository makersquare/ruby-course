require 'pg'

module Songify
  module Repositories
    class Songs

      def initialize(dbname)
        @db = PG.connect(host: 'localhost', dbname: dbname)
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
      
      def drop_table
        @db.exec( "DROP TABLE songs")
        build_table
      end
      
      def get_a_song(song_id)
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;
          ], [song_id] )
        build_a_song(result.entries)
      end
      
      def build_a_song(entries)
        #would have been better to not use loop?
        entries.map do |song|
          x = Songify::Song.new(song["title"],["artist"],["album"])
          x.instance_variable_set :@id, song["id"].to_i
          x
        end
      end
      #add a parameter that allows you to pass in criteria
      #for a song
      def get_all_songs
        result = @db.exec(%q[
          SELECT * FROM songs;
          ])
        build_a_song(result.entries)
        #result.map { |r| build_song(r)}
        #this way we don't have to do this in the build song
        #method
      end
      
      def save_a_song(*song)
        song.each do |song|
         result = @db.exec(%q[
            INSERT INTO songs (title, artist, album)
            VALUES ($1, $2, $3)
            RETURNING id;
            ], [song.title, song.artist, song.album])
          song.instance_variable_set :@id, result.entries.first["id"].to_i 
        end        
      end
  
      def delete_a_song(song_id)
        @db.exec(%q[
          DELETE FROM songs
          WHERE id = $1;
          ], [song_id])
      end
    end
  end
end