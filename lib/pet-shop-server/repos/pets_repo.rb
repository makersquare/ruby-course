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
      catSql = %q[SELECT
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
                   pets.species = 'cat'; ]
      dogSql = %q[SELECT
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
                   pets.species = 'dog'; ]
        catResult = db.exec(catSql, 999)
        dogResult = db.exec(dogSql, 999)
      $real_user = {}
        $real_user['id'] = result.first['id']
        $real_user['username'] = result.first['username']
        # push cats
        result.each do |cat|
          push_object = {
                        'shopId' => cat['shopId'],
                        'name' => cat['name'],
                        'imageUrl' => cat['imageUrl'],
                        'adopted' => cat['adopted'],
                        'happiness' => cat['happiness']
                        }
          $real_user['cats'].push(push_object)
          end

        #push dogs
        result.each do |dog|
          push_object = {
                        'shopId' => dog['shopId'],
                        'name' => dog['name'],
                        'imageUrl' => dog['imageUrl'],
                        'adopted' => dog['adopted'],
                        'happiness' => dog['happiness']
                        }
          $real_user['dogs'].push(push_object)
          end
        

    end

    def self.find_by_name db, name
      sql = %[select * from pets]
    end
  end
end