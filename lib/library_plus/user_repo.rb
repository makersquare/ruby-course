module Library
  class UserRepo
    #library::UserRepo.(method)
    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_data)
      # TODO: Insert SQL statement
    end
    # create, update
    # 
    def self.save(db, user_data)
      if user_data['id']
        sql = %q[
          UPDATE users SET name = $1 WHERE id = $2 RETURNING *
        ]
        db.exec_params(sql,[user_data['name'],user_data['id']]).first
      else
        sql = %q[
          INSERT INTO users (name) 
            VALUES ($1) RETURNING *
          ]
        db.exec_params(sql,[user_data['name']]).first
      end
      # id_return = db.exec("SELECT * FROM users WHERE name = $1", [user_data['name']])
      # id_return.first
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end
