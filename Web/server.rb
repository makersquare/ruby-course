require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'pry-byebug'

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
    new_genre = Songify::Genre.new('Other')
    Songify.genres_repo.save_a_genre(new_genre)
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  post '/create' do 
    genre_id = SOngify.genres_repo.id_by_genre(params['genre'])
    song = Songify::Song.new(params["title"],params["artist"],params["album"],genre_id)
    Songify.songs_repo.save_a_song(song)
    binding.pry
    p "hi"
    redirect to '/show'
  end
  run! if __FILE__ == $0
end

