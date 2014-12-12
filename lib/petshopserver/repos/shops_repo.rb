module Petshopserver

  class ShopsRepo
    # find a user by user ID. Intended to be used when
    # someone is already authenticated. We keep their
    # user id in the cookie.
    def self.find db, shop_id
      sql = %q[SELECT * FROM shops WHERE id = $1]
      result = db.exec(sql, [user_id])
      result.first
    end

    # find shops by name. Intended to be used when
    # someone tries to sign in.
    def self.find_by_name db, name
      sql = %q[SELECT * FROM shops WHERE name = $1]
      result = db.exec(sql, [name])
      result.first
    end

    def self.all(db)
      db.exec("SELECT * FROM shops").to_a
    end

    # save shop info
    def self.save db, shop_data
      sql = %q[INSERT INTO shops (name) VALUES ($1) RETURNING *]
      result = db.exec(sql, [user_data[:name]])
      result.first
    end

    def self.destroy db, id
      sql = %q[DELETE FROM shops WHERE id = $1]
      db.exec(sql, [id])
    end
    
  end
end
