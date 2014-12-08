require 'sinatra'
require './lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @albums.each do |x|
    x['count'] = Songify::SongRepo.songs_per_album(db, x['id']).count
  end
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title]
  })
  redirect to '/albums'
end

get '/albums/:id' do 
  db = Songify.create_db_connection('songify_dev')
  @album = Songify::AlbumRepo.find(db, params[:id])
  @songs = Songify::SongRepo.songs_per_album(db, params[:id]).to_a
  erb :"albums/show"
end


get '/songs' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @songs = Songify::SongRepo.all(db)
  erb :"songs/index"
end

post '/songs' do
  db = Songify.create_db_connection('songify_dev')

  album_title = params[:album_title]
  album_id = Songify::AlbumRepo.find_id(db, album_title)
  song = Songify::SongRepo.save(db, {
    'title' => params[:title],
    'album_id' => album_id['id']
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
