module Petshop
  class ShopsRepo
    def self.all db
      sql = %q[SELECT * FROM shops]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %q[SELECT * FROM shops WHERE id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.save db, shop_name
      if shop_name[:id]
        sql = %q[UPDATE shops SET content = $1 WHERE id = $2 RETURNING *]
        result = db.exec(sql, [shop_name[:name], shop_name[:id]])
      else
        sql = %q[INSERT INTO shops (shop_name) VALUES ($1) RETURNING *]
        result = db.exec(sql, [shop_name[:name], shop_name[:id]])
      end

      result.first
    end

    def self.destroy db, id
      sql = %q[DELETE FROM shops WHERE id = $1]
      db.exec(sql, [id])
      post_exists?(db, id)
    end

  end
end
