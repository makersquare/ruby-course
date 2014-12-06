module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      result = db.exec("SELECT * FROM users WHERE id = $1;", [user_id])
      result.first
      # TODO: Insert SQL statement
    end

    def self.save(db, user_data)
      if user_data['id']
        result = db.exec("UPDATE users SET name = $1 WHERE id = $2 RETURNING *;",[user_data['name'], user_data['id']])
        # TODO: Update SQL statement
      else
        result = db.exec("INSERT INTO users (name) VALUES ($1) RETURNING *;", [user_data['name']])
        # TODO: Insert SQL statement
      end
      result.first

    end

    def self.destroy(db, user_id)
      db.exec("DELETE FROM users WHERE id = $1;", [user_id])

      # TODO: Delete SQL statement
    end

  end
end