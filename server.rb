require 'sinatra'
require './lib/songify.rb'
# Rack::MethodOverride

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
    'title' => params[:title],
    'genre_ids' => params[:genre_ids]
  })
  redirect to '/albums'
end

get '/albums/:id' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.find(db, params[:id])
  @songs = Songify::SongRepo.list(db, params[:id])
  @genres_join = Songify::GenreRepo.genres_by_album(db, params[:id])
  erb :"albums/album"
end

delete '/albums/:id' do
  db = Songify.create_db_connection('songify_dev')
  Songify::AlbumRepo.destroy(db, params[:album_id])
  redirect to '/albums'
end

get '/albums/:id/edit' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.find(db, params[:id])
  @genres_join = Songify::GenreRepo.genres_by_album(db, params[:id])
  @genres = Songify::GenreRepo.all(db)
  erb :"albums/edit"
end

post '/albums/:id/edit' do
  db = Songify.create_db_connection('songify_dev')
  puts params[:id].class
  puts params[:genre_ids].class
  Songify::AlbumRepo.add_genres(db, {
    'id' => params[:id],
    'genre_ids' => params[:genre_ids]
  })
  redirect to "/albums/#{params[:id]}/edit"
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
  @genres = Songify::GenreRepo.find(db, params[:id])
  @genres_join = Songify::GenreRepo.albums(db, params[:id])
  erb :"genres/genre"
end

delete '/genres/:id' do
  db = Songify.create_db_connection('songify_dev')
  Songify::GenreRepo.destroy(db, params[:genre_id])
  redirect to '/genres'
end
