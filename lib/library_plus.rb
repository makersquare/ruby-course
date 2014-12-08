require 'pg'

module Library
  
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM books;
      DELETE FROM checked_out;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users(
        id    SERIAL PRIMARY KEY,
        name  VARCHAR
      );
      CREATE TABLE IF NOT EXISTS books(
      id          SERIAL PRIMARY KEY,
      title       VARCHAR,
      author      VARCHAR,
      status      VARCHAR,  
      borrower_id INTEGER 
      );
      CREATE TABLE IF NOT EXISTS checked_out(
      book_id   INTEGER,
      user_id   INTEGER,
      date_out  date DEFAULT now()
      );
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE users;
      DROP TABLE books;
      DROP TABLE checked_out;
    SQL
  end
end


require_relative 'library_plus/book_repo'
require_relative 'library_plus/user_repo'
