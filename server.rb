require 'sinatra'
require './lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @genres = Songify::GenreRepo.all(db)
  @albums = Songify::AlbumRepo.all(db)
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title], 'genre_ids' => params[:genre_ids]
  })
  redirect to '/albums'
end


get '/songs' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @songs = Songify::SongRepo.all(db)
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

post '/songs' do
  db = Songify.create_db_connection('songify_dev')
  Songify::SongRepo.save(db, params)
  redirect '/songs'
  
end
