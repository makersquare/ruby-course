require 'pry-byebug'

module PetShop
  class ShopRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      # TODO: This has to be a JOIN table
      result = db.exec("SELECT * FROM shops").to_a
    end

    def self.find(db, shopid)
      # TODO: This has to be a JOIN table

      shop = db.exec("SELECT * FROM shops WHERE id=$1", [shopid]).first
    end

    def self.save(db, shop_data)
      if shop_data['id'] # Edit Shop

        # Ensure shop exists
        shop = find(db, shop_data['id'])
        raise "A valid shop id is required." if shop.nil?

        result = db.exec("UPDATE shops SET name = $2 WHERE id = $1", [shop_data['id'], shop_data['name']])
        self.find(db, shop_data['id'])
      else
        raise "shop name is required." if shop_data['name'].nil? || shop_data['name'] == ''
        result = db.exec("INSERT INTO shops (name) VALUES ($1) RETURNING *", [shop_data['name']])
        self.find(db, result.entries.first['id'])
      end
    end

    def self.destroy(db, shopid)
      # Delete SQL statement
      db.exec("DELETE FROM cats WHERE shopid = $1", [shopid])
      db.exec("DELETE FROM dogs WHERE shopid = $1", [shopid])
      db.exec("DELETE FROM shops WHERE id = $1", [shopid])
    end

  end
end
