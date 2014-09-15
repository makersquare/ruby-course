require 'pg'

module Songify
  module Repositories
    class Songs

      # Helper method. Builds song entry.
      def build_song(entry)
        x = Songify::Song.new(
            entry["title"], 
            entry["artist"], 
            entry["album"]
        )
        x.instance_variable_set :@year, entry["year"].to_i
        x.instance_variable_set :@genre_id, entry["genre_id"]
        x.instance_variable_set :@rating, entry["rating"].to_i
        x.instance_variable_set :@id, entry["id"].to_i
        x
      end

      # Parameter should be a song object.
      def save_song(song)
        save = Songify::Repositories.adapter.exec(%q[
          INSERT INTO songs (title, artist, album, year, genre_id, rating) 
          VALUES ($1, $2, $3, $4, $5, $6)
          RETURNING id;
        ], [song.title, song.artist, song.album, song.year, song.genre_id, song.rating])
        song.instance_variable_set :@id, save.entries.first["id"].to_i
      end

      # Parameter should be song ID.
      def delete_song(id)
        delete = Songify::Repositories.adapter.exec(%q[
          DELETE FROM songs WHERE id = $1;
        ], [id])
      end

      # Parameter should be song ID.
      def get_a_song(id)
        get_1 = Songify::Repositories.adapter.exec(%q[
          SELECT * FROM songs WHERE id = $1;
        ], [id])
      end

      # Attribute argument must be a symbol.
      def get_songs_by(attribute, keyword)
        song = nil
        if attribute == :title
          song = Songify::Repositories.adapter.exec(%q[
            SELECT * FROM songs WHERE title = $1;
          ], [keyword])
        elsif attribute == :artist
          song = Songify::Repositories.adapter.exec(%q[
            SELECT * FROM songs WHERE artist = $1;
          ], [keyword])
        elsif attribute == :album
          song = Songify::Repositories.adapter.exec(%q[
            SELECT * FROM songs WHERE album = $1;
          ], [keyword])
        elsif attribute == :year
          song = Songify::Repositories.adapter.exec(%q[
            SELECT * FROM songs WHERE year = $1;
          ], [keyword])
        elsif attribute == :genre_id
          song = Songify::Repositories.adapter.exec(%q[
            SELECT * FROM songs WHERE genre_id = $1;
          ], [keyword])
        elsif attribute == :rating
          song = Songify::Repositories.adapter.exec(%q[
            SELECT * FROM songs WHERE rating = $1;
          ], [keyword])
        end
        # build_song(song)
      end

      # No parameter needed.
      def get_all_songs
        get_all = Songify::Repositories.adapter.exec('SELECT * FROM songs;')
        get_all.map { |song| build_song(song) }
      end

      # Save multiple songs at once
      def save_multiple_songs(*songs)
        songs.each do |song|
          save = Songify::Repositories.adapter.exec(%q[
          INSERT INTO songs (title, artist, album, year, genre_id, rating) 
          VALUES ($1, $2, $3, $4, $5, $6)
          RETURNING id;
        ], [song.title, song.artist, song.album, song.year, song.genre_id, song.rating])
        song.instance_variable_set :@id, save.entries.first["id"].to_i
      end

        # Keepin' it weird
        # base = "INSERT INTO songs (title, artist, album, year, genre, rating) values "
        # values = songs.map do |song| 
        #   title = song.title.gsub(';', '')
        #   artist = song.artist.gsub(';', '')
        #   album = song.album.gsub(';', '')
        #   if !song.year.is_a? Fixnum && song.year != nil
        #     year = song.year.gsub(';', '')
        #   end
        #   if song.genre != nil
        #     genre = song.genre.gsub(';', '')
        #   end
        #   if song.rating != nil
        #     rating = song.rating.gsub(';', '')
        #   end
        #   "('#{title}', '#{artist}', '#{album}')" 
        # end
        # sql = base + values.join(',') + "RETURNING id"
        # result = Songify::Repositories.adapter.exec(sql)
        # songs.each_with_index do |song, index|
        #   song.instance_variable_set :@id, result[index]['id'].to_i
        # end
      end
    end
  end
end