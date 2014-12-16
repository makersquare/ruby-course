class Songify::PlaylistRepo < Songify::Repo 

  def create_table
    command = <<-SQL
      CREATE TABLE IF NOT EXISTS playlists(
        id SERIAL PRIMARY KEY,
        title text
        );
    SQL
    @db.exec(command)
  end

  def drop_table
    command = <<-SQL
      DROP TABLE IF EXISTS playlists CASCADE;
    SQL
    @db.exec(command)
  end

  def create_join
    command = <<-SQL
      CREATE TABLE IF NOT EXISTS song_playlists(
        id SERIAL PRIMARY KEY,
        song_id INTEGER REFERENCES songs (id),
        playlist_id INTEGER REFERENCES playlists(id)
        );
    SQL
    @db.exec(command)
  end

  def drop_join
    command = <<-SQL
      DROP TABLE IF EXISTS song_playlists CASCADE;
    SQL
    @db.exec(command)
  end

  def add_new_playlist(params)
    command = <<-SQL
      INSERT INTO playlists
      (title)
      VALUES ('#{params[:title]}')
      RETURNING *;
    SQL
    result = @db.exec(command).first
    build_playlist(result)
  end

  def build_playlist(params)
    Songify::Playlist.new(Hash[params.map{|k,v| [k.to_sym, v]}])
  end

  def find_playlist(params)
    col = params.keys.first
    val = params[col]
    query = <<-SQL
      SELECT * FROM playlists
      WHERE #{col} = '#{val}'
    SQL
    result = @db.exec(query).to_a
    result.map{|playlist| build_playlist(playlist)}
  end

  def get_all_playlists
    query = <<-SQL
      SELECT * FROM playlists;
    SQL
    result = @db.exec(query).to_a
    result.map{|playlist| build_playlist(playlist)}
  end

  def add_song_to_playlist(params)
    command = <<-SQL
      INSERT INTO song_playlists (playlist_id, song_id)
      VALUES (#{params[:playlist_id]}, #{params[:song_id]})
      RETURNING *;
    SQL
    result = @db.exec(command).first
    find_playlist({id: result['playlist_id']})
  end

  def get_playlists_for_songs(params)
    query = <<-SQL
      SELECT * FROM song_playlists, songs, playlists
      WHERE song_playlists.song_id = #{params[:song_id]} AND playlists.id = song_playlists.playlist_id
    SQL
    result = @db.exec(query).to_a
    result.map{|playlist| build_playlist(playlist)}
  end


end