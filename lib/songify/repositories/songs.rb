require 'pg'

module Songify
  module Repos
    class Songs

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            title text,
            artist text,
            album text,
            genre text,
            length text
          )
        ])
      end

      def drop_table
        @db.exec("DROP TABLE IF EXISTS songs")
        build_table
      end

      def log
        result = @db.exec('SELECT * FROM songs ORDER BY id ASC;')
        build_songs(result.entries)
      end

      def build_songs(entries)
        entries.map do |song|
          x = Songify::Song.new(song["title"], song["artist"], song["album"], song["genre"], song["length"])
          x.instance_variable_set :@id, req["id"].to_i
          x
        end
      end

      #parameter could be song id
      def get_song

      end

      #no parameter needed
      def get_all_songs

      end

      #parameter should be song object
      def save_song(song)

      end

      #parameter could be song id
      def delete_song(song)

      end
      
    end
  end
end