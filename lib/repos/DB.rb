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
        cat['adoption_status'] = "true"
      else 
        cat['adoption_status'] = "false"
      end
      cats << Hash[cat.map {|k, v| [mappings[k], v] }]
     end
     cats
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

