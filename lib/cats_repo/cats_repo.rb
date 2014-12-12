module PetShop
  class CatsRepo
    def self.find_by_user(db, user_id)
      sql = %q[SELECT * FROM pet_adoptions WHERE user_id = $1 and type = 'cat']
      result = db.exec(sql, [user_id])
      result.first
    end
    def self.adopt_cat(db, id)
      db.exec("UPDATE cats WHERE id = $1 SET adopted = 'true'",[id])
    end
    def self.all_from_shop(db, id)
      db.exec("SELECT * FROM cats WHERE shopid = $1",[id]).to_a
    end
  end
end