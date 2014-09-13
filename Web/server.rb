require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application
  set :bind, '0.0.0.0'
  get '/' do 
    erb :index
  end
  # run!

  get '/show' do 
    @songs = Songify.songs_repo.get_all_songs
    erb :show
  end

  get '/new' do 
    new_genre = Songify::Genre.new('punk rock')
    Songify.genres_repo.save_a_genre(new_genre)
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  post '/create' do 
    song = Songify::Song.new(params["title"],params["artist"],params["album"])
    Songify.songs_repo.save_a_song(song)
    redirect to '/show'
  end
  run! if __FILE__ == $0
end

