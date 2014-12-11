module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
    end

    def self.find(db, album_id)
      album_result = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      album_info = db.exec("SELECT g.name, g.id FROM genres g JOIN album_genres ag ON g.id = ag.genre_id JOIN albums a ON a.id = ag.album_id WHERE ag.album_id = $1", [album_id]).to_a
      if album_info[0]
        final_genre = []
        album_info.each do |a|   #Push the album_info Hash
        final_genre.push(a)       #Array of Hashes { "(genre)id" => "x", "(genre)name" => "y"}, in this case, just one Hash
        end
      album_result['genres'] = final_genre
      return album_result
      end
      album_result
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id']) #Brings back the first HASH
      else
        if album_data['title'].nil? || album_data['title'] == ''
          raise Errors::InvalidRecordData.new("title is required.")
        end

        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        
        if album_data['genre_ids']
          album_data['genre_ids'].each do |genre|
            db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2) RETURNING id", [album_data['id'], genre])
          end
        end
        album_data  #Returns this
      end
    end

    def self.destroy(db, album_id)
      # TODO: Delete SQL statement
      #  ALSO DELETE SONGS
      #  ALSO DELETE JOIN TABLE ENTRIES BETWEEN THIS ALBUM AND ITS GENRES
    end

  end
end
