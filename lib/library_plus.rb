require 'pg'

module Library
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM books;
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE books(
        id SERIAL PRIMARY KEY,
        title VARCHAR,
        author VARCHAR
      );
      CREATE TABLE checkouts(
        id SERIAL PRIMARY KEY,
        user_id INT,
        book_id INT,
        status VARCHAR,
        created_at TIMESTAMP default
      );
      /* TODO: Create rest of the tables IF  (books, etc.) */
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      /* TODO: Drop rest of the tables (books, etc.) */
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
