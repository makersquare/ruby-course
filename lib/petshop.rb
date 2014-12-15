require 'pg'
require 'json'
require 'rest-client'

require_relative 'petshop/repos/cats_repo.rb'
require_relative 'petshop/repos/dogs_repo.rb'
require_relative 'petshop/repos/shops_repo.rb'
require_relative 'petshop/repos/users_repo.rb'

module Petshop
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM cats;
      DELETE FROM dogs;
      DELETE FROM users;
      DELETE FROM shops;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS shops(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        shopid INT references shops(id),
        userid INT references users(id),
        name VARCHAR,
        imageurl VARCHAR,
        adopted BOOLEAN,
        happiness INT
      );
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        shopid INT references shops(id),
        userid INT references users(id),
        name VARCHAR,
        imageurl VARCHAR,
        adopted BOOLEAN
      );
    SQL
  end

  def self.seed_shops(db)
    #parse JSON data for shops
    shops = JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops")

    sql = %q[
     INSERT INTO shops(id, name)
     VALUES ($1, $2)
     ]

   shops.each do |data|
     id = data["id"]
     name = data["name"]

     db.exec(sql, [id, name])
   end

  end

  def self.seed_users(db)
     sql = %q[
       INSERT INTO users (username, password)
       VALUES ('testuser', 'pass123')
     ]
     db.exec(sql)
  end

  def self.seed_cats(db)

    #parse JSON data for shops
    shops = JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops")

    #get the cats information
    cats = shops.map do |shop|
      shop_id = shop['id']
      JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops/#{shop_id}/cats")
    end

    flatcats = cats.flatten

   sql = %q[
     INSERT INTO cats(id, shopid, name, imageurl, adopted)
     VALUES ($1, $2, $3, $4, $5)
   ]

   flatcats.each do |cat|
     id = cat["id"]
     shopid = cat["shopid"]
     name = cat["name"]
     imageurl = cat["imageurl"]
     adopted = cat["adopted"] ? true : false

     db.exec(sql, [id, shopid, name, imageurl, adopted])
  end

end

  def self.seed_dogs(db)

    #parse JSON data for shops
    shops = JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops")

    #get the dogs information
    dogs = shops.map do |shop|
      shop_id = shop['id']
      JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs")
    end

    flatdogs = dogs.flatten

    sql = %q[
     INSERT INTO dogs(id, shopid, name, imageurl, adopted, happiness)
     VALUES ($1, $2, $3, $4, $5, $6)
     ]

   flatdogs.each do |dog|
     id = dog["id"]
     shopid = dog["shopid"]
     name = dog["name"]
     imageurl = dog["imageurl"]
     adopted = dog["adopted"] ? true : false
     happiness = dog["happiness"]

     db.exec(sql, [id, shopid, name, imageurl, adopted, happiness])
    end

  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE cats;
      DROP TABLE dogs;
      DROP TABLE users;
      DROP TABLE shops;
    SQL
  end
end





