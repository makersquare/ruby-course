require_relative 'chatitude/repos/users_repo.rb'

module Chatitude
  def self.create_db_connection dbname
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db db
    db.exec <<-SQL
      DELETE FROM users;
    SQL
  end

  def self.create_tables db
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR
      );
    SQL
  end

  def self.drop_tables db
    db.exec <<-SQL
      DROP TABLE users;
    SQL
  end
end
