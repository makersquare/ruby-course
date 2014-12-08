require 'pg'

module Library
  def self.create_db_connection(dbname)
    PG.connect(dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users cascade;
      DELETE FROM books cascade;
      DELETE FROM checkouts;
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

      create table checkouts(
        book_id integer 
        references books(id) on delete cascade,
        user_id integer
        references users(id) on delete cascade
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE if exists users cascade;
      DROP TABLE if exists books cascade;
      DROP TABLE if exists checkouts
    SQL
  end

end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'

# db = Library.create_db_connection "library_test"
# Library.drop_tables db
# Library.create_tables db
