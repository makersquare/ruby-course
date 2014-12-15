module Petshopserver

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
    def self.find_by_username db, username
      sql = %q[SELECT * FROM users WHERE username = $1]
      result = db.exec(sql, [username])
      result.first
    end

    # when someone signs up use this method to save their
    # information in the db. we're not encrypting passwords.
    def self.save db, user_data
      sql = %q[INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *]
      result = db.exec(sql, [user_data['username'], user_data['password']])
      result.first
    end

    def self.adopt_cat db, user_id, cat_id
      sql = %q[INSERT INTO userPets (user_id, cat_id) VALUES ($1, $2) RETURNING *]
      sql1 = %q[UPDATE cats SET adopted = $1 WHERE id = $2 RETURNING *]
      db.exec(sql1, [true, cat_id])
      result = db.exec(sql, [user_id, cat_id])
      result.first
    end

    def self.find_all_cats_by_user_id db, user_id
      sql =  %q[SELECT c.id, c."shopId", c.name, c."imageUrl", c.adopted FROM userPets u INNER JOIN cats c ON c.id = u.cat_id WHERE user_id = $1]
      result = db.exec(sql, [user_id])
      result.entries.map { |x| Petshopserver.boolean_type_cast(x, 'adopted') }
    end

    def self.adopt_dog db, user_id, dog_id
      sql = %q[INSERT INTO userPets (user_id, dog_id) VALUES ($1, $2) RETURNING *]
      sql1 = %q[UPDATE dogs SET adopted = $1 WHERE id = $2 RETURNING *]
      db.exec(sql1, [true, dog_id])
      result = db.exec(sql, [user_id, dog_id])
      result.first
    end

    def self.find_all_dogs_by_user_id db, user_id
      sql =  %q[SELECT d.id, d."shopId", d.name, d."imageUrl", d.happiness, d.adopted FROM userPets u INNER JOIN dogs d ON d.id = u.dog_id WHERE user_id = $1]
      result = db.exec(sql, [user_id])
      result.entries.map { |x| Petshopserver.boolean_type_cast(x, 'adopted') }
    end

  end
end
