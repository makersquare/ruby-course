module Petshop
  class CatsRepo
    def self.all db
      sql = %q[SELECT * FROM cats]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %q[SELECT * FROM cats WHERE id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.find_by_shopid db, shop_id
      sql = %q[SELECT shopid, id, userid, name, imageurl as "imageUrl" FROM cats WHERE shopid = $1]
      result = db.exec(sql, [shop_id])
      result.to_a
    end

    def self.find_available db, adopted, shop_id
      sql = %q[SELECT * FROM cats WHERE adopted != $1 AND shopid = $2]
      result = db.exec(sql, [true], [shop_id])
      result.to_a
    end




    def self.save db, cat_name
      if cat_name[:id]
        sql = %q[UPDATE cats SET content = $1 WHERE id = $2 RETURNING *]
        result = db.exec(sql, [cat_name[:name], cat_name[:id]])
      else
        sql = %q[INSERT INTO cats (cat_name) VALUES ($1) RETURNING *]
        result = db.exec(sql, [cat_name[:name], cat_name[:id]])
      end

      result.first
    end

    def self.destroy db, id
      sql = %q[DELETE FROM cats WHERE id = $1]
      db.exec(sql, [id])
      post_exists?(db, id)
    end

  end
end