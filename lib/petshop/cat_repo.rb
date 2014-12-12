require 'pry-byebug'

module PetShop
  class CatRepo

    def self.all(db)
      result = db.exec("SELECT * FROM cats").to_a
    end

    def self.find(db, cat_id)
      cat = db.exec("SELECT * FROM cats WHERE id=$1", [cat_id]).first
    end

    def self.find_all_by_shop(db, shop_id)
      cats = db.exec("SELECT * FROM cats WHERE shop_id=$1", [shop_id]).to_a
    end

    def self.find_all_by_owner(db, owner_id)
      cats = db.exec("SELECT * FROM cats WHERE owner_id=$1", [owner_id]).to_a
    end

    def self.save(db, cat_data)
      if cat_data['id'] # Update an Existing Cat

        # Ensure cat exists
        cat = find(db, cat_data['id'])
        raise "A valid cat_id is required." if cat.nil?

        owner = find(db, cat_data['owner_id'])
        raise "A valid owner_id is required." if owner.nil?

        #Assign owner
        if cat_data['adopted_status'] && cat_data['name']
          result = db.exec("UPDATE cats SET owner_id = $2, adopted_status = $3, name = $4 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['adopted_status'], cat_data['name']])
        elsif cat_data['name']
          result = db.exec("UPDATE cats SET owner_id = $2, name = $3 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['name']])
        elsif cat_data['adopted_status']
          result = db.exec("UPDATE cats SET owner_id = $2, adopted_status = $3 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['adopted_status']])
        end
        self.find(db, cat_data['id'])
      else # Create a New Cat
        raise "name is required." if cat_data['name'].nil? || cat_data['name'] == ''
        raise "shop_id is required." if cat_data['shop_id'].nil? || cat_data['shop_id'] == ''
        raise "imageUrl is required." if cat_data['imageUrl'].nil? || cat_data['imageUrl'] == ''
        result = db.exec("INSERT INTO cats (name, shop_id, imageUrl, adopted_status) values ($1, $2, $3, false) RETURNING id", [cat_data['name'], cat_data['shop_id'], cat_data['imageUrl']])
        self.find(db, result.entries.first['id'])
      end
    end

    def self.destroy(db, cat_id)
      # Delete SQL statement
      db.exec("DELETE FROM cats WHERE id = $1", [cat_id])
    end

  end
end
