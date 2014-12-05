# Library::UserRepo.all(db)
# Library::BookRepo.all(db)

module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      db.exec("SELECT * FROM users WHERE id = #{user_id}").entries.last
    end

    def self.save(db, user_data)
      if user_data['id']
          # Update Name
          db.exec("UPDATE users SET name = '#{user_data['name']}' WHERE id = #{user_data['id']}")
      else
          # Enter Name and Unique ID gets assigned automatically
          db.exec("INSERT INTO users (name) VALUES ('#{user_data['name']}')")
      end
      get_users(db, user_data).last
    end

    def self.destroy(db, user_id)
      db.exec("DELETE FROM users WHERE id = #{user_id}")
    end

    def self.get_users(db, user_data)
      if user_data['id']
        db.exec("SELECT * FROM users WHERE id = #{user_data['id']}").entries
      else
        db.exec("SELECT * FROM users WHERE name = '#{user_data['name']}'").entries 
      end
    end

  end
end
