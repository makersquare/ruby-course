module PetShop
class Database
 def self.dbconnect
  PG.connect(host: 'localhost', dbname:'petserver')
 end

 def addData
   url = 'pet-shop.api.mks.io/shops/'
   tempshops = RestClient.get(url)
   shops = JSON.parse(tempshops) #this is our hash of shop names and id's!
   shops.each { |shop|
   shopname = shop["name"]
   shopid = shop["id"]             
   sql = %q[
       INSERT INTO shops (name)
       VALUES ($1)
           ]
   @db.exec_params(sql, [shopname, shopid]) #enter shop info to shops table

   url = "pet-shop.api.mks.io/shops/" + shopid.to_s + "/dogs/"
   tempdogs = RestClient.get(url)
   dogs = JSON.parse(tempdogs)
   dogs.each { |dog| #each dog
   shop = dog["shopId"]    
   name = dog["name"]
   image = dog["imageUrl"]   
   id = dog["id"]      
   adopt = dog["adopted"]
   sql = %q[
       INSERT INTO dogs (shop_id, name, img_url)
       VALUES ($1, $2, $3)
           ]
   @db.exec_params(sql, [shop, id, name, image, happiness, adopt])
 }#end each dog

   url = "pet-shop.api.mks.io/shops/" + shopid.to_s + "/cats/"
   tempcats = RestClient.get(url)
   cats = JSON.parse(tempcats)
   cats.each { |cat| #each cat
   shop = cat["shopId"]    
   name = cat["name"]
   image = cat["imageUrl"]   
   id = cat["id"]      
   sql = %q[
       INSERT INTO cats (shop_id, name, img_url)
       VALUES ($1, $2, $3)
           ]
   @db.exec_params(sql, [shop, id, name, image, adopt])
 }#end each cat
 }#end each shop
 end


end