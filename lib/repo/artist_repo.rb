require_relative '../../songify.rb'
require 'pg'

class Songify::ArtistRepo

  def initialize
    @db = PG.connect(dbname: 'songify-db')
  end

  def drop_table
    command = <<-SQL
    DROP TABLE IF EXISTS artists
    SQL
    @db.exec(command)
  end

  def create_table
    command = <<-SQL
      CREATE TABLE IF NOT EXISTS artists(
      id SERIAL PRIMARY KEY,
      name TEXT
      );
    SQL
    @db.exec(command)
  end

  def add_new_artist(params)
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
    result = @db.exec(query)
    build_artist(result.first)
  end

  def get_all
    query = <<-SQL
      SELECT * FROM artists
    SQL
    result = @db.exec(query)
    artists = []
    result.each do |res|
      artists << build_artist(res)
    end
    return artists
  end


  def update_artist(params)
    command = <<-SQL
      UPDATE artists
      SET name = '#{params[:name]}'
      WHERE id = '#{params[:id]}'
      RETURNING *;
    SQL
    result = @db.exec(command)
    build_artist(result.first)
  end

  def delete_artist(params)
    command = <<-SQL
      DELETE FROM artists
      WHERE id = '#{params[:id]}'
      RETURNING *;
    SQL
    result = @db.exec(command)
    build_artist(result.first)
  end

  def build_artist(params)
    Songify::Artist.new(params)
  end

end