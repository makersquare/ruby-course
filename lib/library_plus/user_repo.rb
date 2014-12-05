module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      # TODO: Insert SQL statement
      db.exec("SELECT * FROM users WHERE id = #{user_id};").first
    end

    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
        db.exec("UPDATE users SET name = '#{user_data['name']}' WHERE id = #{user_data['id']}")
      else
        # TODO: Insert SQL statement
        db.exec("INSERT INTO users (name) VALUES ('#{user_data['name']}');")
      end
      db.exec("SELECT * FROM users;").first
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
