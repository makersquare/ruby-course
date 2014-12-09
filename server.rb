require "sinatra"
require "bundler/setup"
require "sinatra/reloader"
require "./lib/songify.rb"

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end


## ALBUMS
get '/albums' do
  db = Songify.create_db_connection('songify_dev')
  @albums = Songify::AlbumRepo.all(db) #Brought back as an 'array of arrays' (for .each method)
  @songs = Songify::SongRepo.all(db)    #FOR EXTENSION #6
  @genres = Songify::GenreRepo.all(db)  #FOR EX2/#3
  
  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  Songify::GenreRepo.save(db, {
    'name' => params[:name]
  })
  album = Songify::AlbumRepo.save(db, {   #returns the album hash { "id" => " "; "title" => " "}
    'title' => params[:title],
    'name' => params[:name]
  })
  redirect to '/albums'
end
## END ALBUMS


## GENRES
get '/genres' do
  db = Songify.create_db_connection('songify_dev')
  @genres = Songify::GenreRepo.all(db) #Brought back as an 'array of arrays' (for .each method)
  erb :"genres/index"
end

post '/genres' do
  db = Songify.create_db_connection('songify_dev')
  genre = Songify::GenreRepo.save(db, {   #Returns the genre hash { "id" => " "; "title" => " "}
    #'title' => params[:title]            #Changed 'album =' to 'genre =' above 
    'name' => params[:name]
  })
  redirect to '/genres'
end
## END GENRES


## SONGS
get '/songs' do
  db = Songify.create_db_connection('songify_dev')
  @songs = Songify::SongRepo.all(db)    #Brought back as an 'array of arrays' (for .each method)
  @albums = Songify::AlbumRepo.all(db)  #Brought back as an 'array of arrays' (for .each method)
  erb :"songs/index"
end

post '/songs' do
 db = Songify.create_db_connection('songify_dev')
 Songify::SongRepo.save(db,  {
  'album_id' => params[:album_id],
  'title' => params[:title]
   })
 redirect to '/songs'
end
## END SONGS
