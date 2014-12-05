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
      if user_data["id"]
        sql_users = %Q[
          SELECT *
          FROM users
          WHERE id = user[:id]
        ]
        db.exec sql
      else
        # prepared statement
        statement_insert_user = %Q[
          insert into users 
          (name)
          values ($1)
        ]
        db.prepare("insert_user", statement_insert_user)
        # execute prepared statement
        db.exec_prepared("insert_user", [user_data[:name]])
      end
      # grab the user via query and return it
      sql_users = %Q[
          SELECT *
          FROM users
          WHERE name = $1
        ]
      users = db.exec(sql_users, [user_data[:name]])
      users.first
    end

    def self.destroy(db, user_data)
      # TODO: Delete SQL statement
    end

  end
end
