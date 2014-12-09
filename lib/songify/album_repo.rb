module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      response = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      # result = db.exec("SELECT * FROM albums_genres WHERE album_id = $1", [album_id])
      # final = {}
      result = db.exec("SELECT g.name FROM albums_genres x JOIN genres g ON x.genre_id = g.id JOIN albums a ON x.album_id = a.id WHERE x.album_id = $1", [album_id]).to_a
      if result[0]
        final_genre = []
        result.each do |x|
          final_genre << x 
        end
        response['genres'] = final_genre
        return response
      end
      response
    end

    def self.find_id(db, album_title)
      db.exec("SELECT * FROM albums WHERE title=$1", [album_title]).first
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
          album_data['genre_ids'].each do |genre|
            db.exec("INSERT INTO albums_genres (album_id, genre_id) VALUES ($1, $2)", [album_data['id'], genre])
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
