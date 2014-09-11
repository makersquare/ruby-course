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
        @db.exec("DROP TABLE songs")
        build_table
      end

      # parameter could be song id
      def get_a_song(id)
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1
        ], [id])
        if result.entries.size > 0
          build_song(result.first)
        else
          nil
        end
      end

      # no parameter needed
      def get_all_songs
        result = @db.exec(%q[
          SELECT * FROM songs
        ])
        result.map { |song| build_song(song) }
      end

      # parameter should be song object
      def save_a_song(song)
        result = @db.exec(%q[
          INSERT INTO songs (title, artist, album)
          VALUES ($1, $2, $3)
          returning id
        ], [song.title, song.artist, song.album])
        song.instance_variable_set("@id", result[0]["id"].to_i)
      end

      # parameter is song object so i can set id back to nil once deleted
      def delete_a_song(id)
        @db.exec(%q[
          DELETE FROM songs WHERE id = $1
        ], [id])
      end

      # helper method to build song objects
      def build_song(song)
        x = Songify::Song.new(song["title"], song["artist"], song["album"])
        x.instance_variable_set :@id, song["id"].to_i
        x
      end
    end
  end
end