require 'pg'

module Songify
  module Repositories
    class Song_Repo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songify')
        build_table
      end

      def build_table
        @db.exec(%q[CREATE TABLE IF NOT EXISTS songs (
          id serial,
          title text,
          artist text,
          album text);])
        
      end

      def drop_table
        @db.exec('DROP TABLE songs;')
        build_table
      end

      def build_songs(entries)
        entries.map do  |song|
          artist = song["artist"]
          album = song["album"]
          title = song["title"]
          id = song["id"]
          song = Songify::Song.new(title, artist, album)
          song.instance_variable_set(:@id, id.to_i) 
          song
        end
      end

      def entries
        result = @db.exec(%q[SELECT * FROM songs])
        result = result.entries
      end

      
      def get_song(id)
        song = @db.exec(%q[SELECT * FROM songs
          WHERE id = ($1);], [id])
        build_songs(song)[0]
      end

      
      def get_all_songs
        build_songs(entries)
      end

      def save_song(song)
        @db.exec(%q[INSERT INTO songs
          (title, artist, album)
          VALUES ($1,$2,$3);],
          [song.title, song.artist, song.album])
      end

    
      def delete_song(id)
        @db.exec(%q[DELETE FROM songs
          WHERE id = ($1);], [id])
      end


    end
  end
end