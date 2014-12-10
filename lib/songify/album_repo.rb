module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      result = db.exec("SELECT * FROM albums WHERE id=$1;", [album_id]).first
      if result
        genres = db.exec("Select genres.name, genres.id from song_genres Join genres on (song_genres.genre = genres.id) WHERE album_id = $1;", [album_id]).to_a
        genres_array = []
        genres.each do |genre|
          genres_array << genre
        end
        result['genres'] = genres_array
      end
      result
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        album_data
      end
      if album_data['genre_ids']
        album_data['genre_ids'].each do |genre|
          db.exec("INSERT INTO song_genres (album_id, genre) VALUES ($1, $2) RETURNING genre;", [album_data['id'], genre])
        end
      genres = db.exec("Select genres.name from song_genres Join genres on (song_genres.genre = genres.id) WHERE album_id = $1;", [album_data['id']]).to_a
      genres_array = []
      genres.each do |genre|
        genres_array << genre['name']
      end
      album_data['genres'] = genres_array
      end
      album_data
    end

    def self.destroy(db, album_id)
      # TODO: Delete SQL statement
      #  ALSO DELETE SONGS
      #  ALSO DELETE JOIN TABLE ENTRIES BETWEEN THIS ALBUM AND ITS GENRES
    end

  end
end