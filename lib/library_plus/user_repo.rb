module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_data)
      # find user by id
      sql = %Q[
        select *
        from users
        where id = $1
      ]
      result = db.exec(sql, [user_data])

      return result.first
    end

    def self.save(db, user_data)
      # update user data if user exists, otherwise create new user
      if user_data.include?(:id)
        sql_users = %Q[
          UPDATE users
          set name =$1
          where id = $2
          returning *
        ]
        result = db.exec(sql_users, [user_data[:name], user_data[:id]])
      else
        sql_insert_user = %Q[
          insert into users 
          (name)
          values ($1)
          returning *
        ]
        result = db.exec(sql_insert_user, [user_data[:name]])
      end
      
      return result.first
    end

    def self.destroy(db, user_data)
      sql = %Q[
        delete from users
      ]
      db.exec(sql)
    end

  end
end
