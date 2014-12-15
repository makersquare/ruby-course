module Petshopserver
  class CatsRepo

    def self.all db
      sql = %q[SELECT * FROM cats]
      result = db.exec(sql)
      result.entries.map { |x| Petshopserver.boolean_type_cast(x, 'adopted') }
    end

    def self.all_by_shop db, id
      sql = %q[SELECT * FROM cats WHERE "shopId" = $1]
      result = db.exec(sql, [id])
      result.entries.map { |x| Petshopserver.boolean_type_cast(x, 'adopted') }

    end

    def self.find db, id
      sql = %q[SELECT * FROM cats WHERE id = $1]
      result = db.exec(sql, [id])
      Petshopserver.boolean_type_cast(result.first, 'adopted')   
      #added class    
    end

    def self.save db, cat_data
      if cat_data["id"]
        id = cat_data["id"].to_i
        sql = %q[UPDATE cats SET adopted = $1 WHERE id = $2 RETURNING *]
        result = db.exec(sql, [cat_data["adopted"], cat_data["id"]])
      else
        sql = %q[INSERT INTO cats ("shopId", name, "imageUrl", adopted) VALUES ($1,$2,$3,$4) RETURNING *]
        result = db.exec(sql, [cat_data["shopId"], cat_data["name"], cat_data["imageUrl"],cat_data["adopted"]])
      end
      result.first
    end

    def self.destroy db, id
      sql = %q[DELETE FROM cats WHERE id = $1]
      db.exec(sql, [id])
    end

  end
end