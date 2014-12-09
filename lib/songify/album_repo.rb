module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      album = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      genres = db.exec('SELECT * FROM album_genres WHERE album_id = $1',[album_id]).entries
      if genres.length > 0 
        sql = %q[
          SELECT genres.name
          FROM album_genres
          INNER JOIN genres
          ON genres.id = album_genres.genre_id
          INNER JOIN albums
          ON albums.id = album_genres.album_id
          where albums.id = $1
        ]
        
        album['genres'] = db.exec(sql, [album_id]).entries
      end
      album
    end

    def self.save(db, album_data)
      album_title = album_data['title']
      
      if album_data['id']
        sql = %q[
          UPDATE albums
          SET title = $2
          WHERE id = $1
        ]
        result = db.exec(sql, [album_data['id'], album_title])
        self.find(db, album_data['id'])
        
      else
        if album_title.nil? || album_title == ''
          raise Errors::InvalidRecordData.new("title is required.")
        end
        sql2 = %q[
          INSERT INTO albums (title)
          VALUES ($1)
          RETURNING id;
        ]
        album_id = db.exec(sql2, [album_title]).entries.first['id']

        if album_data['genre_ids']
          sql3 = %q[
            INSERT INTO album_genres(album_id, genre_id)
            VALUES ($1,$2)
            ]
            album_data['genre_ids'].each do |id|
              db.exec(sql3, [album_id, id])
            end
        end
        album_data['id'] = album_id
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
