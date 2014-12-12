require 'pg'

module PetShop
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM cats;
      DELETE FROM dogs;
      DELETE FROM shops;
      DELETE FROM owners;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS shops(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS owners(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR
      );
      CREATE TABLE IF NOT EXISTS cats(
        id SERIAL PRIMARY KEY,
        name VARCHAR,
        shopid INT references shops (id),
        owner_id INT references owners (id),
        imageurl TEXT,
        adopted VARCHAR
      );
      CREATE TABLE IF NOT EXISTS dogs(
        id SERIAL PRIMARY KEY,
        name VARCHAR,
        shopid INT references shops (id),
        owner_id INT references owners (id),
        imageurl TEXT,
        adopted VARCHAR
      );
      
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE cats;
      DROP TABLE dogs;
      DROP TABLE shops;
      DROP TABLE owners;
    SQL
  end

  def self.seed_db(db)
    db.exec <<-SQL
      -- Insert Shops
      INSERT INTO shops (name) values ('Store Prime');
      INSERT INTO shops (name) values ('Canineite');
      INSERT INTO shops (name) values ('Poochy Paradise');
    SQL

    db.exec <<-SQL
      -- Insert Owners
      INSERT INTO owners (username, password) values ('Jason', 'pass');
      INSERT INTO owners (username, password) values ('Alex', 'pass');
    SQL

    db.exec <<-SQL
      -- Insert Dogs
      INSERT INTO dogs (name, shopid, imageurl, adopted) values 
      ('Sam The Pup', 2, 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSMp3Zb-s_O38HlY4x9xPI0k0cJ8_DtEH4zJ4mKCt_4sGapVOOYrw', 'false');
      INSERT INTO dogs (name, shopid, imageurl, adopted) values 
      ('Bark', 1, 'http://animal-backgrounds.com/download/1092/1920x1200/crop/cute-and-funny-small-dog-wallpaper-1920x1200.jpg', 'false');
      INSERT INTO dogs (name, shopid, imageurl, adopted) values 
      ('Woof', 3, 'http://www.bobtail-chiens.com/medias/images/24-04-2011-gustave.jpg', 'false');
      INSERT INTO dogs (name, shopid, imageurl, adopted) values 
      ('Growl', 2, 'http://www.smalldogbreedsdb.com/wp-content/uploads/EasyRotatorStorage/user-content/erc_66_1381848811/content/assets/Beagle-3.jpg-0.jpg', 'false');
    SQL

    db.exec <<-SQL 
      -- Cats
      INSERT INTO cats (name, shopid, imageurl, adopted) values 
      ('Lammie', 1, 'https://c2.staticflickr.com/8/7418/9738381563_0ac7da6cdc_b.jpg', 'false');
      INSERT INTO cats (name, shopid, imageurl, adopted) values 
      ('Joja', 2, 'http://wallpaper-download.net/wallpapers/animal-wallpapers-african-lion-king-wallpaper-31870.jpg', 'false');
      INSERT INTO cats (name, shopid, imageurl, adopted) values 
      ('Biboo', 3, 'http://alabamapioneers.com/ap2/wp-content/uploads/2014/06/black_panther-t2.jpg', 'false');
    SQL
  end
end

require_relative 'petshop/shop_repo'
require_relative 'petshop/owner_repo'
require_relative 'petshop/dog_repo'
require_relative 'petshop/cat_repo'
