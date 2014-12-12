module Petshops
  class CatRepo
    def self.all(db)
      db.exec('SELECT * FROM cats').entries
    end

    def self.find_by_id(db, id)
      sql = %q[SELECT * FROM cats where id = $1]
      db.exec(sql, [id]).entries.first
    end

    def self.save(db, cat_data)
      if cat_data['id']
        sql = %q[UPDATE cats SET ownerId = $2 where id = $1]
        result = db.exec(sql, cat_data['id'], cat_data['ownerId'])
        result.entries.first
      else
        sql = %q[INSERT INTO cats (name, imageurl, shopid) values ($1, $2, $3) returning *]
        result = db.exec(sql, [cat_data['name'], cat_data['imageurl'], cat_data['shopId']])
        result.entries.first
      end
    end

    def self.find_by_name(db, cat_name)
      sql = %q[SELECT * FROM shops where name = $1]
      result = db.exec(sql, [cat_name])
      result.entries.first
    end

  end
end