module Library
  class UserRepo


    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      # TODO: Insert SQL statement
      id = user_id['id']
      db.exec("SELECT * FROM users WHERE id = $4", [id])
    end

    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
        name = user_data['name']
        id = user_data['id']
        db.exec("UPDATE movies SET name = $1 WHERE id = $2", [name, id])
        new_data = Library::UserRepo.find(db, id)

      else
        # TODO: Insert SQL statement
        name = user_data['name']
        db.exec("INSERT into users (name) VALUES ($1)", [name])
      end
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
