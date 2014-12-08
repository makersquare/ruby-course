require 'sinatra'
require './lib/songify.rb'

# set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title]
  })
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
