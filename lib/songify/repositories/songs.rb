require 'PG'

module Songify
  module Repositories
    class Songs
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      def build_song(entries)
        entries.map do |song|
          s = Songify::Song.new(song["title"],
                                song["artist"],
                                song["album"],
                                song["genre"])
          s.instance_variable_set :@id, song["id"].to_i
          s
        end
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
              id serial,
              title text,
              artist text,
              album text,
              genre text
            )
          ])
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE IF EXISTS songs
          ])
      end

      def show_a_song(song)
        requested_song = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;
          ], [song.id])
        build_song(requested_song.entries)
      end

      def show_all_songs
        requested_songs = @db.exec(%q[
          SELECT * FROM songs
          ])
        build_song(requested_songs.entries)
      end

      def save_a_song(song)
        response = @db.exec(%q[
          INSERT INTO songs(title,artist,album,genre)
          VALUES ($1,$2,$3,$4)
          RETURNING id;
          ], [song.title,song.artist,song.title,song.genre])
        song.instance_variable_set :@id, response.first['id'].to_i
      end

      def delete_a_song(song)
        @db.exec(%q[
          DELETE FROM songs
          WHERE id = $1;
          ], [song.id])
      end
    end
  end
end