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
        user_id = user_data['id']
        sql = %q[
          UPDATE users
          SET name = ($1)
          WHERE id = ($2)
        ]
        db.exec(sql,[user_name,user_id])
        result = db.exec('SELECT name, id FROM users WHERE id = ($1)',[user_id])
        result.entries[0]
      else
        db.exec("INSERT INTO users (name) VALUES ($1)",[user_data['name']])
        result = db.exec("SELECT name, id FROM users WHERE name = ($1)", [user_name])
        result.entries[0]
      end
    end

    def self.destroy(db, user_id)
      sql = %q[
        DELETE FROM users
        WHERE id = ($1)
      ]
      db.exec(sql,[user_id])
    end

  end
end
