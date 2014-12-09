module Songify
  class AlbumRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM albums").to_a
      #r2 = db.exec("SELECT genres.name FROM genres g JOIN albumgenres ag ON ag.genre_id = g.id WHERE a.id = $1", [album_id])
    end

    def self.find(db, album_id)
      r1 = db.exec("SELECT * FROM albums WHERE id=$1", [album_id]).first
      
      q =  <<-SQL 
      SELECT
      ag.album_id,
      g.name
      FROM genres g
      JOIN albumgenres ag 
      ON g.id = ag.genre_id
      WHERE ag.album_id=$1
      SQL

      r2 = db.exec(q, [album_id]).to_a
      r1['genres'] = []

      r2.each do |genre|
        r1['genres'].push(genre['name'])
      end
      return r1
    end

    def self.save(db, album_data)
      if album_data['id']
        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        album_data["genre_ids"].each do |genre_id|
          db.exec("INSERT INTO albumgenres (album_id, genre_id) VALUES ($1, $2)", [album_data["album_id"], genre_id])
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
