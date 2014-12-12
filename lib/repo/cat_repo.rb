module Petshops
  class CatRepo

    def self.all(db)
      db.exec('SELECT * FROM cats').entries
    end

    def self.find_by_id(db, id)
      sql = %q[SELECT * FROM cats WHERE id = $1]
      db.exec(sql, [id]).entries.first
    end

    def self.save(db, cat_data)
      if cat_data['id']
        sql = %q[UPDATE cats SET owner_id = $1, adopted = t WHERE id = $2, shop_id = $3]
        result = db.exec(sql, [cat_data['owner_id'], cat_data['id'], cat_data['shop_id']])
        result.entries.first
      else
        sql = %q[INSERT INTO cats (name, image_url, shop_id) VALUES ($1, $2, $3) RETURNING *]
        result = db.exec(sql, [cat_data['name'], cat_data['image_url'], cat_data['shop_id']])
        result.entries.first
      end
    end

    def self.find_by_name(db, cat_name)
      sql = %q[SELECT * FROM cats WHERE name = $1]
      result = db.exec(sql, [cat_name])
      result.entries.first
    end

    def self.find_by_shop_id(db, shop_id)
      sql = %q[SELECT shop_id AS "shopId", name, image_url AS "imageUrl", adopted, id FROM cats WHERE shop_id = $1]
      result = db.exec(sql, [shop_id])
      result.entries
    end

  end
end