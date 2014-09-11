require 'pg'

module Songify
  module Repositories
    class Songs

      def initialize(db_name)
        @db = PG.connect(host: 'localhost', dbname: db_name)
        build_table
      end

      def build_table
        @db.exec(%q[
            CREATE TABLE IF NOT EXISTS songs (
              id serial,
              title text,
              artist text,
              album text,
              genre_id integer REFERENCES genres (id)
              )
          ])
      end

      def drop_and_rebuild_table
        @db.exec("DROP TABLE songs")
        build_table
      end

      def drop_table
        @db.exec("DROP TABLE songs")
      end

      # parameter should be a song object
      def save_a_song(song, genre)
        result = @db.exec(%q[
            INSERT INTO songs (title, artist, album, genre_id)
            VALUES ($1, $2, $3, $4)
            RETURNING id;
          ], [song.title, song.artist, song.album, genre.id])
          
          song.instance_variable_set :@id, result.first['id'].to_i
      end

      # parameter could be song id
      def get_a_song(id)
        result = @db.exec(%q[
            SELECT * FROM songs 
            WHERE id = $1;
          ], [id])

        build_song(result.first)
      end

      # no parameter needed here
      def get_all_songs
        result = @db.exec('SELECT * FROM songs;')
        result.map { |r| build_song(r)}
      end

      # parameter could be song id
      def delete_a_song(id)
        result = @db.exec(%q[
          DELETE FROM songs 
          WHERE id = $1;
        ], [id])
      end

      def delete_all
        @db.exec("DELETE FROM songs")
      end

      def build_song(song)
        x = Songify::Song.new(song['title'], song['artist'], song['album'], song['genre_id'])
        x.instance_variable_set :@id, song['id'].to_i
        x
      end

    end
  end
end