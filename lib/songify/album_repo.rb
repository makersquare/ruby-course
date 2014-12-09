module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      db.exec("SELECT * FROM albums WHERE id = $1", [album_id]).first
    end

    def self.find_genres(db, album_id)
      sql = %Q[
        SELECT 
          albums.title, 
          genres.name
        FROM 
          album_genres, 
          genres, 
          albums
        WHERE 
          album_genres.genres_id = genres.id AND
          album_genres.album_id = $1
      ]
      result = db.exec(sql, [album_id])
      result.each {|r| p r}
      puts result.flatten
    end

    def self.save(db, album_data)
      #puts album_data
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        #puts "album result", result.entries.first
        album_data['id'] = result.entries.first['id']

        if album_data["genre_ids"]
          sql = %Q[
            insert into album_genres
            (album_id, genres_id)
            values ($1, $2)
          ]
          album_data["genre_ids"].each do |g_id|
            p album_data["id"].to_i, g_id.to_i
            db.exec(sql, [album_data["id"].to_i, g_id.to_i])
          end
        end

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
