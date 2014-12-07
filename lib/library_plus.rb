require 'pg'

module Library
  def self.create_db_connection(dbname)
    PG.connect(dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM books;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      
      create table books(
        id SERIAL PRIMARY KEY,
        title VARCHAR,
        author VARCHAR
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      DROP TABLE books;
    SQL
  end

end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'

# db = Library.create_db_connection "library_test"
# Library.create_tables db
