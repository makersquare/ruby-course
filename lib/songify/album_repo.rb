module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

     def self.find(db, album_id)
      genres = []
      result = db.exec("SELECT * FROM albums WHERE id = $1", [album_id]).first
      if result
        album_genres = db.exec("SELECT * FROM album_genres a JOIN genres g ON g.id = a.genre_id WHERE a.album_id = $1", [album_id]).to_a
        album_genres.each do |line|
          genres << {'id' => line['genre_id'], 'name' => line['name']}
        end
        result['genres'] = genres
      end
      result
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      elsif album_data['genre_ids']
        album_id = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']]).first
        album_data['id'] = album_id['id']
        album_data['genre_ids'].each do |genre|
          db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2)", [album_id['id'], genre])
        end
        album_id
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

    def self.all_songs_by_album(db, album_id)
      sql = %q[
            SELECT s.title FROM songs s
            JOIN albums a
            ON a.id = s.album_id
            WHERE album_id = $1]
      db.exec(sql, [album_id]).to_a
    end 

    def self.all_songs_join_albums(db)
      sql = %q[
            SELECT s.title as song, a.title FROM songs s 
            JOIN albums a
            ON a.id = s.album_id
          ]
      db.exec(sql).to_a
    end


    def self.count_songs_join_albums(db)
          sql = %q[
                select  a.id, a.title, count(s.id) as numberOfSongs
                from albums a LEFT OUTER join songs s
                ON a.id = s.album_id
                group by a.title, a.id ;
              ]
      db.exec(sql).to_a
    end 

  end
end
