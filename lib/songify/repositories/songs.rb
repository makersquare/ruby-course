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
#changed after solution
      def build_song(data) 
        x = Songify::Song.new(data["title"], data["artist"], data["genre"])
        x.instance_variable_set :@id, data["id"].to_i  
        x   
      end

      def save_song(song)
        result = @db.exec(%q[
        INSERT INTO songs (title, artist, genre) VALUES
          ($1, $2, $3) RETURNING id;], [song.title, song.artist, song.genre])

        song.id = result.entries.first["id"].to_i
      end
      
#changed after solution
      def get_song(id)
       result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;], [id])
        build_song(result.first) 
      end

#changed this after solution
      def get_all_songs
        result = @db.exec('SELECT * FROM songs;')
        result.map {|r| build_song(r) } 
      end

      def delete_song(id)
        @db.exec(%q[
          DELETE FROM songs where id = $1;], [id])
      end

    end
  end
end