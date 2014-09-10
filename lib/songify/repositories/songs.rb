require 'pg'

module Songify
  module Repositories
    class Songs

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      # Builds songs table.
      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id SERIAL,
            title TEXT,
            artist TEXT,
            album TEXT,
            year INT,
            genre TEXT,
            rating INT
          );
        ])
      end

      # Resets songs table for testing.
      def drop_and_rebuild_table
        @db.exec(%q[
          DROP TABLE IF EXISTS songs;
        ])
        build_table
      end

      # Helper method. Builds song entry.
      def build_song(entry)
        x = Songify::Song.new(
            entry["title"], 
            entry["artist"], 
            entry["album"]
        )
        x.instance_variable_set :@year, entry["year"].to_i
        x.instance_variable_set :@genre, entry["genre"]
        x.instance_variable_set :@rating, entry["rating"].to_i
        x.instance_variable_set :@id, entry["id"].to_i
        x
      end

      # Parameter should be a song object.
      def save_song(song)
        save = @db.exec(%q[
          INSERT INTO songs (title, artist, album, year, genre, rating) 
          VALUES ($1, $2, $3, $4, $5, $6)
          RETURNING id;
        ], [song.title, song.artist, song.album, song.year, song.genre, song.rating])
        song.instance_variable_set :@id, save.entries.first["id"].to_i
      end

      # Parameter should be song ID.
      def delete_song(id)
        delete = @db.exec(%q[
          DELETE FROM songs WHERE id = $1;
        ], [id])
        # build_song(delete)
      end

      # Parameter should be song ID.
      def get_a_song(id)
        get_1 = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1;
        ], [id])
        # build_song(get_1.entries)
      end

      # Attribute argument must be a symbol.
      def get_songs_by(attribute, keyword)
        song = nil
        if attribute == :title
          song = @db.exec(%q[
            SELECT * FROM songs WHERE title = $1;
          ], [keyword])
        elsif attribute == :artist
          song = @db.exec(%q[
            SELECT * FROM songs WHERE artist = $1;
          ], [keyword])
        elsif attribute == :album
          song = @db.exec(%q[
            SELECT * FROM songs WHERE album = $1;
          ], [keyword])
        elsif attribute == :year
          song = @db.exec(%q[
            SELECT * FROM songs WHERE year = $1;
          ], [keyword])
        elsif attribute == :genre
          song = @db.exec(%q[
            SELECT * FROM songs WHERE genre = $1;
          ], [keyword])
        elsif attribute == :rating
          song = @db.exec(%q[
            SELECT * FROM songs WHERE rating = $1;
          ], [keyword])
        end
        build_song(song)
      end

      # No parameter needed.
      def get_all_songs
        get_all = @db.exec('SELECT * FROM songs;')
        get_all.map { |song| build_song(song) }
      end

      # Save multiple songs at once
      def save_multiple_songs(*songs)
        # songs.each do |song|
        #   save = @db.exec(%q[
        #   INSERT INTO songs (title, artist, album, year, genre, rating) 
        #   VALUES ($1, $2, $3, $4, $5, $6)
        #   RETURNING id;
        # ], [song.title, song.artist, song.album, song.year, song.genre, song.rating])
        # song.instance_variable_set :@id, save.entries.first["id"].to_i

        # Keepin' it weird
        base = "INSERT INTO songs (title, artist, album, year, genre, rating) values "
        values = songs.map do |song| 
          title = song.title.gsub(';', '')
          artist = song.artist.gsub(';', '')
          album = song.album.gsub(';', '')
          year = song.year.gsub(';', '')
          genre = song.genre.gsub(';', '')
          rating = song.rating.gsub(';', '')
          "('#{title}', '#{artist}', '#{album}')" 
        end
        sql = base + values.join(',') + "RETURNING id"
        result = @db.exec(sql)
        songs.each_with_index do |song, index|
          song.instance_variable_set :@id, result[index]['id'].to_i
        end
      end
    end
  end
end