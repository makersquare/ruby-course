module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      result = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      if result
        newresult = db.exec("SELECT albums.title, albums.id, albums_genres.genre_id, genres.name FROM albums, albums_genres, genres WHERE albums.id = albums_genres.album_id AND genres.id = albums_genres.genre_id AND albums.id=$1;", [album_id]).to_a
        genres = []
        newresult.each do |entry|
          genres << {"name" => entry['name'], "id" => entry["genre_id"]}
        end
        result['genres'] = genres 
      end
      puts result
      result
    end

    def self.albums_with_songs(db)
      db.exec("select count(songs.album_id), albums.title , albums.id FROM songs, albums WHERE songs.album_id = albums.id GROUP BY albums.title, albums.id;")
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
        if album_data['genre_ids']
          album_data['genre_ids'].each do |genre_id|
            db.exec("INSERT INTO albums_genres (album_id, genre_id) VALUES ($1, $2)", [album_data['id'], genre_id])
          end
        end
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


