require 'sinatra'
require './lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db)
  @songs = Songify::AlbumRepo.count_songs_join_albums(db)
  @genres = Songify::GenreRepo.all(db)
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  album = Songify::AlbumRepo.save(db, {
    'title' => params[:title],
    'genres' => params[:genre_ids]
  })
  redirect to '/albums'
end

get '/songs' do
  db = Songify.create_db_connection('songify_dev')
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
  genre = Songify::GenreRepo.save(db, {
    'name' => params[:name]
  })
  redirect to '/genres'
end

get '/albums/:id/' do
  db = Songify.create_db_connection('songify_dev')
  @album_id = params[:id]
  @album = Songify::AlbumRepo.find(db, params[:id])
  @songs = Songify::AlbumRepo.all_songs_by_album(db, @album_id)
  @genres = Songify::GenreRepo.all_album_genres(db, params[:id])
  erb :"albums/show"
end 

# post '/create' do
#   db = Songify.create_db_connection('songify_dev')
#   id = params[:album_id]
#   redirect to "/albums/#{id}/songs/create"
# end

# get '/albums/:id/songs/create' do
#   db = Songify.create_db_connection('songify_dev')
#   @album = Songify::AlbumRepo.find(db, params[:id])
#   erb :"songs/create"
# end

post '/albums/:id/songs' do
  db = Songify.create_db_connection('songify_dev')
  song =  Songify::SongRepo.save(db, {
    'title' => params[:title], 'album_id' => params[:id]
  })
  # song = Songify::SongRepo.save(db, {'title' => 'Ciao', 'album_id' =>2
  # })
   redirect to '/albums/' + params[:id]
end

post '/albums/:id/genres' do
  db = Songify.create_db_connection('songify_dev')
  @album = Songify::AlbumRepo.find(db, params[:id])
  puts @album["title"]
  album = Songify::AlbumRepo.save(db, {
    'title' => @album["title"],
    'id' => params[:id],
    'genres' => params[:genre_ids].to_a
  })

  redirect to '/albums/' + params[:id]
end

post '/albums/show' do
  db = Songify.create_db_connection('songify_dev')
  id = params['album_id']
  redirect to "/albums/#{id}/"
end