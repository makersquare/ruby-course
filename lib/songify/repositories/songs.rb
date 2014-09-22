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
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            title text,
            artist text,
            album text,
            genre_id int references genres
            )
          ])
      end

      #this is only for testing purposes
      def drop_table
        @db.exec("TRUNCATE TABLE songs")
        build_table
      end

      #Paramter could be song id
      def get_a_song(song_id)
        result = @db.exec('SELECT * FROM songs WHERE id = $1', [song_id])
        build_song_object(result.entries.first)
      end

      #No parameter needed
      def get_all_songs
        result = @db.exec('SELECT * FROM songs')
        result.entries.map do |song|
          build_song_object(song)
        end
      end

      #Parameter should be a song object
      def save_a_song(song_object)
        result = @db.exec(%q[
          INSERT INTO songs (title, artist, album, genre_id)
          VALUES ($1, $2, $3, $4)
          RETURNING id;
        ], [song_object.title, song_object.artist, song_object.album, song_object.genre_id])
        song_object.instance_variable_set :@id, result.entries.first["id"]
      end

      #Parameter should be ID unique to each song object
      def delete_a_song(song_id)
        result = @db.exec('DELETE FROM songs WHERE id = $1', [song_id])
      end

      #Parameter should be an artist
      def get_songs_by_genres(genre_id)
        result = @db.exec('SELECT * FROM songs WHERE genre_id = $1', [genre_id])
        result.entries.map do |song|
          build_song_object(song)
        end
      end

      def build_song_object(entries)
        x = Songify::Song.new(entries["title"], entries['artist'], entries['album'], entries['genre_id'].to_i)
        x.instance_variable_set :@id, entries['id'].to_i
        x
      end
    end
  end
end
