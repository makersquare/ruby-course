require 'sinatra'
require './lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  @db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(@db)
  @genres = Songify::GenreRepo.all(@db)
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title]
  })
  redirect to '/albums'
end

get'/albums/:id' do
  db = Songify.create_db_connection('songify_dev')
  @songs = Songify::SongRepo.list(db, params[:id])
  @genres = Songify::GenreRepo.genres_by_album(db, params[:id])
  erb :"albums/album"
end

get '/songs' do
  db = Songify.create_db_connection('songify_dev')
  @songs = Songify::SongRepo.all(db)
  @albums = Songify::AlbumRepo.all(db)
  erb :"songs/index"
end

post '/songs' do
  db = Songify.create_db_connection('songify_dev')
  song = Songify::SongRepo.save(db, {
    'title' => params[:title],
    'album_id' => params[:album_id]
    })
  redirect to '/songs'
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
  @genres = Songify::GenreRepo.albums(db, params[:id])
  erb :"genres/genre"
end
