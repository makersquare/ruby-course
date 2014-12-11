module Petshop
  class DogsRepo
    def self.all db
      sql = %q[SELECT * FROM dogs]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %q[SELECT * FROM dogs WHERE id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.save db, dog_name
      if dog_name[:id]
        sql = %q[UPDATE dogs SET content = $1 WHERE id = $2 RETURNING *]
        result = db.exec(sql, [dog_name[:name], dog_name[:id]])
      else
        sql = %q[INSERT INTO dogs (dog_name) VALUES ($1) RETURNING *]
        result = db.exec(sql, [dog_name[:name], dog_name[:id]])
      end

      result.first
    end

    def self.destroy db, id
      sql = %q[DELETE FROM dogs WHERE id = $1]
      db.exec(sql, [id])
      post_exists?(db, id)
    end

  end
end