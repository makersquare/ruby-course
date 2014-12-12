module PetShop
  class DogsRepo

    def self.all_from_shop(db, id)
      sql = %q[SELECT id, shopid, name,  imageurl AS "imageUrl", adopted, happiness  FROM dogs WHERE shopid = $1]
      db.exec(sql, [id]).to_a
    end

    def self.find_by_user(db, user_id)
      sql = %q[SELECT d.id, d.name,  d.imageurl AS "imageUrl" FROM pet_adoptions a JOIN dogs d ON d.id = a.pet_id WHERE user_id = $1 and type = 'dog']
      result = db.exec(sql, [user_id]).to_a
    end

    def self.adopt_dog(db, dog_id)
      sql = %q[UPDATE dogs SET adopted = 'true' WHERE id = $1]
      result = db.exec(sql, [dog_id])
      result
    end



  end
end