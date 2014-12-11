require 'pg'

require_relative 'petshops_repo/petshops_repo.rb'
require_relative 'cats_repo/cats_repo.rb'
require_relative 'dogs_repo/dogs_repo.rb'
require_relative 'users_repo/users_repo.rb'

module PetShop
  def self.create_db_connection()
    PG.connect(host: 'localhost', dbname: "petshop_db", user: "ruby",
  password: "rubyRailsJS")
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS petshops(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        shopid INTEGER references petshops(id),
        imageurl VARCHAR,
        name VARCHAR,
        adopted BOOLEAN
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        shopid INTEGER references petshops(id),
        imageurl VARCHAR,
        name VARCHAR,
        happiness VARCHAR,
        adopted BOOLEAN 
      );
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR 
      );
      CREATE TABLE IF NOT EXISTS pet_adptions(
        id SERIAL PRIMARY KEY,
        type VARCHAR,
        user_id INTEGER references users(id),
        pet_id INTEGER
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE petshops CASCADE;
      DROP TABLE cats CASCADE;
      DROP TABLE dogs CASCADE;
      DROP TABLE users CASCADE;
      DROP TABLE pet_adptions;
    SQL
  end

  def self.seed_db(db)
    r = db.exec <<-SQL
      INSERT INTO petshops (name) values ('My Pet Shop') RETURNING id
    SQL

    dogurl = "http://www.oldyelladogranch.com/puppies.jpg"
    caturl = "http://nextranks.com/data_images/main/cats/cats-04.jpg"
    shopid = r[0]['id']
    q = "INSERT INTO cats (shopid, imageurl, name, adopted) values ($1, $2,  'cat1', 'false')"
    db.exec(q,[shopid, caturl])
    q = "INSERT INTO dogs (shopid, imageurl, name, happiness, adopted) values ($1, $2, 'dog1', '5', 'false')"
    db.exec(q,[shopid, dogurl])
    q = "INSERT INTO users (username, password) values ('ilovepets', 'ilovepets')"
    db.exec(q)
    q = "INSERT INTO users (username, password) values ('someuser', 'someuser')"
    db.exec(q)
    q = "INSERT INTO users (username, password) values ('someotherperson', 'someotherperson')"
    db.exec(q)
  
  end



end