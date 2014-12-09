module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      album = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
#       sql = %q[
#         SELECT genres.name
#         FROM album_genres
#         INNER JOIN genres
#         ON genres.id = album_genres.genre_id
#         INNER JOIN albums
#         ON albums.id = album_genres.album_id
#         where albums.id = $1
#       ]
#       album['genres'] = db.exec(sql, [album_id]).entries
      album
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        
#         if ablum_data['genres']
#           sql = %q[
#             INSERT INTO album_genres(album_id, genre_id)
#             VALUES ($1,$2)
#             ]
#             album_data['genres'].each do |genre|
#               db.exec(sql, [album_id, genre])
#             end
#         end
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
