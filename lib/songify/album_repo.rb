module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
    end

    def self.save(db, album_data)
      if album_data['id']
        if album_data["genres"]
         db.exec("UPDATE albums SET title = $1 WHERE id = $2", [album_data["title"], album_data['id']])
          album_data["genres"].each{|g|
         db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2)", [album_data['id'], g])
        }
        else
          result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
          self.find(db, album_data['id'])
      end
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        puts album_data
        album_data["genres"].each{|g|
          db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2)", [album_data['id'], g])
        }

      end
    end

    def self.destroy(db, album_id)
      # TODO: Delete SQL statement
      #  ALSO DELETE SONGS
      #  ALSO DELETE JOIN TABLE ENTRIES BETWEEN THIS ALBUM AND ITS GENRES
    end
  end
end
