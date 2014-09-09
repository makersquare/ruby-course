module Songify
  module Repos
    class Songs

      def add(song) # C-reate
        cmd = "INSERT INTO songs (song_name, artist, album) VALUES ($1, $2, $3) RETURNING id"
        result = Repos.db.exec(cmd, [song.song_name, song.artist, song.album])
        song.instance_variable_set("@song_id", result[0]["id"].to_i)
      end

      def delete(song) # D-elete
        cmd = "DELETE FROM songs WHERE id = ($1)"
        Repos.db.exec(cmd, [song.song_id])
      end

      def get(song) # R-ead
        cmd = "SELECT * FROM songs WHERE id = ($1)"
        result = Repos.db.exec(cmd, [song.song_id]).entries
        Songify::Song.new(result[0]["song_name"], result[0]["artist"], result[0]["album"], result[0]["id"].to_i)
      end
      
      def get_all # R-ead
        cmd = "SELECT * FROM songs"
        result = Repos.db.exec(cmd)

        result.map do |song|
          Songify::Song.new(song["song_name"], song["artist"], song["album"], song["id"].to_i)
        end  

      end

    end
  end
end