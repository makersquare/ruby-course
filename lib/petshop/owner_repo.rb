require 'pry-byebug'

module Petshop
  class OwnerRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      result = db.exec("SELECT * FROM owners").to_a
    end

    def self.find(db, owner_id)
      owner = db.exec("SELECT * FROM owners WHERE id=$1", [owner_id]).first
    end

    def self.save(db, owner_data)
      if owner_data['id'] # Edit owner

        # Ensure owner exists
        owner = find(db, owner_data['id'])
        raise "A valid owner id is required." if owner.nil?

        if owner_data['name'] # Update Owner Name
          result = db.exec("UPDATE owners SET name = $2 WHERE id = $1", [owner_data['id'], owner_data['name']])
        end

        if owner_data['password'] # Update Owner Password
          result = db.exec("UPDATE owners SET password = $2 WHERE id = $1", [owner_data['id'], owner_data['password']])
        end
        self.find(db, owner_data['id'])
      else
        raise "name is required." if owner_data['name'].nil? || owner_data['name'] == ''
        raise "password is required." if owner_data['password'].nil? || owner_data['password'] == ''
        result = db.exec("INSERT INTO owners (name, password) VALUES ($1, $2) RETURNING *", [owner_data['name'], owner_data['password']])
        self.find(db, result.entries.first['id'])
      end
    end

    def self.destroy(db, owner_id)
      # Delete SQL statement
      db.exec("UPDATE cats SET owner_id = null, adopted_status = false WHERE owner_id = $1", [owner_id])
      db.exec("UPDATE dogs SET owner_id = null, adopted_status = false WHERE owner_id = $1", [owner_id])
      db.exec("DELETE FROM owners WHERE id = $1", [owner_id])
    end

  end
end
