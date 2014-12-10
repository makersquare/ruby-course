module Songify
  class GenreRepo
    def self.albums(db, genre_id)
      db.exec("SELECT g.name AS genre, a.title AS title, a.id AS album_id, g.id AS genre_id FROM genres g JOIN album_genres j ON g.id = j.genre_id JOIN albums a ON a.id = j.album_id WHERE g.id = $1", [genre_id])
    end

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM genres").to_a
    end

    def self.find(db, genre_id)
      db.exec("SELECT * FROM genres WHERE id=$1", [genre_id]).first
    end

    def self.genres_by_album(db, album_id)
      db.exec("SELECT g.name, g.id FROM album_genres a JOIN genres g ON g.id = a.genre_id WHERE a.album_id = $1", [album_id]).to_a
    end

    def self.save(db, genre_data)
      if genre_data['id']
        result = db.exec("UPDATE genres SET name = $2 WHERE id = $1", [genre_data['id'], genre_data['name']])
        self.find(db, genre_data['id'])
      else
        raise "name is required." if genre_data['name'].nil? || genre_data['name'] == ''

        result = db.exec("INSERT INTO genres (name) VALUES ($1) RETURNING id", [genre_data['name']])
        genre_data['id'] = result.entries.first['id']
        genre_data
      end
    end

    def self.destroy(db, genre_id)
      # TODO: Delete SQL statement
      #  ALSO DELETE JOIN TABLE ENTRIES BETWEEN THIS GENRE AND ITS ALBUMS
      db.exec("DELETE FROM album_genres WHERE genre_id = $1", [genre_id])
      db.exec("DELETE FROM genres WHERE id = $1", [genre_id])
    end

  end
end
