require 'sinatra'
require './lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @genres = Songify::GenreRepo.all(db)
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title],
    'genre_ids' => params[:genre_id]
  })
  redirect to '/albums'
end


get '/songs' do
  db = Songify.create_db_connection('songify_dev')
  @songs = Songify::SongRepo.all(db)
  @albums = Songify::AlbumRepo.all(db)
  erb :"songs/index"
end

post '/songs' do
  puts params
  db = Songify.create_db_connection('songify_dev')
  song = Songify::SongRepo.save(db, {
      'title' => params[:title],
      'album_id' => params[:id_select]
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
