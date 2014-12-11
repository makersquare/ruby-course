module PetShop
  class Shops
    def get_all_shops
      sql = %q[
          SELECT * FROM shops
      ]
    end
   