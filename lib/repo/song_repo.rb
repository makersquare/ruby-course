class Songify::SongRepo < Songify::Repo

  def create_table
    command = <<-SQL
      CREATE TABLE IF NOT EXISTS
      songs(
        id SERIAL PRIMARY KEY,
        name TEXT,
        embed TEXT,
        album_id INTEGER REFERENCES albums (id) ON DELETE CASCADE
      );
    SQL
    @db.exec(command)
  end

  def drop_table
    command = <<-SQL
      DROP TABLE IF EXISTS songs CASCADE;
    SQL
    @db.exec(command)
  end

  def add_new_song(params)
    command = <<-SQL
      INSERT INTO songs
      (name, album_id, embed)
      VALUES ('#{params[:name]}', #{params[:album_id]}, '#{params[:embed]}')
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_song(result)
  end

  def build_song(params)
    Songify::Song.new(Hash[params.map{|k,v| [k.to_sym, v]}])
  end

  def get_all_songs
    query = <<-SQL
      SELECT * FROM songs;
    SQL
    results = @db.exec(query).to_a
    results.map{|song| build_song(song)}
  end

  def find_songs(params)
    col = params.keys.first
    val = params[col]
    query = <<-SQL
      SELECT * FROM songs
      WHERE #{col} = '#{val}'
    SQL
    result = @db.exec(query).to_a
    result.map{|song| build_song(song)}
  end

  def update_song(params)
    command = <<-SQL
      UPDATE songs
      SET (name, embed, album_id) = ('#{params[:name]}', '#{params[:embed]}', #{params[:album_id]})
      WHERE id = #{params[:id]}
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_song(result)
  end 

  def delete_song(params)
    command = <<-SQL
      DELETE FROM songs
      WHERE id = #{params[:id]}
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_song(result)
  end

  def get_songs_in_playlist(params)
    query = <<-SQL
      SELECT * FROM song_playlists, songs, playlists
      WHERE song_playlists.playlist_id = #{params[:playlist_id]} AND songs.id = song_playlists.song_id
    SQL
    result = @db.exec(query)
    result.map{|song| build_song(song)}
  end

end