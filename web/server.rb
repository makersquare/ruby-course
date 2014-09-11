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

  post '/create' do
    genre = Songify::Genre.new(params["genre"])
    Songify.genres_repo.save_a_genre(genre)
    song = Songify::Song.new(params["title"], params["artist"], params["album"], genre.id)
    Songify.songs_repo.save_a_song(song)
    redirect '/'
  end

  get '/new' do
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  run! if __FILE__ == $0
end