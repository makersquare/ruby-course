module PetShop
class DB

  def self.get_shops(db)
    db.exec("SELECT * FROM shops").entries
  end

  def self.get_cats(db, shop_id)  
    mappings = {"shop_id" => "shopId", "cat_id" => "id", "name" => "name", "imageurl" => "imageUrl", "adoption_status" => "adopted"}
    response = db.exec("SELECT * FROM cats WHERE shop_id = $1", [shop_id]).entries
    cats = []
    response.each do |cat| 
      if cat['adoption_status'] == "t"
        cat['adoption_status'] = true
      else 
        cat['adoption_status'] = false
      end
      cats << Hash[cat.map {|k, v| [mappings[k], v] }]
    end
    cats
  end

  def self.get_dogs(db, shop_id)  
    mappings = {"shop_id" => "shopId", "dog_id" => "id", "name" => "name", "imageurl" => "imageUrl", "adoption_status" => "adopted"}
     response = db.exec("SELECT * FROM dogs WHERE shop_id = $1", [shop_id]).entries
     dogs = []
     response.each do |dog| 
      if dog['adoption_status'] == "t"
        dog['adoption_status'] = true
      else 
        dog['adoption_status'] = false
      end
      dogs << Hash[dog.map {|k, v| [mappings[k], v] }]
     end
     dogs
  end

  def self.adopt_cat(db, cat_id)
    db.exec("UPDATE cats set adoption_status = 'true' where cat_id = $1", [cat_id])
  end

  def self.adopt_dog(db, dog_id)
    db.exec("UPDATE dogs set adoption_status = 'true' where dog_id = $1", [dog_id])
  end

  def self.find db, user_id
    sql = %q[SELECT * FROM users WHERE id = $1]
    result = db.exec(sql, [user_id]).first

    dog_sql = %q[select dogs.shop_id, dogs.dog_id, dogs.name, dogs.imageurl, dogs.happiness, dogs.adoption_status 
      from dogs 
      INNER JOIN adoptions on dogs.dog_id=adoptions.dog_id where user_id = $1;
    ]
    cat_sql = %q[select cats.shop_id, cats.cat_id, cats.name, cats.imageurl, cats.adoption_status 
      from cats 
      INNER JOIN adoptions on cats.cat_id=adoptions.cat_id where user_id = $1;
    ]

    dogs = db.exec(dog_sql, [user_id])
    dogs = dogs.entries
    result['dogs'] = map_dogs(dogs)

    
    cats = db.exec(cat_sql, [user_id])
    cats = cats.entries
    result['cats'] = map_cats(cats)

    p result
  end
  # find user by username. Intended to be used when
  # someone tries to sign in.
  def self.find_by_name db, username
    sql = %q[SELECT * FROM users WHERE username = $1]
    result = db.exec(sql, [username])
    result.first
  end

  def self.map_cats(cats)
    mappings = {"shop_id" => "shopId", "cat_id" => "id", "name" => "name", "imageurl" => "imageUrl", "adoption_status" => "adopted"}
    mapped_cats = []
    cats.each do |cat| 
      if cat['adoption_status'] == "t"
        cat['adoption_status'] = true
      else 
        cat['adoption_status'] = false
      end
      mapped_cats << Hash[cat.map {|k, v| [mappings[k], v] }]
    end
    mapped_cats
  end

  def self.map_dogs(dogs)
    mappings = {"shop_id" => "shopId", "dog_id" => "id", "name" => "name", "imageurl" => "imageUrl", "adoption_status" => "adopted"}
    mapped_dogs = []
    dogs.each do |dog| 
      if dog['adoption_status'] == "t"
        dog['adoption_status'] = true
      else 
        dog['adoption_status'] = false
      end
      mapped_dogs << Hash[dog.map {|k, v| [mappings[k], v] }]
     end
     mapped_dogs
  end

end #end DB
end#end module

# {"shop_id":"3",
#   "cat_id":"5",
#   "name":"karthurian",
#   "imageurl":"http://cucinatestarossa.blogs.com/weblog/images/cat.jpg",
#   "adoption_status":"t"}
#   {"shopId":1,
#     "name":"Scaredy Cat",
#     "imageUrl":"http://i.imgur.com/TOEskNX.jpg",
#     "adopted":true,
#     "id":1}

