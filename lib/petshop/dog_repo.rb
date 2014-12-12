require 'pry-byebug'

module PetShop
  class DogRepo

    def self.all(db)
      result = db.exec("SELECT * FROM dogs").to_a
    end

    def self.find(db, dog_id)
      dog = db.exec("SELECT * FROM dogs WHERE id=$1", [dog_id]).first
    end

    def self.find_all_by_shop(db, shop_id)
      dogs = db.exec("SELECT * FROM dogs WHERE shop_id=$1", [shop_id]).to_a
    end

    def self.find_all_by_owner(db, owner_id)
      dogs = db.exec("SELECT * FROM dogs WHERE owner_id=$1", [owner_id]).to_a
    end

    def self.save(db, dog_data)
      if dog_data['id'] # Update

        # Ensure dog exists
        dog = find(db, dog_data['id'])
        raise "A valid dog_id is required." if dog.nil?
        raise "A valid owner_id is required." if dog.nil?

        #Assign owner
        if dog_data['adopted_status'] && dog_data['name']
          result = db.exec("UPDATE dogs SET owner_id = $2, adopted_status = $3, name = $4 WHERE id = $1", [dog_data['id'], dog_data['owner_id'], dog_data['adopted_status'], dog_data['name']])
        elsif dog_data['name']
          result = db.exec("UPDATE dogs SET owner_id = $2, name = $3 WHERE id = $1", [dog_data['id'], dog_data['owner_id'], dog_data['name']])
        elsif dog_data['adopted_status']
          result = db.exec("UPDATE dogs SET owner_id = $2, adopted_status = $3 WHERE id = $1", [dog_data['id'], dog_data['owner_id'], dog_data['adopted_status']])
        end
        self.find(db, dog_data['id'])
      else
        raise "name is required." if dog_data['name'].nil? || dog_data['name'] == ''
        raise "shop_id is required." if dog_data['shop_id'].nil? || dog_data['shop_id'] == ''
        raise "imageUrl is required." if dog_data['imageUrl'].nil? || dog_data['imageUrl'] == ''
        result = db.exec("INSERT INTO dogs (name, shop_id, imageUrl, adopted_status) values ($1, $2, $3, false) RETURNING id", [dog_data['name'], dog_data['shop_id'], dog_data['imageUrl']])
        self.find(db, result.entries.first['id'])
      end
    end

    def self.destroy(db, dog_id)
      # Delete SQL statement
      db.exec("DELETE FROM dogs WHERE id = $1", [dog_id])
    end

  end
end
