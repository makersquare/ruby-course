require 'pg'

module Songify
  module Repositories
    class Songs

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[
            CREATE TABLE IF NOT EXISTS songs (
              id serial,
              title text,
              artist text,
              album text
              )
          ])
      end

      def drop_and_rebuild_table
        @db.exec("DROP TABLE songs")
        build_table
      end

      # parameter should be a song object
      def save_a_song(song)
        result = @db.exec(%q[
            INSERT INTO songs (title, artist, album)
            VALUES ($1, $2, $3)
            RETURNING id;
          ], [song.title, song.artist, song.album])
          
          song.instance_variable_set :@id, result.entries.first['id']
      end

      # no parameter needed here
      def get_all_songs
        result = @db.exec('SELECT * FROM songs;')
        build_song(result.entries)
      end

      # parameter could be song id
      def get_a_song(id)
        result = @db.exec(%q[
            SELECT * FROM songs 
            WHERE id = $1;
          ], [id])
        build_song(result.entries)
      end

      # parameter could be song id
      def delete_a_song(id)
          result = @db.exec(%q[
          DELETE FROM songs 
          WHERE id = $1;
        ], [id])
        build_song(result.entries)
      end

      def build_song(entries)
        entries.map do |song|
          x = Songify::Song.new(song['title'], song['artist'], song['album'], song['id'].to_i)
          x
        end
      end

    end
  end
end