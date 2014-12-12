module PetShop
  class CatsRepo
    def self.find_by_user(db, user_id)
      sql = %q[SELECT c.id, c.name,  c.imageurl AS "imageUrl" FROM pet_adoptions a JOIN cats c ON c.id = a.pet_id WHERE a.user_id = $1 and type = 'cat']
      result = db.exec(sql, [user_id]).to_a
      result
    end
    def self.adopt_cat(db, id)
      db.exec("UPDATE cats SET adopted = 'true' WHERE id = $1",[id])
    end
    def self.all_from_shop(db, id)
      db.exec(%q[SELECT id, shopid, name,  imageurl AS "imageUrl", adopted FROM cats WHERE shopid = $1],[id]).to_a

    end
  end
end