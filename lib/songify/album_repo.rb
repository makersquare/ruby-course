require 'pry-byebug'

module Songify
  class AlbumRepo

    def self.add_genres(db, album_data)
      album_id = album_data['id']
      album_data['genre_ids'].each do |genre_id|
        db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2)", [album_id, genre_id])
      end
    end

    def self.all(db)
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
      db.exec("DELETE FROM album_genres WHERE album_id = $1", [album_id])
      db.exec("DELETE FROM songs WHERE album_id = $1", [album_id])
      db.exec("DELETE FROM albums WHERE id = $1", [album_id])
    end

  end
end
