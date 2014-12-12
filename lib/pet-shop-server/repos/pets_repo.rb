module PetShopServer
  class PetsRepo
    def self.all db 
      sql = %q[select * from pets]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %[select * from pets where id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.build_user db, id
      # sql = %[select * from pets where id = $1]
      # result = db.exec(sql, [id])
      catSql = %Q[SELECT
                   users.username,
                   users.password,
                   pets.id,
                   pets.name,
                   pets.image_url,
                   pets.happiness,
                   pets.adopted,
                   pets.shop_id,
                   pets.userid,
                   pets.species
                  FROM
                   public.pets,
                   public.users
                  WHERE
                   users.id = $1 AND
                   users.id = pets.userid AND
                   pets.species = 'cat' ]
      dogSql = %Q[SELECT
                   users.username,
                   users.password,
                   pets.id,
                   pets.name,
                   pets.image_url,
                   pets.happiness,
                   pets.adopted,
                   pets.shop_id,
                   pets.userid,
                   pets.species
                  FROM
                   public.pets,
                   public.users
                  WHERE
                   users.id = $1 AND
                   users.id = pets.userid AND
                   pets.species = 'dog' ]
        catResult = db.exec(catSql, [id])
        dogResult = db.exec(dogSql, [id])

      $real_user = {}
        $real_user['id'] = catResult.first['id']
        $real_user['username'] = catResult.first['username']
        $real_user['cats'] = []
        # push cats
        catResult.each do |cat|
          push_object = {
                        'shopId' => cat['shop_id'],
                        'name' => cat['name'],
                        'imageUrl' => cat['image_url'],
                        'adopted' => cat['adopted'],
                        'happiness' => cat['happiness']
                        }
         
          $real_user['cats'] << push_object
          end

        # push dogs
        $real_user['dogs'] = []
        dogResult.each do |dog|
          push_object = {
                        'shopId' => dog['shop_id'],
                        'name' => dog['name'],
                        'imageUrl' => dog['image_url'],
                        'adopted' => dog['adopted'],
                        'happiness' => dog['happiness']
                        }
          $real_user['dogs'] << push_object


          end
                  
          $real_user

    end

    def self.find_by_name db, name
      sql = %[select * from pets]
    end
  end
end