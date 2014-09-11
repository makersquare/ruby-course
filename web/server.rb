require_relative '../lib/songify.rb'
require 'sinatra/base'
require 'sinatra'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

  get '/' do
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs
    erb :show
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    song = Songify::Song.new(params["title"], params["artist"], params["album"])
    genre = Songify::Genre.new(params["genre"]) ## figure this out
    Songify.genres_repo.save_genre(genre)
    Songify.songs_repo.save_a_song(song, genre)

    redirect to '/show'
  end

end