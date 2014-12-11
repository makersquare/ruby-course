require 'pg'
require 'rest-client'
require 'json'

#           Table "public.shops"
#  Column |       Type        | Modifiers 
# --------+-------------------+-----------
#  id     | numeric           | 
#  name   | character varying | 


#                Table "public.dogs"
#      Column      |       Type        | Modifiers 
# -----------------+-------------------+-----------
#  shop_id         | integer           | 
#  dog_id          | integer           | 
#  name            | character varying | 
#  imageurl        | character varying | 
#  happiness       | integer           | 
#  adoption_status | boolean           | 


#                Table "public.cats"
#      Column      |       Type        | Modifiers 
# -----------------+-------------------+-----------
#  shop_id         | integer           | 
#  cat_id          | integer           | 
#  name            | character varying | 
#  imageurl        | character varying | 
#  adoption_status | boolean           | 

module PetShop
class Database
  def initialize
  @db = PG.connect(host: 'localhost', dbname:'petshop_db')
  end 

  def addData
    url = 'pet-shop.api.mks.io/shops/'
    tempshops = RestClient.get(url)
    shops = JSON.parse(tempshops) #this is our hash of shop names and id's!
    shops.each { |shop|
    shopname = shop["name"]
    shopid = shop["id"]             
    sql = %q[
        INSERT INTO shops (name, id)
        VALUES ($1, $2)
            ]
    @db.exec_params(sql, [shopname, shopid]) #enter shop info to shops table

    url = "pet-shop.api.mks.io/shops/" + shopid.to_s + "/dogs/"
    tempdogs = RestClient.get(url)
    dogs = JSON.parse(tempdogs)
    dogs.each { |dog| #each dog
    shop = dog["shopId"]    
    name = dog["name"]
    happiness = dog["happiness"]
    image = dog["imageUrl"]   
    id = dog["id"]      
    adopt = dog["adopted"]
    sql = %q[
        INSERT INTO dogs (shop_id, dog_id, name, imageurl, happiness, adoption_status)
        VALUES ($1, $2, $3, $4, $5, $6)
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
    adopt = cat["adopted"]
    sql = %q[
        INSERT INTO cats (shop_id, cat_id, name, imageurl, adoption_status)
        VALUES ($1, $2, $3, $4, $5)
            ]
    @db.exec_params(sql, [shop, id, name, image, adopt])
  }#end each cat
  }#end each shop
  end

  def print_shops
    sql = %q[
      SELECT * FROM shops]
    success = @db.exec(sql)
    shops = success.entries #hashes of shop info
    puts "ID | Name"
    puts "-----------------------------"
    shops.each { |shop|
     if shop["id"].to_i < 10
      puts "#{shop["id"].to_i}  | #{shop["name"]}"
     else
      puts "#{shop["id"].to_i} | #{shop["name"]}"
     end
    }
  end


  def print_store_dogs(store_id)
    sql1 = %q[
        SELECT name FROM shops WHERE id = $1
         ]
    success1 = @db.exec_params(sql1, [store_id])
    name = success1.entries[0]["name"]

    sql2 = %q[
      SELECT * FROM dogs WHERE shop_id = $1
          ]
      success = @db.exec_params(sql2, [store_id])
      dogs = success.entries #hashes of dog info
      puts "Dogs in store #{name}:"
      puts "------------------"
      dogs.each {|dog|
          puts "Name: #{dog["name"]}"
          puts "Happiness: #{dog["happiness"]}"
          if dog["adopted"]
            puts "Adopted: Yes!"
          else 
            puts "Adopted: No"
          end
          puts "------------------"
        }
  end

  def print_store_dogs(store_id)
    sql1 = %q[
        SELECT name FROM shops WHERE id = $1
         ]
    success1 = @db.exec_params(sql1, [store_id])
    name = success1.entries[0]["name"]

    sql2 = %q[
      SELECT * FROM dogs WHERE shop_id = $1
          ]
      success = @db.exec_params(sql2, [store_id])
      dogs = success.entries #hashes of dog info
      puts "Dogs in store #{name}:"
      puts "------------------"
      dogs.each {|dog|
          puts "Name: #{dog["name"]}"
          puts "Happiness: #{dog["happiness"]}"
          if dog["adopted"]
            puts "Adopted: Yes!"
          else 
            puts "Adopted: No"
          end
          puts "------------------"
        }
  end

 def happiestdogs
  sql = %q[
    SELECT name, happiness FROM dogs ORDER BY happiness
  ]
  alldogs = @db.exec(sql)
  happiest = alldogs.entries[-5..-1]
  puts "Happiest Dogs:"
  happiest.each{|dog|
    puts "#{dog["name"]}: #{dog["happiness"]}"
  }  
 end

 def allpets
  sqldogs = %q[
    SELECT dogs.name AS name, dogs.happiness AS happiness, shops.name AS shop
    FROM dogs
    JOIN shops
    ON dogs.shop_id = shops.id 
      ]
  tempdogs = @db.exec(sqldogs)
  dogs = tempdogs.entries
  puts "All Pets:"
  dogs.each {|dog|
    puts "#{dog["name"]}, #{dog["happiness"]}, @ #{dog["shop"]}"
  }
  sqlcats = %q[
    SELECT cats.name AS name, shops.name AS shop
    FROM cats
    JOIN shops
    ON cats.shop_id = shops.id 
      ]
  tempcats = @db.exec(sqlcats)
    cats = tempcats.entries
    cats.each {|cat|
      puts "#{cat["name"]} @ #{cat["shop"]}"
    }
end

end #end of class



