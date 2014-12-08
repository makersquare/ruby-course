require 'pg'

module Library
  def self.create_db_connection(dbname)
    @db = PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM books;
      DELETE FROM memberships;
    SQL
  end

  def self.create_tables(db)
    @db.exec <<-SQL
      CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE books(
        id SERIAL,
        title VARCHAR,
        author VARCHAR
      );
      CREATE TABLE checkouts (
        name VARCHAR,
        book_id INTEGER,
        checked_out BOOLEAN
        );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      DROP TABLE books;
      DROP TABLE memberships;
    SQL
  end
end

require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
