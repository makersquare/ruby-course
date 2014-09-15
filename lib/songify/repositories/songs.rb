require 'pg'

module Songify
  module Repos
    class Songs

      def initialize(db_name='songify_dev')
        @db = PG.connect(host: 'localhost', dbname: db_name)
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            title text,
            artist text,
            album text,
            genre_id int REFERENCES genres(id)
          );
        ])
      end

      def drop_table
        @db.exec("DROP TABLE IF EXISTS songs CASCADE;")
        build_table
      end

      def get_song(song_id)
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;
        ], [song_id])

        build_songs(result.entries).first
      end

      def get_all_songs
        result = @db.exec('SELECT * FROM songs ORDER BY id ASC;')
        build_songs(result.entries)
      end

      def save_song(song, genre)
        result = @db.exec(%q[
          INSERT INTO songs (title, artist, album, genre_id)
          VALUES ($1, $2, $3, $4)
          RETURNING id;
        ], [song.title, song.artist, song.album, genre.id])

        song.id = result.entries.first["id"].to_i
        song.genre_id = result.entries.first["genre_id"].to_i
      end

      def delete_song(song_id)
        @db.exec(%q[
          DELETE FROM songs
          WHERE id = $1;
        ], [song_id])
      end

      def build_songs(entries)
        entries.map do |song|
          x = Songify::Song.new(song["title"], song["artist"], song["album"])
          x.instance_variable_set :@id, song["id"].to_i
          x.instance_variable_set :@genre_id, song["genre_id"].to_i
          x
        end
      end
      
    end
  end
end