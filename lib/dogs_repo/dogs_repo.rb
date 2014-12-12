module PetShop
  class DogsRepo

    def self.all_from_shop(db, id)
      sql = %q[SELECT * FROM dogs WHERE shopid = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.find_by_user(db, user_id)
      sql = %q[SELECT * FROM pet_adoptions WHERE user_id = $1]
      result = db.exec(sql, [user_id])
      result.first
    end

    def self.adopt_dog(db, dog_id)
      sql = %q[UPDATE dogs SET adopted = 'true' WHERE id = $1]
      result = db.exec(sql, [dog_id])
      result.first
    end



  end
end