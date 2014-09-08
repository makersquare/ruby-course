module Songify
  module Repositories
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
            album text
          )
        ])
      end

      def drop_table
        @db.exec("DROP TABLE songs")
        build_table
      end

      # parameter could be song id
      def get_a_song
      end

      # no parameter needed
      def get_all_songs
      end

      # parameter should be song object
      def save_a_song(song)
      end

      # parameter could be song id
      def delete_a_song
      end

      # helper method to build song objects
      def build_song
      end
    end
  end
end