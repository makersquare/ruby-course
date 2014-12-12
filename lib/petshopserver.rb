require 'pg'

require_relative 'petshopserver/repos/shops_repo.rb'
require_relative 'petshopserver/repos/cats_repo.rb'
require_relative 'petshopserver/repos/dogs_repo.rb'
require_relative 'petshopserver/repos/users_repo.rb'

# in irb - 
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
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        shop_id INTEGER references shops(id),
        name VARCHAR,
        user_id INTEGER references users(id),
        adopted BOOLEAN
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        shop_id INTEGER references shops(id),
        name VARCHAR,
        user_id INTEGER references users(id),
        adopted BOOLEAN
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
end