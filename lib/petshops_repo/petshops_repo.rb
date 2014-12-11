module PetShop
  class Shops
    def get_all_shops
      db.exec('SELECT * FROM shops')
    end
  end
end
