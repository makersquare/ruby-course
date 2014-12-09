require 'sinatra'
require './lib/songify.rb'
require 'pry-byebug'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @genres = Songify::GenreRepo.all(db)
  @songs = Songify::SongRepo.all(db)
  @song_count_by_album_id = Songify::SongRepo.songs_per_album(db)
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')

  # Add Album to album db with title and genres
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title],
    'genre_ids' => params[:genre_ids]
  })

  # Add all songs to the songs db
  params[:songs].each do |song|
    Songify::SongRepo.save(db, { 'album_id' => album['id'], 'title' => song })
  end

  redirect to '/albums'
end

get '/albums/:id' do
  db = Songify.create_db_connection('songify_dev')

  @songs = Songify::SongRepo.songs_by_album(db, params[:id])
  erb :"albums/showpage"
end

get '/albums/:id/delete' do
  db = Songify.create_db_connection('songify_dev')
  Songify::AlbumRepo.destroy(db, params[:id])
  redirect to '/albums'
end

get '/songs' do
  erb :"songs/index"
end


get '/genres' do
  db = Songify.create_db_connection('songify_dev')
  @genres = Songify::GenreRepo.all(db)
  erb :"genres/index"
end

post '/genres' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::GenreRepo.save(db, {
    'name' => params[:name]
  })
  redirect to '/genres'
end

get '/genres/:id' do
  db = Songify.create_db_connection('songify_dev')
  @genres = Songify::GenreRepo.find(db, params[:id])
  @albums = []
  @genres['albums'].each do |album|
    @albums.push(Songify::AlbumRepo.find(db, album['id']))
  end
  erb :"genres/showpage"
end

get '/genres/:id/delete' do
  db = Songify.create_db_connection('songify_dev')
  Songify::GenreRepo.destroy(db, params[:id])
  redirect to '/genres'
end
