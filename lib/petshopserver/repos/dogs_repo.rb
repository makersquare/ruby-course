module Petshopserver
  class DogsRepo

    def self.all db
      sql = %q[SELECT * FROM dogs]
      result = db.exec(sql)
      result.entries.map { |x| Petshopserver.boolean_type_cast(x, 'adopted') }
    end

    def self.all_by_shop db, id
      sql = %q[SELECT * FROM dogs WHERE "shopId" = $1]
      result = db.exec(sql, [id])
      result.entries.map { |x| Petshopserver.boolean_type_cast(x, 'adopted') }

      # dogs = result.entries
      # dogs.each do |d|
      #   if d['adopted'] == 't'
      #     d['adopted'] = true
      #   else
      #     d['adopted'] = false
      #   end
      # end
      # dogs
    end

    def self.find db, id
      sql = %q[SELECT * FROM dogs WHERE id = $1]
      result = db.exec(sql, [id])
      Petshopserver.boolean_type_cast(result.first, 'adopted')   
    end

    def self.save db, dog_data
      if dog_data["id"]
        id = dog_data["id"].to_i
        sql = %q[UPDATE dogs SET adopted = $1 WHERE id = $2 RETURNING *]
        result = db.exec(sql, [dog_data["adopted"], dog_data["id"]])
      else
        sql = %q[INSERT INTO dogs ("shopId", name, "imageUrl", happiness, adopted) VALUES ($1,$2,$3,$4, $5) RETURNING *]
        result = db.exec(sql, [dog_data["shopId"], dog_data["name"], dog_data["imageUrl"],dog_data["happiness"], dog_data["adopted"]])
      end
      result.first
    end

    def self.destroy db, id
      sql = %q[DELETE FROM dogs WHERE id = $1]
      db.exec(sql, [id])
    end

  end
end