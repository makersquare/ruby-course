require 'pg'

module Library
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname )
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      /* TODO: Create rest of the tables (books, etc.) */
      CREATE TABLE IF NOT EXISTS books(
        title VARCHAR,
        author VARCHAR
        );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      /* TODO: Drop rest of the tables (books, etc.) */
      DROP TABLE books;
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
