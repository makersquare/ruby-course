# Library::UserRepo.all(db)

module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
     db.exec("select * from users where id = #{user_id}")[0]
    end
#create, update
# Library::UserRepo.save(db, {'name' => "Alice"})
# Library::UserRepo.save(db, {'id' => "Alice"}) update
    def self.save(db, user_data)
      if user_data['id']
        db.exec("UPDATE users SET name = '#{user_data['name']}'  WHERE id = #{user_data['id']} returning *")[0]
        
      else
        db.exec("INSERT into users (name) values ($1) returning *", [user_data['name']])[0]
      end
    end

    def self.destroy(db, user_id)
     db.exec("DELETE FROM users WHERE id = #{user_id}")
    end

  end
end
