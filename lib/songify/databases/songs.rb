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
            rating int,
            genre_id int REFERENCES genres (id)
            )
          ])
      end

      def drop_table
        @db.exec(%q[DROP TABLE songs])
        build_table
      end

      def save_a_song(song)
        genre_id = Songify.genres.save_a_genre(Songify::Genre.new(song.genre))

        result = @db.exec(%q[
          INSERT INTO songs (title,artist,album,year_published,rating,genre_id)
          VALUES ($1,$2,$3,$4,$5,$6)
          RETURNING id
          ], [song.title,song.artist,song.album,song.year_published,song.rating, genre_id])
        song.instance_variable_set :@id, result.entries.first["id"].to_i
      end

      def get_a_song(id)
        result = @db.exec(%q[
          SELECT * FROM songs WHERE id = $1
          ], [id])
        build_song(result.entries).first
      end

      def get_all_songs
        result = @db.exec('SELECT * FROM songs')
        build_song(result.entries)
      end

      def get_all_songs_by(parameter)
        colname = parameter.keys.first.to_s.gsub(/;/, ' ')
        value = parameter.values.first.gsub(/;/, ' ')
        sql = "SELECT * FROM songs WHERE #{colname} = '#{value}'"
        
        result = @db.exec(sql)
        build_song(result.entries)
      end      

      def delete_a_song(id)
        result = @db.exec(%q[
          DELETE FROM songs WHERE id = $1
          RETURNING *
          ], [id])
        build_song(result.entries).first
      end

      def delete_all
        @db.exec("DELETE FROM songs")
      end

      def build_song(entries)
        entries.map do |song_hash|
          genre = Songify.genres.get_a_genre(song_hash["genre_id"]).genre
          x = Songify::Song.new(
            title:song_hash["title"], 
            artist:song_hash["artist"],
            album:song_hash["album"],
            year_published:song_hash["year_published"].to_i,
            rating:song_hash["rating"].to_i
            )
          x.instance_variable_set :@id, song_hash["id"].to_i
          x.instance_variable_set :@genre, genre
          x
        end
      end

    end
  end
end

##################################
# bad code for get_all_songs_by versions
              #USING search_term
        # result = @db.exec(%q[
        #   EXECUTE 'SELECT * FROM songs
        #     WHERE %col = $1', argument)
        #     USING search_term
        #   ]#, [search_term,argument]
        #   )
        # build_song(result.entries)
          # EXECUTE format('SELECT * FROM songs
          #   WHERE %col = %sea')
            
          # ],[argument,search_term]
          # )
        # EXECUTE 'UPDATE tbl SET '
        # || quote_ident(colname)
        # || ' = '
        # || quote_nullable(newvalue)
        # || ' WHERE key = '
        # || quote_nullable(keyvalue);

####################################
# bad code for putting in multiple songs at once
# base = "INSERT INTO songs (title,artist,album,year_published,rating) VALUES "
        # values = songs.map do |x|
        #   song_string ="('#{x.title}', '#{x.artist}', '#{x.album}', '#{x.year_published.to_s}', '#{x.rating.to_s}')"
        # end
        # safe_values = values.map {|x| x.gsub(/[;']/, ' ')}

        # #that will strip out all the possible semi-colons for sanitization purposes

        # sql = base + safe_values.join(",") + "RETURNING id"

        # result = @db.exec(sql)
        # songs.each_with_index do |song,i|
        #   song.instance_variable_set :@id, result.entries[i]["id"].to_i
        # end








