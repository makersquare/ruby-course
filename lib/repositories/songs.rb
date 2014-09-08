require 'pg'

module Songify
  module Repositories
    class Songs

      def initialize
        @db = PG.connect(host:'localhost', dbname:'songify')
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

      # def build_songs(entries)
      #   entries.map do |song|
      #     x = Songify::Song.new(song["title"], song["artist"], song["album"])
      #     x.instance_variable_set :@id, song["id"].to_i
      #     x
      #   end
      # end

      def build_song(data)
        x = Songify::Song.new(data['title'], data['artist'], data['album'])
        x.instance_variable_set :@id, data['id'].to_i
        x
      end


      # parameter could be song id
      def get_a_song(song_id)
        result = @db.exec("SELECT * FROM songs WHERE id=($1)", [song_id])
        build_song(result.first)
      end

      # no parameter needed
      def get_all_songs
        result = @db.exec("SELECT * FROM songs")
        # build_songs(result.entries)
        result.map { |r| build_song(r) }
      end

      # paramter should be song object
      def save_a_song(song)
        @db.exec(%q[
          INSERT INTO songs(title, artist, album)
          VALUES ($1, $2, $3)
        ], [song.title, song.artist, song.album])
      end

      # parameter could be song id
      def delete_a_song(song_id)
        @db.exec("DELETE FROM songs WHERE id=($1)", [song_id])
      end

    end
  end
end