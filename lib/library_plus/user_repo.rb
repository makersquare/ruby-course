module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_data)
      # TODO: Insert SQL statement
    end

    #Library::UserRepo.save(db, { 'name' => "alice"})
    #Library::UserRepo.save(db, {'id' => 1, 'name => "Alice"})

    def self.save(db, user_data)
      x = 0
      if user_data['id']
        # TODO: Update SQL statement
        db.exec("UPDATE users SET name = $1 WHERE id = $2", [user_data['name'], user_data['id']])
      else
        # TODO: Insert SQL statement
        db.exec("INSERT into users (name) values ($1)", [user_data['name']])
      end
    end

    def self.destroy(db, user_data)
      # TODO: Delete SQL statement
    end

  end
end
