require 'pg'

module Songify
  module Repos
    class Songs

      def initialize
        @db = PG.connect(host:'localhost',dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            title text,
            artist text,
            album text,
            year_published int,
            rating int
            )
          ])
      end

      def drop_table
        @db.exec(%q[DROP TABLE songs])
        build_table
      end

      def save_a_song(song)
        result = @db.exec(%q[
          INSERT INTO songs (title,artist,album,year_published,rating)
          VALUES ($1,$2,$3,$4,$5)
          RETURNING id
          ], [song.title,song.artist,song.album,song.year_published,song.rating])
        song.id = result.entries.first["id"].to_i
      end

      def get_a_song(id)
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1
          ], [id])
        build_song(result.entries)
      end

      def get_all_songs
        result = @db.exec('SELECT * FROM songs')
        build_song(result.entries)
      end

      def delete_a_song(id)
        result = @db.exec(%q[
          DELETE FROM songs WHERE id = $1
          RETURNING *
          ], [id])
        build_song(result.entries)
      end

      def build_song(entries)
        entries.map do |song_hash|
          x = Songify::Song.new(
            title:song_hash["title"], 
            artist:song_hash["artist"],
            album:song_hash["album"],
            year_published:song_hash["year_published"].to_i,
            rating:song_hash["rating"]
            )
          x.id = song_hash["id"].to_i
          x
        end
      end

    end
  end
end

      # def update_request_status(request)
      #   @db.exec(%q[
      #     UPDATE requests
      #     SET status = $1
      #     WHERE id = $2;
      #   ], [request.status,request.id])
      # end

