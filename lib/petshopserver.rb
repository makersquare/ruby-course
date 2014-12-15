require 'pg'

require_relative 'petshopserver/repos/shops_repo.rb'
require_relative 'petshopserver/repos/cats_repo.rb'
require_relative 'petshopserver/repos/dogs_repo.rb'
require_relative 'petshopserver/repos/users_repo.rb'

module Petshopserver
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM shops;
      DELETE FROM dogs;
      DELETE FROM cats;
      DELETE FROM users;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR
      );
      CREATE TABLE IF NOT EXISTS shops(
        id SERIAL PRIMARY KEY,        
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        "shopId" int references shops(id),
        name varchar,
        "imageUrl" varchar,
        happiness int,
        adopted boolean
      );
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        "shopId" int references shops(id),
        name varchar,
        "imageUrl" varchar,
        adopted boolean
      );
      CREATE TABLE IF NOT EXISTS userPets(
        id SERIAL PRIMARY KEY,
        "user_id" INTEGER references users(id),
        "cat_id" INTEGER references cats(id),
        "dog_id" INTEGER references dogs(id)
      );
    SQL
  end

  def self.seed_db(db)
    db.exec <<-SQL  
      INSERT INTO users (username, password) values ('anonymous', 'anonymous')
      INSERT INTO users (username, password) values ('Jessica', '123')
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE shops;
      DROP TABLE dogs;
      DROP TABLE cats;
      DROP TABLE users;
    SQL
  end
 
  def self.seed_all_db(db)
    shops = JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops")
    shops.shift
    cats = shops.map do |shop|
      shop_id = shop['id']
      JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops/#{shop_id}/cats")
    end
 
    dogs = shops.map do |shop|
      shop_id = shop['id']
      JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs")
    end
 
    save_shops_to_db(shops,db)
    save_cats_to_db(cats.flatten,db)
    save_dogs_to_db(dogs.flatten,db)
  end
 
  def self.save_shops_to_db(shops,db) 
    sq = []
    # "(1, 'Jo's Palace'), (2, Nicks Shop)"
    shops.each do |shop|  
      shop["name"].gsub(/'/, "///'")
    end 
    values = shops.map do |shop|
      id = shop['id'].to_i
      name = shop['name']
      db.escape_string(name.to_s)
      ["(#{id}, '#{name}')"]
    end
    values = values.flatten.join(',')
    sql  = %Q[
    insert into shops (id, name) values #{values} 
    ]

    db.exec(sql)
  end

  def self.save_cats_to_db(cats,db)
    sql = %q[
      INSERT INTO cats (shopId, name, imageUrl, adopted)
      VALUES ($1, $2, $3, $4)
    ]
    cats.each do |cat|
      name = cat['name']
      imageurl = cat['imageUrl']
      adopted = cat['adopted']
      shopid = cat['shopId']
 
      db.exec(sql, [shopid, name, imageurl, adopted])
    end
  end
 
  def self.save_dogs_to_db(dogs,db)
    sql = %q[
      INSERT INTO dogs (shopId, name, imageUrl, happiness, adopted)
      VALUES ($1, $2, $3, $4, $5)
    ]
    dogs.each do |dog|
      name = dog['name']
      imageurl = dog['imageUrl']
      happiness = dog['happiness'].to_i
      x ||= dog['adopted'] 
      shopid = dog['shopId']
 
      db.exec(sql, [shopid, name, imageurl, happiness, adopted])
    end
  end

  def self.boolean_type_cast object, key
    if object[key] == 't'
      object[key] = true
    else
      object[key] = false
    end
    object
  end

end 
