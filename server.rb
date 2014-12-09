require 'sinatra'
require './lib/songify.rb'

# set :bind, '0.0.0.0' # This is needed for Vagrant

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
    'genres' => params[:genreid].to_a
  })

  redirect to '/albums'
end

post '/albums/:id/genres' do
  db = Songify.create_db_connection('songify_dev')
  @album = Songify::AlbumRepo.find(db, params[:id])
  puts @album["title"]
  album = Songify::AlbumRepo.save(db, {
    'title' => @album["title"],
    'id' => params[:id],
    'genres' => params[:genreid].to_a
  })

  redirect to '/albums/' + params[:id]
end

get '/albums/:id' do
  db = Songify.create_db_connection('songify_dev')
  @genres = Songify::GenreRepo.all(db)
  @album = Songify::AlbumRepo.find(db, params[:id])
  @songs = Songify::SongRepo.findbyalbum(db, params[:id] )
  @albgenres = Songify::GenreRepo.findalbumgenres(db, params[:id])
  erb :"albums/show"
end

post '/albums/:id/songs' do
  db = Songify.create_db_connection('songify_dev')
  Songify::SongRepo.save(db, params)
redirect to '/albums/' + params[:id]
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
