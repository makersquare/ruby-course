module Petshops
  class UserRepo
    def self.all(db)
      db.exec('SELECT name, id FROM users').entries
    end

    def self.find_by_id(db, id)
      sql = %q[SELECT name FROM users where id = $1]
      db.exec(sql, [id]).entries.first
    end

    def self.save(db, user_data)
      if user_data['id']
        sql = %q[UPDATE users SET password = $2 where id = $1]
        result = db.exec(sql, user_data['id'], user_data['password'])
        result.entries.first
      else
        sql = %q[INSERT INTO users (name, password) values ($1, $2) returning *]
        result = db.exec(sql, [user_data['name'], user_data['password']])
        result.entries.first
      end
    end

    def self.find_by_name(db, user_name)
      sql = %q[SELECT name, password, id FROM users where name = $1]
      result = db.exec(sql, [user_name])
      result.entries.first
    end

  end
end