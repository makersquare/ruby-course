module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      # if album_id.count > 1
      #   db.exec("SELECT * FROM album_genres WHERE album_id = $1", [album_id]).first
      # else
        result = db.exec("SELECT * FROM albums WHERE id = $1", [album_id]).first
        genres = db.exec("SELECT * FROM album_genres WHERE album_id = $1", [album_id]).first
        result
      # end
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      elsif album_data['genre_ids']
        album_id = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']]).first
        album_data['genre_ids'].each do |genre|
          puts album_id['id']
          puts genre
          result = db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2)", [album_id['id'], genre])
        end
        puts result.first
        album = {'id' => album_id, 'genres' => album_data['genre_ids']}
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        album_data
      end
    end

    def self.destroy(db, album_id)
      # TODO: Delete SQL statement
      #  ALSO DELETE SONGS
      #  ALSO DELETE JOIN TABLE ENTRIES BETWEEN THIS ALBUM AND ITS GENRES
    end

  end
end
