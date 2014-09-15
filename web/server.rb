require_relative "../lib/songify.rb"
require 'sinatra/base'
require "sinatra"

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

  get "/" do 
    erb :index
  end

  get "/show" do 
    @songs = Songify.songs_repo.get_all_songs
    erb :show 
  end

  get "/new" do #form to get song and sends it to create
    @genres = Songify.genres_repo.get_all_genres

    erb :new
  end

  post "/create" do 
    @genres = Songify.genres_repo.get_all_genres
    genre = Songify::Genre.new(params["add_genre_name"]) 

    Songify.genres_repo.save_genre(genre)
    
    song = Songify::Song.new(params["title"], params["artist"], params["album"])
    song.set_genre_id(genre) 
    Songify.songs_repo.save_song(song)

    redirect to('/show')

  end

  get '/show_genres' do 
    @genres = Songify.genres_repo.get_all_genres
    
    erb :show_genres
  end

   post '/genre' do 
   @genres = Songify.genres_repo.get_all_genres
    @found_genre = @genres.find { |s| s.name == params["genres[genre_name]"]} 
    @found_genre
  @selected_songs = Songify.songs_repo.select_song_by_genre(@found_genre) 

    redirect to ('/this_genre')

  end
 
 get '/this_genre' do


  erb :this_genre
  end


  run! if __FILE__ == $0
end
 