require 'pg'

module Library
  def self.create_db_connection(dbname)
    cstring = {
  host: "localhost",
  dbname: dbname,
  user: "ruby",
  password: "rubyRailsJS"
}
    PG.connect(cstring)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
    db.exec <<-SQL
      DELETE FROM books;
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
    db.exec <<-SQL
      DELETE FROM checkouts;
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      /* TODO: Create rest of the tables (books, etc.) */
    SQL
    db.exec <<-SQL
      CREATE TABLE books(
        id SERIAL PRIMARY KEY,
        title VARCHAR,
        author VARCHAR
      );
    SQL
    db.exec <<-SQL
      CREATE TABLE checkouts(
        id SERIAL PRIMARY KEY,
        book_id INTEGER,
        user_id INTEGER,
        checkout_date date,
        due_date date,
        return_date date
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      /* TODO: Drop rest of the tables (books, etc.) */
    SQL
    db.exec <<-SQL
      DROP TABLE books;
      /* TODO: Drop rest of the tables (books, etc.) */
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
require_relative 'library_plus/checkout_repo'
