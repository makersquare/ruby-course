require 'pg'

module Library
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      /* TODO: Clear rest of the tables (books, etc.) */
      DELETE FROM books;
      DELETE FROM checkouts;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE if not exists users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      /* TODO: Create rest of the tables (books, etc.) */
      CREATE TABLE if not exists books(
        id SERIAL PRIMARY KEY,
        title VARCHAR,
        author VARCHAR
      );
      CREATE TABLE if not exists checkouts(
        user_id INTEGER,
        book_id INTEGER,
        status VARCHAR default available,
        created_at TIMESTAMP without time zone
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      /* TODO: Drop rest of the tables (books, etc.) */
      DROP TABLE books;
      DROP TABLE checkouts;
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
