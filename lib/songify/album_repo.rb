module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      genres = []
      item = db.exec("SELECT albums.id as id, albums.title as title, array_to_string(array_agg(genres.name), ',') as genre,  array_to_string(array_agg(genres.id), ',') as genre_id 
      FROM albums,song_genres, genres 
      WHERE song_genres.album_id = $1 AND albums.id = $1 AND song_genres.genre_id = genres.id 
      GROUP BY albums.id", [album_id]).first
     
      res = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      if (item != nil)
        genre_list = item['genre'].split(',')
        genre_ids = item['genre_id'].split(',')
        for i in 0..(genre_list.size - 1)
          genres << {'id' => genre_ids[i], 'name' => genre_list[i]}
        end
        res['genres'] = genres
      end

      return res

    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'].to_i, album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        album_data
        if (album_data["genre_ids"] != nil)
          album_data["genre_ids"].each do |g|
            db.exec("INSERT INTO song_genres (album_id, genre_id) VALUES ($1, $2)", [album_data['id'], g])
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
