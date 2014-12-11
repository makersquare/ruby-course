module PetShop
class DB

  def self.get_shops(db)
    db.exec("SELECT * FROM shops").entries
  end

  def self.get_cats(db, shop_id)
     db.exec("SELECT * FROM cats WHERE shop_id = $1", [shop_id]).entries
  end


end
end