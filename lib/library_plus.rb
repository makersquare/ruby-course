require 'pg'
require 'pry-byebug'

module Library

  def self.create_db(dbname)
    success = system("createdb #{dbname}")
  end

  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DROP TABLE IF EXISTS checkouts;
      DROP TABLE IF EXISTS users;
      DROP TABLE IF EXISTS books;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS books(
        id SERIAL PRIMARY KEY,
        title VARCHAR,
        author VARCHAR,
        status  VARCHAR
      );
      CREATE TABLE IF NOT EXISTS checkouts(
        book_id INTEGER references books(id),
        user_id INTEGER references users(id),
        status VARCHAR,
        checkout_date VARCHAR
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE IF EXISTS checkouts; # Drop Dependent Tables First
      DROP TABLE IF EXISTS users;
      DROP TABLE IF EXISTS books;
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
