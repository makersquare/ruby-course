require 'securerandom'

module Chatitude
  class UsersRepo
    def self.find db, user_id
      sql = %q[SELECT * FROM users WHERE id = $1]
      result = db.exec(sql, [user_id])
      result.first
    end

    def self.find_by_name db, username
      sql = %q[SELECT * FROM users WHERE username = $1]
      result = db.exec(sql, [username])
      result.first
    end

    def self.find_by_token db, token
      sql = %q[
        SELECT
          u.id
          , u.username
          , u.password
        FROM sessions s
        JOIN users u
        ON s.user_id = u.id
        WHERE s.token = $1
      ]
      result = db.exec(sql, [token])
      result.first
    end

    def self.save db, user_data
      sql = %q[INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *]
      result = db.exec(sql, [user_data[:username], user_data[:password]])
      result.first
    end

    def self.sign_in db, id
      token = SecureRandom.hex(16)
      sql = %q[INSERT INTO sessions (user_id, token) VALUES ($1, $2)]
      result = db.exec(sql, [id, token])
      token
    end

    def self.sign_out db, token
      db.exec("DELETE FROM sessions WHERE token = $1", [token])
    end
  end
end
