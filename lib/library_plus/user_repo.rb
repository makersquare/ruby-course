module Library
  class UserRepo
    #library::UserRepo.(method)
    def self.all(db)
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      db.exec("SELECT * FROM users WHERE id = $1", [user_id]).first
    end
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
    end

    def self.destroy(db, user_id)
      sql = %[
          DELETE FROM users WHERE id = $1
      ]
      db.exec_params(sql, [user_id['id']])
    end

  end
end

# akjhdskjhfklsfh
# lkjsfdkjhsklj
#lkshfkdjfhlskdjfhlsdkjfhdslkjfhdslkjfhdlkfhj