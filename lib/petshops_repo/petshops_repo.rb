module PetShop
  class Shops
    def self.get_all_shops(db)
      shops = db.exec('SELECT * FROM petshops').to_a
      

    end

  end
end
