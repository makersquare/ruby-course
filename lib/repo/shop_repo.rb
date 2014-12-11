module Petshops
  class ShopRepo
    def self.all(db)
      db.exec('SELECT * FROM shops').entries
    end

    def self.find_by_id(db, id)
      sql = %q[SELECT * FROM shops where id = $1]
      db.exec(sql, [id]).entries.first
    end

    def self.save(db, shop_name)
      sql = %q[INSERT INTO shops (name) values ($1) returning *]
      result = db.exec(sql, [shop_name])
      result.entries.first
    end

    def self.find_by_name(db, shop_name)
      sql = %q[SELECT * FROM shops where name = ($1) returning *]
      result = db.exec(sql, [shop_name])
      result.entries.first
    end

  end
end