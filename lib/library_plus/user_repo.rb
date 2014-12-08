# Library::UserRepo.all(db)
#Library::BookRepo.all(db) 

module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      # TODO: Insert SQL statement
      db.exec("SELECT * FROM users WHERE id = $1", [user_id]).to_a[0]
    end

    #Libary::UserRepo.save(db, {'id' => "1"})
    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
        db.exec("UPDATE users SET name = $1 WHERE id = $2 returning *", [user_data['name'], user_data['id']]).to_a[0]
      else
        # TODO: Insert SQL statement
        db.exec("INSERT INTO users (name) VALUES ($1) returning *", [user_data['name']]).to_a[0]
        
      end
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
