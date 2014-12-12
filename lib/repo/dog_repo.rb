module Petshops
  class DogRepo
    def self.all(db)
      db.exec('SELECT * FROM dogs').entries
    end

    def self.find_by_id(db, id)
      sql = %q[SELECT * FROM dogs WHERE id = $1]
      result = db.exec(sql, [id]).entries.first
    end

    def self.find_by_name(db, name)
      sql = %q[SELECT * FROM dogs where name = $1]
      result = db.exec(sql, [name]).entries.first
    end

    def self.save(db, dog_data)
      if dog_data['id']
        sql = %q[UPDATE dogs set owner_id = $1, adopted = $2, shop_id = $3 WHERE id = $4 RETURNING *]
        result = db.exec(sql, [dog_data['owner_id'], 'true', dog_data['shop_id'], dog_data['id']])
        puts result.entries.first
        result.entries.first
      else
        sql = %q[INSERT INTO dogs (name, image_url, shop_id) values ($1, $2, $3) returning *]
        result = db.exec(sql, [dog_data['name'], dog_data['image_url'], dog_data['shop_id']])
        result.entries.first
      end
    end

    def self.find_by_shop_id(db, shop_id)
      sql = %q[SELECT shop_id AS "shopId", name, image_url AS "imageUrl", adopted, id FROM dogs WHERE shop_id = $1]
      result = db.exec(sql, [shop_id])
      result.entries
    end

  end

end