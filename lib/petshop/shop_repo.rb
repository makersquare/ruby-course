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

        # Ensure shop exists
        shop = find(db, shop_data['id'])
        raise "A valid shop_id is required." if shop.nil?

        result = db.exec("UPDATE shops SET title = $2 WHERE id = $1", [shop_data['id'], shop_data['title']])
        self.find(db, shop_data['id'])
      else
        raise "title is required." if shop_data['title'].nil? || shop_data['title'] == ''
        result = db.exec("INSERT INTO shops (title) VALUES ($1) RETURNING *", [shop_data['title']])
        self.find(db, result.entries.first['id'])
      end
    end

    def self.destroy(db, shop_id)
      # Delete SQL statement
      db.exec("DELETE FROM cats WHERE shop_id = $1", [shop_id])
      db.exec("DELETE FROM dogs WHERE shop_id = $1", [shop_id])
      db.exec("DELETE FROM shops WHERE id = $1", [shop_id])
    end

  end
end
