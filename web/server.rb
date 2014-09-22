require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'pry-byebug'

class Songify::Server < Sinatra::Application

set :bind, '0.0.0.0'

  get '/' do 
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs
    @genres = Songify.genres_repo.get_all_genres
    erb :show
  end

  get '/new' do
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  get '/search_genre' do
    @genres = Songify.genres_repo.get_all_genres
    erb :create
  end

  post '/search_genre' do
    y = params['genre_drop']
    @genres = Songify.genres_repo.get_all_genres
    genre_object = Songify.genres_repo.get_a_genre_by_name(y)
    @all_songs_by_genre = Songify.songs_repo.get_songs_by_genres(genre_object.id)
    erb :create
  end

  post '/create' do

    if params['genre'] == ""
      genre_name = params['genre_drop']
      y = Songify.genres_repo.get_a_genre_by_name(genre_name)
    else 
      genre_name = params['genre']
      y = Songify::Genre.new(genre_name)
      Songify.genres_repo.save_a_genre(y)
    end 
    song_title = params['title']
    song_artist = params['artist']
    song_album = params['album']
    x = Songify::Song.new(song_title, song_album, song_artist, y.id)
    Songify.songs_repo.save_a_song(x)
    redirect to('/show') 
    
  end
run! if __FILE__ == $0

end