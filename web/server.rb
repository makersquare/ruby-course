require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application
  set :bind, '0.0.0.0'

  get '/' do
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.show_all_songs
    erb :show
  end

  get '/new' do
    @genres = Songify.genres_repo.show_all_genres
    erb :new
  end

  post '/create' do
    song = Songify::Song.new(params["song-title"],params["song-artist"],params["song-album"])
    genre = Songify::Genre.new(params["genre"])
    Songify.genres_repo.save_genre(genre)
    Songify.songs_repo.save_a_song(song, genre)
    redirect to '/show'
  end

  run! if __FILE__ == $0
end