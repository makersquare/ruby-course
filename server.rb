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

  # Add Album to album db
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title]
  })
  songs = params[:songs]

  # Add all songs to the songs db
  songs.each do |song|
    Songify::SongRepo.save(db, { 'album_id' => album['id'], 'title' => song })
  end

  redirect to '/albums'
end

get '/albums/:id' do
  db = Songify.create_db_connection('songify_dev')

  @songs = Songify::SongRepo.songs_by_album(db, params[:id])
  binding.pry
  erb :"albums/showpage"
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
