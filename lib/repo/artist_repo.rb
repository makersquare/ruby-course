require_relative '../../songify.rb'
require 'pg'

class Songify::ArtistRepo

  def initialize
    @db = PG.connect(dbname: 'songify-db')
  end

  def create_table
    command = <<-SQL
    CREATE TABLE artists(
      id SERIAL PRIMARY KEY,
      name TEXT
      );
    SQL
    @db.exec(command)
  end

  def add_artist(params)
    command = <<-SQL
    INSERT INTO artists(name)
    VALUES ('#{params[:name]}')
    RETURNING *;
    SQL
    result = @db.exec(command)
    build_artist(result.first)
  end

  def find_artist_by_name(params)
    query = <<-SQL
    SELECT * FROM artists
    WHERE name = '#{params[:name]}'
    SQL
    result = @db.exec(command)
    build_artist(result.first)
  end

  def update_artist
  end

  def delete_artist
  end

  def build_artist(params)
    Songify::Artist.new(params)
  end

end