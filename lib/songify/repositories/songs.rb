require "pg"

module Songify
  module Repo
    class Songs

      def initialize(db_name)
        @db = PG.connect(host: "localhost", dbname: db_name)
        build_table
      end

#table will be songs

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
        @db.exec("DROP TABLE IF EXISTS songs cascade")
        build_table
      end

#changed after solution
      def build_song(data) 
        x = Songify::Song.new(data["title"], data["artist"], data["album"])
        x.instance_variable_set :@id, data["id"].to_i
        x.instance_variable_set :@genre_id, data["genre_id"].to_i  
        x   
      end

      def save_song(song)
        result = @db.exec(%q[
        INSERT INTO songs (title, artist, album, genre_id) VALUES
          ($1, $2, $3, $4) RETURNING id;], 
          [song.title, song.artist, song.album, song.genre_id])

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

      def select_song_by_genre(genre)
        result = @db.exec(%q[SELECT * FROM songs WHERE genre_id = $1;], [genre.id])
        final_result = result.map {|r| build_song(r) }
        final_result # just added this in 
      end

    end
  end
end