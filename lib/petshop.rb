require 'pg'
require 'rest-client'
require 'json'

module Petshops
  def self.create_db_connection dbname
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.get(url)
    response = RestClient.get(url)
    JSON.parse(response)
  end

  def self.clear_tables db
    db.exec <<-SQL
      DELETE FROM cats;
      DELETE FROM dogs;
      DELETE FROM shops;
      DELETE FROM users;
    SQL
  end

  def self.create_tables db
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
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        name VARCHAR,
        adopted BOOLEAN,
        image_url VARCHAR,
        owner_id INTEGER REFERENCES users(id)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
        shop_id INTEGER REFERENCES shops(id)
          ON DELETE CASCADE
          ON UPDATE CASCADE
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        name VARCHAR,
        adopted BOOLEAN,
        image_url VARCHAR,
        owner_id INTEGER REFERENCES users(id)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
        shop_id INTEGER REFERENCES shops(id)
          ON DELETE CASCADE
          ON UPDATE CASCADE
      );
    SQL
  end

  def self.drop_tables db

    db.exec <<-SQL
      DROP TABLE cats;
      DROP TABLE dogs;
      DROP TABLE shops;
      DROP TABLE users;
    SQL
  end

  def self.seed_tables
    #### Testing ####
    db = create_db_connection 'petserver'
    clear_tables db
    drop_tables db
    create_tables db
    #### Testing ####

    shops_list = get("http://pet-shop.api.mks.io/shops")
    cats_by_shop = []
    dogs_by_shop = []
    shops_query = []
    cats_query = []
    dogs_query = []

    shops_list.each do |shop|
      shops_query << "(\'" + db.escape_string(shop['name']) + "\')"
      cats_by_shop << get("pet-shop.api.mks.io/shops/" + shop['id'].to_s + "/cats")
      dogs_by_shop << get("pet-shop.api.mks.io/shops/" + shop['id'].to_s + "/dogs")
    end

    cat_shop = 0
    cats_by_shop.each do |shop|
      cat_shop += 1
      shop.each do |cat|
        cats_query << "(\'" + db.escape_string(cat["name"]) + "\', \'" + (cat["adopted"].to_s != "true" ? "false" : "#{cat["adopted"].to_s}") + "\', \'" + db.escape_string(cat["imageUrl"]) + "\', \'#{cat_shop.to_s}\')"
      end
    end

    dog_shop = 0
    dogs_by_shop.each do |shop|
      dog_shop += 1
      shop.each do |dog|
        dogs_query << "(\'" + db.escape_string(dog["name"]) + "\', \'" + (dog["adopted"].to_s != "true" ? "false" : "#{dog["adopted"].to_s}") + "\', \'" + db.escape_string(dog["imageUrl"]) + "\', \'#{dog_shop.to_s}\')"
      end
    end

    shops_query = shops_query.join(",")
    cats_query = cats_query.join(",")
    dogs_query = dogs_query.join(",")
    users_query = "('Glenn', 'password'), ('James', 'jamespets'), ('Melissa', 'jarjarbinks')"

    db.exec("INSERT INTO shops (name) VALUES " + shops_query)
    db.exec("INSERT INTO cats (name, adopted, image_url, shop_id) VALUES " + cats_query)
    db.exec("INSERT INTO dogs (name, adopted, image_url, shop_id) VALUES " + dogs_query)

    db.exec("INSERT INTO users (username, password) VALUES " + users_query)
  end  
end

require_relative 'repo/cat_repo.rb'
require_relative 'repo/dog_repo.rb'
require_relative 'repo/shop_repo.rb'
require_relative 'repo/user_repo.rb'