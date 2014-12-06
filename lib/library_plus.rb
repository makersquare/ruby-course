require 'pg'

module Library
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM books;
      DELETE FROM checkouts;
      /* TODO: Clear rest of the tables (books, etc.) */
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
        author VARCHAR
        );
      CREATE TABLE IF NOT EXISTS checkouts(
        id SERIAL PRIMARY KEY,
        user_id INTEGER,
        book_id INTEGER,
        status VARCHAR,
        created_at TIMESTAMP without time zone);
      /* TODO: Create rest of the tables (books, etc.) */
    SQL

  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      DROP TABLE books;
      DROP TABLE checkouts;
      /* TODO: Drop rest of the tables (books, etc.) */
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
