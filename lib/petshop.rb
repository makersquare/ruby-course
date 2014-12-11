require 'pg'

# require_relative 'blogtastic/repos/posts_repo.rb'
# require_relative 'blogtastic/repos/comments_repo.rb'
# require_relative 'blogtastic/repos/users_repo.rb'


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
        name VARCHAR,
        password VARCHAR
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        shopId INT references shops(id),
        userId INT references users(id),
        name VARCHAR,
        imageUrl VARCHAR,
        adopted BOOLEAN,
        happiness INT
      );
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        shopId INT references shops(id),
        userId INT references users(id),
        name VARCHAR,
        imageUrl VARCHAR,
        adopted BOOLEAN
      );
    SQL
  end

  def self.seed_db(db)
    db.exec <<-SQL
      INSERT INTO users (name, password) values ('anonymous', 'anonymous');
      INSERT INTO shops (name) values ('Rufinos Ruffers');
      INSERT INTO dogs (name, imageUrl, adopted, happiness) values ('Barky', 'http://www.google.com/barky.jpg', 'false', 4);
      INSERT INTO cats (name, imageUrl, adopted) values ('Catzy', 'http://www.cats.com/catzy.jpg', 'false')
    SQL
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

