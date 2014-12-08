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
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE IF NOT EXISTS books(
        id SERIAL PRIMARY KEY,
        title VARCHAR,
        author VARCHAR
      );
      CREATE TABLE IF NOT EXISTS checkout(
        id SERIAL PRIMARY KEY,
        user_id integer REFERENCES users ( id),
        book_id integer REFERENCES books ( id),
        status VARCHAR DEFAULT 'returned',
        created_at TIMESTAMP DEFAULT current_timestamp
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
