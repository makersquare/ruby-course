require 'pg'

module Library
  def self.create_db_connection(dbname)
    @db = PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM users;
      /* TODO: Clear rest of the tables (books, etc.) */
    SQL
  end

  def self.create_tables(db)
    @db.exec <<-SQL
      CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR
      );
      CREATE TABLE books(
        title VARCHAR,
        id INTEGER,
        author VARCHAR
      );
      CREATE TABLE memberships (
        user_id INTEGER,
        book_id INTEGER,
        checked_out BOOLEAN
        );
      /* TODO: Create rest of the tables (books, etc.) */
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
