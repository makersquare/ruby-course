module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      item = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      if item
      sql = %q[
          SELECT g.name, g.id 
          FROM song_genres s
          JOIN genres g ON g.id = s.genre_id
          WHERE s.album_id = $1
      ]
      result = db.exec(sql, [album_id])
      genres = []
        result.entries.each do |x|
         genres << x
        end
        item['genres'] = genres
      end
      item
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1 RETURNING *", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        album_data
        if album_data.has_key?('genre_ids')
          album_data['genre_ids'].each do |x|
              db.exec("INSERT INTO song_genres (album_id, genre_id) VALUES ($1, $2) RETURNING *", [album_data['id'],x])
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