module PetShop
  class DogsRepo

    def self.all_from_shop(db, id)
      sql = %q[SELECT id, shopid, name,  imageurl AS "imageUrl", adopted, happiness  FROM dogs WHERE shopid = $1]
      db.exec(sql, [id]).to_a
    end
  end
end