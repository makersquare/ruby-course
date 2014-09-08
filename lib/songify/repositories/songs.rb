require 'pg'
module Songify
  module Repositories
    class Songs
      def initialize 
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end
      # songid
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
      def get_song(song_id)
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1
        ], [song_id])
        songs_obj(result.first)
      end
      # no parameter needed
      def get_all_songs
        result = @db.exec('SELECT * FROM songs')
        result.map do |song|
          songs_obj(song)
        end
      end

      def save_song(song)
        result = @db.exec(%q[
          INSERT INTO songs (title, artist, album)
          VALUES ($1, $2, $3)
          RETURNING id;
        ], [song.title, song.artist, song.album])
        song.instance_variable_set :@id, result.entries.first["id"]

      end
      # songid
      def delete_song(song_id)
         @db.exec(%q[
          DELETE FROM songs 
          WHERE id = $1
          ], [song_id])
      end

      def truncate_song
        @db.exec("TRUNCATE TABLE songs")
      end
      
      def songs_obj(data)
        x = Songify::Song.new(data["title"], data["artist"], data["album"])
        x.instance_variable_set :@id, data["id"].to_i
        x
      end


    end
  end
end