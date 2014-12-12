module Petshops
  class UserRepo
    def self.all(db)
      db.exec('SELECT username, id FROM users').entries
    end

    def self.find_by_id(db, id)
      sql = %q[SELECT username FROM users where id = $1]
      db.exec(sql, [id]).entries.first
    end

    def self.save(db, user_data)
      if user_data['id']
        sql = %q[UPDATE users SET password = $2 where id = $1]
        result = db.exec(sql, user_data['id'], user_data['password'])
        result.entries.first
      else
        sql = %q[INSERT INTO users (username, password) values ($1, $2) returning *]
        result = db.exec(sql, [user_data['username'], user_data['password']])
        result.entries.first
      end
    end

    def self.find_by_name(db, user_name)
      sql = %q[SELECT * FROM users where username = $1]
      result = db.exec(sql, [user_name])
      result.entries.first
    end
    
    def self.grab_all_pets(db, user_id)
      cats = CatRepo.find_by_owner_id(db, user_id)
      dogs = DogRepo.find_by_owner_id(db, user_id)
      cats << dogs
    end

  end
end