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

    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
      else
        userID = ((user_data[:name].hash)/10000000000).abs  
        r = db.exec("INSERT INTO users (id, name) VALUES (#{userID}, '#{user_data[:name]}')")
        return db.exec("SELECT * FROM users WHERE id = #{userID}").to_a[0]

      end
    end

    def self.destroy(db, user_data)
      if(user_data['id'])
        db.exec("DELETE FROM users WHERE  id = #{user_data['id']}")
      else
        db.exec("DELETE FROM users WHERE  name = #{user_data['name']}")
      end

    end
  end
end
