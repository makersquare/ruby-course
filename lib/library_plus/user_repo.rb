module Library
  class UserRepo


    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      # TODO: Insert SQL statement

      result = db.exec("SELECT * FROM users WHERE id = $1", [user_id])
      result.entries[0]

    end

    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
        name = user_data['name']
        id = user_data['id']
        db.exec("UPDATE movies SET name = $1 WHERE id = $2", [name, id])
        new_data = Library::UserRepo.find(db, id)
        new_data

      else
        # TODO: Insert SQL statement
        name = user_data['name']
        returned = db.exec("INSERT into users (name) VALUES ($1) returning id", [name])
        # new_data = Library::UserRepo.find(db, id)
        user_data['id'] = returned.entries[0]['id'].to_i
        # require 'pry-byebug'; binding.pry
        user_data
      end
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
