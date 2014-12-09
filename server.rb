require 'sinatra'
require './lib/songify.rb'
require 'json'

# set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @genres = JSON.generate(Songify::GenreRepo.all(db))
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title],
    'genre_ids' => params[:genres]
  })
  redirect to '/albums'
end


get '/songs' do
  db = Songify.create_db_connection('songify_dev')
  @songs = Songify::SongRepo.all_with_album(db)
  erb :"songs/index"
end

get '/songs/add' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @genres = JSON.generate(Songify::GenreRepo.all(db))

  erb :"songs/add"
end
post '/songs/add' do
  db = Songify.create_db_connection('songify_dev')
  data = {}
  data["title"] = params["title"]
  data["album_id"] = params["album"]
  Songify::SongRepo.save(db, data)

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
