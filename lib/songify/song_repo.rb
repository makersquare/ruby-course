module Songify
  class SongRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM songs").to_a
    end

    def self.find(db, song_id)
      db.exec("SELECT * FROM songs WHERE id=$1", [song_id]).first
    end

    def self.save(db, song_data)
      if song_data['id']
        result = db.exec("UPDATE songs SET title = $2 WHERE id = $1", [song_data['id'], song_data['title']])
        self.find(db, song_data['id'])
      else
        raise "title is required." if song_data['title'].nil? || song_data['title'] == ''

        # Ensure album exists
        album = AlbumRepo.find(db, song_data['album_id'])
        raise "A valid album_id is required." if album.nil?

        result = db.exec("INSERT INTO songs (title, album_id) VALUES ($1, $2) RETURNING id", [song_data['title'], song_data['album_id']])
        song_data['id'] = result.entries.first['id']
      end
    end
    def self.all_with_album(db)
      r = db.exec <<-SQL 
      SELECT s.id, 
              s.title AS song_title,
               a.title AS album_title
                FROM songs s 
                JOIN albums a 
                on s.album_id = a.id
                SQL
      r.to_a
    end
  end
end
