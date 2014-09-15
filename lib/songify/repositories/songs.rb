require 'PG'

module Songify
  module Repositories
    class Songs
      def initialize(dbname)
        @db = PG.connect(host: 'localhost', dbname: dbname)
        build_table
      end

      def build_song(song)
        s = Songify::Song.new(song["title"],song["artist"],song["album"],song["genre_id"])
        s.instance_variable_set :@id, song['id'].to_i
        s
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
              id serial,
              title text,
              artist text,
              album text,
              genre_id integer REFERENCES genres (id)
            )
          ])
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE IF EXISTS songs CASCADE
          ])
        build_table
      end

      def show_a_song(song)
        requested_song = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;
          ], [song.id])
        build_song(requested_song.first)
      end

      def show_all_songs
        requested_songs = @db.exec(%q[
          SELECT * FROM songs
          ])
        requested_songs.map { |s| build_song(s) }
      end

      def save_a_song(song,genre)
        response = @db.exec(%q[
          INSERT INTO songs(title,artist,album,genre_id)
          VALUES ($1,$2,$3,$4)
          RETURNING id;
          ], [song.title,song.artist,song.album,genre.id])
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