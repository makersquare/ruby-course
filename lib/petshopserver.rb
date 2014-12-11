require 'pg'

require_relative 'petshopserver/repo/cat_repo.rb'
require_relative 'petshopserver/repo/dog_repo.rb'
require_relative 'petshopserver/repo/shop_repo.rb'
require_relative 'petshopserver/repo/user_repo.rb'

module Petshop
  def self.create_db_connection(dbname)
    PG.connect(host:'localhost', dbname: dbname)
  end
  
  def self.clear_db(db)
    db.exec %q[
      DELETE FROM users_pets;
      DELETE FROM cats;
      DELETE FROM dogs;
      DELETE FROM users;
      DELETE FROM shops;
     ]
  end
  
  def self.create_tables(db)
    db.exec %q[
      CREATE TABLE IF NOT EXISTS users_pets (
        id          SERIAL PRIMARY KEY,
        user_id     INTEGER REFERENCES users(id) ON DELETE CASCADE,
        cat_id      INTEGER REFERENCES cats(id) ON DELETE CASCADE,
        dog_id      INTEGER REFERENCES dogs(id) ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS cats (
        id              SERIAL PRIMARY KEY,
        name            VARCHAR,
        img_url         VARCHAR,
        adopted_status  BOOLEAN,
        shop_id         INTEGER REFERENCES shops(id) ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS dogs (
        id                SERIAL PRIMARY KEY,
        name              VARCHAR,
        img_url           VARCHAR,
        happiness         INTEGER,
        adopted_status    BOOLEAN,
        shop_id           INTEGER REFERENCES shops(id) ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS users (
        id        SERIAL PRIMARY KEY,
        name      VARCHAR,
        password  VARCHAR
      ); 
      CREATE TABLE IF NOT EXISTS shops (
        id      SERIAL PRIMARY KEY,
        name    VARCHAR
      ); 
    ]
  end
    
  def self.drop_tables(db)
    db.exec %q[
      DROP TABLE users_posts;
      DROP TABLE cats;
      DROP TABLE dogs;
      DROP TABLE users;
      DROP TABLE shops
    ]
  end
end