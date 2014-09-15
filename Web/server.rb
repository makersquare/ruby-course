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
    erb :show
  end

  post '/show' do
    genre_id = Songify.genres_repo.id_by_genre(params['genre_search']).to_i
    @songs = Songify.songs_repo.get_all_by_genre(genre_id)

    erb :show
  end

  get '/new' do 
    @genres = Songify.genres_repo.get_all_genres
    erb :new
  end

  post '/create' do 
    if params['new-genre'].empty?
      genre_id = Songify.genres_repo.id_by_genre(params['genre']).to_i
    else
      genre = Songify::Genre.new(params['new-genre'])
      Songify.genres_repo.save_a_genre(genre)
      genre_id = Songify.genres_repo.id_by_genre(params['new-genre']).to_i
    end


    song = Songify::Song.new(params["title"],params["artist"],params["album"],genre_id)
    Songify.songs_repo.save_a_song(song)
    redirect to '/show'
  end
  run! if __FILE__ == $0
end

