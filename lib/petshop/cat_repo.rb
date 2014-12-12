require 'pry-byebug'

module PetShop
  class CatRepo

    def self.all(db)
      result = db.exec("SELECT * FROM cats").to_a
    end

    def self.find(db, cat_id)
      cat = db.exec("SELECT * FROM cats WHERE id=$1", [cat_id]).first
    end

    def self.find_all_by_shop(db, shopid)
      cats = db.exec("SELECT * FROM cats WHERE shopid=$1", [shopid]).to_a
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
        if cat_data['adopted'] && cat_data['name']
          result = db.exec("UPDATE cats SET owner_id = $2, adopted = $3, name = $4 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['adopted'], cat_data['name']])
        elsif cat_data['name']
          result = db.exec("UPDATE cats SET owner_id = $2, name = $3 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['name']])
        elsif cat_data['adopted']
          result = db.exec("UPDATE cats SET owner_id = $2, adopted = $3 WHERE id = $1", [cat_data['id'], cat_data['owner_id'], cat_data['adopted']])
        end
        self.find(db, cat_data['id'])
      else # Create a New Cat
        raise "name is required." if cat_data['name'].nil? || cat_data['name'] == ''
        raise "shopid is required." if cat_data['shopid'].nil? || cat_data['shopid'] == ''
        raise "imageurl is required." if cat_data['imageurl'].nil? || cat_data['imageurl'] == ''
        result = db.exec("INSERT INTO cats (name, shopid, imageurl, adopted) values ($1, $2, $3, 'false') RETURNING id", [cat_data['name'], cat_data['shopid'], cat_data['imageurl']])
        self.find(db, result.entries.first['id'])
      end
    end

    def self.destroy(db, cat_id)
      # Delete SQL statement
      db.exec("DELETE FROM cats WHERE id = $1", [cat_id])
    end

  end
end
