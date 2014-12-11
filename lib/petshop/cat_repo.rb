require 'pry-byebug'

module Petshop
  class ShopRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      # TODO: This has to be a JOIN table
      result = db.exec("SELECT * FROM shops").to_a
    end

    def self.find(db, shop_id)
      # TODO: This has to be a JOIN table

      shop = db.exec("SELECT * FROM shops WHERE id=$1", [shop_id]).first
    end

    def self.save(db, shop_data)
      if shop_data['id'] # Edit Shop

        # Ensure album exists
        album = find(db, album_data['id'])
        raise "A valid album_id is required." if album.nil?

        result = db.exec("UPDATE albums SET title = $2 WHERE id = $1", [album_data['id'], album_data['title']])
        self.find(db, album_data['id'])
      else
        raise "title is required." if album_data['title'].nil? || album_data['title'] == ''
        result = db.exec("INSERT INTO albums (title) VALUES ($1) RETURNING id", [album_data['title']])
        album_data['id'] = result.entries.first['id']
        if album_data['genre_ids']
          album_data['genre_ids'].each do |genre_id|
            result = db.exec("INSERT INTO album_genres (album_id, genre_id) VALUES ($1, $2) RETURNING id", [album_data['id'], genre_id])
          end
        end
        album_data
      end
    end

    def self.destroy(db, album_id)
      # Delete SQL statement
      db.exec("DELETE FROM songs WHERE album_id = $1", [album_id])
      db.exec("DELETE FROM album_genres WHERE album_id = $1", [album_id])
      db.exec("DELETE FROM albums WHERE id = $1", [album_id])
    end

  end
end
