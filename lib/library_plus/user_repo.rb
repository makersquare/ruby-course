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
      # update user data if user exists, otherwise create new user
      if user_data[:id]
        sql_users = %Q[
          UPDATE users
          set name =$1
          where id = $2
          returning *
        ]
        result = db.exec sql_users, user_data[:name], user_data[:id]
      else
        # prepared statement
        statement_insert_user = %Q[
          insert into users 
          (name)
          values ($1)
          returning *
        ]
        db.prepare("insert_user", statement_insert_user)
        # execute prepared statement
        result = db.exec_prepared("insert_user", [user_data[:name]])
      end
      
      return result.first
    end

    def self.destroy(db, user_data)
      # TODO: Delete SQL statement
    end

  end
end
