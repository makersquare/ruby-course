class Songify::AlbumRepo < Songify::Repo 

  def create_table
    command = <<-SQL
      CREATE TABLE IF NOT EXISTS 
      albums(
        id SERIAL PRIMARY KEY,
        title TEXT,
        artist TEXT,
        cover TEXT
      );
    SQL
    @db.exec(command)
  end

  def drop_table
    command = <<-SQL
      DROP TABLE IF EXISTS albums CASCADE;
    SQL
    @db.exec(command)
  end

  def add_new_album(params)
    command = <<-SQL
      INSERT INTO albums 
      (title, artist, cover)
      VALUES ('#{params[:title]}', '#{params[:artist]}', '#{params[:cover]}')
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_album(result)
  end

  def build_album(params)
    Songify::Album.new(Hash[params.map{|k,v| [k.to_sym, v]}])
  end

  def find_album(params)
    col = params.keys.first
    val = params[col]
    query = <<-SQL
      SELECT * FROM albums
      WHERE #{col} = '#{val}'
    SQL
    result = @db.exec(query).to_a
    result.map {|album| build_album(album)}
  end

  def get_all_albums
    query = <<-SQL
      SELECT * FROM albums;
    SQL
    result = @db.exec(query).to_a
    result.map{|album| build_album(album)} 
  end

  def update_album(params)
    command = <<-SQL
      UPDATE albums
      SET (title, artist, cover) = ('#{params[:title]}', '#{params[:artist]}', '#{params[:cover]}')
      WHERE id = #{params[:id]}
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_album(result)
  end

  def delete_album(params)
    command = <<-SQL
      DELETE FROM albums
      WHERE id = #{params[:id]}
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_album(result)
  end

end