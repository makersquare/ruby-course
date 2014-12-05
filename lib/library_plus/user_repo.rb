module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      result = db.exec('SELECT name, id FROM users WHERE id = ($1)',[user_id])
      result.entries[0]
    end

    def self.save(db, user_data)
      user_name = user_data['name']
      if user_data['id']
        find(db, user_data)
      else
        db.exec("INSERT INTO users (name) VALUES ($1)",[user_data['name']])
        result = db.exec("SELECT name, id FROM users WHERE name = ($1)", [user_name])
        result.entries[0]
      end
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
