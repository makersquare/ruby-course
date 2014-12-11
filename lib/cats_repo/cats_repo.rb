module PetShop
  class CatsRepo
    def show_all_cats
      db.exec('SELECT * FROM cats')
    end
    def adopt(id)
      db.exec("UPDATE cats WHERE id = $1 SET adopted = 'true'",[id])
    end
  end
end