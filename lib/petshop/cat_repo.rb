require 'pry-byebug'

module Petshop
  class CatsRepo

    def self.all(db)
      result = db.exec("SELECT * FROM cats").to_a
    end

    def self.find(db, cat_id)
      shop = db.exec("SELECT * FROM cats WHERE id=$1", [cat_id]).first
    end

    def self.find_all_by_shop(db, shop_id)
      cats = db.exec("SELECT * FROM cats WHERE shop_id=$1", [shop_id]).to_a
    end

    def self.save(db, cat_data)
      if cat_data['id'] # Update

        # Ensure cat exists
        cat = find(db, cat_data['id'])
        raise "A valid cat_id is required." if cat.nil?
        raise "A valid owner_id is required." if cat.nil?

        #Assign owner
        result = db.exec("UPDATE cats SET owner_id = $2, adopted_status = $3 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['adopted_status']])
        self.find(db, cat_data['id'])
      else
        raise "name is required." if cat_data['name'].nil? || cat_data['name'] == ''
        raise "shop_id is required." if cat_data['shop_id'].nil? || cat_data['shop_id'] == ''
        raise "imageUrl is required." if cat_data['imageUrl'].nil? || cat_data['imageUrl'] == ''
        result = db.exec("INSERT INTO cats (name, shop_id, imageUrl, adopted_status) values ($1, $2, $3, false); RETURNING id", [dog_data['id'], dog_data['shop_id'], dog_data['imageUrl']])
        cat_data['id'] = result.entries.first['id']
        cat_data
      end
    end

    def self.destroy(db, cat_id)
      # Delete SQL statement
      db.exec("DELETE FROM cats WHERE id = $1", [cat_id])
    end

  end
end