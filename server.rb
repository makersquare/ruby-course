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
  #@songs = Songify::SongRepo.all(db)    #FOR EXTENSION #6
  @genres = Songify::GenreRepo.all(db)   #FOR EX3

  erb :"albums/index"
end

post '/albums' do
  db = Songify.create_db_connection('songify_dev')
  # genre = Songify::GenreRepo.save(db, {    ## DON'T KNOW IF THIS IS CORRECT 
  #   'name' => params[:genre_names]
  # })
  album = Songify::AlbumRepo.save(db, {   #Returns the album hash { "id" => " "; "title" => " "}
    'title' => params[:album_title],
    'genre_ids' => params[:genre_ids]
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
    'name' => params[:genre_name]         #'name' needs to reference genre name column(?)
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
 song = Songify::SongRepo.save(db,  {
  'album_id' => params[:album_name],     #'album_id' needs to reference song album_id column(?)
  'title' => params[:song_title]         #'title' needs to reference song title column(?)
   })
 redirect to '/songs'                    
end
## END SONGS
