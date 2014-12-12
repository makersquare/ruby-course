require 'pg'
require 'bcrypt'

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
        imageUrl VARCHAR,
        name VARCHAR,
        adopted VARCHAR
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        shopid INTEGER references petshops(id),
        imageUrl VARCHAR,
        name VARCHAR,
        happiness VARCHAR,
        adopted VARCHAR 
      );
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR 
      );
      CREATE TABLE IF NOT EXISTS pet_adoptions(
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
      DROP TABLE pet_adoptions;
    SQL
  end

  def self.seed_db(db)
    r = db.exec <<-SQL
      INSERT INTO petshops (name) values ('My Pet Shop') RETURNING id
    SQL

    dogurl = "http://www.oldyelladogranch.com/puppies.jpg"
    caturl = "http://nextranks.com/data_images/main/cats/cats-04.jpg"
    shopid = r[0]['id']
    q = "INSERT INTO cats (shopid, imageUrl, name) values ($1, $2,  'cat1')"
    db.exec(q,[shopid, caturl])
    q = "INSERT INTO dogs (shopid, imageUrl, name, happiness) values ($1, $2, 'dog1', '5')"
    db.exec(q,[shopid, dogurl])
    password_hash = BCrypt::Password.create('ilovepets')
    q = "INSERT INTO users (username, password) values ('ilovepets', '#{password_hash}')"
    db.exec(q)
    password_hash = BCrypt::Password.create('someuser')
    q = "INSERT INTO users (username, password) values ('someuser', '#{password_hash}')"
    db.exec(q)
    password_hash = BCrypt::Password.create('someotherperson')
    q = "INSERT INTO users (username, password) values ('someotherperson', '#{password_hash}')"
    db.exec(q)
  
  end



end