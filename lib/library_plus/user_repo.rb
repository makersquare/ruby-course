module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      # TODO: Insert SQL statement
    end

    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
        db.exec_params("UPDATE users SET name = $2 WHERE id= $1 ",[user_data["id"],user_data[:name]])
      else
        # TODO: Insert SQL statement
        db.exec_params("INSERT INTO users (name) VALUES ($1)",[user_data[:name]])
      end
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
