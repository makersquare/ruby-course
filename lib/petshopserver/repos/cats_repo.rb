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
    end

  end
end