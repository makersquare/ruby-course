require "pg"

module Songify
  module Repo
    class Songs

      def initialize
        @db = PG.connect(host: "localhost", dbname: "songify")
        build_table
      end

#table will be songs

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
          id serial,
          title text,
          artist text,
          genre text
          )
        ])
      end

      def drop_table
        @db.exec("DROP TABLE songs")
        build_table
      end

      def build_song(entries)
        entries.map do |song|
        x = Songify::Song.new(song["title"], song["artist"], song["genre"])
        x.instance_variable_set :@id, song["id"].to_i  
        x
      end   
      end

      def log
        result = @db.exec('SELECT * FROM songs;')
        build_song(result.entries)
      end

      def save_song(song)
        result = @db.exec(%q[
        INSERT INTO songs (title, artist, genre) VALUES
          ($1, $2, $3) RETURNING id;], [song.title, song.artist, song.genre])

        song.id = result.entries.first["id"].to_i
      end

      def get_song(id)
       result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;], [id])
        build_song(result.entries)
      end

      def get_all_songs
        result = @db.exec('SELECT * FROM songs;')
        build_song(result.entries)
      end

      def delete_song(id)
        @db.exec(%q[
          DELETE FROM songs where id = $1;], [id])
      end

    end
  end
end