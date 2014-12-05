module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_data)
      db.exec("SELECT * FROM users WHERE id = #{user_data}").to_a[0]
    end

    def self.save(db, user_data)
      if user_data['id']
          db.exec("UPDATE users SET name = '#{user_data['name']}' WHERE id = #{user_data['id']} returning *").to_a[0]
      else
          db.exec("INSERT INTO users (name) VALUES ('#{user_data['name']}') returning *").to_a[0]
      end
    end

    def self.destroy(db, user_data)
        r = db.exec("DELETE FROM users WHERE  id = #{user_data}")
        return r.cmd_status()

    end
  end
end
