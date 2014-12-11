module Petshop
  class UsersRepo
    # find a user by user ID. Intended to be used when
    # someone is already authenticated. We keep their
    # user id in the cookie.
    def self.find db, user_id
      sql = %q[SELECT * FROM users WHERE id = $1]
      result = db.exec(sql, [user_id])
      result.first
    end

    # find user by username. Intended to be used when
    # someone tries to sign in.
    def self.find_by_name db, username
      sql = %q[SELECT * FROM users WHERE username = $1]
      result = db.exec(sql, [username])
      result.first
    end

    # when someone signs up use this method to save their
    # information in the db. we're not encrypting passwords.
    def self.save db, user_data
      sql = %q[INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *]
      result = db.exec(sql, [user_data[:username], user_data[:password]])
      result.first
    end
    def self.adopt db, user_data
      sql = %q[INSERT INTO users (type, user_id, pet_id) VALUES ($1, $2, $3) RETURNING *]
      result = db.exec(sql, user_data[:type]], [user_data[:id], user_data[:pet_id]])
      result.first
    end
    def self.save db, user_data
      sql = %q[INSERT INTO pet_adptions (username, password) VALUES ($1, $2) RETURNING *]
      result = db.exec(sql, [user_data[:username], user_data[:password]])
      result.first
    end
  end
end
