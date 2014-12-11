module PetShop
  class Shops
    def get_all_shops
      db.exec('SELECT * FROM shops')
    end
<<<<<<< HEAD
=======

>>>>>>> 8b1a40da1d97c73be6817b24eaca4624daa682de
  end
end
