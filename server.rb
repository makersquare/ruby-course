require 'sinatra'
require './lib/songify.rb'
require 'sinatra/reloader'

set :bind, '0.0.0.0' # This is needed for Vagrant

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
  db = Songify.create_db_connection('songify_dev')
  @songs = Songify::SongRepo.all(db)
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  erb :"songs/index"
end

post '/songs' do 
  song_data = {'title' => params['name'], 'album_id' => params['album-select']}
  db = Songify.create_db_connection('songify_dev')
  song = Songify::SongRepo.save(db, song_data)
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
