require 'pg'

require_relative 'repo/cat_repo.rb'
require_relative 'repo/dog_repo.rb'
require_relative 'repo/shop_repo.rb'
require_relative 'repo/user_repo.rb'

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
      CREATE TABLE IF NOT EXISTS shops (
        id      SERIAL PRIMARY KEY,
        name    VARCHAR
      ); 
      CREATE TABLE IF NOT EXISTS dogs (
        id                SERIAL PRIMARY KEY,
        name              VARCHAR,
        img_url           VARCHAR,
        adopted_status    BOOLEAN DEFAULT false,
        shop_id           INTEGER REFERENCES shops(id) ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS users (
        id        SERIAL PRIMARY KEY,
        name      VARCHAR,
        password  VARCHAR
      ); 
      CREATE TABLE IF NOT EXISTS cats (
        id              SERIAL PRIMARY KEY,
        name            VARCHAR,
        img_url         VARCHAR,
        adopted_status  BOOLEAN DEFAULT false,
        shop_id         INTEGER REFERENCES shops(id) ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS users_pets (
        id          SERIAL PRIMARY KEY,
        user_id     INTEGER REFERENCES users(id) ON DELETE CASCADE,
        cat_id      INTEGER REFERENCES cats(id) ON DELETE CASCADE,
        dog_id      INTEGER REFERENCES dogs(id) ON DELETE CASCADE
      );

    ]
  end
  
  def self.seed_db(db)
   sql = 'INSERT INTO shops (name) VALUES ($1)'
   db.exec(sql,['shop one'])
   db.exec(sql, ['Coolio'])
   
   sql2 = %q[
     INSERT INTO cats (name, shop_id, img_url)
     VALUES ($1,$2,$3)
   ]
   db.exec(sql2,['whiskers',1,"http://wac.450f.edgecastcdn.net/80450F/catcountry1073.com/files/2013/02/CAT.jpg"])
   db.exec(sql2,['scratchy',1,"http://img2.wikia.nocookie.net/__cb20131106172200/uncyclopedia/images/b/b3/Napoleon_Liger.JPG"])
   db.exec(sql2, ['plopply',2,'https://reignmag.com/wp-content/uploads/2014/10/JohnCandySpaceBalls.jpg'])
   db.exec(sql2, ['Tom',2,"http://cdn.sheknows.com/articles/2013/06/25-random-cat-behaviors-finally-explained-01.jpg"])
   
   sql3 = %q[
     INSERT INTO dogs (name, shop_id, img_url)
     VALUES ($1,$2,$3)
   ]
   db.exec(sql3, ['grumpy',1,'http://www.prevention.com/sites/default/files/imagecache/slideshow_display/dog-dogue-de-bordeaux-puppy-410x290.jpg'])
   db.exec(sql3, ['barkley',1,'http://static.memrise.com/uploads/mems/130613000120225223403.jpg'])
   db.exec(sql3, ['sniffles',2,'http://nextranks.com/data_images/dogs/harrier/harrier-01.jpg'])
   db.exec(sql3, ['boots',2,"http://img2.wikia.nocookie.net/__cb20140823165721/simpsons/images/2/2c/Santa's_Little_Helper.png"])
   
   sql4 = %q[
     INSERT INTO users (name, password)
     VALUES ($1,$2)
   ]
   db.exec(sql4, ['Melizza', 'password'])
   db.exec(sql4, ['James', 'jamespets'])
   
  end
    
  def self.drop_tables(db)
    db.exec %q[
      DROP TABLE users_pets CASCADE;
      DROP TABLE cats CASCADE;
      DROP TABLE dogs CASCADE;
      DROP TABLE users CASCADE;
      DROP TABLE shops CASCADE;
    ]
  end
end