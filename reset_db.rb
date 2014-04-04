# USAGE:
# $ bundle exec ruby reset-db.rb
#
# You can also specify a database:
# $ bundle exec ruby reset_db.rb my-app.db
require "sqlite3"

db_name = ARGV[0] || "tm_test.db"
sqlite = SQLite3::Database.new(db_name)

puts "Destroying #{db_name}..."
sqlite.execute %q{DROP TABLE IF EXISTS projects}
sqlite.execute %q{DROP TABLE IF EXISTS tasks}

puts "Creating tables..."
sqlite.execute %q{
  CREATE TABLE projects (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT     NOT NULL
  );
}
sqlite.execute %q{
  CREATE TABLE tasks (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    project_id    INT,
    name          TEXT     NOT NULL,
    priority      INT,
    FOREIGN KEY(project_id) REFERENCES projects(id)
  );
}

puts "Database Schema:\n\n"
puts `echo .schema | sqlite3 #{db_name}`
