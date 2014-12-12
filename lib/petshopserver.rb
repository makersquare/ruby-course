require 'pg'

require_relative 'petshopserver/repos/shops_repo.rb'
require_relative 'petshopserver/repos/cats_repo.rb'
require_relative 'petshopserver/repos/dogs_repo.rb'
require_relative 'petshopserver/repos/users_repo.rb'


# in irb - 
# load 'file_name.rb'
# db = Petshopserver.create_db_connection('petshopserver')
# Petshopserver.create_tables(db)
# Petshopserver.seed_db(db)


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
        shopId int references shops(id),
        name varchar,
        imageUrl varchar,
        happiness int,
        adopted boolean
      );
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        shopId int references shops(id),
        name varchar,
        imageUrl varchar,
        adopted boolean
      );
      CREATE TABLE IF NOT EXISTS userPets(
        id SERIAL PRIMARY KEY,
        user_id INTEGER references users(id),
        cat_id INTEGER references cats(id),
        dog_id INTEGER references dogs(id)
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
 
def self.seed_shops_db(db)
    shops = JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops")
    shops.shift
    # cats = shops.map do |shop|
    #   shop_id = shop['id']
    #   JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops/#{shop_id}/cats")
    # end
 
    # dogs = shops.map do |shop|
    #   shop_id = shop['id']
    #   JSON.parse RestClient.get("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs")
    # end
 
    save_shops_to_db(shops,db)
    # save_cats_to_db(cats.flatten)
    # save_dogs_to_db(dogs.flatten)
  end
 
  def self.save_shops_to_db(shops,db) 
    sq = []
    # "(1, 'Jo's Palace'), (2, Nicks Shop)"
    shops.each do |shop|  
      # if shop["name"].include? ("'")
      #   sq << shop
      #   shops.delete(shop)
      # # k = shops.count
      # end  
      # sq
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
end 
